package com.petrescue.routes

import com.petrescue.UserSession
import com.petrescue.cache.AppCache
import com.petrescue.cache.CacheKeys
import com.petrescue.config.AppConfig
import com.petrescue.i18n.lang
import com.petrescue.i18n.messages
import com.petrescue.services.DonationService
import com.petrescue.services.PetService
import com.petrescue.services.SiteConfigService
import com.petrescue.services.UrgentAppealService
import io.ktor.server.application.*
import io.ktor.server.freemarker.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import io.ktor.server.sessions.*

fun Route.homeRoutes(appConfig: AppConfig) {
    val petService = PetService()
    val donationService = DonationService()
    val siteConfigService = SiteConfigService()
    val urgentAppealService = UrgentAppealService()

    get("/") {
        val session = call.sessions.get<UserSession>()

        val featuredPets = AppCache.getOrLoad(CacheKeys.HOME_FEATURED_PETS) {
            petService.getAll(status = "AVAILABLE").take(6)
        }
        val recentPets = AppCache.getOrLoad(CacheKeys.HOME_RECENT_PETS) {
            petService.getRecent(3)
        }
        val approvedWishes = AppCache.getOrLoad(CacheKeys.HOME_APPROVED_WISHES) {
            donationService.getApproved().take(3)
        }

        val statsAvailable = AppCache.getOrLoad(CacheKeys.HOME_STATS_AVAILABLE) {
            petService.countByStatus("AVAILABLE")
        }
        val statsAdopted = AppCache.getOrLoad(CacheKeys.HOME_STATS_ADOPTED) {
            petService.countByStatus("ADOPTED")
        }
        val statsTreated = AppCache.getOrLoad(CacheKeys.HOME_STATS_TREATED) {
            petService.countAll()
        }
        val statsDonors = AppCache.getOrLoad(CacheKeys.HOME_STATS_DONORS) {
            donationService.countDonors()
        }

        val siteConfig = AppCache.getOrLoad(CacheKeys.HOME_SITE_CONFIG) {
            siteConfigService.getAll()
        }

        val urgentAppeals = AppCache.getOrLoad(CacheKeys.HOME_URGENT_APPEALS) {
            urgentAppealService.getRecent(2)
        }

        call.respond(
            FreeMarkerContent(
                "index.ftl", mapOf(
                    "session" to session,
                    "pets" to featuredPets,
                    "recentPets" to recentPets,
                    "approvedWishes" to approvedWishes,
                    "statsAvailable" to statsAvailable,
                    "statsAdopted" to statsAdopted,
                    "statsTreated" to statsTreated,
                    "statsDonors" to statsDonors,
                    "msg" to call.messages(),
                    "lang" to call.lang(),
                    "siteConfig" to siteConfig,
                    "urgentAppeals" to urgentAppeals,
                    "firebaseConfig" to appConfig.firebaseWebConfig()
                ), ""
            )
        )
    }

    // Language toggle: set cookie and redirect back
    get("/lang/{code}") {
        val code = call.parameters["code"] ?: "vi"
        val referer = call.request.headers["Referer"] ?: "/"
        call.response.cookies.append("lang", code, path = "/", maxAge = 86400L * 365)
        call.respondRedirect(referer)
    }
}

/** Convenience extension: extract Firebase client-side config as a map for templates. */
fun AppConfig.firebaseWebConfig(): Map<String, String> = mapOf(
    "apiKey" to firebaseApiKey,
    "authDomain" to firebaseAuthDomain,
    "projectId" to firebaseProjectId,
    "storageBucket" to firebaseStorageBucket,
    "messagingSenderId" to firebaseMessagingSenderId,
    "appId" to firebaseAppId,
    "vapidKey" to firebaseVapidKey
)
