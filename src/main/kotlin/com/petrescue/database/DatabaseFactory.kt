package com.petrescue.database

import com.petrescue.config.AppConfig
import org.jetbrains.exposed.sql.Database

object DatabaseFactory {
    fun init(config: AppConfig) {
        Database.connect(
            url = config.dbUrl,
            driver = config.dbDriver,
            user = config.dbUsername,
            password = config.dbPassword
        )
    }
}
