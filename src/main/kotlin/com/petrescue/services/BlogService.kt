package com.petrescue.services

import com.petrescue.models.Blog
import com.petrescue.repositories.BlogRepository

class BlogService {
    private val repository = BlogRepository()

    fun getAll(publishedOnly: Boolean = false) = repository.findAll(publishedOnly)
    fun getById(id: Int) = repository.findById(id)
    fun create(blog: Blog) = repository.create(blog)
    fun update(blog: Blog) = repository.update(blog)
    fun delete(id: Int) = repository.delete(id)
    fun incrementViews(id: Int) = repository.incrementViewCount(id)
}
