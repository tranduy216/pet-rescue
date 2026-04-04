package com.petrescue.repositories

import com.petrescue.database.tables.Users
import com.petrescue.models.User
import org.jetbrains.exposed.sql.*
import org.jetbrains.exposed.sql.SqlExpressionBuilder.eq
import org.jetbrains.exposed.sql.transactions.transaction
import java.time.LocalDateTime

class UserRepository {

    fun findById(id: Int): User? = transaction {
        Users.select { Users.id eq id }.singleOrNull()?.toUser()
    }

    fun findByUsername(username: String): User? = transaction {
        Users.select { Users.username eq username }.singleOrNull()?.toUser()
    }

    fun findByEmail(email: String): User? = transaction {
        Users.select { Users.email eq email }.singleOrNull()?.toUser()
    }

    fun findAll(role: String? = null): List<User> = transaction {
        var query = Users.selectAll()
        if (!role.isNullOrBlank()) query = query.andWhere { Users.role eq role }
        query.map { it.toUser() }
    }

    fun create(user: User): User = transaction {
        val id = Users.insert {
            it[username] = user.username
            it[email] = user.email
            it[passwordHash] = user.passwordHash
            it[fullName] = user.fullName
            it[phone] = user.phone
            it[facebookLink] = user.facebookLink
            it[role] = user.role
            it[isActive] = user.active
            it[avatarUrl] = user.avatarUrl
        } get Users.id
        user.copy(id = id.value)
    }

    fun update(user: User): Boolean = transaction {
        Users.update({ Users.id eq user.id }) {
            it[email] = user.email
            it[fullName] = user.fullName
            it[phone] = user.phone
            it[facebookLink] = user.facebookLink
            it[role] = user.role
            it[isActive] = user.active
            it[avatarUrl] = user.avatarUrl
            it[updatedAt] = LocalDateTime.now()
        } > 0
    }

    fun updatePassword(userId: Int, newHash: String): Boolean = transaction {
        Users.update({ Users.id eq userId }) {
            it[passwordHash] = newHash
            it[updatedAt] = LocalDateTime.now()
        } > 0
    }

    fun delete(id: Int): Boolean = transaction {
        Users.deleteWhere { Users.id eq id } > 0
    }

    private fun ResultRow.toUser() = User(
        id = this[Users.id].value,
        username = this[Users.username],
        email = this[Users.email],
        passwordHash = this[Users.passwordHash],
        fullName = this[Users.fullName],
        phone = this[Users.phone],
        facebookLink = this[Users.facebookLink],
        role = this[Users.role],
        active = this[Users.isActive],
        avatarUrl = this[Users.avatarUrl],
        createdAt = this[Users.createdAt],
        updatedAt = this[Users.updatedAt]
    )
}
