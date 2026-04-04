package com.petrescue.routes

import com.petrescue.UserSession
import com.petrescue.i18n.lang
import com.petrescue.i18n.messages
import com.petrescue.models.Pet
import com.petrescue.models.PetMedia
import com.petrescue.services.PetService
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

private const val MAX_IMAGE_SIZE_BYTES = 5 * 1024 * 1024
private val ALLOWED_IMAGE_EXTENSIONS = setOf("jpg", "jpeg", "png", "gif", "webp", "bmp")

private data class FileUploadResult(val savedPath: String? = null, val error: String? = null)

private fun processImageUpload(part: PartData.FileItem): FileUploadResult {
    val originalName = part.originalFileName ?: return FileUploadResult()
    val ext = originalName.substringAfterLast('.', "").lowercase()
    if (ext.isEmpty() || ext !in ALLOWED_IMAGE_EXTENSIONS) {
        return FileUploadResult(error = "Invalid file type '${ext.ifEmpty { "unknown" }}'. Only image files (jpg, jpeg, png, gif, webp, bmp) are allowed.")
    }
    val bytes = part.streamProvider().readBytes()
    if (bytes.size > MAX_IMAGE_SIZE_BYTES) {
        return FileUploadResult(error = "File '$originalName' exceeds the 5MB size limit.")
    }
    val fileName = "${UUID.randomUUID()}_$originalName"
    val file = File("uploads/$fileName")
    file.parentFile.mkdirs()
    file.writeBytes(bytes)
    return FileUploadResult(savedPath = "/uploads/$fileName")
}

fun Route.petRoutes() {
    val service = PetService()

    route("/pets") {
        get {
            val session = call.sessions.get<UserSession>()
            val lang = call.lang()
            val msg = call.messages()
            val search = call.request.queryParameters["search"]
            val type = call.request.queryParameters["type"]
            val status = call.request.queryParameters["status"]
            val pets = service.getAll(search, type, status)
            val isHtmx = call.request.headers["HX-Request"] == "true"
            if (isHtmx) {
                call.respond(FreeMarkerContent("pets/list_partial.ftl", mapOf("pets" to pets, "session" to session, "msg" to msg, "lang" to lang), ""))
            } else {
                call.respond(
                    FreeMarkerContent(
                        "pets/list.ftl", mapOf(
                            "pets" to pets,
                            "session" to session,
                            "search" to search,
                            "type" to type,
                            "status" to status,
                            "msg" to msg,
                            "lang" to lang
                        ), ""
                    )
                )
            }
        }

        get("/new") {
            val session = call.sessions.get<UserSession>()
            call.respond(FreeMarkerContent("pets/form.ftl", mapOf("pet" to null, "session" to session, "error" to null, "msg" to call.messages(), "lang" to call.lang()), ""))
        }

        post("/new") {
            val session = call.sessions.get<UserSession>()
            val multipart = call.receiveMultipart()
            val params = mutableMapOf<String, String>()
            val mediaFiles = mutableListOf<String>()
            var uploadError: String? = null
            multipart.forEachPart { part ->
                when (part) {
                    is PartData.FormItem -> params[part.name ?: ""] = part.value
                    is PartData.FileItem -> {
                        if (part.originalFileName?.isNotBlank() == true && uploadError == null) {
                            val result = processImageUpload(part)
                            when {
                                result.error != null -> uploadError = result.error
                                result.savedPath != null -> mediaFiles.add(result.savedPath)
                            }
                        }
                    }
                    else -> {}
                }
                part.dispose()
            }
            if (uploadError != null) {
                call.respond(FreeMarkerContent("pets/form.ftl", mapOf("pet" to null, "session" to session, "error" to uploadError, "msg" to call.messages(), "lang" to call.lang()), ""))
                return@post
            }
            val pet = service.create(
                Pet(
                    name = params["name"] ?: "",
                    type = params["type"] ?: "DOG",
                    breed = params["breed"],
                    age = params["age"]?.toIntOrNull(),
                    gender = params["gender"],
                    description = params["description"],
                    youtubeUrl = params["youtubeUrl"]?.trim()?.takeIf { it.isNotBlank() },
                    status = params["status"] ?: "AVAILABLE",
                    createdBy = session!!.userId
                )
            )
            mediaFiles.forEach { url ->
                service.addMedia(PetMedia(petId = pet.id, fileUrl = url, mediaType = "IMAGE"))
            }
            call.respondRedirect("/pets/${pet.id}")
        }

        get("/{id}") {
            val session = call.sessions.get<UserSession>()
            val id = call.parameters["id"]?.toIntOrNull() ?: run { call.respond(HttpStatusCode.NotFound); return@get }
            val pet = service.getById(id) ?: run { call.respond(HttpStatusCode.NotFound); return@get }
            call.respond(FreeMarkerContent("pets/detail.ftl", mapOf("pet" to pet, "session" to session, "msg" to call.messages(), "lang" to call.lang()), ""))
        }

        get("/{id}/edit") {
            val session = call.sessions.get<UserSession>()
            val id = call.parameters["id"]?.toIntOrNull() ?: return@get
            val pet = service.getById(id)
            call.respond(FreeMarkerContent("pets/form.ftl", mapOf("pet" to pet, "session" to session, "error" to null, "msg" to call.messages(), "lang" to call.lang()), ""))
        }

        post("/{id}/edit") {
            val session = call.sessions.get<UserSession>()
            val id = call.parameters["id"]?.toIntOrNull() ?: return@post
            val existing = service.getById(id) ?: return@post
            val multipart = call.receiveMultipart()
            val params = mutableMapOf<String, String>()
            val mediaFiles = mutableListOf<String>()
            var uploadError: String? = null
            multipart.forEachPart { part ->
                when (part) {
                    is PartData.FormItem -> params[part.name ?: ""] = part.value
                    is PartData.FileItem -> {
                        if (part.originalFileName?.isNotBlank() == true && uploadError == null) {
                            val result = processImageUpload(part)
                            when {
                                result.error != null -> uploadError = result.error
                                result.savedPath != null -> mediaFiles.add(result.savedPath)
                            }
                        }
                    }
                    else -> {}
                }
                part.dispose()
            }
            if (uploadError != null) {
                call.respond(FreeMarkerContent("pets/form.ftl", mapOf("pet" to existing, "session" to session, "error" to uploadError, "msg" to call.messages(), "lang" to call.lang()), ""))
                return@post
            }
            service.update(
                existing.copy(
                    name = params["name"] ?: existing.name,
                    type = params["type"] ?: existing.type,
                    breed = params["breed"],
                    age = params["age"]?.toIntOrNull(),
                    gender = params["gender"],
                    description = params["description"],
                    youtubeUrl = params["youtubeUrl"]?.trim()?.takeIf { it.isNotBlank() },
                    status = params["status"] ?: existing.status
                )
            )
            mediaFiles.forEach { url ->
                service.addMedia(PetMedia(petId = id, fileUrl = url, mediaType = "IMAGE"))
            }
            call.respondRedirect("/pets/$id")
        }

        post("/{id}/delete") {
            val session = call.sessions.get<UserSession>()
            val id = call.parameters["id"]?.toIntOrNull() ?: return@post
            service.delete(id)
            call.respondRedirect("/pets")
        }

        post("/{id}/media/{mediaId}/delete") {
            val session = call.sessions.get<UserSession>()
            val id = call.parameters["id"]?.toIntOrNull() ?: return@post
            val mediaId = call.parameters["mediaId"]?.toIntOrNull() ?: return@post
            service.deleteMedia(mediaId)
            call.respondRedirect("/pets/$id/edit")
        }
    }

    route("/uploads/{file...}") {
        get {
            val path = call.parameters.getAll("file")?.joinToString("/") ?: return@get
            val file = File("uploads/$path")
            if (file.exists()) {
                call.respondFile(file)
            } else {
                call.respond(HttpStatusCode.NotFound)
            }
        }
    }
}
