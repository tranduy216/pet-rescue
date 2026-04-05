package com.petrescue.database.tables

import org.jetbrains.exposed.dao.id.IntIdTable
import org.jetbrains.exposed.sql.javatime.datetime
import java.time.LocalDateTime

object Donations : IntIdTable("t_tbl_donations") {
    val donorName = varchar("donor_name", 255)
    val donorEmail = varchar("donor_email", 255)
    val amount = decimal("amount", 15, 2)
    val message = text("message").nullable()
    val status = varchar("status", 50).default("NEW")
    val transactionId = varchar("transaction_id", 255).nullable()
    val createdAt = datetime("created_at").clientDefault { LocalDateTime.now() }
    val updatedAt = datetime("updated_at").clientDefault { LocalDateTime.now() }
}
