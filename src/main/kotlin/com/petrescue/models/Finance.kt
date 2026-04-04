package com.petrescue.models

import java.math.BigDecimal
import java.time.LocalDate
import java.time.LocalDateTime

data class Finance(
    val id: Int = 0,
    val type: String,
    val amount: BigDecimal,
    val description: String,
    val category: String? = null,
    val recordedBy: Int,
    val date: LocalDate = LocalDate.now(),
    val createdAt: LocalDateTime = LocalDateTime.now()
)
