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
                    <th class="px-4 py-3 text-left text-sm">${msg['adoption_col_pet_name']!'Pet Name'}</th>
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
                    <td class="px-4 py-3 text-sm"><a href="/pets/${a.petId}" class="text-green-600 hover:text-green-800 font-medium">#${a.petId}</a></td>
                    <td class="px-4 py-3 text-sm"><a href="/pets/${a.petId}" class="text-green-600 hover:text-green-800">${a.petName!'—'}</a></td>
                    <td class="px-4 py-3 text-sm">${a.phone}</td>
                    <td class="px-4 py-3 text-sm">${a.facebookLink}</td>
                    <td class="px-4 py-3 text-sm">
                        <span class="px-2 py-1 rounded text-xs font-medium
                            <#if a.status == 'CONFIRMED'>bg-blue-100 text-blue-800
                            <#elseif a.status == 'FINISHED'>bg-green-100 text-green-800
                            <#elseif a.status == 'CANCELLED'>bg-red-100 text-red-800
                            <#else>bg-yellow-100 text-yellow-800</#if>">
                            <#if a.status == 'REGISTERED'>${msg['adoption_status_registered']!'Registered'}
                            <#elseif a.status == 'CONFIRMED'>${msg['adoption_status_confirmed']!'Confirmed'}
                            <#elseif a.status == 'FINISHED'>${msg['adoption_status_finished']!'Finished'}
                            <#elseif a.status == 'CANCELLED'>${msg['adoption_status_cancelled']!'Cancelled'}
                            <#else>${a.status}</#if>
                        </span>
                    </td>
                    <td class="px-4 py-3 text-sm">${a.createdAt?string('yyyy-MM-dd')}</td>
                    <td class="px-4 py-3 text-sm space-x-2">
                        <#if session.role == "ADMIN" || session.role == "VOLUNTEER">
                            <#if a.status == 'REGISTERED'>
                            <form method="POST" action="/adoptions/${a.id}/confirm" class="inline">
                                <button type="submit" class="text-blue-600 hover:text-blue-800 text-xs font-medium">${msg['btn_confirm']!'Confirm'}</button>
                            </form>
                            <form method="POST" action="/adoptions/${a.id}/cancel" class="inline">
                                <button type="submit" class="text-red-600 hover:text-red-800 text-xs font-medium">${msg['btn_cancel']!'Cancel'}</button>
                            </form>
                            </#if>
                            <#if a.status == 'CONFIRMED'>
                            <form method="POST" action="/adoptions/${a.id}/finish" class="inline">
                                <button type="submit" class="text-green-600 hover:text-green-800 text-xs font-medium">${msg['btn_finish']!'Finish'}</button>
                            </form>
                            <form method="POST" action="/adoptions/${a.id}/cancel" class="inline">
                                <button type="submit" class="text-red-600 hover:text-red-800 text-xs font-medium">${msg['btn_cancel']!'Cancel'}</button>
                            </form>
                            </#if>
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
