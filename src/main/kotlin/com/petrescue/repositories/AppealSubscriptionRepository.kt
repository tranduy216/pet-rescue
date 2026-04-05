package com.petrescue.repositories

import com.petrescue.database.tables.AppealSubscriptions
import com.petrescue.models.AppealSubscription
import org.jetbrains.exposed.sql.*
import org.jetbrains.exposed.sql.SqlExpressionBuilder.eq
import org.jetbrains.exposed.sql.transactions.transaction

class AppealSubscriptionRepository {

    fun subscribe(sub: AppealSubscription): Boolean = transaction {
        // Upsert: ignore duplicate (appeal_id, fcm_token); update email/userId if auth
        val existing = AppealSubscriptions
            .select { (AppealSubscriptions.appealId eq sub.appealId) and (AppealSubscriptions.fcmToken eq sub.fcmToken) }
            .singleOrNull()
        if (existing == null) {
            AppealSubscriptions.insert {
                it[appealId] = sub.appealId
                it[userId] = sub.userId
                it[email] = sub.email
                it[fcmToken] = sub.fcmToken
            }
            true
        } else {
            // Upgrade guest to user if we now have credentials
            if (sub.userId != null || sub.email != null) {
                AppealSubscriptions.update({
                    (AppealSubscriptions.appealId eq sub.appealId) and
                    (AppealSubscriptions.fcmToken eq sub.fcmToken)
                }) {
                    if (sub.userId != null) it[userId] = sub.userId
                    if (sub.email != null) it[email] = sub.email
                }
            }
            false
        }
    }

    fun unsubscribe(appealId: Int, fcmToken: String): Boolean = transaction {
        AppealSubscriptions.deleteWhere {
            (AppealSubscriptions.appealId eq appealId) and (AppealSubscriptions.fcmToken eq fcmToken)
        } > 0
    }

    fun isSubscribed(appealId: Int, fcmToken: String): Boolean = transaction {
        AppealSubscriptions
            .select { (AppealSubscriptions.appealId eq appealId) and (AppealSubscriptions.fcmToken eq fcmToken) }
            .count() > 0
    }

    fun findByAppeal(appealId: Int): List<AppealSubscription> = transaction {
        AppealSubscriptions
            .select { AppealSubscriptions.appealId eq appealId }
            .map { it.toModel() }
    }

    fun findAllAppealIds(): List<Int> = transaction {
        AppealSubscriptions
            .slice(AppealSubscriptions.appealId)
            .selectAll()
            .map { it[AppealSubscriptions.appealId] }
            .distinct()
    }

    private fun ResultRow.toModel() = AppealSubscription(
        id = this[AppealSubscriptions.id].value,
        appealId = this[AppealSubscriptions.appealId],
        userId = this[AppealSubscriptions.userId],
        email = this[AppealSubscriptions.email],
        fcmToken = this[AppealSubscriptions.fcmToken],
        createdAt = this[AppealSubscriptions.createdAt]
    )
}
