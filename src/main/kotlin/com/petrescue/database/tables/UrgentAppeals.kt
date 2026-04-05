package com.petrescue.database.tables

import org.jetbrains.exposed.dao.id.IntIdTable
import org.jetbrains.exposed.sql.javatime.date
import org.jetbrains.exposed.sql.javatime.datetime
import java.math.BigDecimal
import java.time.LocalDateTime

object UrgentAppeals : IntIdTable("m_tbl_urgent_appeals") {
    val title = varchar("title", 500)
    val content = text("content")
    val amount = decimal("amount", 15, 2).default(BigDecimal.ZERO)
    val videoUrl = varchar("video_url", 500).nullable()
    val createdBy = integer("created_by").references(Users.id)
    val createdAt = datetime("created_at").clientDefault { LocalDateTime.now() }
    val updatedAt = datetime("updated_at").clientDefault { LocalDateTime.now() }
}

object UrgentAppealImages : IntIdTable("m_tbl_urgent_appeal_images") {
    val appealId = integer("appeal_id").references(UrgentAppeals.id)
    val fileUrl = varchar("file_url", 500)
    val createdAt = datetime("created_at").clientDefault { LocalDateTime.now() }
}

object UrgentAppealUpdates : IntIdTable("m_tbl_urgent_appeal_updates") {
    val appealId = integer("appeal_id").references(UrgentAppeals.id)
    val progress = integer("progress")
    val content = text("content")
    val updateDate = date("update_date")
    val videoUrl = varchar("video_url", 500).nullable()
    val createdBy = integer("created_by").references(Users.id)
    val createdAt = datetime("created_at").clientDefault { LocalDateTime.now() }
}

object UrgentAppealUpdateImages : IntIdTable("m_tbl_urgent_appeal_update_images") {
    val updateId = integer("update_id").references(UrgentAppealUpdates.id)
    val fileUrl = varchar("file_url", 500)
    val createdAt = datetime("created_at").clientDefault { LocalDateTime.now() }
}
