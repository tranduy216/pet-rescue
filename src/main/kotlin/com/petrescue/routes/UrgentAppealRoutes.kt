package com.petrescue.routes

import com.petrescue.UserSession
import com.petrescue.config.AppConfig
import com.petrescue.i18n.lang
import com.petrescue.i18n.messages
import com.petrescue.i18n.siteConfig
import com.petrescue.models.AppealSubscription
import com.petrescue.models.UrgentAppeal
import com.petrescue.models.UrgentAppealUpdate
import com.petrescue.services.AppealSubscriptionService
import com.petrescue.services.UrgentAppealService
import io.ktor.http.*
import io.ktor.http.content.*
import io.ktor.server.application.*
import io.ktor.server.freemarker.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import io.ktor.server.sessions.*
import java.io.File
import java.math.BigDecimal
import java.time.LocalDate
import java.util.UUID

private val ALLOWED_IMAGE_EXTENSIONS_UA = setOf("jpg", "jpeg", "png", "gif", "webp", "bmp")
private const val MAX_IMAGE_SIZE_BYTES_UA = 5 * 1024 * 1024

fun Route.urgentAppealRoutes(appConfig: AppConfig) {
    val service = UrgentAppealService()
    val subscriptionService = AppealSubscriptionService(appConfig)
    val userRepository = com.petrescue.repositories.UserRepository()

    route("/urgent-appeals") {
        get {
            val session = call.sessions.get<UserSession>()
            val appeals = service.getAll()
            call.respond(FreeMarkerContent("urgent-appeals/list.ftl", mapOf(
                "appeals" to appeals,
                "session" to session,
                "msg" to call.messages(),
                "lang" to call.lang(),
                "siteConfig" to call.siteConfig(),
                "firebaseConfig" to appConfig.firebaseWebConfig()
            ), ""))
        }

        get("/new") {
            val session = call.sessions.get<UserSession>() ?: return@get call.respondRedirect("/login")
            if (session.role != "ADMIN" && session.role != "VOLUNTEER") return@get call.respond(HttpStatusCode.Forbidden)
            call.respond(FreeMarkerContent("urgent-appeals/form.ftl", mapOf(
                "session" to session,
                "msg" to call.messages(),
                "lang" to call.lang(),
                "error" to null,
                "siteConfig" to call.siteConfig()
            ), ""))
        }

        post("/new") {
            val session = call.sessions.get<UserSession>() ?: return@post call.respondRedirect("/login")
            if (session.role != "ADMIN" && session.role != "VOLUNTEER") return@post call.respond(HttpStatusCode.Forbidden)

            val multipart = call.receiveMultipart()
            var title = ""
            var content = ""
            var amount = BigDecimal.ZERO
            var videoUrl: String? = null
            val imagePaths = mutableListOf<String>()

            multipart.forEachPart { part ->
                when (part) {
                    is PartData.FormItem -> {
                        when (part.name) {
                            "title" -> title = part.value.trim()
                            "content" -> content = part.value.trim()
                            "amount" -> amount = part.value.trim().toBigDecimalOrNull() ?: BigDecimal.ZERO
                            "videoUrl" -> videoUrl = part.value.trim().ifBlank { null }
                        }
                    }
                    is PartData.FileItem -> {
                        val fieldName = part.name ?: ""
                        if (fieldName in setOf("image1", "image2", "image3") && imagePaths.size < 3) {
                            val originalName = part.originalFileName ?: ""
                            if (originalName.isNotBlank()) {
                                val ext = originalName.substringAfterLast('.', "").lowercase()
                                if (ext in ALLOWED_IMAGE_EXTENSIONS_UA) {
                                    val bytes = part.streamProvider().readBytes()
                                    if (bytes.size <= MAX_IMAGE_SIZE_BYTES_UA) {
                                        val fileName = "${UUID.randomUUID()}_$originalName"
                                        val file = File("uploads/$fileName")
                                        file.parentFile.mkdirs()
                                        file.writeBytes(bytes)
                                        imagePaths.add("/uploads/$fileName")
                                    }
                                }
                            }
                        }
                    }
                    else -> {}
                }
                part.dispose()
            }

            if (title.isBlank() || content.isBlank()) {
                call.respond(FreeMarkerContent("urgent-appeals/form.ftl", mapOf(
                    "session" to session,
                    "msg" to call.messages(),
                    "lang" to call.lang(),
                    "error" to "Tiêu đề và nội dung không được để trống.",
                    "siteConfig" to call.siteConfig()
                ), ""))
                return@post
            }

            val appeal = service.create(UrgentAppeal(
                title = title,
                content = content,
                amount = amount,
                videoUrl = videoUrl,
                createdBy = session.userId
            ))
            imagePaths.forEach { service.addImage(appeal.id, it) }
            call.respondRedirect("/urgent-appeals/${appeal.id}")
        }

        get("/{id}") {
            val session = call.sessions.get<UserSession>()
            val id = call.parameters["id"]?.toIntOrNull() ?: return@get call.respond(HttpStatusCode.NotFound)
            val appeal = service.getById(id) ?: return@get call.respond(HttpStatusCode.NotFound)
            val canManage = session != null && (session.role == "ADMIN" || session.role == "VOLUNTEER")
            call.respond(FreeMarkerContent("urgent-appeals/detail.ftl", mapOf(
                "appeal" to appeal,
                "session" to session,
                "canManage" to canManage,
                "msg" to call.messages(),
                "lang" to call.lang(),
                "siteConfig" to call.siteConfig(),
                "firebaseConfig" to appConfig.firebaseWebConfig()
            ), ""))
        }

        get("/{id}/update/new") {
            val session = call.sessions.get<UserSession>() ?: return@get call.respondRedirect("/login")
            if (session.role != "ADMIN" && session.role != "VOLUNTEER") return@get call.respond(HttpStatusCode.Forbidden)
            val id = call.parameters["id"]?.toIntOrNull() ?: return@get call.respond(HttpStatusCode.NotFound)
            val appeal = service.getById(id) ?: return@get call.respond(HttpStatusCode.NotFound)
            call.respond(FreeMarkerContent("urgent-appeals/update-form.ftl", mapOf(
                "appeal" to appeal,
                "session" to session,
                "msg" to call.messages(),
                "lang" to call.lang(),
                "error" to null,
                "siteConfig" to call.siteConfig()
            ), ""))
        }

        post("/{id}/update/new") {
            val session = call.sessions.get<UserSession>() ?: return@post call.respondRedirect("/login")
            if (session.role != "ADMIN" && session.role != "VOLUNTEER") return@post call.respond(HttpStatusCode.Forbidden)
            val id = call.parameters["id"]?.toIntOrNull() ?: return@post call.respond(HttpStatusCode.NotFound)
            val appeal = service.getById(id) ?: return@post call.respond(HttpStatusCode.NotFound)

            val multipart = call.receiveMultipart()
            var progress = 0
            var content = ""
            var updateDateStr = LocalDate.now().toString()
            var videoUrl: String? = null
            val imagePaths = mutableListOf<String>()

            multipart.forEachPart { part ->
                when (part) {
                    is PartData.FormItem -> {
                        when (part.name) {
                            "progress" -> progress = part.value.trim().toIntOrNull() ?: 0
                            "content" -> content = part.value.trim()
                            "updateDate" -> updateDateStr = part.value.trim()
                            "videoUrl" -> videoUrl = part.value.trim().ifBlank { null }
                        }
                    }
                    is PartData.FileItem -> {
                        if (part.name in setOf("image1", "image2", "image3") && imagePaths.size < 3) {
                            val originalName = part.originalFileName ?: ""
                            if (originalName.isNotBlank()) {
                                val ext = originalName.substringAfterLast('.', "").lowercase()
                                if (ext in ALLOWED_IMAGE_EXTENSIONS_UA) {
                                    val bytes = part.streamProvider().readBytes()
                                    if (bytes.size <= MAX_IMAGE_SIZE_BYTES_UA) {
                                        val fileName = "${UUID.randomUUID()}_$originalName"
                                        val file = File("uploads/$fileName")
                                        file.parentFile.mkdirs()
                                        file.writeBytes(bytes)
                                        imagePaths.add("/uploads/$fileName")
                                    }
                                }
                            }
                        }
                    }
                    else -> {}
                }
                part.dispose()
            }

            if (content.isBlank()) {
                call.respond(FreeMarkerContent("urgent-appeals/update-form.ftl", mapOf(
                    "appeal" to appeal,
                    "session" to session,
                    "msg" to call.messages(),
                    "lang" to call.lang(),
                    "error" to "Nội dung không được để trống.",
                    "siteConfig" to call.siteConfig()
                ), ""))
                return@post
            }

            val updateDate = try { LocalDate.parse(updateDateStr) } catch (e: Exception) {
                call.application.log.debug("Failed to parse updateDate '{}': {}", updateDateStr, e.message)
                LocalDate.now()
            }
            val minDate = appeal.createdAt.toLocalDate()
            val finalDate = if (updateDate.isBefore(minDate)) minDate else updateDate

            val update = service.addUpdate(UrgentAppealUpdate(
                appealId = id,
                progress = progress,
                content = content,
                updateDate = finalDate,
                videoUrl = videoUrl,
                createdBy = session.userId
            ))
            imagePaths.forEach { service.addUpdateImage(update.id, it) }
            call.respondRedirect("/urgent-appeals/$id")
        }

        // ── Subscribe (no auth required) ────────────────────────────────────────
        // Body (form): fcmToken (required)
        // Email and userId are taken from the session when the user is authenticated.
        post("/{id}/follow") {
            val id = call.parameters["id"]?.toIntOrNull() ?: return@post call.respond(HttpStatusCode.NotFound)
            service.getById(id) ?: return@post call.respond(HttpStatusCode.NotFound)

            val params = call.receiveParameters()
            val fcmToken = params["fcmToken"]?.trim() ?: return@post call.respond(HttpStatusCode.BadRequest)
            if (fcmToken.isBlank()) return@post call.respond(HttpStatusCode.BadRequest)

            val session = call.sessions.get<UserSession>()
            val email = session?.let { userRepository.findById(it.userId)?.email }

            subscriptionService.subscribe(
                AppealSubscription(
                    appealId = id,
                    userId = session?.userId,
                    email = email,
                    fcmToken = fcmToken
                )
            )
            call.respond(HttpStatusCode.OK, "subscribed")
        }

        // ── Unsubscribe ──────────────────────────────────────────────────────────
        post("/{id}/unfollow") {
            val id = call.parameters["id"]?.toIntOrNull() ?: return@post call.respond(HttpStatusCode.NotFound)
            val params = call.receiveParameters()
            val fcmToken = params["fcmToken"]?.trim() ?: return@post call.respond(HttpStatusCode.BadRequest)
            subscriptionService.unsubscribe(id, fcmToken)
            call.respond(HttpStatusCode.OK, "unsubscribed")
        }

        // ── Notify all subscribers of an appeal ──────────────────────────────────
        // Restricted to ADMIN and VOLUNTEER. Body: title (optional), body (optional).
        // If omitted, defaults are derived from the appeal title.
        post("/{id}/notify") {
            val session = call.sessions.get<UserSession>() ?: return@post call.respond(HttpStatusCode.Unauthorized)
            if (session.role != "ADMIN" && session.role != "VOLUNTEER") return@post call.respond(HttpStatusCode.Forbidden)

            val id = call.parameters["id"]?.toIntOrNull() ?: return@post call.respond(HttpStatusCode.NotFound)
            val appeal = service.getById(id) ?: return@post call.respond(HttpStatusCode.NotFound)

            val params = call.receiveParameters()
            val title = params["title"]?.trim()?.ifBlank { null } ?: "📢 ${appeal.title}"
            val body = params["body"]?.trim()?.ifBlank { null } ?: "Có cập nhật mới từ lời khẩn cầu."

            val count = subscriptionService.notify(id, title, body)
            call.respond(HttpStatusCode.OK, "Đã gửi thông báo tới $count người theo dõi.")
        }
    }
}
