package com.petrescue.routes

import com.petrescue.UserSession
import com.petrescue.i18n.lang
import com.petrescue.i18n.messages
import com.petrescue.services.SiteConfigService
import io.ktor.server.application.*
import io.ktor.server.freemarker.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import io.ktor.server.sessions.*

fun Route.configRoutes() {
    val siteConfigService = SiteConfigService()

    get("/config") {
        val session = call.sessions.get<UserSession>()
        val config = siteConfigService.getAll()
        call.respond(
            FreeMarkerContent(
                "config/form.ftl", mapOf(
                    "session" to session,
                    "msg" to call.messages(),
                    "lang" to call.lang(),
                    "config" to config,
                    "success" to false
                ), ""
            )
        )
    }

    post("/config") {
        val params = call.receiveParameters()
        val session = call.sessions.get<UserSession>()
        val msg = call.messages()

        val titleVi = params["homepage_title_vi"]?.trim() ?: ""
        val titleEn = params["homepage_title_en"]?.trim() ?: ""
        val subtitleVi = params["homepage_subtitle_vi"]?.trim() ?: ""
        val subtitleEn = params["homepage_subtitle_en"]?.trim() ?: ""
        val videoUrl = params["homepage_video_url"]?.trim() ?: ""

        val allowedPrefixes = listOf(
            "https://www.youtube.com/embed/",
            "https://www.youtube-nocookie.com/embed/"
        )
        val videoUrlError = videoUrl.isNotBlank() && allowedPrefixes.none { videoUrl.startsWith(it) }

        if (!videoUrlError) {
            siteConfigService.set("homepage_title_vi", titleVi)
            siteConfigService.set("homepage_title_en", titleEn)
            siteConfigService.set("homepage_subtitle_vi", subtitleVi)
            siteConfigService.set("homepage_subtitle_en", subtitleEn)
            if (videoUrl.isNotBlank()) siteConfigService.set("homepage_video_url", videoUrl)
        }

        val config = siteConfigService.getAll()
        call.respond(
            FreeMarkerContent(
                "config/form.ftl", mapOf(
                    "session" to session,
                    "msg" to msg,
                    "lang" to call.lang(),
                    "config" to config,
                    "success" to !videoUrlError,
                    "videoUrlError" to videoUrlError
                ), ""
            )
        )
    }
}
