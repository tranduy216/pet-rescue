package com.petrescue.cache

import java.util.concurrent.ConcurrentHashMap

/**
 * Thread-safe in-memory cache with TTL support.
 * Each entry lives for [ttlMillis] milliseconds (default: 1 hour).
 * Call [invalidateAll] to clear all entries on any write operation.
 */
object AppCache {

    private val ttlMillis: Long = 60 * 60 * 1000L // 1 hour

    private data class CacheEntry<T>(val value: T, val expiresAt: Long)

    private val store = ConcurrentHashMap<String, CacheEntry<*>>()

    /**
     * Returns the cached value for [key], or null if missing / expired.
     */
    @Suppress("UNCHECKED_CAST")
    fun <T> get(key: String): T? {
        val entry = store[key] ?: return null
        if (System.currentTimeMillis() > entry.expiresAt) {
            store.remove(key)
            return null
        }
        return entry.value as T
    }

    /**
     * Stores [value] under [key] with a TTL of 1 hour.
     */
    fun <T> set(key: String, value: T) {
        store[key] = CacheEntry(value as Any, System.currentTimeMillis() + ttlMillis)
    }

    /**
     * Returns the cached value for [key].
     * If not present or expired, calls [loader], caches the result, and returns it.
     */
    fun <T> getOrLoad(key: String, loader: () -> T): T {
        return get(key) ?: loader().also { set(key, it) }
    }

    /**
     * Removes all entries from the cache.
     * Should be called after any create / update / delete operation.
     */
    fun invalidateAll() {
        store.clear()
    }
}
