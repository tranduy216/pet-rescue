package com.petrescue.database.tables

import org.jetbrains.exposed.sql.Table

object RoleResources : Table("m_tbl_role_resource") {
    val role = varchar("role", 50)
    val resource = varchar("resource", 255)
    val httpMethod = varchar("http_method", 10)
    override val primaryKey = PrimaryKey(role, resource, httpMethod)
}
