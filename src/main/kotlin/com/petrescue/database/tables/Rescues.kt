package com.petrescue.database.tables

import org.jetbrains.exposed.dao.id.IntIdTable
import org.jetbrains.exposed.sql.javatime.datetime
import java.time.LocalDateTime

object Rescues : IntIdTable("t_tbl_rescues") {
    val userId = integer("user_id").references(Users.id).nullable()
    val location = varchar("location", 500)
    val description = text("description")
    val status = varchar("status", 50).default("REPORTED")
    val contactInfo = varchar("contact_info", 500)
    val createdAt = datetime("created_at").clientDefault { LocalDateTime.now() }
    val updatedAt = datetime("updated_at").clientDefault { LocalDateTime.now() }
}
