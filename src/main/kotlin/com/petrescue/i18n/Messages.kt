package com.petrescue.i18n

import java.io.InputStreamReader
import java.util.Properties

object Messages {

    private fun loadProperties(filename: String): Map<String, String> {
        val props = Properties()
        val stream = Messages::class.java.classLoader
            .getResourceAsStream("i18n/$filename")
            ?: error("Missing i18n resource: i18n/$filename")
        stream.use { props.load(InputStreamReader(it, Charsets.UTF_8)) }
        return props.stringPropertyNames().associateWith { props.getProperty(it) }
    }

    private val vi: Map<String, String> by lazy { loadProperties("messages_vi.properties") }
    private val en: Map<String, String> by lazy { loadProperties("messages_en.properties") }

    fun forLang(lang: String): Map<String, String> = if (lang == "en") en else vi
}

fun io.ktor.server.application.ApplicationCall.lang(): String =
    request.cookies["lang"] ?: "vi"

fun io.ktor.server.application.ApplicationCall.messages(): Map<String, String> =
    Messages.forLang(lang())
