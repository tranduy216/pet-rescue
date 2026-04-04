package com.petrescue.repositories

import com.petrescue.database.tables.AuditLogs
import com.petrescue.models.AuditLog
import org.jetbrains.exposed.sql.*
import org.jetbrains.exposed.sql.SqlExpressionBuilder.less
import org.jetbrains.exposed.sql.SqlExpressionBuilder.notInList
import org.jetbrains.exposed.sql.transactions.transaction
import java.time.LocalDateTime

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

    /**
     * Deletes audit log records older than [months] months.
     * Then, if the total count still exceeds [maxRecords], deletes the oldest
     * records beyond the limit so that at most [maxRecords] remain.
     */
    fun cleanup(months: Long = 6, maxRecords: Int = 20_000): Int = transaction {
        val cutoff = LocalDateTime.now().minusMonths(months)
        val deletedOld = AuditLogs.deleteWhere { AuditLogs.createdAt less cutoff }

        val total = AuditLogs.selectAll().count()
        val deletedExcess = if (total > maxRecords) {
            val keepIds = AuditLogs.selectAll()
                .orderBy(AuditLogs.createdAt, SortOrder.DESC)
                .limit(maxRecords)
                .map { it[AuditLogs.id].value }
            AuditLogs.deleteWhere { AuditLogs.id notInList keepIds }
        } else 0

        deletedOld + deletedExcess
    }
}
