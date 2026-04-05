package com.petrescue.config

import io.ktor.server.config.*

class AppConfig(config: ApplicationConfig) {
    val storageType: String = config.propertyOrNull("app.storage.type")?.getString() ?: "local"
    val storagePath: String = config.propertyOrNull("app.storage.localPath")?.getString() ?: "uploads"
    val dbUrl: String = config.propertyOrNull("app.database.url")?.getString()
        ?: "jdbc:h2:file:./data/petrescue;MODE=PostgreSQL;AUTO_SERVER=TRUE"
    val dbDriver: String = config.propertyOrNull("app.database.driver")?.getString() ?: "org.h2.Driver"

    // Email / SMTP
    val emailEnabled: Boolean = config.propertyOrNull("app.email.enabled")?.getString()?.toBoolean() ?: false
    val emailHost: String = config.propertyOrNull("app.email.host")?.getString() ?: "smtp.gmail.com"
    val emailPort: Int = config.propertyOrNull("app.email.port")?.getString()?.toIntOrNull() ?: 587
    val emailUsername: String = config.propertyOrNull("app.email.username")?.getString() ?: ""
    val emailPassword: String = config.propertyOrNull("app.email.password")?.getString() ?: ""
    val emailFrom: String = config.propertyOrNull("app.email.from")?.getString() ?: "noreply@petrescue.com"

    // Firebase – server-side (FCM Legacy HTTP API)
    val fcmServerKey: String = config.propertyOrNull("app.firebase.serverKey")?.getString() ?: ""

    // Firebase – client-side (Web SDK config passed to templates)
    val firebaseApiKey: String = config.propertyOrNull("app.firebase.apiKey")?.getString() ?: ""
    val firebaseAuthDomain: String = config.propertyOrNull("app.firebase.authDomain")?.getString() ?: ""
    val firebaseProjectId: String = config.propertyOrNull("app.firebase.projectId")?.getString() ?: ""
    val firebaseStorageBucket: String = config.propertyOrNull("app.firebase.storageBucket")?.getString() ?: ""
    val firebaseMessagingSenderId: String = config.propertyOrNull("app.firebase.messagingSenderId")?.getString() ?: ""
    val firebaseAppId: String = config.propertyOrNull("app.firebase.appId")?.getString() ?: ""
    val firebaseVapidKey: String = config.propertyOrNull("app.firebase.vapidKey")?.getString() ?: ""
}
