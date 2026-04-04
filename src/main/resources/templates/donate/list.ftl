<#import "../layout/base.ftl" as layout>
<@layout.page title="${msg['donate_page_title']!'Donations'} - ${msg['site_name']!'Pet Rescue'}">
<div class="px-4">
    <div class="flex justify-between items-center mb-6">
        <h1 class="text-2xl font-bold text-green-800">${msg['donate_page_title']!'📋 Donations'}</h1>
        <div class="bg-green-100 px-4 py-2 rounded-lg">
            <span class="text-green-700 font-medium">${msg['donate_total']!'Total Confirmed:'} $${total}</span>
        </div>
    </div>
    <div class="bg-white rounded-xl shadow overflow-hidden">
        <table class="w-full">
            <thead class="bg-green-700 text-white">
                <tr>
                    <th class="px-4 py-3 text-left text-sm">${msg['donate_col_donor']!'Donor'}</th>
                    <th class="px-4 py-3 text-left text-sm">${msg['donate_col_email']!'Email'}</th>
                    <th class="px-4 py-3 text-left text-sm">${msg['donate_col_amount']!'Amount'}</th>
                    <th class="px-4 py-3 text-left text-sm">${msg['donate_col_message']!'Message'}</th>
                    <th class="px-4 py-3 text-left text-sm">${msg['donate_col_status']!'Status'}</th>
                    <th class="px-4 py-3 text-left text-sm">${msg['donate_col_date']!'Date'}</th>
                    <th class="px-4 py-3 text-left text-sm">${msg['donate_col_actions']!'Actions'}</th>
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
                            <#if d.status == 'CONFIRMED'>${msg['adoption_status_approved']!'Confirmed'}
                            <#elseif d.status == 'CANCELLED'>${msg['adoption_status_cancelled']!'Cancelled'}
                            <#else>${msg['adoption_status_requested']!'Pending'}</#if>
                        </span>
                    </td>
                    <td class="px-4 py-3 text-sm">${d.createdAt?string?substring(0, 10)}</td>
                    <td class="px-4 py-3 text-sm space-x-2">
                        <#if d.status == 'PENDING' && session?? && session.role == "ADMIN">
                        <form method="POST" action="/donations/${d.id}/confirm" class="inline">
                            <button type="submit" class="text-green-600 hover:text-green-800 text-xs font-medium">${msg['btn_confirm']!'Confirm'}</button>
                        </form>
                        <form method="POST" action="/donations/${d.id}/cancel" class="inline">
                            <button type="submit" class="text-red-600 hover:text-red-800 text-xs font-medium">${msg['btn_cancel']!'Cancel'}</button>
                        </form>
                        </#if>
                    </td>
                </tr>
                </#list>
            </tbody>
        </table>
        <#if !donations?has_content>
        <div class="text-center py-8 text-gray-500">${msg['donate_empty']!'No donations yet.'}</div>
        </#if>
    </div>
</div>
</@layout.page>
