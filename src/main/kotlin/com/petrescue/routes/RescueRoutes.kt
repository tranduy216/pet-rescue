package com.petrescue.routes

import com.petrescue.UserSession
import com.petrescue.i18n.lang
import com.petrescue.i18n.messages
import com.petrescue.models.Rescue
import com.petrescue.services.RescueService
import io.ktor.server.application.*
import io.ktor.server.freemarker.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import io.ktor.server.sessions.*

fun Route.rescueRoutes() {
    val service = RescueService()

    route("/rescues") {
        get {
            val session = call.sessions.get<UserSession>()
            val rescues = service.getAll()
            call.respond(FreeMarkerContent("rescues/list.ftl", mapOf("rescues" to rescues, "session" to session, "msg" to call.messages(), "lang" to call.lang()), ""))
        }

        get("/new") {
            val session = call.sessions.get<UserSession>()
            call.respond(FreeMarkerContent("rescues/form.ftl", mapOf("session" to session, "error" to null, "msg" to call.messages(), "lang" to call.lang()), ""))
        }

        post("/new") {
            val session = call.sessions.get<UserSession>()
            val params = call.receiveParameters()
            service.create(
                Rescue(
                    userId = session?.userId,
                    location = params["location"] ?: "",
                    description = params["description"] ?: "",
                    contactInfo = params["contactInfo"] ?: ""
                )
            )
            call.respondRedirect("/rescues")
        }

        post("/{id}/status") {
            val session = call.sessions.get<UserSession>()
            val id = call.parameters["id"]?.toIntOrNull() ?: return@post
            val params = call.receiveParameters()
            service.updateStatus(id, params["status"] ?: "REPORTED")
            call.respondRedirect("/rescues")
        }

        post("/{id}/delete") {
            val session = call.sessions.get<UserSession>()
            val id = call.parameters["id"]?.toIntOrNull() ?: return@post
            service.delete(id)
            call.respondRedirect("/rescues")
        }
    }
}
