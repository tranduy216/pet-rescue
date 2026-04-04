package com.petrescue.routes

import com.petrescue.UserSession
import com.petrescue.i18n.Messages
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
        val lang = call.request.cookies["lang"] ?: "vi"
        val msg = Messages.forLang(lang)
        val config = siteConfigService.getAll()
        call.respond(
            FreeMarkerContent(
                "config/form.ftl", mapOf(
                    "session" to session,
                    "msg" to msg,
                    "lang" to lang,
                    "config" to config,
                    "success" to false
                ), ""
            )
        )
    }

    post("/config") {
        val params = call.receiveParameters()
        val session = call.sessions.get<UserSession>()
        val lang = call.request.cookies["lang"] ?: "vi"
        val msg = Messages.forLang(lang)

        val title = params["homepage_title"]?.trim() ?: ""
        val subtitle = params["homepage_subtitle"]?.trim() ?: ""
        val videoUrl = params["homepage_video_url"]?.trim() ?: ""

        if (title.isNotBlank()) siteConfigService.set("homepage_title", title)
        if (subtitle.isNotBlank()) siteConfigService.set("homepage_subtitle", subtitle)
        if (videoUrl.isNotBlank()) {
            val allowedPrefixes = listOf(
                "https://www.youtube.com/embed/",
                "https://www.youtube-nocookie.com/embed/"
            )
            if (allowedPrefixes.any { videoUrl.startsWith(it) }) {
                siteConfigService.set("homepage_video_url", videoUrl)
            }
        }

        val config = siteConfigService.getAll()
        call.respond(
            FreeMarkerContent(
                "config/form.ftl", mapOf(
                    "session" to session,
                    "msg" to msg,
                    "lang" to lang,
                    "config" to config,
                    "success" to true
                ), ""
            )
        )
    }
}
