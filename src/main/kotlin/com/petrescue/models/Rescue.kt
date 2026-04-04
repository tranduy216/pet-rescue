package com.petrescue.models

import java.time.LocalDateTime

data class Rescue(
    val id: Int = 0,
    val userId: Int? = null,
    val location: String,
    val description: String,
    val status: String = "REPORTED",
    val contactInfo: String,
    val createdAt: LocalDateTime = LocalDateTime.now(),
    val updatedAt: LocalDateTime = LocalDateTime.now(),
    val reporterName: String? = null
)
