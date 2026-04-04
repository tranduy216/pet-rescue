package com.petrescue.services

import com.petrescue.repositories.SiteConfigRepository

class SiteConfigService {
    private val repository = SiteConfigRepository()

    fun get(key: String, default: String = ""): String = repository.get(key) ?: default

    fun set(key: String, value: String) = repository.set(key, value)

    fun getAll(): Map<String, String> = repository.getAll()
}
