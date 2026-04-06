package com.petrescue.services

import com.petrescue.cache.AppCache
import com.petrescue.models.Pet
import com.petrescue.models.PetMedia
import com.petrescue.repositories.PetRepository

class PetService {
    private val repository = PetRepository()

    fun getRecent(limit: Int = 3) = repository.findRecent(limit)

    fun getAll(search: String? = null, type: String? = null, status: String? = null) =
        repository.findAll(search, type, status)

    fun getById(id: Int) = repository.findById(id)

    fun create(pet: Pet) = repository.create(pet).also { AppCache.invalidateAll() }

    fun update(pet: Pet) = repository.update(pet).also { AppCache.invalidateAll() }

    fun delete(id: Int) = repository.delete(id).also { AppCache.invalidateAll() }

    fun addMedia(media: PetMedia) = repository.addMedia(media).also { AppCache.invalidateAll() }

    fun deleteMedia(mediaId: Int) = repository.deleteMedia(mediaId).also { AppCache.invalidateAll() }

    fun getMediaById(mediaId: Int) = repository.findMediaById(mediaId)

    fun countByStatus(status: String) = repository.countByStatus(status)

    fun countAll() = repository.countAll()
}
