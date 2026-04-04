package com.petrescue.models

import java.time.LocalDateTime

enum class PetStatus {
    JUST_RESCUED,
    UNDER_TREATMENT,
    READY_TO_ADOPT,
    ADOPT_REGISTERED,
    ADOPTED,
    CANNOT_ADOPT,
    GONE_AWAY
}

data class Pet(
    val id: Int = 0,
    val name: String,
    val type: String,
    val breed: String? = null,
    val age: Int? = null,
    val gender: String? = null,
    val description: String? = null,
    val youtubeUrl: String? = null,
    val status: String = PetStatus.JUST_RESCUED.name,
    val createdBy: Int,
    val version: Int = 0,
    val createdAt: LocalDateTime = LocalDateTime.now(),
    val updatedAt: LocalDateTime = LocalDateTime.now(),
    val mediaList: List<PetMedia> = emptyList()
)

data class PetMedia(
    val id: Int = 0,
    val petId: Int,
    val fileUrl: String,
    val mediaType: String = "IMAGE",
    val createdAt: LocalDateTime = LocalDateTime.now()
)

data class PetPost(
    val id: Int = 0,
    val petId: Int,
    val title: String,
    val content: String,
    val authorId: Int,
    val createdAt: LocalDateTime = LocalDateTime.now(),
    val updatedAt: LocalDateTime = LocalDateTime.now()
)
