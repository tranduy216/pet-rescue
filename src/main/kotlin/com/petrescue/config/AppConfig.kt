package com.petrescue.config

import io.ktor.server.config.*

class AppConfig(config: ApplicationConfig) {
    val storageType: String = config.propertyOrNull("app.storage.type")?.getString() ?: "local"
    val storagePath: String = config.propertyOrNull("app.storage.localPath")?.getString() ?: "uploads"

    // Cloudflare R2
    val r2Endpoint: String = config.propertyOrNull("app.storage.r2.endpoint")?.getString() ?: ""
    val r2Bucket: String = config.propertyOrNull("app.storage.r2.bucket")?.getString() ?: ""
    val r2AccessKey: String = config.propertyOrNull("app.storage.r2.accessKey")?.getString() ?: ""
    val r2SecretKey: String = config.propertyOrNull("app.storage.r2.secretKey")?.getString() ?: ""
    val r2PublicUrl: String = config.propertyOrNull("app.storage.r2.publicUrl")?.getString() ?: ""

    val dbUrl: String = config.propertyOrNull("app.database.url")?.getString()
        ?: "jdbc:h2:file:./data/petrescue;MODE=PostgreSQL;AUTO_SERVER=TRUE"
    val dbDriver: String = config.propertyOrNull("app.database.driver")?.getString() ?: "org.h2.Driver"
    val dbUsername: String = config.propertyOrNull("app.database.username")?.getString() ?: ""
    val dbPassword: String = config.propertyOrNull("app.database.password")?.getString() ?: ""
}
