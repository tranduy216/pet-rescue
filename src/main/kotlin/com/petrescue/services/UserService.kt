package com.petrescue.services

import at.favre.lib.crypto.bcrypt.BCrypt
import com.petrescue.models.User
import com.petrescue.repositories.UserRepository

private val USERNAME_REGEX = Regex("^[a-z0-9_]+$")
private val EMAIL_REGEX = Regex("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$")
private val PHONE_REGEX = Regex("^[+\\d][\\d\\s\\-().]{5,19}$")

class UserService {
    private val repository = UserRepository()

    fun login(username: String, password: String): User? {
        val user = repository.findByUsername(username.lowercase().trim()) ?: return null
        if (!user.active) return null
        val result = BCrypt.verifyer().verify(password.toCharArray(), user.passwordHash)
        return if (result.verified) user else null
    }

    fun register(username: String, email: String, password: String, fullName: String, phone: String? = null): User? {
        val normalizedUsername = username.lowercase().trim()
        if (normalizedUsername.isBlank() || !normalizedUsername.matches(USERNAME_REGEX)) return null
        if (email.isBlank() || !email.matches(EMAIL_REGEX)) return null
        if (phone != null && !phone.matches(PHONE_REGEX)) return null
        if (repository.findByUsername(normalizedUsername) != null) return null
        if (repository.findByEmail(email) != null) return null
        val hash = BCrypt.withDefaults().hashToString(12, password.toCharArray())
        return repository.create(
            User(
                username = normalizedUsername,
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
