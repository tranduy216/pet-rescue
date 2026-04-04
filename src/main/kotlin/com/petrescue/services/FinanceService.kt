package com.petrescue.services

import com.petrescue.models.Finance
import com.petrescue.repositories.FinanceRepository

class FinanceService {
    private val repository = FinanceRepository()

    fun getAll() = repository.findAll()
    fun getById(id: Int) = repository.findById(id)
    fun create(finance: Finance) = repository.create(finance)
    fun delete(id: Int) = repository.delete(id)
    fun getTotalIncome() = repository.getTotalByType("INCOME")
    fun getTotalExpense() = repository.getTotalByType("EXPENSE")
    fun getDailyStats(days: Int = 30) = repository.getDailyStats(days)
}
