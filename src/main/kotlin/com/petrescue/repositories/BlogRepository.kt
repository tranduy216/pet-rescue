package com.petrescue.repositories

import com.petrescue.database.tables.Blogs
import com.petrescue.models.Blog
import org.jetbrains.exposed.sql.*
import org.jetbrains.exposed.sql.SqlExpressionBuilder.eq
import org.jetbrains.exposed.sql.transactions.transaction
import java.time.LocalDateTime

class BlogRepository {

    fun findAll(publishedOnly: Boolean = false): List<Blog> = transaction {
        var query = Blogs.selectAll()
        if (publishedOnly) {
            query = query.andWhere { Blogs.isPublished eq true }
        }
        query.orderBy(Blogs.createdAt, SortOrder.DESC).map { it.toBlog() }
    }

    fun findById(id: Int): Blog? = transaction {
        Blogs.select { Blogs.id eq id }.singleOrNull()?.toBlog()
    }

    fun create(blog: Blog): Blog = transaction {
        val id = Blogs.insert {
            it[title] = blog.title
            it[content] = blog.content
            it[authorId] = blog.authorId
            it[tags] = blog.tags
            it[isPublished] = blog.isPublished
        } get Blogs.id
        blog.copy(id = id.value)
    }

    fun update(blog: Blog): Boolean = transaction {
        Blogs.update({ Blogs.id eq blog.id }) {
            it[title] = blog.title
            it[content] = blog.content
            it[tags] = blog.tags
            it[isPublished] = blog.isPublished
            it[updatedAt] = LocalDateTime.now()
        } > 0
    }

    fun incrementViewCount(id: Int): Boolean = transaction {
        val blog = Blogs.select { Blogs.id eq id }.singleOrNull() ?: return@transaction false
        val currentCount = blog[Blogs.viewCount]
        Blogs.update({ Blogs.id eq id }) {
            it[viewCount] = currentCount + 1
        } > 0
    }

    fun delete(id: Int): Boolean = transaction {
        Blogs.deleteWhere { Blogs.id eq id } > 0
    }

    private fun ResultRow.toBlog() = Blog(
        id = this[Blogs.id].value,
        title = this[Blogs.title],
        content = this[Blogs.content],
        authorId = this[Blogs.authorId],
        tags = this[Blogs.tags],
        isPublished = this[Blogs.isPublished],
        viewCount = this[Blogs.viewCount],
        createdAt = this[Blogs.createdAt],
        updatedAt = this[Blogs.updatedAt]
    )
}
