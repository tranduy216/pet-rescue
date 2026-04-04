package com.petrescue.database.tables

import org.jetbrains.exposed.dao.id.IntIdTable
import org.jetbrains.exposed.sql.javatime.date
import org.jetbrains.exposed.sql.javatime.datetime
import java.time.LocalDate
import java.time.LocalDateTime

object Finances : IntIdTable("t_tbl_finances") {
    val type = varchar("type", 20)
    val amount = decimal("amount", 15, 2)
    val description = text("description")
    val category = varchar("category", 100).nullable()
    val recordedBy = integer("recorded_by").references(Users.id)
    val date = date("date").clientDefault { LocalDate.now() }
    val createdAt = datetime("created_at").clientDefault { LocalDateTime.now() }
}
