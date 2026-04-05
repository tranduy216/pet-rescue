package com.petrescue.models

import java.math.BigDecimal
import java.time.LocalDateTime

data class Donation(
    val id: Int = 0,
    val donorName: String,
    val donorEmail: String,
    val amount: BigDecimal,
    val message: String? = null,
    val status: String = "NEW",
    val transactionId: String? = null,
    val createdAt: LocalDateTime = LocalDateTime.now(),
    val updatedAt: LocalDateTime = LocalDateTime.now()
)
