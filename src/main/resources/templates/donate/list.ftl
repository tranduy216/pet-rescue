<#import "../layout/base.ftl" as layout>
<@layout.page title="Donations - Pet Rescue">
<div class="px-4">
    <div class="flex justify-between items-center mb-6">
        <h1 class="text-2xl font-bold text-green-800">📋 Donations</h1>
        <div class="bg-green-100 px-4 py-2 rounded-lg">
            <span class="text-green-700 font-medium">Total Confirmed: $${total}</span>
        </div>
    </div>
    <div class="bg-white rounded-xl shadow overflow-hidden">
        <table class="w-full">
            <thead class="bg-green-700 text-white">
                <tr>
                    <th class="px-4 py-3 text-left text-sm">Donor</th>
                    <th class="px-4 py-3 text-left text-sm">Email</th>
                    <th class="px-4 py-3 text-left text-sm">Amount</th>
                    <th class="px-4 py-3 text-left text-sm">Message</th>
                    <th class="px-4 py-3 text-left text-sm">Status</th>
                    <th class="px-4 py-3 text-left text-sm">Date</th>
                    <th class="px-4 py-3 text-left text-sm">Actions</th>
                </tr>
            </thead>
            <tbody class="divide-y divide-gray-200">
                <#list donations as d>
                <tr class="hover:bg-green-50">
                    <td class="px-4 py-3 text-sm font-medium">${d.donorName}</td>
                    <td class="px-4 py-3 text-sm">${d.donorEmail}</td>
                    <td class="px-4 py-3 text-sm font-medium text-green-700">$${d.amount}</td>
                    <td class="px-4 py-3 text-sm">${(d.message)!'-'}</td>
                    <td class="px-4 py-3 text-sm">
                        <span class="px-2 py-1 rounded text-xs font-medium
                            <#if d.status == 'CONFIRMED'>bg-green-100 text-green-800
                            <#elseif d.status == 'CANCELLED'>bg-red-100 text-red-800
                            <#else>bg-yellow-100 text-yellow-800</#if>">
                            ${d.status}
                        </span>
                    </td>
                    <td class="px-4 py-3 text-sm">${d.createdAt?string('yyyy-MM-dd')}</td>
                    <td class="px-4 py-3 text-sm space-x-2">
                        <#if d.status == 'PENDING'>
                        <form method="POST" action="/donations/${d.id}/confirm" class="inline">
                            <button type="submit" class="text-green-600 hover:text-green-800 text-xs font-medium">Confirm</button>
                        </form>
                        <form method="POST" action="/donations/${d.id}/cancel" class="inline">
                            <button type="submit" class="text-red-600 hover:text-red-800 text-xs font-medium">Cancel</button>
                        </form>
                        </#if>
                    </td>
                </tr>
                </#list>
            </tbody>
        </table>
        <#if !donations?has_content>
        <div class="text-center py-8 text-gray-500">No donations yet.</div>
        </#if>
    </div>
</div>
</@layout.page>
