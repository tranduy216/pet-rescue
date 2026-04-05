package com.petrescue.routes

import com.petrescue.UserSession
import com.petrescue.i18n.lang
import com.petrescue.i18n.messages
import com.petrescue.i18n.siteConfig
import com.petrescue.services.UserService
import io.ktor.server.application.*
import io.ktor.server.freemarker.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import io.ktor.server.sessions.*

fun Route.authRoutes(userService: UserService) {
    get("/login") {
        val session = call.sessions.get<UserSession>()
        if (session != null) {
            call.respondRedirect("/")
            return@get
        }
        call.respond(FreeMarkerContent("auth/login.ftl", mapOf("error" to null, "msg" to call.messages(), "lang" to call.lang(), "siteConfig" to call.siteConfig()), ""))
    }

    post("/login") {
        val params = call.receiveParameters()
        val username = params["username"] ?: ""
        val password = params["password"] ?: ""
        val user = userService.login(username, password)
        if (user != null) {
            call.sessions.set(UserSession(user.id, user.username, user.role))
            call.respondRedirect("/")
        } else {
            call.respond(FreeMarkerContent("auth/login.ftl", mapOf("error" to "Invalid username or password", "msg" to call.messages(), "lang" to call.lang(), "siteConfig" to call.siteConfig()), ""))
        }
    }

    get("/register") {
        val redirect = call.request.queryParameters["redirect"] ?: ""
        call.respond(FreeMarkerContent("auth/register.ftl", mapOf("error" to null, "redirect" to redirect, "msg" to call.messages(), "lang" to call.lang(), "siteConfig" to call.siteConfig()), ""))
    }

    post("/register") {
        val params = call.receiveParameters()
        val username = params["username"] ?: ""
        val email = params["email"] ?: ""
        val password = params["password"] ?: ""
        val fullName = params["fullName"] ?: ""
        val phone = params["phone"]?.trim()?.takeIf { it.isNotBlank() }
        val redirect = params["redirect"]?.takeIf { it.startsWith("/") } ?: "/"
        val user = userService.register(username, email, password, fullName, phone)
        if (user != null) {
            call.sessions.set(UserSession(user.id, user.username, user.role))
            call.respondRedirect(redirect)
        } else {
            call.respond(FreeMarkerContent("auth/register.ftl", mapOf("error" to "Username or email already exists", "redirect" to redirect, "msg" to call.messages(), "lang" to call.lang(), "siteConfig" to call.siteConfig()), ""))
        }
    }

    get("/logout") {
        call.sessions.clear<UserSession>()
        call.respondRedirect("/login")
    }
}
