package com.petrescue.services

import com.petrescue.models.AuditLog
import com.petrescue.repositories.AuditLogRepository

object AuditLogService {
    private val repository = AuditLogRepository()

    fun log(action: String, entityType: String, entityId: Int? = null, userId: Int? = null, username: String? = null, details: String? = null) {
        try {
            repository.create(AuditLog(action = action, entityType = entityType, entityId = entityId, userId = userId, username = username, details = details))
        } catch (e: Exception) {
            // Audit logging should never break the main flow
        }
    }

    fun getAll(limit: Int = 200) = repository.findAll(limit)

    /** Deletes records older than 6 months and trims to 20 000 max. Returns count of deleted rows. */
    fun cleanup() = repository.cleanup()
}
