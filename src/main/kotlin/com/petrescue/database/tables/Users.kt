package com.petrescue.database.tables

import org.jetbrains.exposed.dao.id.IntIdTable
import org.jetbrains.exposed.sql.javatime.datetime
import java.time.LocalDateTime

object Users : IntIdTable("m_tbl_users") {
    val username = varchar("username", 100).uniqueIndex()
    val email = varchar("email", 255).uniqueIndex()
    val passwordHash = varchar("password_hash", 255)
    val fullName = varchar("full_name", 255)
    val phone = varchar("phone", 50).nullable()
    val facebookLink = varchar("facebook_link", 500).nullable()
    val role = varchar("role", 50).default("USER")
    val isActive = bool("is_active").default(true)
    val avatarUrl = varchar("avatar_url", 500).nullable()
    val createdAt = datetime("created_at").clientDefault { LocalDateTime.now() }
    val updatedAt = datetime("updated_at").clientDefault { LocalDateTime.now() }
}
