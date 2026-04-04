package com.petrescue.database.tables

import org.jetbrains.exposed.dao.id.IntIdTable
import org.jetbrains.exposed.sql.javatime.datetime
import java.time.LocalDateTime

object Blogs : IntIdTable("t_tbl_blogs") {
    val title = varchar("title", 500)
    val content = text("content")
    val authorId = integer("author_id").references(Users.id)
    val tags = varchar("tags", 500).nullable()
    val isPublished = bool("is_published").default(false)
    val viewCount = integer("view_count").default(0)
    val createdAt = datetime("created_at").clientDefault { LocalDateTime.now() }
    val updatedAt = datetime("updated_at").clientDefault { LocalDateTime.now() }
}
