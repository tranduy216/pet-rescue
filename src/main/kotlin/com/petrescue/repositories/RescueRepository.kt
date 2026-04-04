package com.petrescue.repositories

import com.petrescue.database.tables.Rescues
import com.petrescue.models.Rescue
import org.jetbrains.exposed.sql.*
import org.jetbrains.exposed.sql.SqlExpressionBuilder.eq
import org.jetbrains.exposed.sql.transactions.transaction
import java.time.LocalDateTime

class RescueRepository {

    fun findAll(status: String? = null): List<Rescue> = transaction {
        var query = Rescues.selectAll()
        if (!status.isNullOrBlank()) query = query.andWhere { Rescues.status eq status }
        query.orderBy(Rescues.createdAt, SortOrder.DESC).map { it.toRescue() }
    }

    fun findById(id: Int): Rescue? = transaction {
        Rescues.select { Rescues.id eq id }.singleOrNull()?.toRescue()
    }

    fun create(rescue: Rescue): Rescue = transaction {
        val id = Rescues.insert {
            it[userId] = rescue.userId
            it[location] = rescue.location
            it[description] = rescue.description
            it[status] = rescue.status
            it[contactInfo] = rescue.contactInfo
        } get Rescues.id
        rescue.copy(id = id.value)
    }

    fun updateStatus(id: Int, status: String): Boolean = transaction {
        Rescues.update({ Rescues.id eq id }) {
            it[Rescues.status] = status
            it[updatedAt] = LocalDateTime.now()
        } > 0
    }

    fun delete(id: Int): Boolean = transaction {
        Rescues.deleteWhere { Rescues.id eq id } > 0
    }

    private fun ResultRow.toRescue() = Rescue(
        id = this[Rescues.id].value,
        userId = this[Rescues.userId],
        location = this[Rescues.location],
        description = this[Rescues.description],
        status = this[Rescues.status],
        contactInfo = this[Rescues.contactInfo],
        createdAt = this[Rescues.createdAt],
        updatedAt = this[Rescues.updatedAt]
    )
}
