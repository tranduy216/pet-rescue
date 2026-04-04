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

        val title = params["homepage_title"]?.trim() ?: ""
        val subtitle = params["homepage_subtitle"]?.trim() ?: ""
        val videoUrl = params["homepage_video_url"]?.trim() ?: ""

        val allowedPrefixes = listOf(
            "https://www.youtube.com/embed/",
            "https://www.youtube-nocookie.com/embed/"
        )
        val videoUrlError = videoUrl.isNotBlank() && allowedPrefixes.none { videoUrl.startsWith(it) }

        if (!videoUrlError) {
            // Allow blank values to clear existing config
            siteConfigService.set("homepage_title", title)
            siteConfigService.set("homepage_subtitle", subtitle)
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
