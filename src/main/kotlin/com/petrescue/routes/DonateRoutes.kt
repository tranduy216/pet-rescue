package com.petrescue.routes

import com.petrescue.UserSession
import com.petrescue.i18n.lang
import com.petrescue.i18n.messages
import com.petrescue.models.Donation
import com.petrescue.services.DonationService
import io.ktor.server.application.*
import io.ktor.server.freemarker.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import io.ktor.server.sessions.*
import java.math.BigDecimal

fun Route.donateRoutes() {
    val service = DonationService()

    route("/donate") {
        get {
            val session = call.sessions.get<UserSession>()
            call.respond(FreeMarkerContent("donate/form.ftl", mapOf("session" to session, "success" to false, "error" to null, "msg" to call.messages(), "lang" to call.lang()), ""))
        }

        post {
            val session = call.sessions.get<UserSession>()
            val params = call.receiveParameters()
            val donation = service.create(
                Donation(
                    donorName = params["donorName"] ?: "",
                    donorEmail = params["donorEmail"] ?: "",
                    amount = params["amount"]?.toBigDecimalOrNull() ?: BigDecimal.ZERO,
                    message = params["message"]
                )
            )
            call.respond(
                FreeMarkerContent(
                    "donate/form.ftl",
                    mapOf("session" to session, "success" to true, "error" to null, "donation" to donation, "msg" to call.messages(), "lang" to call.lang()),
                    ""
                )
            )
        }
    }

    route("/donations") {
        get {
            val session = call.sessions.get<UserSession>()
            val donations = service.getAll()
            val total = service.getTotalConfirmed()
            call.respond(FreeMarkerContent("donate/list.ftl", mapOf("donations" to donations, "total" to total, "session" to session, "msg" to call.messages(), "lang" to call.lang()), ""))
        }

        post("/{id}/confirm") {
            val session = call.sessions.get<UserSession>()
            if (session == null || session.role != "ADMIN") {
                call.respondRedirect("/donations")
                return@post
            }
            val id = call.parameters["id"]?.toIntOrNull() ?: return@post
            service.updateStatus(id, "CONFIRMED")
            call.respondRedirect("/donations")
        }

        post("/{id}/cancel") {
            val session = call.sessions.get<UserSession>()
            if (session == null || session.role != "ADMIN") {
                call.respondRedirect("/donations")
                return@post
            }
            val id = call.parameters["id"]?.toIntOrNull() ?: return@post
            service.updateStatus(id, "CANCELLED")
            call.respondRedirect("/donations")
        }
    }
}
