package com.petrescue.routes

import com.petrescue.UserSession
import com.petrescue.i18n.lang
import com.petrescue.i18n.messages
import com.petrescue.models.Adoption
import com.petrescue.services.AdoptionService
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
            val session = call.sessions.get<UserSession>()
            val adoptions = if (session?.role in listOf("ADMIN", "VOLUNTEER")) {
                service.getAll()
            } else {
                service.getByUser(session!!.userId)
            }
            call.respond(FreeMarkerContent("adoptions/list.ftl", mapOf("adoptions" to adoptions, "session" to session, "msg" to call.messages(), "lang" to call.lang()), ""))
        }

        get("/request/{petId}") {
            val session = call.sessions.get<UserSession>()
            val petId = call.parameters["petId"]?.toIntOrNull() ?: return@get
            val pet = petService.getById(petId) ?: return@get
            call.respond(FreeMarkerContent("adoptions/form.ftl", mapOf("pet" to pet, "session" to session, "error" to null), ""))
        }

        post("/request/{petId}") {
            val session = call.sessions.get<UserSession>()
            val petId = call.parameters["petId"]?.toIntOrNull() ?: return@post
            val params = call.receiveParameters()
            service.create(
                Adoption(
                    petId = petId,
                    userId = session!!.userId,
                    phone = params["phone"] ?: "",
                    facebookLink = params["facebookLink"] ?: "",
                    notes = params["notes"]
                )
            )
            call.respondRedirect("/adoptions")
        }

        post("/{id}/approve") {
            val session = call.sessions.get<UserSession>()
            val id = call.parameters["id"]?.toIntOrNull() ?: return@post
            service.approve(id, session!!.userId)
            call.respondRedirect("/adoptions")
        }

        post("/{id}/cancel") {
            val session = call.sessions.get<UserSession>()
            val id = call.parameters["id"]?.toIntOrNull() ?: return@post
            val params = call.receiveParameters()
            service.cancel(id, session!!.userId, params["reason"])
            call.respondRedirect("/adoptions")
        }
    }
}
