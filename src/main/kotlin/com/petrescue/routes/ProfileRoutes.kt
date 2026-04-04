package com.petrescue.routes

import com.petrescue.UserSession
import com.petrescue.i18n.Messages
import com.petrescue.services.UserService
import io.ktor.server.application.*
import io.ktor.server.freemarker.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import io.ktor.server.sessions.*

fun Route.profileRoutes() {
    val userService = UserService()

    get("/profile") {
        val session = call.sessions.get<UserSession>() ?: run {
            call.respondRedirect("/login")
            return@get
        }
        val lang = call.request.cookies["lang"] ?: "vi"
        val msg = Messages.forLang(lang)
        val user = userService.getById(session.userId)
        call.respond(
            FreeMarkerContent(
                "profile/form.ftl", mapOf(
                    "session" to session,
                    "msg" to msg,
                    "lang" to lang,
                    "user" to user,
                    "success" to false,
                    "error" to null
                ), ""
            )
        )
    }

    post("/profile") {
        val session = call.sessions.get<UserSession>() ?: run {
            call.respondRedirect("/login")
            return@post
        }
        val lang = call.request.cookies["lang"] ?: "vi"
        val msg = Messages.forLang(lang)
        val params = call.receiveParameters()

        val newEmail = params["email"]?.trim() ?: ""
        val newPhone = params["phone"]?.trim()?.takeIf { it.isNotBlank() }

        val existing = userService.getById(session.userId)
        if (existing == null) {
            call.respondRedirect("/login")
            return@post
        }

        // Check if email is taken by another account
        if (newEmail.isNotBlank() && newEmail != existing.email) {
            val emailOwner = userService.findByEmail(newEmail)
            if (emailOwner != null && emailOwner.id != session.userId) {
                call.respond(
                    FreeMarkerContent(
                        "profile/form.ftl", mapOf(
                            "session" to session,
                            "msg" to msg,
                            "lang" to lang,
                            "user" to existing,
                            "success" to false,
                            "error" to msg["profile_email_taken"]
                        ), ""
                    )
                )
                return@post
            }
        }

        val updated = existing.copy(
            email = if (newEmail.isNotBlank()) newEmail else existing.email,
            phone = newPhone ?: existing.phone
        )
        userService.update(updated)

        call.respond(
            FreeMarkerContent(
                "profile/form.ftl", mapOf(
                    "session" to session,
                    "msg" to msg,
                    "lang" to lang,
                    "user" to updated,
                    "success" to true,
                    "error" to null
                ), ""
            )
        )
    }
}
