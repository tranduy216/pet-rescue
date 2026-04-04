package com.petrescue.routes

import com.petrescue.UserSession
import com.petrescue.i18n.lang
import com.petrescue.i18n.messages
import com.petrescue.models.Rescue
import com.petrescue.services.AuditLogService
import com.petrescue.services.RescueService
import com.petrescue.services.UserService
import io.ktor.server.application.*
import io.ktor.server.freemarker.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import io.ktor.server.sessions.*

fun Route.rescueRoutes() {
    val service = RescueService()
    val userService = UserService()

    route("/rescues") {
        get {
            val session = call.sessions.get<UserSession>()
            val status = call.request.queryParameters["status"]
            val rescues = service.getAll(status)
            call.respond(FreeMarkerContent("rescues/list.ftl", mapOf("rescues" to rescues, "session" to session, "msg" to call.messages(), "lang" to call.lang(), "status" to status), ""))
        }

        get("/new") {
            val session = call.sessions.get<UserSession>() ?: run { call.respondRedirect("/login"); return@get }
            val user = userService.getById(session.userId)
            call.respond(FreeMarkerContent("rescues/form.ftl", mapOf("session" to session, "user" to user, "error" to null, "msg" to call.messages(), "lang" to call.lang()), ""))
        }

        post("/new") {
            val session = call.sessions.get<UserSession>() ?: run { call.respondRedirect("/login"); return@post }
            val params = call.receiveParameters()
            val user = userService.getById(session.userId)
            val contactInfo = params["contactInfo"]?.takeIf { it.isNotBlank() }
                ?: user?.phone?.takeIf { it.isNotBlank() }
                ?: ""
            val rescue = service.create(
                Rescue(
                    userId = session.userId,
                    location = params["location"] ?: "",
                    description = params["description"] ?: "",
                    contactInfo = contactInfo
                )
            )
            AuditLogService.log("CREATE", "Rescue", rescue.id, session.userId, session.username)
            call.respondRedirect("/rescues")
        }

        post("/{id}/status") {
            val session = call.sessions.get<UserSession>() ?: run { call.respondRedirect("/login"); return@post }
            if (session.role !in listOf("ADMIN", "VOLUNTEER")) { call.respondRedirect("/rescues"); return@post }
            val id = call.parameters["id"]?.toIntOrNull() ?: return@post
            val params = call.receiveParameters()
            val newStatus = params["status"] ?: "NEW"
            service.updateStatus(id, newStatus)
            AuditLogService.log("UPDATE", "Rescue", id, session.userId, session.username, "status=$newStatus")
            call.respondRedirect("/rescues")
        }

        post("/{id}/delete") {
            val session = call.sessions.get<UserSession>() ?: run { call.respondRedirect("/login"); return@post }
            if (session.role != "ADMIN") { call.respondRedirect("/rescues"); return@post }
            val id = call.parameters["id"]?.toIntOrNull() ?: return@post
            service.delete(id)
            call.respondRedirect("/rescues")
        }
    }
}
