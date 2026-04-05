package com.petrescue.util

/** Escapes a string for safe embedding inside a JavaScript double-quoted string literal. */
fun String.escapeJs(): String = this
    .replace("\\", "\\\\")
    .replace("\"", "\\\"")
    .replace("\n", "\\n")
    .replace("\r", "\\r")
    .replace("\t", "\\t")
