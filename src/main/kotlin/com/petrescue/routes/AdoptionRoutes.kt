package com.petrescue.routes

import com.petrescue.UserSession
import com.petrescue.i18n.lang
import com.petrescue.i18n.messages
import com.petrescue.i18n.siteConfig
import com.petrescue.models.Adoption
import com.petrescue.services.AdoptionService
import com.petrescue.services.AuditLogService
import com.petrescue.services.PetService
import io.ktor.server.application.*
import io.ktor.server.freemarker.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import io.ktor.server.sessions.*

fun Route.adoptionRoutes() {
    val service = AdoptionService()
    val petService = PetService()

    route("/adoptions") {
        get {
            val session = call.sessions.get<UserSession>() ?: run {
                call.respondRedirect("/register?redirect=/adoptions")
                return@get
            }
            val status = call.request.queryParameters["status"]
            val adoptions = if (session.role in listOf("ADMIN", "VOLUNTEER")) {
                service.getAll(status)
            } else {
                service.getByUser(session.userId, status)
            }
            call.respond(FreeMarkerContent("adoptions/list.ftl", mapOf("adoptions" to adoptions, "session" to session, "msg" to call.messages(), "lang" to call.lang(), "status" to status, "siteConfig" to call.siteConfig()), ""))
        }

        get("/request/{petId}") {
            val session = call.sessions.get<UserSession>() ?: run {
                val petId = call.parameters["petId"]?.toIntOrNull()
                if (petId != null) {
                    call.respondRedirect("/register?redirect=/adoptions/request/$petId")
                } else {
                    call.respondRedirect("/register?redirect=/adoptions")
                }
                return@get
            }
            val petId = call.parameters["petId"]?.toIntOrNull() ?: return@get
            val pet = petService.getById(petId) ?: return@get
            if (pet.status != "READY_TO_ADOPT") {
                call.respondRedirect("/pets/$petId")
                return@get
            }
            call.respond(FreeMarkerContent("adoptions/form.ftl", mapOf("pet" to pet, "session" to session, "error" to null, "msg" to call.messages(), "lang" to call.lang(), "siteConfig" to call.siteConfig()), ""))
        }

        post("/request/{petId}") {
            val session = call.sessions.get<UserSession>() ?: run {
                val petId = call.parameters["petId"]?.toIntOrNull()
                if (petId != null) {
                    call.respondRedirect("/register?redirect=/adoptions/request/$petId")
                } else {
                    call.respondRedirect("/register?redirect=/adoptions")
                }
                return@post
            }
            val petId = call.parameters["petId"]?.toIntOrNull() ?: return@post
            val pet = petService.getById(petId) ?: return@post
            val params = call.receiveParameters()
            if (pet.status != "READY_TO_ADOPT") {
                val msg = call.messages()
                val error = msg["adoption_error_pet_not_ready"] ?: "adoption_error_pet_not_ready"
                call.respond(FreeMarkerContent("adoptions/form.ftl", mapOf("pet" to pet, "session" to session, "error" to error, "msg" to msg, "lang" to call.lang(), "siteConfig" to call.siteConfig()), ""))
                return@post
            }
            val adoption = try {
                service.create(
                    Adoption(
                        petId = petId,
                        userId = session.userId,
                        phone = params["phone"] ?: "",
                        facebookLink = params["facebookLink"] ?: "",
                        notes = params["notes"]
                    )
                )
            } catch (e: IllegalStateException) {
                val msg = call.messages()
                val error = msg[e.message] ?: e.message
                call.respond(FreeMarkerContent("adoptions/form.ftl", mapOf("pet" to pet, "session" to session, "error" to error, "msg" to msg, "lang" to call.lang(), "siteConfig" to call.siteConfig()), ""))
                return@post
            }
            AuditLogService.log("CREATE", "Adoption", adoption.id, session.userId, session.username, "petId=$petId")
            call.respondRedirect("/adoptions")
        }

        post("/{id}/confirm") {
            val session = call.sessions.get<UserSession>() ?: run { call.respondRedirect("/login"); return@post }
            if (session.role !in listOf("ADMIN", "VOLUNTEER")) { call.respondRedirect("/"); return@post }
            val id = call.parameters["id"]?.toIntOrNull() ?: return@post
            service.confirm(id, session.userId)
            AuditLogService.log("UPDATE", "Adoption", id, session.userId, session.username, "status=CONFIRMED")
            call.respondRedirect("/adoptions")
        }

        post("/{id}/finish") {
            val session = call.sessions.get<UserSession>() ?: run { call.respondRedirect("/login"); return@post }
            if (session.role !in listOf("ADMIN", "VOLUNTEER")) { call.respondRedirect("/"); return@post }
            val id = call.parameters["id"]?.toIntOrNull() ?: return@post
            service.finish(id, session.userId)
            AuditLogService.log("UPDATE", "Adoption", id, session.userId, session.username, "status=FINISHED")
            call.respondRedirect("/adoptions")
        }

        post("/{id}/cancel") {
            val session = call.sessions.get<UserSession>() ?: run { call.respondRedirect("/login"); return@post }
            if (session.role !in listOf("ADMIN", "VOLUNTEER")) { call.respondRedirect("/"); return@post }
            val id = call.parameters["id"]?.toIntOrNull() ?: return@post
            val params = call.receiveParameters()
            service.cancel(id, session.userId, params["reason"])
            AuditLogService.log("UPDATE", "Adoption", id, session.userId, session.username, "status=CANCELLED")
            call.respondRedirect("/adoptions")
        }
    }
}
