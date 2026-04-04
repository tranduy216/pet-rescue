package com.petrescue.repositories

import com.petrescue.database.tables.RoleResources
import com.petrescue.models.RoleResource
import org.jetbrains.exposed.sql.*
import org.jetbrains.exposed.sql.transactions.transaction

class RoleResourceRepository {

    fun findAll(): List<RoleResource> = transaction {
        RoleResources.selectAll().map { it.toRoleResource() }
    }

    /**
     * Returns the set of roles that are allowed to access the given resource and method.
     * Also checks for wildcard method "*".
     */
    fun allowedRoles(resource: String, httpMethod: String): Set<String> = transaction {
        RoleResources.select {
            (RoleResources.resource eq resource) and
                    (RoleResources.httpMethod eq httpMethod or (RoleResources.httpMethod eq "*"))
        }.map { it[RoleResources.role] }.toSet()
    }

    /**
     * Returns true when at least one role-resource entry exists for this resource
     * (any method), meaning the route requires authentication.
     */
    fun hasAnyEntry(resource: String): Boolean = transaction {
        RoleResources.select { RoleResources.resource eq resource }.count() > 0
    }

    fun insert(entry: RoleResource) = transaction {
        RoleResources.insertIgnore {
            it[role] = entry.role
            it[resource] = entry.resource
            it[httpMethod] = entry.httpMethod
        }
    }

    /**
     * Seed the table with default permission rules.
     * Uses insertIgnore so it is safe to call on every startup.
     */
    fun seed() {
        val entries = listOf(
            // /users – ADMIN only
            RoleResource("ADMIN", "/users", "GET"),
            RoleResource("ADMIN", "/users", "POST"),

            // /adoptions – any authenticated role
            RoleResource("USER", "/adoptions", "GET"),
            RoleResource("USER", "/adoptions", "POST"),
            RoleResource("VOLUNTEER", "/adoptions", "GET"),
            RoleResource("VOLUNTEER", "/adoptions", "POST"),
            RoleResource("ADMIN", "/adoptions", "GET"),
            RoleResource("ADMIN", "/adoptions", "POST"),
            // /adoptions/*/approve – ADMIN and VOLUNTEER only
            RoleResource("ADMIN", "/adoptions/*/approve", "POST"),
            RoleResource("VOLUNTEER", "/adoptions/*/approve", "POST"),
            // /adoptions/*/cancel – any authenticated role
            RoleResource("USER", "/adoptions/*/cancel", "POST"),
            RoleResource("VOLUNTEER", "/adoptions/*/cancel", "POST"),
            RoleResource("ADMIN", "/adoptions/*/cancel", "POST"),

            // /rescues – any authenticated role
            RoleResource("USER", "/rescues", "GET"),
            RoleResource("USER", "/rescues", "POST"),
            RoleResource("VOLUNTEER", "/rescues", "GET"),
            RoleResource("VOLUNTEER", "/rescues", "POST"),
            RoleResource("ADMIN", "/rescues", "GET"),
            RoleResource("ADMIN", "/rescues", "POST"),
            // /rescues/*/status – ADMIN and VOLUNTEER only
            RoleResource("ADMIN", "/rescues/*/status", "POST"),
            RoleResource("VOLUNTEER", "/rescues/*/status", "POST"),
            // /rescues/*/delete – ADMIN only
            RoleResource("ADMIN", "/rescues/*/delete", "POST"),

            // /pets write operations – ADMIN and VOLUNTEER
            RoleResource("ADMIN", "/pets/new", "GET"),
            RoleResource("ADMIN", "/pets/new", "POST"),
            RoleResource("VOLUNTEER", "/pets/new", "GET"),
            RoleResource("VOLUNTEER", "/pets/new", "POST"),
            RoleResource("ADMIN", "/pets/*/edit", "GET"),
            RoleResource("ADMIN", "/pets/*/edit", "POST"),
            RoleResource("VOLUNTEER", "/pets/*/edit", "GET"),
            RoleResource("VOLUNTEER", "/pets/*/edit", "POST"),
            RoleResource("ADMIN", "/pets/*/delete", "POST"),
            RoleResource("ADMIN", "/pets/*/media/*/delete", "POST"),
            RoleResource("VOLUNTEER", "/pets/*/media/*/delete", "POST"),

            // /config – ADMIN only
            RoleResource("ADMIN", "/config", "GET"),
            RoleResource("ADMIN", "/config", "POST"),

            // /profile – any authenticated user
            RoleResource("USER", "/profile", "GET"),
            RoleResource("USER", "/profile", "POST"),
            RoleResource("VOLUNTEER", "/profile", "GET"),
            RoleResource("VOLUNTEER", "/profile", "POST"),
            RoleResource("ADMIN", "/profile", "GET"),
            RoleResource("ADMIN", "/profile", "POST"),

            // /blog write operations – ADMIN and VOLUNTEER
            RoleResource("ADMIN", "/blog/new", "GET"),
            RoleResource("ADMIN", "/blog/new", "POST"),
            RoleResource("VOLUNTEER", "/blog/new", "GET"),
            RoleResource("VOLUNTEER", "/blog/new", "POST"),
            RoleResource("ADMIN", "/blog/*/edit", "GET"),
            RoleResource("ADMIN", "/blog/*/edit", "POST"),
            RoleResource("VOLUNTEER", "/blog/*/edit", "GET"),
            RoleResource("VOLUNTEER", "/blog/*/edit", "POST"),
            RoleResource("ADMIN", "/blog/*/delete", "POST"),

            // /blog/upload-image – ADMIN and VOLUNTEER
            RoleResource("ADMIN", "/blog/upload-image", "POST"),
            RoleResource("VOLUNTEER", "/blog/upload-image", "POST"),

            // /wishes – ADMIN only
            RoleResource("ADMIN", "/wishes", "GET"),
            RoleResource("ADMIN", "/wishes/*/approve", "POST"),
            RoleResource("ADMIN", "/wishes/*/receive", "POST"),
            RoleResource("ADMIN", "/wishes/*/delete", "POST")
        )
        entries.forEach { insert(it) }
    }

    private fun ResultRow.toRoleResource() = RoleResource(
        role = this[RoleResources.role],
        resource = this[RoleResources.resource],
        httpMethod = this[RoleResources.httpMethod]
    )
}
