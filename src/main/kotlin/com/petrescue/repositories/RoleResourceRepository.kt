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

    private fun ResultRow.toRoleResource() = RoleResource(
        role = this[RoleResources.role],
        resource = this[RoleResources.resource],
        httpMethod = this[RoleResources.httpMethod]
    )
}
