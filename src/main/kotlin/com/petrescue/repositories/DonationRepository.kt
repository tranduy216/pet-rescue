package com.petrescue.repositories

import com.petrescue.database.tables.Donations
import com.petrescue.models.Donation
import org.jetbrains.exposed.sql.*
import org.jetbrains.exposed.sql.SqlExpressionBuilder.eq
import org.jetbrains.exposed.sql.transactions.transaction
import java.math.BigDecimal
import java.time.LocalDateTime

class DonationRepository {

    fun findAll(status: String? = null): List<Donation> = transaction {
        var query = Donations.selectAll()
        if (!status.isNullOrBlank()) query = query.andWhere { Donations.status eq status }
        query.orderBy(Donations.createdAt, SortOrder.DESC).map { it.toDonation() }
    }

    fun findApproved(): List<Donation> = transaction {
        Donations.select { Donations.status eq "APPROVED" }
            .orderBy(Donations.createdAt, SortOrder.DESC)
            .map { it.toDonation() }
    }

    fun findById(id: Int): Donation? = transaction {
        Donations.select { Donations.id eq id }.singleOrNull()?.toDonation()
    }

    fun create(donation: Donation): Donation = transaction {
        val id = Donations.insert {
            it[donorName] = donation.donorName
            it[donorEmail] = donation.donorEmail
            it[amount] = donation.amount
            it[message] = donation.message
            it[status] = donation.status
            it[transactionId] = donation.transactionId
        } get Donations.id
        donation.copy(id = id.value)
    }

    fun delete(id: Int): Boolean = transaction {
        Donations.deleteWhere { Donations.id eq id } > 0
    }

    fun updateStatus(id: Int, status: String): Boolean = transaction {
        Donations.update({ Donations.id eq id }) {
            it[Donations.status] = status
            it[updatedAt] = LocalDateTime.now()
        } > 0
    }

    fun getTotalConfirmed(): BigDecimal = transaction {
        Donations.select { Donations.status eq "CONFIRMED" }
            .fold(BigDecimal.ZERO) { acc, row -> acc + row[Donations.amount] }
    }

    fun countDonors(): Long = transaction {
        Donations.slice(Donations.donorEmail).selectAll().withDistinct().count()
    }

    private fun ResultRow.toDonation() = Donation(
        id = this[Donations.id].value,
        donorName = this[Donations.donorName],
        donorEmail = this[Donations.donorEmail],
        amount = this[Donations.amount],
        message = this[Donations.message],
        status = this[Donations.status],
        transactionId = this[Donations.transactionId],
        createdAt = this[Donations.createdAt],
        updatedAt = this[Donations.updatedAt]
    )
}
