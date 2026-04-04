package com.petrescue.services

import com.petrescue.models.Rescue
import com.petrescue.repositories.RescueRepository

class RescueService {
    private val repository = RescueRepository()

    fun getAll(status: String? = null) = repository.findAll(status)
    fun getById(id: Int) = repository.findById(id)
    fun create(rescue: Rescue) = repository.create(rescue)
    fun updateStatus(id: Int, status: String) = repository.updateStatus(id, status)
    fun delete(id: Int) = repository.delete(id)
}
