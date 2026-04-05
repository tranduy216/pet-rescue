package com.petrescue.models

import java.math.BigDecimal
import java.time.LocalDate
import java.time.LocalDateTime

data class UrgentAppeal(
    val id: Int = 0,
    val title: String,
    val content: String,
    val amount: BigDecimal = BigDecimal.ZERO,
    val videoUrl: String? = null,
    val createdBy: Int,
    val createdAt: LocalDateTime = LocalDateTime.now(),
    val updatedAt: LocalDateTime = LocalDateTime.now(),
    val images: List<String> = emptyList(),
    val updates: List<UrgentAppealUpdate> = emptyList()
) {
    val currentProgress: Int get() = updates.maxOfOrNull { it.progress } ?: 0
}

data class UrgentAppealUpdate(
    val id: Int = 0,
    val appealId: Int,
    val progress: Int,
    val content: String,
    val updateDate: LocalDate,
    val videoUrl: String? = null,
    val createdBy: Int,
    val createdAt: LocalDateTime = LocalDateTime.now(),
    val images: List<String> = emptyList()
)
