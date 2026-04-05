package com.petrescue.routes

import com.petrescue.UserSession
import com.petrescue.i18n.lang
import com.petrescue.i18n.messages
import com.petrescue.i18n.siteConfig
import com.petrescue.models.Donation
import com.petrescue.services.DonationService
import io.ktor.http.*
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
            call.respond(FreeMarkerContent("donate/form.ftl", mapOf("session" to session, "msg" to call.messages(), "lang" to call.lang(), "siteConfig" to call.siteConfig()), ""))
        }

        post {
            val session = call.sessions.get<UserSession>()
            val params = call.receiveParameters()
            val donorName = params["donorName"] ?: ""
            val message = params["message"]
            if (donorName.isBlank()) {
                call.respond(HttpStatusCode.BadRequest)
                return@post
            }
            service.create(
                Donation(
                    donorName = donorName,
                    donorEmail = "",
                    amount = BigDecimal.ZERO,
                    message = message
                )
            )
            call.respond(HttpStatusCode.OK)
        }
    }
}
