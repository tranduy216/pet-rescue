package com.petrescue.repositories

import com.petrescue.database.tables.Finances
import com.petrescue.models.Finance
import org.jetbrains.exposed.sql.*
import org.jetbrains.exposed.sql.SqlExpressionBuilder.eq
import org.jetbrains.exposed.sql.transactions.transaction
import java.math.BigDecimal
import java.time.LocalDate

class FinanceRepository {

    fun findAll(): List<Finance> = transaction {
        Finances.selectAll().orderBy(Finances.date, SortOrder.DESC).map { it.toFinance() }
    }

    fun findById(id: Int): Finance? = transaction {
        Finances.select { Finances.id eq id }.singleOrNull()?.toFinance()
    }

    fun create(finance: Finance): Finance = transaction {
        val id = Finances.insert {
            it[type] = finance.type
            it[amount] = finance.amount
            it[description] = finance.description
            it[category] = finance.category
            it[recordedBy] = finance.recordedBy
            it[date] = finance.date
        } get Finances.id
        finance.copy(id = id.value)
    }

    fun delete(id: Int): Boolean = transaction {
        Finances.deleteWhere { Finances.id eq id } > 0
    }

    fun getTotalByType(type: String): BigDecimal = transaction {
        Finances.select { Finances.type eq type }
            .fold(BigDecimal.ZERO) { acc, row -> acc + row[Finances.amount] }
    }

    fun getDailyStats(days: Int = 30): List<Map<String, Any>> = transaction {
        val startDate = LocalDate.now().minusDays(days.toLong())
        val rows = Finances.select { Finances.date greaterEq startDate }.toList()
        rows.groupBy { it[Finances.date] }
            .map { (date, groupRows) ->
                val income = groupRows.filter { it[Finances.type] == "INCOME" }
                    .fold(BigDecimal.ZERO) { acc, r -> acc + r[Finances.amount] }
                val expense = groupRows.filter { it[Finances.type] == "EXPENSE" }
                    .fold(BigDecimal.ZERO) { acc, r -> acc + r[Finances.amount] }
                mapOf<String, Any>("date" to date.toString(), "income" to income, "expense" to expense)
            }
            .sortedBy { it["date"] as String }
    }

    private fun ResultRow.toFinance() = Finance(
        id = this[Finances.id].value,
        type = this[Finances.type],
        amount = this[Finances.amount],
        description = this[Finances.description],
        category = this[Finances.category],
        recordedBy = this[Finances.recordedBy],
        date = this[Finances.date],
        createdAt = this[Finances.createdAt]
    )
}
