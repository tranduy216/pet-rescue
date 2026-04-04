package com.petrescue.routes

import com.petrescue.UserSession
import com.petrescue.services.BlogService
import com.petrescue.services.PetService
import io.ktor.server.application.*
import io.ktor.server.freemarker.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import io.ktor.server.sessions.*

fun Route.homeRoutes() {
    val petService = PetService()
    val blogService = BlogService()

    get("/") {
        val session = call.sessions.get<UserSession>()
        val pets = petService.getAll(status = "AVAILABLE").take(6)
        val blogs = blogService.getAll(publishedOnly = true).take(3)
        call.respond(
            FreeMarkerContent(
                "index.ftl", mapOf(
                    "session" to session,
                    "pets" to pets,
                    "blogs" to blogs
                ), ""
            )
        )
    }
}
