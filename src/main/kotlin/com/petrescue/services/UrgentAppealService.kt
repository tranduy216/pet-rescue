package com.petrescue.services

import com.petrescue.cache.AppCache
import com.petrescue.models.UrgentAppeal
import com.petrescue.models.UrgentAppealUpdate
import com.petrescue.repositories.UrgentAppealRepository

class UrgentAppealService {
    private val repository = UrgentAppealRepository()

    fun getAll(): List<UrgentAppeal> = repository.findAll()

    fun getById(id: Int): UrgentAppeal? = repository.findById(id)

    fun getRecent(limit: Int): List<UrgentAppeal> = repository.findRecent(limit)

    fun create(appeal: UrgentAppeal): UrgentAppeal {
        val created = repository.create(appeal)
        AppCache.invalidateAll()
        return created
    }

    fun addImage(appealId: Int, fileUrl: String) {
        repository.addImage(appealId, fileUrl)
        AppCache.invalidateAll()
    }

    fun addUpdate(update: UrgentAppealUpdate): UrgentAppealUpdate {
        val created = repository.addUpdate(update)
        AppCache.invalidateAll()
        return created
    }

    fun addUpdateImage(updateId: Int, fileUrl: String) {
        repository.addUpdateImage(updateId, fileUrl)
        AppCache.invalidateAll()
    }
}
