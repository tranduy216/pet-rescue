package com.petrescue.storage

import java.io.File

/**
 * Stores files on the local filesystem under [rootPath].
 * Files are accessible at `/uploads/<folder>/<fileName>`.
 */
class LocalStorageService(private val rootPath: String) : StorageService {

    override fun upload(folder: String, fileName: String, bytes: ByteArray, contentType: String): String {
        val dir = File(rootPath, folder)
        dir.mkdirs()
        File(dir, fileName).writeBytes(bytes)
        return if (folder.isBlank()) "/uploads/$fileName" else "/uploads/$folder/$fileName"
    }

    override fun delete(publicUrl: String) {
        // Strip leading "/uploads/"
        val relative = publicUrl.removePrefix("/uploads/")
        File(rootPath, relative).delete()
    }
}
