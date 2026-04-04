package com.petrescue.database

import com.petrescue.config.AppConfig
import com.petrescue.database.tables.*
import org.jetbrains.exposed.sql.Database
import org.jetbrains.exposed.sql.SchemaUtils
import org.jetbrains.exposed.sql.transactions.transaction

object DatabaseFactory {
    fun init(config: AppConfig) {
        Database.connect(
            url = config.dbUrl,
            driver = config.dbDriver
        )
        transaction {
            SchemaUtils.create(
                Users,
                Pets,
                PetMedia,
                PetPosts,
                Adoptions,
                Finances,
                Rescues,
                Blogs,
                Donations
            )
        }
    }
}
