package com.petrescue.database.tables

import org.jetbrains.exposed.dao.id.IntIdTable
import org.jetbrains.exposed.sql.javatime.datetime
import java.time.LocalDateTime

object AuditLogs : IntIdTable("t_tbl_audit_logs") {
    val action = varchar("action", 50)
    val entityType = varchar("entity_type", 100)
    val entityId = integer("entity_id").nullable()
    val userId = integer("user_id").nullable()
    val username = varchar("username", 100).nullable()
    val details = text("details").nullable()
    val createdAt = datetime("created_at").clientDefault { LocalDateTime.now() }
}
