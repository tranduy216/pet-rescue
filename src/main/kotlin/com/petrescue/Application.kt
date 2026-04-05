package com.petrescue

import com.petrescue.config.AppConfig
import com.petrescue.database.DatabaseFactory
import com.petrescue.i18n.lang
import com.petrescue.i18n.messages
import com.petrescue.i18n.siteConfig
import com.petrescue.plugins.AuthorizationPlugin
import com.petrescue.routes.*
import com.petrescue.services.AppealSubscriptionService
import com.petrescue.services.AuditLogService
import com.petrescue.services.UrgentAppealService
import com.petrescue.services.UserService
import freemarker.cache.ClassTemplateLoader
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.auth.*
import io.ktor.server.freemarker.*
import io.ktor.server.http.content.*
import io.ktor.server.plugins.callloging.*
import io.ktor.server.plugins.defaultheaders.*
import io.ktor.server.plugins.statuspages.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import io.ktor.server.sessions.*
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import org.slf4j.event.Level
import java.io.File
import kotlin.time.Duration.Companion.hours

data class UserSession(val userId: Int, val username: String, val role: String) : Principal

private fun String.escapeJs(): String = this
    .replace("\\", "\\\\")
    .replace("\"", "\\\"")
    .replace("\n", "\\n")
    .replace("\r", "\\r")

fun Application.module() {
    val appConfig = AppConfig(environment.config)

    DatabaseFactory.init(appConfig)

    File(appConfig.storagePath).mkdirs()
    File("data").mkdirs()
    File("static").mkdirs()

    install(DefaultHeaders)
    install(CallLogging) {
        level = Level.INFO
        filter { call -> call.request.path().startsWith("/") }
    }

    install(Sessions) {
        cookie<UserSession>("user_session") {
            cookie.path = "/"
            cookie.maxAgeInSeconds = 86400
            cookie.httpOnly = true
        }
    }

    install(Authentication) {
        session<UserSession>("auth-session") {
            validate { session -> session }
            challenge {
                call.respondRedirect("/login")
            }
        }
    }

    install(AuthorizationPlugin)

    install(FreeMarker) {
        templateLoader = ClassTemplateLoader(this::class.java.classLoader, "templates")
    }

    install(StatusPages) {
        status(HttpStatusCode.NotFound) { call, _ ->
            val session = call.sessions.get<UserSession>()
            call.respond(
                FreeMarkerContent(
                    "error.ftl",
                    mapOf("message" to "Page not found", "code" to 404, "session" to session, "msg" to call.messages(), "lang" to call.lang(), "siteConfig" to call.siteConfig()),
                    ""
                )
            )
        }
        status(HttpStatusCode.InternalServerError) { call, _ ->
            val session = call.sessions.get<UserSession>()
            call.respond(
                FreeMarkerContent(
                    "error.ftl",
                    mapOf("message" to "Internal server error", "code" to 500, "session" to session, "msg" to call.messages(), "lang" to call.lang(), "siteConfig" to call.siteConfig()),
                    ""
                )
            )
        }
        exception<Throwable> { call, cause ->
            call.application.log.error("Unhandled exception", cause)
            val session = call.sessions.get<UserSession>()
            call.respond(
                HttpStatusCode.InternalServerError,
                FreeMarkerContent(
                    "error.ftl",
                    mapOf("message" to (cause.message ?: "Unknown error"), "code" to 500, "session" to session, "msg" to call.messages(), "lang" to call.lang(), "siteConfig" to call.siteConfig()),
                    ""
                )
            )
        }
    }

    val userService = UserService()
    userService.seedAdminUser()

    // Daily audit log cleanup: remove records older than 6 months, keep at most 20 000 rows
    launch {
        while (true) {
            delay(24.hours)
            try {
                val deleted = AuditLogService.cleanup()
                if (deleted > 0) log.info("Audit log cleanup: removed $deleted old records")
            } catch (e: Exception) {
                log.error("Audit log cleanup failed", e)
            }
        }
    }

    // Every-6-hours appeal notification job
    val appealSubscriptionService = AppealSubscriptionService(appConfig)
    val urgentAppealService = UrgentAppealService()
    launch {
        // Track when each appeal was last notified (in-memory; resets on restart)
        val lastNotifiedAt = mutableMapOf<Int, java.time.LocalDateTime>()
        while (true) {
            delay(6.hours)
            try {
                val subscribedAppealIds = appealSubscriptionService.findSubscribedAppealIds()
                for (appealId in subscribedAppealIds) {
                    val appeal = urgentAppealService.getById(appealId) ?: continue
                    val lastNotified = lastNotifiedAt[appealId]
                    val hasNewUpdate = lastNotified == null ||
                        appeal.updates.any { it.createdAt.isAfter(lastNotified) }
                    if (hasNewUpdate) {
                        val latestUpdate = appeal.updates.maxByOrNull { it.createdAt }
                        val title = "📢 ${appeal.title}"
                        val body = latestUpdate?.content?.take(120) ?: "Có cập nhật mới từ lời khẩn cầu."
                        val count = appealSubscriptionService.notify(appealId, title, body)
                        lastNotifiedAt[appealId] = java.time.LocalDateTime.now()
                        if (count > 0) log.info("Appeal $appealId: notified $count subscribers")
                    }
                }
            } catch (e: Exception) {
                log.error("Appeal notification job failed", e)
            }
        }
    }

    routing {
        staticResources("/assets", "assets")
        static("/static") {
            staticRootFolder = File("static")
            files(".")
        }
        static("/uploads") {
            staticRootFolder = File("uploads")
            files(".")
        }
        // Firebase service worker – served dynamically so Firebase config is injected
        get("/firebase-messaging-sw.js") {
            val cfg = appConfig
            val content = """
importScripts('https://www.gstatic.com/firebasejs/10.12.0/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/10.12.0/firebase-messaging-compat.js');

firebase.initializeApp({
  apiKey: "${cfg.firebaseApiKey.escapeJs()}",
  authDomain: "${cfg.firebaseAuthDomain.escapeJs()}",
  projectId: "${cfg.firebaseProjectId.escapeJs()}",
  storageBucket: "${cfg.firebaseStorageBucket.escapeJs()}",
  messagingSenderId: "${cfg.firebaseMessagingSenderId.escapeJs()}",
  appId: "${cfg.firebaseAppId.escapeJs()}"
});

const messaging = firebase.messaging();
messaging.onBackgroundMessage(function(payload) {
  var n = payload.notification || {};
  self.registration.showNotification(n.title || 'Pet Rescue', {
    body: n.body || '',
    icon: '/static/icon.png'
  });
});
""".trimIndent()
            call.respondText(content, ContentType.Application.JavaScript)
        }
        urgentAppealRoutes(appConfig)
        authRoutes(userService)
        homeRoutes(appConfig)
        petRoutes()
        blogRoutes()
        donateRoutes()
        userRoutes()
        adoptionRoutes()
        rescueRoutes()
        configRoutes()
        profileRoutes()
        wishRoutes()
        auditRoutes()
    }
}
