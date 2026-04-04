package com.petrescue.services

import at.favre.lib.crypto.bcrypt.BCrypt
import com.petrescue.models.User
import com.petrescue.repositories.UserRepository

class UserService {
    private val repository = UserRepository()

    fun seedAdminUser() {
        val existing = repository.findByUsername("admin")
        if (existing == null) {
            val hash = BCrypt.withDefaults().hashToString(12, "admin123".toCharArray())
            repository.create(
                User(
                    username = "admin",
                    email = "admin@petrescue.com",
                    passwordHash = hash,
                    fullName = "System Administrator",
                    role = "ADMIN"
                )
            )
        }
    }

    fun login(username: String, password: String): User? {
        val user = repository.findByUsername(username) ?: return null
        if (!user.active) return null
        val result = BCrypt.verifyer().verify(password.toCharArray(), user.passwordHash)
        return if (result.verified) user else null
    }

    fun register(username: String, email: String, password: String, fullName: String, phone: String? = null): User? {
        if (repository.findByUsername(username) != null) return null
        if (repository.findByEmail(email) != null) return null
        val hash = BCrypt.withDefaults().hashToString(12, password.toCharArray())
        return repository.create(
            User(
                username = username,
                email = email,
                passwordHash = hash,
                fullName = fullName,
                phone = phone,
                role = "USER"
            )
        )
    }

    fun getById(id: Int) = repository.findById(id)
    fun findByEmail(email: String) = repository.findByEmail(email)
    fun getAll() = repository.findAll()
    fun update(user: User) = repository.update(user)
    fun delete(id: Int) = repository.delete(id)
    fun changePassword(userId: Int, newPassword: String): Boolean {
        val hash = BCrypt.withDefaults().hashToString(12, newPassword.toCharArray())
        return repository.updatePassword(userId, hash)
    }
}
