package com.petrescue.routes

import com.petrescue.UserSession
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
        call.respond(FreeMarkerContent("auth/login.ftl", mapOf("error" to null), ""))
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
            call.respond(FreeMarkerContent("auth/login.ftl", mapOf("error" to "Invalid username or password"), ""))
        }
    }

    get("/register") {
        call.respond(FreeMarkerContent("auth/register.ftl", mapOf("error" to null), ""))
    }

    post("/register") {
        val params = call.receiveParameters()
        val username = params["username"] ?: ""
        val email = params["email"] ?: ""
        val password = params["password"] ?: ""
        val fullName = params["fullName"] ?: ""
        val user = userService.register(username, email, password, fullName)
        if (user != null) {
            call.sessions.set(UserSession(user.id, user.username, user.role))
            call.respondRedirect("/")
        } else {
            call.respond(FreeMarkerContent("auth/register.ftl", mapOf("error" to "Username or email already exists"), ""))
        }
    }

    get("/logout") {
        call.sessions.clear<UserSession>()
        call.respondRedirect("/login")
    }
}
