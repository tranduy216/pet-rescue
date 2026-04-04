package com.petrescue.models

import java.time.LocalDateTime

data class User(
    val id: Int = 0,
    val username: String,
    val email: String,
    val passwordHash: String = "",
    val fullName: String,
    val phone: String? = null,
    val facebookLink: String? = null,
    val role: String = "USER",
    val isActive: Boolean = true,
    val avatarUrl: String? = null,
    val createdAt: LocalDateTime = LocalDateTime.now(),
    val updatedAt: LocalDateTime = LocalDateTime.now()
)

enum class UserRole {
    ADMIN, VOLUNTEER, USER, GUEST
}
