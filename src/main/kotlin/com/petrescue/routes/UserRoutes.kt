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

fun Route.userRoutes() {
    val service = UserService()

    route("/users") {
        get {
            val session = call.sessions.get<UserSession>()
            val role = call.request.queryParameters["role"]
            val users = service.getAll(role)
            call.respond(FreeMarkerContent("users/list.ftl", mapOf("users" to users, "session" to session, "msg" to call.messages(), "lang" to call.lang(), "role" to role), ""))
        }

        get("/new") {
            val session = call.sessions.get<UserSession>()
            call.respond(FreeMarkerContent("users/form.ftl", mapOf("user" to null, "session" to session, "error" to null, "msg" to call.messages(), "lang" to call.lang()), ""))
        }

        post("/new") {
            val session = call.sessions.get<UserSession>()
            val params = call.receiveParameters()
            val username = params["username"] ?: ""
            val email = params["email"] ?: ""
            val password = params["password"] ?: ""
            val fullName = params["fullName"] ?: ""
            val role = params["role"] ?: "USER"
            val user = service.register(username, email, password, fullName)
            if (user != null) {
                service.update(user.copy(role = role))
                call.respondRedirect("/config?tab=users")
            } else {
                call.respond(FreeMarkerContent("users/form.ftl", mapOf("user" to null, "session" to session, "error" to "Username or email already exists", "msg" to call.messages(), "lang" to call.lang()), ""))
            }
        }

        get("/{id}/edit") {
            val session = call.sessions.get<UserSession>()
            val id = call.parameters["id"]?.toIntOrNull() ?: return@get
            val user = service.getById(id)
            call.respond(FreeMarkerContent("users/form.ftl", mapOf("user" to user, "session" to session, "error" to null, "msg" to call.messages(), "lang" to call.lang()), ""))
        }

        post("/{id}/edit") {
            val session = call.sessions.get<UserSession>()
            val id = call.parameters["id"]?.toIntOrNull() ?: return@post
            val params = call.receiveParameters()
            val existing = service.getById(id) ?: return@post
            service.update(
                existing.copy(
                    email = params["email"] ?: existing.email,
                    fullName = params["fullName"] ?: existing.fullName,
                    phone = params["phone"],
                    facebookLink = params["facebookLink"],
                    role = params["role"] ?: existing.role,
                    active = params["isActive"] == "true"
                )
            )
            call.respondRedirect("/config?tab=users")
        }

        post("/{id}/delete") {
            val session = call.sessions.get<UserSession>()
            val id = call.parameters["id"]?.toIntOrNull() ?: return@post
            service.delete(id)
            call.respondRedirect("/config?tab=users")
        }
    }
}
