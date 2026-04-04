package com.petrescue

import com.petrescue.config.AppConfig
import com.petrescue.database.DatabaseFactory
import com.petrescue.plugins.AuthorizationPlugin
import com.petrescue.routes.*
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
import org.slf4j.event.Level
import java.io.File

data class UserSession(val userId: Int, val username: String, val role: String) : Principal

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
            call.respond(FreeMarkerContent("error.ftl", mapOf("message" to "Page not found", "code" to 404), ""))
        }
        status(HttpStatusCode.InternalServerError) { call, _ ->
            call.respond(FreeMarkerContent("error.ftl", mapOf("message" to "Internal server error", "code" to 500), ""))
        }
        exception<Throwable> { call, cause ->
            call.application.log.error("Unhandled exception", cause)
            call.respond(
                HttpStatusCode.InternalServerError,
                FreeMarkerContent("error.ftl", mapOf("message" to (cause.message ?: "Unknown error"), "code" to 500), "")
            )
        }
    }

    val userService = UserService()
    userService.seedAdminUser()

    routing {
        static("/static") {
            staticRootFolder = File("static")
            files(".")
        }
        authRoutes(userService)
        homeRoutes()
        petRoutes()
        blogRoutes()
        donateRoutes()
        userRoutes()
        financeRoutes()
        adoptionRoutes()
        rescueRoutes()
        configRoutes()
        profileRoutes()
    }
}
