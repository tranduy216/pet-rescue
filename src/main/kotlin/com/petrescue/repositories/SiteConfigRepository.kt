package com.petrescue.repositories

import com.petrescue.database.tables.SiteConfigs
import org.jetbrains.exposed.sql.*
import org.jetbrains.exposed.sql.transactions.transaction
import java.time.LocalDateTime

class SiteConfigRepository {

    fun get(key: String): String? = transaction {
        SiteConfigs.select { SiteConfigs.configKey eq key }
            .singleOrNull()
            ?.get(SiteConfigs.configValue)
    }

    fun set(key: String, value: String) = transaction {
        val existing = SiteConfigs.select { SiteConfigs.configKey eq key }.singleOrNull()
        if (existing == null) {
            SiteConfigs.insert {
                it[configKey] = key
                it[configValue] = value
                it[updatedAt] = LocalDateTime.now()
            }
        } else {
            SiteConfigs.update({ SiteConfigs.configKey eq key }) {
                it[configValue] = value
                it[updatedAt] = LocalDateTime.now()
            }
        }
    }

    fun getAll(): Map<String, String> = transaction {
        SiteConfigs.selectAll().associate {
            it[SiteConfigs.configKey] to it[SiteConfigs.configValue]
        }
    }
}
