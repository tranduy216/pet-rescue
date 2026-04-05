package com.petrescue.database.tables

import org.jetbrains.exposed.dao.id.IntIdTable
import org.jetbrains.exposed.sql.javatime.datetime
import java.time.LocalDateTime

object AppealSubscriptions : IntIdTable("m_tbl_appeal_subscriptions") {
    val appealId = integer("appeal_id").references(UrgentAppeals.id)
    val userId = integer("user_id").references(Users.id).nullable()
    val email = varchar("email", 255).nullable()
    val fcmToken = varchar("fcm_token", 512)
    val createdAt = datetime("created_at").clientDefault { LocalDateTime.now() }

    init {
        uniqueIndex(appealId, fcmToken)
    }
}
