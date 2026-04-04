package com.petrescue.models

import java.time.LocalDateTime

data class AuditLog(
    val id: Int = 0,
    val action: String,
    val entityType: String,
    val entityId: Int? = null,
    val userId: Int? = null,
    val username: String? = null,
    val details: String? = null,
    val createdAt: LocalDateTime = LocalDateTime.now()
)
