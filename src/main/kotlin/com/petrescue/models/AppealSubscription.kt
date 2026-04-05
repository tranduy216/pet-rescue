package com.petrescue.models

import java.time.LocalDateTime

data class AppealSubscription(
    val id: Int = 0,
    val appealId: Int,
    val userId: Int? = null,
    val email: String? = null,
    val fcmToken: String,
    val createdAt: LocalDateTime = LocalDateTime.now()
)
