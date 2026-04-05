package com.petrescue.repositories

import com.petrescue.database.tables.UrgentAppealImages
import com.petrescue.database.tables.UrgentAppealUpdateImages
import com.petrescue.database.tables.UrgentAppealUpdates
import com.petrescue.database.tables.UrgentAppeals
import com.petrescue.models.UrgentAppeal
import com.petrescue.models.UrgentAppealUpdate
import org.jetbrains.exposed.sql.*
import org.jetbrains.exposed.sql.SqlExpressionBuilder.eq
import org.jetbrains.exposed.sql.transactions.transaction
import java.time.LocalDateTime

class UrgentAppealRepository {

    fun findAll(): List<UrgentAppeal> = transaction {
        UrgentAppeals.selectAll().map { it.toAppeal() }.map { appeal ->
            val images = UrgentAppealImages.select { UrgentAppealImages.appealId eq appeal.id }
                .map { it[UrgentAppealImages.fileUrl] }
            val updates = findUpdatesForAppeal(appeal.id)
            appeal.copy(images = images, updates = updates)
        }.sortedWith(
            compareBy<UrgentAppeal> { it.currentProgress }.thenByDescending { it.createdAt }
        )
    }

    fun findById(id: Int): UrgentAppeal? = transaction {
        val appeal = UrgentAppeals.select { UrgentAppeals.id eq id }.singleOrNull()?.toAppeal()
            ?: return@transaction null
        val images = UrgentAppealImages.select { UrgentAppealImages.appealId eq id }
            .map { it[UrgentAppealImages.fileUrl] }
        val updates = findUpdatesForAppeal(id)
        appeal.copy(images = images, updates = updates)
    }

    fun findRecent(limit: Int): List<UrgentAppeal> = transaction {
        findAll().take(limit)
    }

    private fun findUpdatesForAppeal(appealId: Int): List<UrgentAppealUpdate> = transaction {
        UrgentAppealUpdates.select { UrgentAppealUpdates.appealId eq appealId }
            .orderBy(UrgentAppealUpdates.updateDate, SortOrder.DESC)
            .map { row ->
                val updateId = row[UrgentAppealUpdates.id].value
                val imgs = UrgentAppealUpdateImages.select { UrgentAppealUpdateImages.updateId eq updateId }
                    .map { it[UrgentAppealUpdateImages.fileUrl] }
                UrgentAppealUpdate(
                    id = updateId,
                    appealId = row[UrgentAppealUpdates.appealId],
                    progress = row[UrgentAppealUpdates.progress],
                    content = row[UrgentAppealUpdates.content],
                    updateDate = row[UrgentAppealUpdates.updateDate],
                    videoUrl = row[UrgentAppealUpdates.videoUrl],
                    createdBy = row[UrgentAppealUpdates.createdBy],
                    createdAt = row[UrgentAppealUpdates.createdAt],
                    images = imgs
                )
            }
    }

    fun create(appeal: UrgentAppeal): UrgentAppeal = transaction {
        val id = UrgentAppeals.insert {
            it[title] = appeal.title
            it[content] = appeal.content
            it[amount] = appeal.amount
            it[videoUrl] = appeal.videoUrl
            it[createdBy] = appeal.createdBy
        } get UrgentAppeals.id
        appeal.copy(id = id.value)
    }

    fun addImage(appealId: Int, fileUrl: String) = transaction {
        UrgentAppealImages.insert {
            it[UrgentAppealImages.appealId] = appealId
            it[UrgentAppealImages.fileUrl] = fileUrl
        }
    }

    fun addUpdate(update: UrgentAppealUpdate): UrgentAppealUpdate = transaction {
        val id = UrgentAppealUpdates.insert {
            it[appealId] = update.appealId
            it[progress] = update.progress
            it[content] = update.content
            it[updateDate] = update.updateDate
            it[videoUrl] = update.videoUrl
            it[createdBy] = update.createdBy
        } get UrgentAppealUpdates.id
        UrgentAppeals.update({ UrgentAppeals.id eq update.appealId }) {
            it[updatedAt] = LocalDateTime.now()
        }
        update.copy(id = id.value)
    }

    fun addUpdateImage(updateId: Int, fileUrl: String) = transaction {
        UrgentAppealUpdateImages.insert {
            it[UrgentAppealUpdateImages.updateId] = updateId
            it[UrgentAppealUpdateImages.fileUrl] = fileUrl
        }
    }

    private fun ResultRow.toAppeal() = UrgentAppeal(
        id = this[UrgentAppeals.id].value,
        title = this[UrgentAppeals.title],
        content = this[UrgentAppeals.content],
        amount = this[UrgentAppeals.amount],
        videoUrl = this[UrgentAppeals.videoUrl],
        createdBy = this[UrgentAppeals.createdBy],
        createdAt = this[UrgentAppeals.createdAt],
        updatedAt = this[UrgentAppeals.updatedAt]
    )
}
