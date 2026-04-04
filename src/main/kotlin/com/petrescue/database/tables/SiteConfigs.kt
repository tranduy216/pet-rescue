package com.petrescue.database.tables

import org.jetbrains.exposed.dao.id.IntIdTable
import org.jetbrains.exposed.sql.javatime.datetime
import java.time.LocalDateTime

object SiteConfigs : IntIdTable("m_tbl_site_configs") {
    val configKey = varchar("config_key", 100).uniqueIndex()
    val configValue = text("config_value")
    val updatedAt = datetime("updated_at").clientDefault { LocalDateTime.now() }
}
