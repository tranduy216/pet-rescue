package com.petrescue.routes

import com.petrescue.UserSession
import com.petrescue.i18n.lang
import com.petrescue.i18n.messages
import com.petrescue.i18n.siteConfig
import com.petrescue.services.DonationService
import com.petrescue.services.SiteConfigService
import com.petrescue.services.UserService
import io.ktor.http.content.*
import io.ktor.server.application.*
import io.ktor.server.freemarker.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import io.ktor.server.sessions.*
import java.io.File

private val ALLOWED_QR_EXTENSIONS = setOf("jpg", "jpeg", "png", "webp")
private const val MAX_QR_SIZE_BYTES = 2 * 1024 * 1024

fun Route.configRoutes() {
    val siteConfigService = SiteConfigService()
    val userService = UserService()
    val donationService = DonationService()

    fun buildConfigModel(call: ApplicationCall, tab: String, success: Boolean = false, videoUrlError: Boolean = false, wishStatus: String? = null): Map<String, Any?> {
        val session = call.sessions.get<UserSession>()
        val config = siteConfigService.getAll()
        val users = if (tab == "users") userService.getAll() else emptyList<Any>()
        val wishes = if (tab == "wishes") donationService.getAll(wishStatus) else emptyList<Any>()
        return mapOf(
            "session" to session,
            "msg" to call.messages(),
            "lang" to call.lang(),
            "config" to config,
            "tab" to tab,
            "success" to success,
            "videoUrlError" to videoUrlError,
            "users" to users,
            "wishes" to wishes,
            "wishStatus" to wishStatus,
            "siteConfig" to call.siteConfig()
        )
    }

    get("/config") {
        val tab = call.request.queryParameters["tab"] ?: "system"
        val wishStatus = call.request.queryParameters["wishStatus"]?.takeIf { it.isNotBlank() }
        call.respond(FreeMarkerContent("config/form.ftl", buildConfigModel(call, tab, wishStatus = wishStatus), ""))
    }

    post("/config") {
        val parts = call.receiveMultipart()

        var titleVi = ""; var titleEn = ""; var subtitleVi = ""; var subtitleEn = ""
        var videoUrl = ""; var facebookUrl = ""; var youtubeUrl = ""
        var qrError: String? = null

        parts.forEachPart { part ->
            when (part) {
                is PartData.FormItem -> when (part.name) {
                    "homepage_title_vi"    -> titleVi = part.value.trim()
                    "homepage_title_en"    -> titleEn = part.value.trim()
                    "homepage_subtitle_vi" -> subtitleVi = part.value.trim()
                    "homepage_subtitle_en" -> subtitleEn = part.value.trim()
                    "homepage_video_url"   -> videoUrl = part.value.trim()
                    "social_facebook_url"  -> facebookUrl = part.value.trim()
                    "social_youtube_url"   -> youtubeUrl = part.value.trim()
                }
                is PartData.FileItem -> {
                    val fieldName = part.name ?: ""
                    if (fieldName == "qr_station" || fieldName == "qr_web") {
                        val originalName = part.originalFileName ?: ""
                        if (originalName.isNotBlank()) {
                            val ext = originalName.substringAfterLast('.', "").lowercase()
                            if (ext !in ALLOWED_QR_EXTENSIONS) {
                                qrError = "Định dạng ảnh QR không hợp lệ. Chỉ chấp nhận: ${ALLOWED_QR_EXTENSIONS.joinToString(", ")}"
                            } else {
                                val bytes = part.streamProvider().readBytes()
                                if (bytes.size > MAX_QR_SIZE_BYTES) {
                                    qrError = "Ảnh QR vượt quá giới hạn 2MB."
                                } else {
                                    val targetName = if (fieldName == "qr_station") "qr-station.png" else "qr-web.png"
                                    val targetFile = File("static/$targetName")
                                    targetFile.parentFile.mkdirs()
                                    targetFile.writeBytes(bytes)
                                }
                            }
                        }
                    }
                }
                else -> {}
            }
            part.dispose()
        }

        val allowedPrefixes = listOf(
            "https://www.youtube.com/embed/",
            "https://www.youtube-nocookie.com/embed/"
        )
        val videoUrlError = videoUrl.isNotBlank() && allowedPrefixes.none { videoUrl.startsWith(it) }

        if (!videoUrlError && qrError == null) {
            siteConfigService.set("homepage_title_vi", titleVi)
            siteConfigService.set("homepage_title_en", titleEn)
            siteConfigService.set("homepage_subtitle_vi", subtitleVi)
            siteConfigService.set("homepage_subtitle_en", subtitleEn)
            if (videoUrl.isNotBlank()) siteConfigService.set("homepage_video_url", videoUrl)
            if (facebookUrl.isNotBlank()) siteConfigService.set("social_facebook_url", facebookUrl)
            if (youtubeUrl.isNotBlank()) siteConfigService.set("social_youtube_url", youtubeUrl)
        }

        val model = buildConfigModel(call, "system", !videoUrlError && qrError == null, videoUrlError)
            .toMutableMap()
        if (qrError != null) model["qrError"] = qrError
        call.respond(FreeMarkerContent("config/form.ftl", model, ""))
    }
}

