package com.petrescue.routes

import com.petrescue.UserSession
import com.petrescue.i18n.lang
import com.petrescue.i18n.messages
import com.petrescue.services.DonationService
import io.ktor.server.application.*
import io.ktor.server.freemarker.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import io.ktor.server.sessions.*

fun Route.wishRoutes() {
    val service = DonationService()

    route("/wishes") {
        get {
            val session = call.sessions.get<UserSession>()
            val status = call.request.queryParameters["status"]
            val wishes = service.getAll(status)
            call.respond(
                FreeMarkerContent(
                    "wishes/list.ftl",
                    mapOf("wishes" to wishes, "session" to session, "msg" to call.messages(), "lang" to call.lang(), "status" to status),
                    ""
                )
            )
        }

        post("/{id}/approve") {
            val id = call.parameters["id"]?.toIntOrNull() ?: return@post
            service.approve(id)
            call.respondRedirect("/config?tab=wishes")
        }

        post("/{id}/receive") {
            val id = call.parameters["id"]?.toIntOrNull() ?: return@post
            service.markReceived(id)
            call.respondRedirect("/config?tab=wishes")
        }

        post("/{id}/delete") {
            val id = call.parameters["id"]?.toIntOrNull() ?: return@post
            service.updateStatus(id, "DELETED")
            call.respondRedirect("/config?tab=wishes")
        }
    }
}
