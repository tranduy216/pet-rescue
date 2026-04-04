<#import "../layout/base.ftl" as layout>
<@layout.page title="Finance Dashboard - Pet Rescue">
<div class="px-4">
    <div class="flex justify-between items-center mb-6">
        <h1 class="text-2xl font-bold text-green-800">💰 Finance Dashboard</h1>
        <a href="/finances/new" class="bg-green-600 text-white px-4 py-2 rounded-lg hover:bg-green-700">+ Add Entry</a>
    </div>

    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
        <div class="bg-green-100 rounded-xl p-6">
            <h3 class="text-sm font-medium text-green-600">Total Income</h3>
            <p class="text-3xl font-bold text-green-800 mt-2">$${totalIncome}</p>
        </div>
        <div class="bg-red-100 rounded-xl p-6">
            <h3 class="text-sm font-medium text-red-600">Total Expense</h3>
            <p class="text-3xl font-bold text-red-800 mt-2">$${totalExpense}</p>
        </div>
        <div class="<#if balance?number >= 0>bg-blue-100<#else>bg-orange-100</#if> rounded-xl p-6">
            <h3 class="text-sm font-medium <#if balance?number >= 0>text-blue-600<#else>text-orange-600</#if>">Balance</h3>
            <p class="text-3xl font-bold <#if balance?number >= 0>text-blue-800<#else>text-orange-800</#if> mt-2">$${balance}</p>
        </div>
    </div>

    <div class="bg-white rounded-xl shadow-md p-6 mb-8">
        <h2 class="text-lg font-semibold text-green-700 mb-4">30-Day Overview</h2>
        <canvas id="financeChart" height="80"></canvas>
    </div>

    <div class="bg-white rounded-xl shadow overflow-hidden">
        <table class="w-full">
            <thead class="bg-green-700 text-white">
                <tr>
                    <th class="px-4 py-3 text-left text-sm">Date</th>
                    <th class="px-4 py-3 text-left text-sm">Type</th>
                    <th class="px-4 py-3 text-left text-sm">Amount</th>
                    <th class="px-4 py-3 text-left text-sm">Category</th>
                    <th class="px-4 py-3 text-left text-sm">Description</th>
                    <#if session.role == "ADMIN"><th class="px-4 py-3 text-left text-sm">Actions</th></#if>
                </tr>
            </thead>
            <tbody class="divide-y divide-gray-200">
                <#list finances as f>
                <tr class="hover:bg-green-50">
                    <td class="px-4 py-3 text-sm">${f.date}</td>
                    <td class="px-4 py-3 text-sm">
                        <span class="px-2 py-1 rounded text-xs font-medium <#if f.type == 'INCOME'>bg-green-100 text-green-800<#else>bg-red-100 text-red-800</#if>">
                            ${f.type}
                        </span>
                    </td>
                    <td class="px-4 py-3 text-sm font-medium <#if f.type == 'INCOME'>text-green-700<#else>text-red-700</#if>">$${f.amount}</td>
                    <td class="px-4 py-3 text-sm">${(f.category)!'-'}</td>
                    <td class="px-4 py-3 text-sm">${f.description}</td>
                    <#if session.role == "ADMIN">
                    <td class="px-4 py-3 text-sm">
                        <form method="POST" action="/finances/${f.id}/delete" class="inline">
                            <button type="submit" class="text-red-600 hover:text-red-800 text-xs"
                                onclick="return confirm('Delete this entry?')">Delete</button>
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
            { label: 'Income', data: data.income, borderColor: '#16a34a', backgroundColor: 'rgba(22,163,74,0.1)', tension: 0.3 },
            { label: 'Expense', data: data.expense, borderColor: '#dc2626', backgroundColor: 'rgba(220,38,38,0.1)', tension: 0.3 }
        ]
    },
    options: { responsive: true, plugins: { legend: { position: 'top' } } }
});
</script>
</@layout.page>
