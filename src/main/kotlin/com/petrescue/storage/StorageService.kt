package com.petrescue.storage

/**
 * Abstraction over file storage backends (local disk, Cloudflare R2, etc.).
 */
interface StorageService {
    /**
     * Upload [bytes] as [fileName] under [folder] and return the public URL.
     */
    fun upload(folder: String, fileName: String, bytes: ByteArray, contentType: String): String

    /**
     * Delete the object at the given [publicUrl]. Best-effort; no exception on missing object.
     */
    fun delete(publicUrl: String)
}
