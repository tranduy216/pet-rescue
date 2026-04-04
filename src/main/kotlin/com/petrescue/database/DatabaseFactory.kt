package com.petrescue.database

import com.petrescue.config.AppConfig
import org.flywaydb.core.Flyway
import org.jetbrains.exposed.sql.Database

object DatabaseFactory {
    fun init(config: AppConfig) {
        Flyway.configure()
            .dataSource(config.dbUrl, config.dbUsername, config.dbPassword)
            .locations("classpath:flyway")
            .baselineOnMigrate(true)
            .load()
            .migrate()

        Database.connect(
            url = config.dbUrl,
            driver = config.dbDriver,
            user = config.dbUsername,
            password = config.dbPassword
        )
    }
}
