package com.petrescue.services

import com.petrescue.config.AppConfig
import jakarta.mail.Message
import jakarta.mail.Session
import jakarta.mail.Transport
import jakarta.mail.internet.InternetAddress
import jakarta.mail.internet.MimeMessage
import org.slf4j.LoggerFactory
import java.util.Properties

class EmailService(private val config: AppConfig) {

    private val log = LoggerFactory.getLogger(EmailService::class.java)

    fun send(to: String, subject: String, htmlBody: String) {
        if (!config.emailEnabled) {
            log.debug("Email disabled – skipping send to {}", to)
            return
        }
        try {
            val props = Properties().apply {
                put("mail.smtp.host", config.emailHost)
                put("mail.smtp.port", config.emailPort.toString())
                put("mail.smtp.auth", "true")
                put("mail.smtp.starttls.enable", "true")
            }
            val session = Session.getInstance(props, object : jakarta.mail.Authenticator() {
                override fun getPasswordAuthentication() =
                    jakarta.mail.PasswordAuthentication(config.emailUsername, config.emailPassword)
            })
            val msg = MimeMessage(session).apply {
                setFrom(InternetAddress(config.emailFrom))
                setRecipients(Message.RecipientType.TO, InternetAddress.parse(to))
                setSubject(subject, "UTF-8")
                setContent(htmlBody, "text/html; charset=UTF-8")
            }
            Transport.send(msg)
            log.info("Email sent to {}", to)
        } catch (e: Exception) {
            log.error("Failed to send email to {}: {}", to, e.message)
        }
    }
}
