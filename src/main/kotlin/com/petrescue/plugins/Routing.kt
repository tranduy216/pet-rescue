package com.petrescue.plugins

import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*

fun Application.configureRouting() {
    routing {
        get("/") {
            call.respondText("Pet Rescue API is running!")
        }
        get("/health") {
            call.respondText("OK")
        }
    }
}
