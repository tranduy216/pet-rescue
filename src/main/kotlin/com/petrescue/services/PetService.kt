package com.petrescue.services

import com.petrescue.cache.AppCache
import com.petrescue.models.Pet
import com.petrescue.models.PetMedia
import com.petrescue.models.PetStatus
import com.petrescue.repositories.AdoptionRepository
import com.petrescue.repositories.PetRepository

class PetService {
    private val repository = PetRepository()
    private val adoptionRepository = AdoptionRepository()

    companion object {
        private val VALID_STATUSES = PetStatus.entries.map { it.name }.toSet()
        // Statuses managed exclusively by the adoption workflow; cannot be set manually on create
        val CREATE_DISALLOWED_STATUSES = setOf(PetStatus.ADOPT_REGISTERED.name, PetStatus.ADOPTED.name)
    }

    fun getRecent(limit: Int = 3) = repository.findRecent(limit)

    fun getAll(search: String? = null, type: String? = null, status: String? = null) =
        repository.findAll(search, type, status)

    fun getById(id: Int) = repository.findById(id)

    fun create(pet: Pet): Pet {
        if (pet.status !in VALID_STATUSES) {
            throw IllegalStateException("pet_error_invalid_status")
        }
        if (pet.status in CREATE_DISALLOWED_STATUSES) {
            throw IllegalStateException("pet_error_create_disallowed_status")
        }
        return repository.create(pet).also { AppCache.invalidateAll() }
    }

    fun update(pet: Pet): Boolean {
        if (pet.status !in VALID_STATUSES) {
            throw IllegalStateException("pet_error_invalid_status")
        }
        val existing = repository.findById(pet.id)
        if (existing != null && existing.status != pet.status) {
            // ADOPT_REGISTERED and ADOPTED can only be set or cleared by the adoption workflow, never manually
            if (existing.status in CREATE_DISALLOWED_STATUSES || pet.status in CREATE_DISALLOWED_STATUSES) {
                throw IllegalStateException("pet_error_adoption_managed_status")
            }
            // Also block any other status change while an active adoption exists
            if (adoptionRepository.hasActiveAdoption(pet.id)) {
                throw IllegalStateException("pet_error_active_adoption")
            }
        }
        return repository.update(pet).also { AppCache.invalidateAll() }
    }

    fun delete(id: Int) = repository.delete(id).also { AppCache.invalidateAll() }

    fun addMedia(media: PetMedia) = repository.addMedia(media).also { AppCache.invalidateAll() }

    fun deleteMedia(mediaId: Int) = repository.deleteMedia(mediaId).also { AppCache.invalidateAll() }

    fun countByStatus(status: String) = repository.countByStatus(status)

    fun countAll() = repository.countAll()
}
