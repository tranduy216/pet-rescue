package com.petrescue.routes

import com.petrescue.UserSession
import com.petrescue.i18n.lang
import com.petrescue.i18n.messages
import com.petrescue.services.AuditLogService
import io.ktor.server.application.*
import io.ktor.server.freemarker.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import io.ktor.server.sessions.*

fun Route.auditRoutes() {
    get("/audit") {
        val session = call.sessions.get<UserSession>() ?: run { call.respondRedirect("/login"); return@get }
        if (session.role != "ADMIN") { call.respondRedirect("/"); return@get }
        val logs = AuditLogService.getAll()
        call.respond(FreeMarkerContent("audit/list.ftl", mapOf("logs" to logs, "session" to session, "msg" to call.messages(), "lang" to call.lang()), ""))
    }
}
