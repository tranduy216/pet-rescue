package com.petrescue.services

import com.petrescue.cache.AppCache
import com.petrescue.models.Donation
import com.petrescue.repositories.DonationRepository

class DonationService {
    private val repository = DonationRepository()

    fun getAll() = repository.findAll()
    fun getApproved() = repository.findApproved()
    fun getById(id: Int) = repository.findById(id)
    fun create(donation: Donation) = repository.create(donation).also { AppCache.invalidateAll() }
    fun updateStatus(id: Int, status: String) = repository.updateStatus(id, status).also { AppCache.invalidateAll() }
    fun approve(id: Int) = repository.updateStatus(id, "APPROVED").also { AppCache.invalidateAll() }
    fun markReceived(id: Int) = repository.updateStatus(id, "RECEIVED").also { AppCache.invalidateAll() }
    fun getTotalConfirmed() = repository.getTotalConfirmed()
    fun countDonors() = repository.countDonors()
}
