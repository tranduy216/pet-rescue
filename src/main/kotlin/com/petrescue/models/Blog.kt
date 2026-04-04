package com.petrescue.models

import java.time.LocalDateTime

data class Blog(
    val id: Int = 0,
    val title: String,
    val content: String,
    val authorId: Int,
    val tags: String? = null,
    val isPublished: Boolean = false,
    val viewCount: Int = 0,
    val createdAt: LocalDateTime = LocalDateTime.now(),
    val updatedAt: LocalDateTime = LocalDateTime.now(),
    val authorName: String? = null
)
