package com.petrescue

import com.petrescue.config.AppConfig
import com.petrescue.database.DatabaseFactory
import com.petrescue.i18n.lang
import com.petrescue.i18n.messages
import com.petrescue.plugins.AuthorizationPlugin
import com.petrescue.routes.*
import com.petrescue.services.UserService
import com.petrescue.storage.LocalStorageService
import com.petrescue.storage.R2StorageService
import com.petrescue.storage.StorageService
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
import org.slf4j.event.Level
import java.io.File

data class UserSession(val userId: Int, val username: String, val role: String) : Principal

fun Application.module() {
    val appConfig = AppConfig(environment.config)

    DatabaseFactory.init(appConfig)

    val storage: StorageService = when (appConfig.storageType.lowercase()) {
        "r2" -> R2StorageService(
            endpoint = appConfig.r2Endpoint,
            bucket = appConfig.r2Bucket,
            accessKey = appConfig.r2AccessKey,
            secretKey = appConfig.r2SecretKey,
            publicUrl = appConfig.r2PublicUrl
        )
        else -> {
            File(appConfig.storagePath).mkdirs()
            LocalStorageService(appConfig.storagePath)
        }
    }

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
                    mapOf("message" to "Page not found", "code" to 404, "session" to session, "msg" to call.messages(), "lang" to call.lang()),
                    ""
                )
            )
        }
        status(HttpStatusCode.InternalServerError) { call, _ ->
            val session = call.sessions.get<UserSession>()
            call.respond(
                FreeMarkerContent(
                    "error.ftl",
                    mapOf("message" to "Internal server error", "code" to 500, "session" to session, "msg" to call.messages(), "lang" to call.lang()),
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
                    mapOf("message" to (cause.message ?: "Unknown error"), "code" to 500, "session" to session, "msg" to call.messages(), "lang" to call.lang()),
                    ""
                )
            )
        }
    }

    val userService = UserService()

    routing {
        staticResources("/assets", "assets")
        static("/static") {
            staticRootFolder = File("static")
            files(".")
        }
        // Serve local uploads only when not using R2
        if (appConfig.storageType.lowercase() != "r2") {
            static("/uploads") {
                staticRootFolder = File(appConfig.storagePath)
                files(".")
            }
        }
        authRoutes(userService)
        homeRoutes()
        petRoutes(storage)
        blogRoutes(storage)
        donateRoutes()
        userRoutes()
        adoptionRoutes()
        rescueRoutes()
        configRoutes()
        profileRoutes()
        wishRoutes()
    }
}
