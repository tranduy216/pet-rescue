package com.petrescue.routes

import com.petrescue.UserSession
import com.petrescue.i18n.lang
import com.petrescue.i18n.messages
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
        call.respond(FreeMarkerContent("auth/login.ftl", mapOf("error" to null, "msg" to call.messages(), "lang" to call.lang()), ""))
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
            call.respond(FreeMarkerContent("auth/login.ftl", mapOf("error" to "Invalid username or password", "msg" to call.messages(), "lang" to call.lang()), ""))
        }
    }

    get("/register") {
        call.respond(FreeMarkerContent("auth/register.ftl", mapOf("error" to null, "msg" to call.messages(), "lang" to call.lang()), ""))
    }

    post("/register") {
        val params = call.receiveParameters()
        val username = params["username"] ?: ""
        val email = params["email"] ?: ""
        val password = params["password"] ?: ""
        val fullName = params["fullName"] ?: ""
        val phone = params["phone"]?.trim()?.takeIf { it.isNotBlank() }

        val validationError = when {
            username.isBlank() ->
                "Username is required"
            !username.lowercase().trim().matches(Regex("^[a-z0-9_]+$")) ->
                "Username can only contain letters (a–z), digits, and underscores — no spaces or special characters"
            email.isBlank() ->
                "Email is required"
            !email.matches(Regex("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$")) ->
                "Invalid email format"
            phone != null && !phone.matches(Regex("^[+\\d][\\d\\s\\-().]{5,19}$")) ->
                "Invalid phone number format"
            else -> null
        }

        if (validationError != null) {
            call.respond(
                FreeMarkerContent(
                    "auth/register.ftl",
                    mapOf("error" to validationError, "msg" to call.messages(), "lang" to call.lang()),
                    ""
                )
            )
            return@post
        }

        val user = userService.register(username, email, password, fullName, phone)
        if (user != null) {
            call.sessions.set(UserSession(user.id, user.username, user.role))
            call.respondRedirect("/")
        } else {
            call.respond(FreeMarkerContent("auth/register.ftl", mapOf("error" to "Username or email already exists", "msg" to call.messages(), "lang" to call.lang()), ""))
        }
    }

    get("/logout") {
        call.sessions.clear<UserSession>()
        call.respondRedirect("/login")
    }
}
