package com.petrescue.database.tables

import org.jetbrains.exposed.dao.id.IntIdTable
import org.jetbrains.exposed.sql.javatime.datetime
import java.time.LocalDateTime

object Pets : IntIdTable("m_tbl_pets") {
    val name = varchar("name", 255)
    val type = varchar("type", 50)
    val breed = varchar("breed", 255).nullable()
    val age = integer("age").nullable()
    val gender = varchar("gender", 20).nullable()
    val description = text("description").nullable()
    val youtubeUrl = varchar("youtube_url", 500).nullable()
    val status = varchar("status", 50).default("AVAILABLE")
    val createdBy = integer("created_by").references(Users.id)
    val version = integer("version").default(0)
    val createdAt = datetime("created_at").clientDefault { LocalDateTime.now() }
    val updatedAt = datetime("updated_at").clientDefault { LocalDateTime.now() }
}

object PetMedia : IntIdTable("m_tbl_pet_media") {
    val petId = integer("pet_id").references(Pets.id)
    val fileUrl = varchar("file_url", 500)
    val mediaType = varchar("media_type", 20).default("IMAGE")
    val createdAt = datetime("created_at").clientDefault { LocalDateTime.now() }
}

object PetPosts : IntIdTable("m_tbl_pet_posts") {
    val petId = integer("pet_id").references(Pets.id)
    val title = varchar("title", 500)
    val content = text("content")
    val authorId = integer("author_id").references(Users.id)
    val createdAt = datetime("created_at").clientDefault { LocalDateTime.now() }
    val updatedAt = datetime("updated_at").clientDefault { LocalDateTime.now() }
}
