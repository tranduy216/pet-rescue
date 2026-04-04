package com.petrescue.routes

import com.petrescue.UserSession
import com.petrescue.models.Blog
import com.petrescue.services.BlogService
import io.ktor.server.application.*
import io.ktor.server.freemarker.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import io.ktor.server.sessions.*

fun Route.blogRoutes() {
    val service = BlogService()

    route("/blog") {
        get {
            val session = call.sessions.get<UserSession>()
            val publishedOnly = session?.role !in listOf("ADMIN", "VOLUNTEER")
            val blogs = service.getAll(publishedOnly)
            call.respond(FreeMarkerContent("blog/list.ftl", mapOf("blogs" to blogs, "session" to session), ""))
        }

        get("/new") {
            val session = call.sessions.get<UserSession>() ?: run { call.respondRedirect("/login"); return@get }
            if (session.role !in listOf("ADMIN", "VOLUNTEER")) { call.respondRedirect("/blog"); return@get }
            call.respond(FreeMarkerContent("blog/form.ftl", mapOf("blog" to null, "session" to session, "error" to null), ""))
        }

        post("/new") {
            val session = call.sessions.get<UserSession>() ?: run { call.respondRedirect("/login"); return@post }
            if (session.role !in listOf("ADMIN", "VOLUNTEER")) { call.respondRedirect("/blog"); return@post }
            val params = call.receiveParameters()
            service.create(
                Blog(
                    title = params["title"] ?: "",
                    content = params["content"] ?: "",
                    authorId = session.userId,
                    tags = params["tags"],
                    published = params["isPublished"] == "true"
                )
            )
            call.respondRedirect("/blog")
        }

        get("/{id}") {
            val session = call.sessions.get<UserSession>()
            val id = call.parameters["id"]?.toIntOrNull() ?: return@get
            val blog = service.getById(id) ?: return@get
            service.incrementViews(id)
            call.respond(FreeMarkerContent("blog/detail.ftl", mapOf("blog" to blog, "session" to session), ""))
        }

        get("/{id}/edit") {
            val session = call.sessions.get<UserSession>() ?: run { call.respondRedirect("/login"); return@get }
            if (session.role !in listOf("ADMIN", "VOLUNTEER")) { call.respondRedirect("/blog"); return@get }
            val id = call.parameters["id"]?.toIntOrNull() ?: return@get
            val blog = service.getById(id)
            call.respond(FreeMarkerContent("blog/form.ftl", mapOf("blog" to blog, "session" to session, "error" to null), ""))
        }

        post("/{id}/edit") {
            val session = call.sessions.get<UserSession>() ?: run { call.respondRedirect("/login"); return@post }
            if (session.role !in listOf("ADMIN", "VOLUNTEER")) { call.respondRedirect("/blog"); return@post }
            val id = call.parameters["id"]?.toIntOrNull() ?: return@post
            val existing = service.getById(id) ?: return@post
            val params = call.receiveParameters()
            service.update(
                existing.copy(
                    title = params["title"] ?: existing.title,
                    content = params["content"] ?: existing.content,
                    tags = params["tags"],
                    published = params["isPublished"] == "true"
                )
            )
            call.respondRedirect("/blog/$id")
        }

        post("/{id}/delete") {
            val session = call.sessions.get<UserSession>() ?: run { call.respondRedirect("/login"); return@post }
            if (session.role != "ADMIN") { call.respondRedirect("/blog"); return@post }
            val id = call.parameters["id"]?.toIntOrNull() ?: return@post
            service.delete(id)
            call.respondRedirect("/blog")
        }
    }
}
