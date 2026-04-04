package com.petrescue.routes

import com.petrescue.UserSession
import com.petrescue.models.Finance
import com.petrescue.services.FinanceService
import io.ktor.server.application.*
import io.ktor.server.freemarker.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import io.ktor.server.sessions.*
import kotlinx.serialization.json.JsonPrimitive
import kotlinx.serialization.json.buildJsonObject
import kotlinx.serialization.json.buildJsonArray
import java.math.BigDecimal
import java.time.LocalDate

fun Route.financeRoutes() {
    val service = FinanceService()

    route("/finances") {
        get {
            val session = call.sessions.get<UserSession>()
            val finances = service.getAll()
            val totalIncome = service.getTotalIncome()
            val totalExpense = service.getTotalExpense()
            val balance = totalIncome - totalExpense
            val dailyStats = service.getDailyStats(30)
            val chartData = buildJsonObject {
                put("labels", buildJsonArray {
                    dailyStats.forEach { stat -> add(JsonPrimitive(stat["date"] as String)) }
                })
                put("income", buildJsonArray {
                    dailyStats.forEach { stat -> add(JsonPrimitive((stat["income"] as BigDecimal).toDouble())) }
                })
                put("expense", buildJsonArray {
                    dailyStats.forEach { stat -> add(JsonPrimitive((stat["expense"] as BigDecimal).toDouble())) }
                })
            }
            call.respond(
                FreeMarkerContent(
                    "finances/dashboard.ftl", mapOf(
                        "session" to session,
                        "finances" to finances,
                        "totalIncome" to totalIncome.toPlainString(),
                        "totalExpense" to totalExpense.toPlainString(),
                        "balance" to balance.toDouble(),
                        "balanceStr" to balance.toPlainString(),
                        "chartData" to chartData.toString()
                    ), ""
                )
            )
        }

        get("/new") {
            val session = call.sessions.get<UserSession>()
            call.respond(FreeMarkerContent("finances/form.ftl", mapOf("session" to session, "error" to null), ""))
        }

        post("/new") {
            val session = call.sessions.get<UserSession>()
            val params = call.receiveParameters()
            service.create(
                Finance(
                    type = params["type"] ?: "INCOME",
                    amount = params["amount"]?.toBigDecimalOrNull() ?: BigDecimal.ZERO,
                    description = params["description"] ?: "",
                    category = params["category"],
                    recordedBy = session?.userId ?: 0,
                    date = params["date"]?.let { LocalDate.parse(it) } ?: LocalDate.now()
                )
            )
            call.respondRedirect("/finances")
        }

        post("/{id}/delete") {
            val session = call.sessions.get<UserSession>()
            val id = call.parameters["id"]?.toIntOrNull() ?: return@post
            service.delete(id)
            call.respondRedirect("/finances")
        }
    }
}
