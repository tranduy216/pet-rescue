package com.petrescue.plugins

import com.petrescue.UserSession
import com.petrescue.repositories.RoleResourceRepository
import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.sessions.*

// Centralised role-based access control plugin.
//
// The table m_tbl_role_resource holds rows of the form (role, resource, http_method)
// where "resource" is a path pattern such as:
//   "/users", "/pets/new", "/pets/[id]/edit", "/pets/[id]/media/[id]/delete"
//
// Algorithm per request:
// 1. Normalise the incoming path by replacing numeric/UUID path segments with "*"
//    (e.g. "/pets/42/edit" becomes "/pets/[*]/edit").
// 2. Collect every distinct resource pattern that is a prefix of, or an exact match
//    for, the normalised path, ordered longest-first.
// 3. Take the first (most specific) match and look up its allowed roles.
// 4. If no pattern matches the path -> public route -> allow.
// 5. If a pattern matches:
//    - No session -> redirect to /login.
//    - Session role not in allowed set -> redirect to / (unauthorised).
//    - Otherwise -> allow.
val AuthorizationPlugin = createApplicationPlugin(name = "AuthorizationPlugin") {
    val repository = RoleResourceRepository()

    // Eagerly load all role-resource entries so we avoid a DB hit per request.
    // The permission set is effectively static after seed, so loading once at
    // startup is sufficient.
    val allEntries = repository.findAll()

    // Build a set of all unique resource patterns for fast lookup.
    val allResources: Set<String> = allEntries.map { it.resource }.toSet()

    // Pre-group by (resource, httpMethod) -> set of allowed roles.
    val allowedByResourceAndMethod: Map<Pair<String, String>, Set<String>> =
        allEntries.groupBy { it.resource to it.httpMethod }
            .mapValues { (_, v) -> v.map { it.role }.toSet() }

    onCall { call ->
        val rawPath = call.request.local.uri
            .substringBefore("?") // drop query string
            .trimEnd('/')
            .ifEmpty { "/" }

        val normalised = normalisePath(rawPath)
        val method = call.request.local.method.value.uppercase()

        // Find the most specific resource pattern that matches the normalised path.
        val matchedResource = bestMatch(normalised, allResources) ?: return@onCall

        // Determine allowed roles for this resource + method (also check wildcard).
        val allowed = (allowedByResourceAndMethod[matchedResource to method]
            ?: emptySet<String>()) +
                (allowedByResourceAndMethod[matchedResource to "*"] ?: emptySet())

        if (allowed.isEmpty()) {
            // The resource is registered but no roles are allowed via this method.
            call.respondRedirect("/")
            return@onCall
        }

        val session = call.sessions.get<UserSession>()
        if (session == null) {
            call.respondRedirect("/login")
            return@onCall
        }

        if (session.role !in allowed) {
            call.respondRedirect("/")
        }
    }
}

// Compiled once – shared across all calls to normalisePath.
private val UUID_REGEX = Regex("[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}")
private val NUMERIC_REGEX = Regex("^\\d+$")

// Replace every path segment that looks like a numeric ID or UUID with "*".
// Examples:
//   "/pets/42/edit"          becomes  "/pets/[*]/edit"
//   "/blog/123/delete"       becomes  "/blog/[*]/delete"
//   "/pets/7/media/3/delete" becomes  "/pets/[*]/media/[*]/delete"
private fun normalisePath(path: String): String {
    return path.split("/").joinToString("/") { segment ->
        when {
            segment.matches(NUMERIC_REGEX) -> "*"
            segment.matches(UUID_REGEX) -> "*"
            else -> segment
        }
    }
}

// Return the resource pattern from candidates that best (most specifically)
// matches normalisedPath, or null if no pattern applies.
//
// Matching rules (checked in order, first hit wins):
// 1. Exact match:           "/pets/new" matches "/pets/new"
// 2. Wildcard segment match: "/pets/[*]/edit" matches normalised "/pets/[*]/edit"
// 3. Prefix match:          "/rescues"  matches "/rescues/new" or "/rescues/[*]/status"
//
// Among all matching candidates the longest (most specific) pattern is chosen.
private fun bestMatch(normalisedPath: String, candidates: Set<String>): String? {
    val matches = candidates.filter { pattern ->
        normalisedPath == pattern ||
                normalisedPath.startsWith("$pattern/") ||
                patternMatches(pattern, normalisedPath)
    }
    return matches.maxByOrNull { it.length }
}

// Simple glob-style pattern match where every "*" in pattern matches
// exactly one path segment.
private fun patternMatches(pattern: String, path: String): Boolean {
    val patternParts = pattern.split("/")
    val pathParts = path.split("/")
    if (patternParts.size != pathParts.size) return false
    return patternParts.zip(pathParts).all { (p, s) -> p == "*" || p == s }
}
