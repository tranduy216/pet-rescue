package com.petrescue.services

import com.petrescue.cache.AppCache
import com.petrescue.models.Donation
import com.petrescue.repositories.DonationRepository

class DonationService {
    private val repository = DonationRepository()

    fun getAll(status: String? = null) = repository.findAll(status)
    fun getApproved() = repository.findApproved()
    fun getById(id: Int) = repository.findById(id)
    fun create(donation: Donation) = repository.create(donation).also { AppCache.invalidateAll() }
    fun updateStatus(id: Int, status: String) = repository.updateStatus(id, status).also { AppCache.invalidateAll() }
    fun delete(id: Int) = repository.delete(id).also { AppCache.invalidateAll() }
    fun approve(id: Int) = repository.updateStatus(id, "APPROVED").also { AppCache.invalidateAll() }
    fun getTotalConfirmed() = repository.getTotalConfirmed()
    fun countDonors() = repository.countDonors()
}
