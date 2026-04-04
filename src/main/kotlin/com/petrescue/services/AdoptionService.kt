package com.petrescue.services

import com.petrescue.models.Adoption
import com.petrescue.repositories.AdoptionRepository
import com.petrescue.repositories.PetRepository

class AdoptionService {
    private val repository = AdoptionRepository()
    private val petRepository = PetRepository()

    fun getAll() = repository.findAll()
    fun getById(id: Int) = repository.findById(id)
    fun getByUser(userId: Int) = repository.findByUser(userId)

    fun create(adoption: Adoption): Adoption {
        val created = repository.create(adoption)
        val pet = petRepository.findById(adoption.petId)
        if (pet != null) {
            petRepository.update(pet.copy(status = "ADOPT_REGISTERED"))
        }
        return created
    }

    fun confirm(id: Int, byUserId: Int): Boolean {
        val adoption = repository.findById(id) ?: return false
        val success = repository.updateStatus(id, "CONFIRMED", byUserId)
        if (success) {
            val pet = petRepository.findById(adoption.petId)
            if (pet != null) {
                petRepository.update(pet.copy(status = "ADOPT_REGISTERED"))
            }
        }
        return success
    }

    fun finish(id: Int, byUserId: Int): Boolean {
        val adoption = repository.findById(id) ?: return false
        val success = repository.updateStatus(id, "FINISHED", byUserId)
        if (success) {
            val pet = petRepository.findById(adoption.petId)
            if (pet != null) {
                petRepository.update(pet.copy(status = "ADOPTED"))
            }
        }
        return success
    }

    fun cancel(id: Int, byUserId: Int, reason: String?): Boolean {
        val adoption = repository.findById(id) ?: return false
        val success = repository.updateStatus(id, "CANCELLED", byUserId, reason)
        if (success) {
            val pet = petRepository.findById(adoption.petId)
            if (pet != null) {
                petRepository.update(pet.copy(status = "READY_TO_ADOPT"))
            }
        }
        return success
    }
}
