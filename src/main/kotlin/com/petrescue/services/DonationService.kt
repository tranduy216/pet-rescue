package com.petrescue.services

import com.petrescue.models.Donation
import com.petrescue.repositories.DonationRepository

class DonationService {
    private val repository = DonationRepository()

    fun getAll() = repository.findAll()
    fun getById(id: Int) = repository.findById(id)
    fun create(donation: Donation) = repository.create(donation)
    fun updateStatus(id: Int, status: String) = repository.updateStatus(id, status)
    fun getTotalConfirmed() = repository.getTotalConfirmed()
}
