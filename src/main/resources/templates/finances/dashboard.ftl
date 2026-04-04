<#import "../layout/base.ftl" as layout>
<@layout.page title="${msg['finance_page_title']!'Finance Dashboard'} - ${msg['site_name']!'Pet Rescue'}">
<div class="px-4">
    <div class="flex justify-between items-center mb-6">
        <h1 class="text-2xl font-bold text-green-800">${msg['finance_page_title']!'💰 Finance Dashboard'}</h1>
        <a href="/finances/new" class="bg-green-600 text-white px-4 py-2 rounded-lg hover:bg-green-700">${msg['finance_add_btn']!'+ Add Entry'}</a>
    </div>

    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
        <div class="bg-green-100 rounded-xl p-6">
            <h3 class="text-sm font-medium text-green-600">${msg['finance_total_income']!'Total Income'}</h3>
            <p class="text-3xl font-bold text-green-800 mt-2">$${totalIncome}</p>
        </div>
        <div class="bg-red-100 rounded-xl p-6">
            <h3 class="text-sm font-medium text-red-600">${msg['finance_total_expense']!'Total Expense'}</h3>
            <p class="text-3xl font-bold text-red-800 mt-2">$${totalExpense}</p>
        </div>
        <div class="<#if balance gte 0>bg-blue-100<#else>bg-orange-100</#if> rounded-xl p-6">
            <h3 class="text-sm font-medium <#if balance gte 0>text-blue-600<#else>text-orange-600</#if>">${msg['finance_balance']!'Balance'}</h3>
            <p class="text-3xl font-bold <#if balance gte 0>text-blue-800<#else>text-orange-800</#if> mt-2">$${balanceStr}</p>
        </div>
    </div>

    <div class="bg-white rounded-xl shadow-md p-6 mb-8">
        <h2 class="text-lg font-semibold text-green-700 mb-4">${msg['finance_overview']!'30-Day Overview'}</h2>
        <canvas id="financeChart" height="80"></canvas>
    </div>

    <div class="bg-white rounded-xl shadow overflow-hidden">
        <table class="w-full">
            <thead class="bg-green-700 text-white">
                <tr>
                    <th class="px-4 py-3 text-left text-sm">${msg['finance_col_date']!'Date'}</th>
                    <th class="px-4 py-3 text-left text-sm">${msg['finance_col_type']!'Type'}</th>
                    <th class="px-4 py-3 text-left text-sm">${msg['finance_col_amount']!'Amount'}</th>
                    <th class="px-4 py-3 text-left text-sm">${msg['finance_col_category']!'Category'}</th>
                    <th class="px-4 py-3 text-left text-sm">${msg['finance_col_description']!'Description'}</th>
                    <#if session.role == "ADMIN"><th class="px-4 py-3 text-left text-sm">${msg['finance_col_actions']!'Actions'}</th></#if>
                </tr>
            </thead>
            <tbody class="divide-y divide-gray-200">
                <#list finances as f>
                <tr class="hover:bg-green-50">
                    <td class="px-4 py-3 text-sm">${f.date}</td>
                    <td class="px-4 py-3 text-sm">
                        <span class="px-2 py-1 rounded text-xs font-medium <#if f.type == 'INCOME'>bg-green-100 text-green-800<#else>bg-red-100 text-red-800</#if>">
                            <#if f.type == 'INCOME'>${msg['finance_type_income']!'Income'}<#else>${msg['finance_type_expense']!'Expense'}</#if>
                        </span>
                    </td>
                    <td class="px-4 py-3 text-sm font-medium <#if f.type == 'INCOME'>text-green-700<#else>text-red-700</#if>">$${f.amount}</td>
                    <td class="px-4 py-3 text-sm">${(f.category)!'-'}</td>
                    <td class="px-4 py-3 text-sm">${f.description}</td>
                    <#if session.role == "ADMIN">
                    <td class="px-4 py-3 text-sm">
                        <form method="POST" action="/finances/${f.id}/delete" class="inline">
                            <button type="submit" class="text-red-600 hover:text-red-800 text-xs"
                                onclick="return confirm('${msg['finance_delete_confirm']!'Delete this entry?'}')">${msg['btn_delete']!'Delete'}</button>
                        </form>
                    </td>
                    </#if>
                </tr>
                </#list>
            </tbody>
        </table>
    </div>
</div>

<script>
const data = ${chartData};
const ctx = document.getElementById('financeChart').getContext('2d');
new Chart(ctx, {
    type: 'line',
    data: {
        labels: data.labels,
        datasets: [
            { label: '${msg['finance_type_income']!'Income'}', data: data.income, borderColor: '#16a34a', backgroundColor: 'rgba(22,163,74,0.1)', tension: 0.3 },
            { label: '${msg['finance_type_expense']!'Expense'}', data: data.expense, borderColor: '#dc2626', backgroundColor: 'rgba(220,38,38,0.1)', tension: 0.3 }
        ]
    },
    options: { responsive: true, plugins: { legend: { position: 'top' } } }
});
</script>
</@layout.page>
