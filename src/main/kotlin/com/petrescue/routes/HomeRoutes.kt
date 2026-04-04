package com.petrescue.routes

import com.petrescue.UserSession
import com.petrescue.i18n.lang
import com.petrescue.i18n.messages
import com.petrescue.services.BlogService
import com.petrescue.services.DonationService
import com.petrescue.services.PetService
import com.petrescue.services.SiteConfigService
import io.ktor.server.application.*
import io.ktor.server.freemarker.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import io.ktor.server.sessions.*

fun Route.homeRoutes() {
    val petService = PetService()
    val blogService = BlogService()
    val donationService = DonationService()
    val siteConfigService = SiteConfigService()

    get("/") {
        val session = call.sessions.get<UserSession>()

        val featuredPets = petService.getAll(status = "AVAILABLE").take(6)
        val recentPets = petService.getRecent(3)
        val blogs = blogService.getAll(publishedOnly = true).take(3)
        val approvedWishes = donationService.getApproved().take(3)

        val statsAvailable = petService.countByStatus("AVAILABLE")
        val statsAdopted = petService.countByStatus("ADOPTED")
        val statsTreated = petService.countAll()
        val statsDonors = donationService.countDonors()

        val siteConfig = siteConfigService.getAll()

        call.respond(
            FreeMarkerContent(
                "index.ftl", mapOf(
                    "session" to session,
                    "pets" to featuredPets,
                    "recentPets" to recentPets,
                    "blogs" to blogs,
                    "approvedWishes" to approvedWishes,
                    "statsAvailable" to statsAvailable,
                    "statsAdopted" to statsAdopted,
                    "statsTreated" to statsTreated,
                    "statsDonors" to statsDonors,
                    "msg" to call.messages(),
                    "lang" to call.lang(),
                    "siteConfig" to siteConfig
                ), ""
            )
        )
    }

    // Language toggle: set cookie and redirect back
    get("/lang/{code}") {
        val code = call.parameters["code"] ?: "vi"
        val referer = call.request.headers["Referer"] ?: "/"
        call.response.cookies.append("lang", code, path = "/", maxAge = 86400L * 365)
        call.respondRedirect(referer)
    }
}
