package com.petrescue.services

import com.petrescue.config.AppConfig
import com.petrescue.util.escapeJs
import org.slf4j.LoggerFactory
import java.net.URI
import java.net.http.HttpClient
import java.net.http.HttpRequest
import java.net.http.HttpResponse
import java.time.Duration

class FcmService(private val config: AppConfig) {

    private val log = LoggerFactory.getLogger(FcmService::class.java)
    private val httpClient = HttpClient.newBuilder()
        .connectTimeout(Duration.ofSeconds(10))
        .build()

    fun send(fcmToken: String, title: String, body: String, data: Map<String, String> = emptyMap()) {
        if (config.fcmServerKey.isBlank()) {
            log.debug("FCM server key not configured – skipping push to token …{}", fcmToken.takeLast(8))
            return
        }
        val dataJson = if (data.isEmpty()) "" else {
            val entries = data.entries.joinToString(",") { (k, v) -> "\"${k.escapeJs()}\":\"${v.escapeJs()}\"" }
            ",\"data\":{$entries}"
        }
        val payload = """
            {
              "to": "${fcmToken.escapeJs()}",
              "notification": {
                "title": "${title.escapeJs()}",
                "body": "${body.escapeJs()}"
              }$dataJson
            }
        """.trimIndent()

        val request = HttpRequest.newBuilder()
            .uri(URI.create("https://fcm.googleapis.com/fcm/send"))
            .timeout(Duration.ofSeconds(15))
            .header("Content-Type", "application/json")
            .header("Authorization", "key=${config.fcmServerKey}")
            .POST(HttpRequest.BodyPublishers.ofString(payload))
            .build()

        try {
            val response = httpClient.send(request, HttpResponse.BodyHandlers.ofString())
            if (response.statusCode() in 200..299) {
                log.info("FCM push sent to token …{}", fcmToken.takeLast(8))
            } else {
                log.warn("FCM push failed ({}): {}", response.statusCode(), response.body())
            }
        } catch (e: Exception) {
            log.error("FCM push error for token …{}: {}", fcmToken.takeLast(8), e.message)
        }
    }
}
