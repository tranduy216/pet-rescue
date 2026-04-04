package com.petrescue.repositories

import com.petrescue.database.tables.AuditLogs
import com.petrescue.models.AuditLog
import org.jetbrains.exposed.sql.SortOrder
import org.jetbrains.exposed.sql.insert
import org.jetbrains.exposed.sql.selectAll
import org.jetbrains.exposed.sql.transactions.transaction

class AuditLogRepository {

    fun create(log: AuditLog): AuditLog = transaction {
        val id = AuditLogs.insert {
            it[action] = log.action
            it[entityType] = log.entityType
            it[entityId] = log.entityId
            it[userId] = log.userId
            it[username] = log.username
            it[details] = log.details
        } get AuditLogs.id
        log.copy(id = id.value)
    }

    fun findAll(limit: Int = 200): List<AuditLog> = transaction {
        AuditLogs.selectAll()
            .orderBy(AuditLogs.createdAt, SortOrder.DESC)
            .limit(limit)
            .map {
                AuditLog(
                    id = it[AuditLogs.id].value,
                    action = it[AuditLogs.action],
                    entityType = it[AuditLogs.entityType],
                    entityId = it[AuditLogs.entityId],
                    userId = it[AuditLogs.userId],
                    username = it[AuditLogs.username],
                    details = it[AuditLogs.details],
                    createdAt = it[AuditLogs.createdAt]
                )
            }
    }
}
