package com.petrescue.services

import com.petrescue.config.AppConfig
import com.petrescue.models.AppealSubscription
import com.petrescue.repositories.AppealSubscriptionRepository
import org.slf4j.LoggerFactory

class AppealSubscriptionService(config: AppConfig) {

    private val log = LoggerFactory.getLogger(AppealSubscriptionService::class.java)
    private val repository = AppealSubscriptionRepository()
    private val emailService = EmailService(config)
    private val fcmService = FcmService(config)

    fun subscribe(sub: AppealSubscription) = repository.subscribe(sub)

    fun unsubscribe(appealId: Int, fcmToken: String) = repository.unsubscribe(appealId, fcmToken)

    fun isSubscribed(appealId: Int, fcmToken: String) = repository.isSubscribed(appealId, fcmToken)

    /**
     * Sends push notification (FCM) + email to all subscribers of [appealId].
     * @return number of subscribers notified
     */
    fun notify(appealId: Int, title: String, body: String): Int {
        val subs = repository.findByAppeal(appealId)
        if (subs.isEmpty()) return 0

        val dataMap = mapOf("appealId" to appealId.toString())

        subs.forEach { sub ->
            // Push notification
            fcmService.send(sub.fcmToken, title, body, dataMap)

            // Email (authenticated subscribers only)
            sub.email?.let { email ->
                val html = buildEmailHtml(title, body, appealId)
                emailService.send(email, title, html)
            }
        }
        log.info("Notified {} subscribers for appeal {}", subs.size, appealId)
        return subs.size
    }

    fun findSubscribedAppealIds() = repository.findAllAppealIds()

    private fun buildEmailHtml(title: String, body: String, appealId: Int): String = """
        <!DOCTYPE html><html><body style="font-family:sans-serif;max-width:600px;margin:auto;padding:24px">
        <h2 style="color:#dc2626">📢 $title</h2>
        <p style="color:#374151">$body</p>
        <a href="/urgent-appeals/$appealId"
           style="display:inline-block;margin-top:16px;padding:10px 20px;background:#dc2626;color:#fff;border-radius:8px;text-decoration:none">
           Xem chi tiết →
        </a>
        </body></html>
    """.trimIndent()
}
