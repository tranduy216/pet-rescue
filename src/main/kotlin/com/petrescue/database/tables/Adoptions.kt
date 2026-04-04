package com.petrescue.database.tables

import org.jetbrains.exposed.dao.id.IntIdTable
import org.jetbrains.exposed.sql.javatime.datetime
import java.time.LocalDateTime

object Adoptions : IntIdTable("t_tbl_adoptions") {
    val petId = integer("pet_id").references(Pets.id)
    val userId = integer("user_id").references(Users.id)
    val status = varchar("status", 50).default("REGISTERED")
    val approvedBy = integer("approved_by").references(Users.id).nullable()
    val cancelledBy = integer("cancelled_by").references(Users.id).nullable()
    val reason = text("reason").nullable()
    val phone = varchar("phone", 50)
    val facebookLink = varchar("facebook_link", 500)
    val notes = text("notes").nullable()
    val version = integer("version").default(0)
    val createdAt = datetime("created_at").clientDefault { LocalDateTime.now() }
    val updatedAt = datetime("updated_at").clientDefault { LocalDateTime.now() }
}
