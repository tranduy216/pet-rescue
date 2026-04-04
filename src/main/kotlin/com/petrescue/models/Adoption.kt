package com.petrescue.models

import java.time.LocalDateTime

data class Adoption(
    val id: Int = 0,
    val petId: Int,
    val userId: Int,
    val status: String = "REGISTERED",
    val approvedBy: Int? = null,
    val cancelledBy: Int? = null,
    val reason: String? = null,
    val phone: String,
    val facebookLink: String,
    val notes: String? = null,
    val version: Int = 0,
    val createdAt: LocalDateTime = LocalDateTime.now(),
    val updatedAt: LocalDateTime = LocalDateTime.now(),
    val petName: String? = null,
    val userName: String? = null
)
