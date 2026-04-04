package com.petrescue.repositories

import com.petrescue.database.tables.Adoptions
import com.petrescue.models.Adoption
import org.jetbrains.exposed.sql.*
import org.jetbrains.exposed.sql.SqlExpressionBuilder.eq
import org.jetbrains.exposed.sql.transactions.transaction
import java.time.LocalDateTime

class AdoptionRepository {

    fun findAll(): List<Adoption> = transaction {
        Adoptions.selectAll().orderBy(Adoptions.createdAt, SortOrder.DESC).map { it.toAdoption() }
    }

    fun findById(id: Int): Adoption? = transaction {
        Adoptions.select { Adoptions.id eq id }.singleOrNull()?.toAdoption()
    }

    fun findByUser(userId: Int): List<Adoption> = transaction {
        Adoptions.select { Adoptions.userId eq userId }.map { it.toAdoption() }
    }

    fun create(adoption: Adoption): Adoption = transaction {
        val id = Adoptions.insert {
            it[petId] = adoption.petId
            it[userId] = adoption.userId
            it[status] = adoption.status
            it[phone] = adoption.phone
            it[facebookLink] = adoption.facebookLink
            it[notes] = adoption.notes
        } get Adoptions.id
        adoption.copy(id = id.value)
    }

    fun updateStatus(id: Int, status: String, byUserId: Int, reason: String? = null): Boolean = transaction {
        Adoptions.update({ Adoptions.id eq id }) {
            it[Adoptions.status] = status
            if (status == "APPROVED") it[approvedBy] = byUserId
            if (status == "CANCELLED") it[cancelledBy] = byUserId
            it[Adoptions.reason] = reason
            it[updatedAt] = LocalDateTime.now()
        } > 0
    }

    private fun ResultRow.toAdoption() = Adoption(
        id = this[Adoptions.id].value,
        petId = this[Adoptions.petId],
        userId = this[Adoptions.userId],
        status = this[Adoptions.status],
        approvedBy = this[Adoptions.approvedBy],
        cancelledBy = this[Adoptions.cancelledBy],
        reason = this[Adoptions.reason],
        phone = this[Adoptions.phone],
        facebookLink = this[Adoptions.facebookLink],
        notes = this[Adoptions.notes],
        createdAt = this[Adoptions.createdAt],
        updatedAt = this[Adoptions.updatedAt]
    )
}
