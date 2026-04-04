package com.petrescue.services

import com.petrescue.models.Pet
import com.petrescue.models.PetMedia
import com.petrescue.repositories.PetRepository

class PetService {
    private val repository = PetRepository()

    fun getAll(search: String? = null, type: String? = null, status: String? = null) =
        repository.findAll(search, type, status)

    fun getById(id: Int) = repository.findById(id)

    fun create(pet: Pet) = repository.create(pet)

    fun update(pet: Pet) = repository.update(pet)

    fun delete(id: Int) = repository.delete(id)

    fun addMedia(media: PetMedia) = repository.addMedia(media)

    fun deleteMedia(mediaId: Int) = repository.deleteMedia(mediaId)
}
