<#import "../layout/base.ftl" as layout>
<@layout.page title="${msg['adoption_page_title']!'Adoptions'} - ${msg['site_name']!'Pet Rescue'}">
<div class="px-4">
    <div class="flex justify-between items-center mb-6">
        <h1 class="text-2xl font-bold text-green-800">${msg['adoption_page_title']!'🏠 Adoptions'}</h1>
    </div>
    <div class="bg-white rounded-xl shadow overflow-hidden">
        <table class="w-full">
            <thead class="bg-green-700 text-white">
                <tr>
                    <th class="px-4 py-3 text-left text-sm">${msg['adoption_col_pet_id']!'Pet ID'}</th>
                    <th class="px-4 py-3 text-left text-sm">${msg['adoption_col_phone']!'Phone'}</th>
                    <th class="px-4 py-3 text-left text-sm">${msg['adoption_col_facebook']!'Facebook'}</th>
                    <th class="px-4 py-3 text-left text-sm">${msg['adoption_col_status']!'Status'}</th>
                    <th class="px-4 py-3 text-left text-sm">${msg['adoption_col_date']!'Date'}</th>
                    <th class="px-4 py-3 text-left text-sm">${msg['adoption_col_actions']!'Actions'}</th>
                </tr>
            </thead>
            <tbody class="divide-y divide-gray-200">
                <#list adoptions as a>
                <tr class="hover:bg-green-50">
                    <td class="px-4 py-3 text-sm"><a href="/pets/${a.petId}" class="text-green-600 hover:text-green-800">Pet #${a.petId}</a></td>
                    <td class="px-4 py-3 text-sm">${a.phone}</td>
                    <td class="px-4 py-3 text-sm">${a.facebookLink}</td>
                    <td class="px-4 py-3 text-sm">
                        <span class="px-2 py-1 rounded text-xs font-medium
                            <#if a.status == 'APPROVED'>bg-green-100 text-green-800
                            <#elseif a.status == 'CANCELLED'>bg-red-100 text-red-800
                            <#else>bg-yellow-100 text-yellow-800</#if>">
                            <#if a.status == 'REQUESTED'>${msg['adoption_status_requested']!'Requested'}
                            <#elseif a.status == 'APPROVED'>${msg['adoption_status_approved']!'Approved'}
                            <#else>${msg['adoption_status_cancelled']!'Cancelled'}</#if>
                        </span>
                    </td>
                    <td class="px-4 py-3 text-sm">${a.createdAt?string('yyyy-MM-dd')}</td>
                    <td class="px-4 py-3 text-sm space-x-2">
                        <#if a.status == 'REQUESTED'>
                            <#if session.role == "ADMIN" || session.role == "VOLUNTEER">
                            <form method="POST" action="/adoptions/${a.id}/approve" class="inline">
                                <button type="submit" class="text-green-600 hover:text-green-800 text-xs font-medium">${msg['btn_approve']!'Approve'}</button>
                            </form>
                            </#if>
                            <form method="POST" action="/adoptions/${a.id}/cancel" class="inline">
                                <button type="submit" class="text-red-600 hover:text-red-800 text-xs font-medium">${msg['btn_cancel']!'Cancel'}</button>
                            </form>
                        </#if>
                    </td>
                </tr>
                </#list>
            </tbody>
        </table>
        <#if !adoptions?has_content>
        <div class="text-center py-8 text-gray-500">${msg['adoption_empty']!'No adoptions found.'}</div>
        </#if>
    </div>
</div>
</@layout.page>
