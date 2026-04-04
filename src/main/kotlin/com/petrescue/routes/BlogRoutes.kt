package com.petrescue.routes

import com.petrescue.UserSession
import com.petrescue.i18n.lang
import com.petrescue.i18n.messages
import com.petrescue.models.Blog
import com.petrescue.services.BlogService
import io.ktor.http.*
import io.ktor.http.content.*
import io.ktor.server.application.*
import io.ktor.server.freemarker.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import io.ktor.server.sessions.*
import java.io.File
import java.util.UUID

fun Route.blogRoutes() {
    val service = BlogService()

    post("/blog/upload-image") {
        val allowedExtensions = setOf("jpg", "jpeg", "png", "gif", "webp")
        val multipart = call.receiveMultipart()
        var url = ""
        multipart.forEachPart { part ->
            if (part is PartData.FileItem && part.originalFileName?.isNotBlank() == true) {
                val rawExt = part.originalFileName!!.substringAfterLast('.', "").lowercase()
                val ext = rawExt.filter { it.isLetterOrDigit() }.take(10)
                if (ext in allowedExtensions) {
                    val fileName = "${UUID.randomUUID()}.$ext"
                    val dir = File("uploads/blog")
                    dir.mkdirs()
                    val file = File(dir, fileName)
                    part.streamProvider().use { input -> file.outputStream().use { input.copyTo(it) } }
                    url = "/uploads/blog/$fileName"
                }
            }
            part.dispose()
        }
        if (url.isNotEmpty()) {
            call.respond(mapOf("url" to url))
        } else {
            call.respond(HttpStatusCode.BadRequest, mapOf("error" to "No valid image file uploaded"))
        }
    }

    route("/blog") {
        get {
            val session = call.sessions.get<UserSession>()
            val publishedOnly = session?.role !in listOf("ADMIN", "VOLUNTEER")
            val filterStatus = if (publishedOnly) null else call.request.queryParameters["status"]
            val blogs = service.getAll(publishedOnly, filterStatus)
            call.respond(
                FreeMarkerContent(
                    "blog/list.ftl",
                    mapOf("blogs" to blogs, "session" to session, "msg" to call.messages(), "lang" to call.lang(), "status" to filterStatus),
                    ""
                )
            )
        }

        get("/new") {
            val session = call.sessions.get<UserSession>()
            call.respond(
                FreeMarkerContent(
                    "blog/form.ftl",
                    mapOf("blog" to null, "session" to session, "error" to null, "msg" to call.messages(), "lang" to call.lang()),
                    ""
                )
            )
        }

        post("/new") {
            val session = call.sessions.get<UserSession>()
            val params = call.receiveParameters()
            service.create(
                Blog(
                    title = params["title"] ?: "",
                    content = params["content"] ?: "",
                    authorId = session!!.userId,
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
            call.respond(
                FreeMarkerContent(
                    "blog/detail.ftl",
                    mapOf("blog" to blog, "session" to session, "msg" to call.messages(), "lang" to call.lang()),
                    ""
                )
            )
        }

        get("/{id}/edit") {
            val session = call.sessions.get<UserSession>()
            val id = call.parameters["id"]?.toIntOrNull() ?: return@get
            val blog = service.getById(id)
            call.respond(
                FreeMarkerContent(
                    "blog/form.ftl",
                    mapOf("blog" to blog, "session" to session, "error" to null, "msg" to call.messages(), "lang" to call.lang()),
                    ""
                )
            )
        }

        post("/{id}/edit") {
            val session = call.sessions.get<UserSession>()
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
            val id = call.parameters["id"]?.toIntOrNull() ?: return@post
            service.delete(id)
            call.respondRedirect("/blog")
        }
    }
}
