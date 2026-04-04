package com.petrescue.config

import io.ktor.server.config.*

class AppConfig(config: ApplicationConfig) {
    val storageType: String = config.propertyOrNull("app.storage.type")?.getString() ?: "local"
    val storagePath: String = config.propertyOrNull("app.storage.localPath")?.getString() ?: "uploads"
    val dbUrl: String = config.propertyOrNull("app.database.url")?.getString()
        ?: "jdbc:h2:file:./data/petrescue;MODE=PostgreSQL;AUTO_SERVER=TRUE"
    val dbDriver: String = config.propertyOrNull("app.database.driver")?.getString() ?: "org.h2.Driver"
    val dbUsername: String = config.propertyOrNull("app.database.username")?.getString() ?: ""
    val dbPassword: String = config.propertyOrNull("app.database.password")?.getString() ?: ""
}
