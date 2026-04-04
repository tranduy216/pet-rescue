package com.petrescue.repositories

import com.petrescue.database.tables.PetMedia
import com.petrescue.database.tables.Pets
import com.petrescue.models.Pet
import com.petrescue.models.PetMedia as PetMediaModel
import org.jetbrains.exposed.sql.*
import org.jetbrains.exposed.sql.SqlExpressionBuilder.eq
import org.jetbrains.exposed.sql.transactions.transaction
import java.time.LocalDateTime

class PetRepository {

    fun findRecent(limit: Int): List<Pet> = transaction {
        Pets.selectAll()
            .orderBy(Pets.createdAt, SortOrder.DESC)
            .limit(limit)
            .map { row ->
                val pet = row.toPet()
                val media = PetMedia.select { PetMedia.petId eq pet.id }.map { it.toMedia() }
                pet.copy(mediaList = media)
            }
    }

    fun findAll(search: String? = null, type: String? = null, status: String? = null): List<Pet> = transaction {
        var query = Pets.selectAll()
        if (!search.isNullOrBlank()) {
            query = query.andWhere { Pets.name.lowerCase() like "%${search.lowercase()}%" }
        }
        if (!type.isNullOrBlank()) {
            query = query.andWhere { Pets.type eq type }
        }
        if (!status.isNullOrBlank()) {
            query = query.andWhere { Pets.status eq status }
        }
        query.map { row ->
            val pet = row.toPet()
            val media = PetMedia.select { PetMedia.petId eq pet.id }.map { it.toMedia() }
            pet.copy(mediaList = media)
        }
    }

    fun findById(id: Int): Pet? = transaction {
        val pet = Pets.select { Pets.id eq id }.singleOrNull()?.toPet() ?: return@transaction null
        val media = PetMedia.select { PetMedia.petId eq id }.map { it.toMedia() }
        pet.copy(mediaList = media)
    }

    fun create(pet: Pet): Pet = transaction {
        val id = Pets.insert {
            it[name] = pet.name
            it[type] = pet.type
            it[breed] = pet.breed
            it[age] = pet.age
            it[gender] = pet.gender
            it[description] = pet.description
            it[youtubeUrl] = pet.youtubeUrl
            it[status] = pet.status
            it[createdBy] = pet.createdBy
        } get Pets.id
        pet.copy(id = id.value)
    }

    fun update(pet: Pet): Boolean = transaction {
        Pets.update({ (Pets.id eq pet.id) and (Pets.version eq pet.version) }) {
            it[name] = pet.name
            it[type] = pet.type
            it[breed] = pet.breed
            it[age] = pet.age
            it[gender] = pet.gender
            it[description] = pet.description
            it[youtubeUrl] = pet.youtubeUrl
            it[status] = pet.status
            it[version] = pet.version + 1
            it[updatedAt] = LocalDateTime.now()
        } > 0
    }

    fun delete(id: Int): Boolean = transaction {
        PetMedia.deleteWhere { petId eq id }
        Pets.deleteWhere { Pets.id eq id } > 0
    }

    fun addMedia(media: PetMediaModel): PetMediaModel = transaction {
        val id = PetMedia.insert {
            it[petId] = media.petId
            it[fileUrl] = media.fileUrl
            it[mediaType] = media.mediaType
        } get PetMedia.id
        media.copy(id = id.value)
    }

    fun deleteMedia(mediaId: Int): Boolean = transaction {
        PetMedia.deleteWhere { PetMedia.id eq mediaId } > 0
    }

    fun countByStatus(status: String): Long = transaction {
        Pets.select { Pets.status eq status }.count()
    }

    fun countAll(): Long = transaction {
        Pets.selectAll().count()
    }

    private fun ResultRow.toPet() = Pet(
        id = this[Pets.id].value,
        name = this[Pets.name],
        type = this[Pets.type],
        breed = this[Pets.breed],
        age = this[Pets.age],
        gender = this[Pets.gender],
        description = this[Pets.description],
        youtubeUrl = this[Pets.youtubeUrl],
        status = this[Pets.status],
        createdBy = this[Pets.createdBy],
        version = this[Pets.version],
        createdAt = this[Pets.createdAt],
        updatedAt = this[Pets.updatedAt]
    )

    private fun ResultRow.toMedia() = PetMediaModel(
        id = this[PetMedia.id].value,
        petId = this[PetMedia.petId],
        fileUrl = this[PetMedia.fileUrl],
        mediaType = this[PetMedia.mediaType],
        createdAt = this[PetMedia.createdAt]
    )
}
