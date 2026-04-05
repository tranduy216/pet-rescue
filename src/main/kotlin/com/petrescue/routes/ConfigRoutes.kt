package com.petrescue.routes

import com.petrescue.UserSession
import com.petrescue.i18n.lang
import com.petrescue.i18n.messages
import com.petrescue.i18n.siteConfig
import com.petrescue.services.DonationService
import com.petrescue.services.SiteConfigService
import com.petrescue.services.UserService
import io.ktor.server.application.*
import io.ktor.server.freemarker.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import io.ktor.server.sessions.*

fun Route.configRoutes() {
    val siteConfigService = SiteConfigService()
    val userService = UserService()
    val donationService = DonationService()

    fun buildConfigModel(call: ApplicationCall, tab: String, success: Boolean = false, videoUrlError: Boolean = false): Map<String, Any?> {
        val session = call.sessions.get<UserSession>()
        val config = siteConfigService.getAll()
        val users = if (tab == "users") userService.getAll() else emptyList<Any>()
        val wishes = if (tab == "wishes") donationService.getAll(null) else emptyList<Any>()
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
            "siteConfig" to call.siteConfig()
        )
    }

    get("/config") {
        val tab = call.request.queryParameters["tab"] ?: "system"
        call.respond(FreeMarkerContent("config/form.ftl", buildConfigModel(call, tab), ""))
    }

    post("/config") {
        val params = call.receiveParameters()
        val msg = call.messages()

        val titleVi = params["homepage_title_vi"]?.trim() ?: ""
        val titleEn = params["homepage_title_en"]?.trim() ?: ""
        val subtitleVi = params["homepage_subtitle_vi"]?.trim() ?: ""
        val subtitleEn = params["homepage_subtitle_en"]?.trim() ?: ""
        val videoUrl = params["homepage_video_url"]?.trim() ?: ""
        val facebookUrl = params["social_facebook_url"]?.trim() ?: ""
        val youtubeUrl = params["social_youtube_url"]?.trim() ?: ""
        val bank1Name = params["bank1_name"]?.trim() ?: ""
        val bank1Account = params["bank1_account"]?.trim() ?: ""
        val bank2Name = params["bank2_name"]?.trim() ?: ""
        val bank2Account = params["bank2_account"]?.trim() ?: ""

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
            if (facebookUrl.isNotBlank()) siteConfigService.set("social_facebook_url", facebookUrl)
            if (youtubeUrl.isNotBlank()) siteConfigService.set("social_youtube_url", youtubeUrl)
            siteConfigService.set("bank1_name", bank1Name)
            siteConfigService.set("bank1_account", bank1Account)
            siteConfigService.set("bank2_name", bank2Name)
            siteConfigService.set("bank2_account", bank2Account)
        }

        call.respond(FreeMarkerContent("config/form.ftl", buildConfigModel(call, "system", !videoUrlError, videoUrlError), ""))
    }
}

