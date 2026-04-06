package com.petrescue.storage

import software.amazon.awssdk.auth.credentials.AwsBasicCredentials
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider
import software.amazon.awssdk.core.sync.RequestBody
import software.amazon.awssdk.regions.Region
import software.amazon.awssdk.services.s3.S3Client
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest
import software.amazon.awssdk.services.s3.model.NoSuchKeyException
import software.amazon.awssdk.services.s3.model.PutObjectRequest
import java.net.URI

/**
 * Stores files in Cloudflare R2 (S3-compatible).
 *
 * @param endpoint   R2 endpoint, e.g. `https://<accountId>.r2.cloudflarestorage.com`
 * @param bucket     Bucket name
 * @param accessKey  R2 Access Key ID
 * @param secretKey  R2 Secret Access Key
 * @param publicUrl  Base public URL for served objects, e.g. `https://pub-xxx.r2.dev` or a custom domain
 */
class R2StorageService(
    endpoint: String,
    private val bucket: String,
    accessKey: String,
    secretKey: String,
    private val publicUrl: String
) : StorageService {

    private val s3: S3Client = S3Client.builder()
        .endpointOverride(URI.create(endpoint))
        .credentialsProvider(
            StaticCredentialsProvider.create(
                AwsBasicCredentials.create(accessKey, secretKey)
            )
        )
        .region(Region.of("auto"))
        .build()

    override fun upload(folder: String, fileName: String, bytes: ByteArray, contentType: String): String {
        val key = if (folder.isBlank()) fileName else "$folder/$fileName"
        val request = PutObjectRequest.builder()
            .bucket(bucket)
            .key(key)
            .contentType(contentType)
            .contentLength(bytes.size.toLong())
            .build()
        s3.putObject(request, RequestBody.fromBytes(bytes))
        val base = publicUrl.trimEnd('/')
        return "$base/$key"
    }

    override fun delete(publicUrl: String) {
        val base = this.publicUrl.trimEnd('/')
        val key = publicUrl.removePrefix("$base/")
        try {
            s3.deleteObject(
                DeleteObjectRequest.builder()
                    .bucket(bucket)
                    .key(key)
                    .build()
            )
        } catch (_: NoSuchKeyException) {
            // Object already gone – ignore
        }
    }
}
