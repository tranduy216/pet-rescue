package com.petrescue.services

import com.petrescue.cache.AppCache
import com.petrescue.models.Adoption
import com.petrescue.repositories.AdoptionRepository
import com.petrescue.repositories.PetRepository
import org.jetbrains.exposed.sql.transactions.transaction

class AdoptionService {
    private val repository = AdoptionRepository()
    private val petRepository = PetRepository()

    fun getAll(status: String? = null) = repository.findAll(status)
    fun getById(id: Int) = repository.findById(id)
    fun getByUser(userId: Int, status: String? = null) = repository.findByUser(userId, status)

    fun create(adoption: Adoption): Adoption {
        return transaction {
            val pet = petRepository.findById(adoption.petId)
                ?: throw IllegalStateException("pet_not_found")
            if (pet.status != "READY_TO_ADOPT") {
                throw IllegalStateException("adoption_error_pet_not_ready")
            }
            val created = repository.create(adoption)
            val updated = petRepository.update(pet.copy(status = "ADOPT_REGISTERED"))
            if (!updated) throw IllegalStateException("adoption_error_optimistic_lock")
            AppCache.invalidateAll()
            created
        }
    }

    fun confirm(id: Int, byUserId: Int): Boolean {
        return transaction {
            val adoption = repository.findById(id) ?: return@transaction false
            val success = repository.updateStatus(id, "CONFIRMED", byUserId)
            if (success) AppCache.invalidateAll()
            success
        }
    }

    fun finish(id: Int, byUserId: Int): Boolean {
        return transaction {
            val adoption = repository.findById(id) ?: return@transaction false
            val success = repository.updateStatus(id, "FINISHED", byUserId)
            if (success) {
                val pet = petRepository.findById(adoption.petId)
                    ?: throw IllegalStateException("pet_not_found")
                val petUpdated = petRepository.update(pet.copy(status = "ADOPTED"))
                if (!petUpdated) throw IllegalStateException("adoption_error_optimistic_lock")
                AppCache.invalidateAll()
            }
            success
        }
    }

    fun cancel(id: Int, byUserId: Int, reason: String?): Boolean {
        return transaction {
            val adoption = repository.findById(id) ?: return@transaction false
            val success = repository.updateStatus(id, "CANCELLED", byUserId, reason)
            if (success) {
                val pet = petRepository.findById(adoption.petId)
                    ?: throw IllegalStateException("pet_not_found")
                val petUpdated = petRepository.update(pet.copy(status = "READY_TO_ADOPT"))
                if (!petUpdated) throw IllegalStateException("adoption_error_optimistic_lock")
                AppCache.invalidateAll()
            }
            success
        }
    }
}
