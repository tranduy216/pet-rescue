<#import "../layout/base.ftl" as layout>
<@layout.page title="${msg['audit_page_title']!'Audit Log'} - ${msg['site_name']!'Pet Rescue'}">
<div class="px-4">
    <div class="flex justify-between items-center mb-6">
        <h1 class="text-2xl font-bold text-green-800">📋 ${msg['audit_page_title']!'Nhật Ký Hoạt Động'}</h1>
    </div>
    <div class="bg-white rounded-xl shadow overflow-hidden">
        <table class="w-full">
            <thead class="bg-green-700 text-white">
                <tr>
                    <th class="px-4 py-3 text-left text-sm">${msg['audit_col_time']!'Thời Gian'}</th>
                    <th class="px-4 py-3 text-left text-sm">${msg['audit_col_user']!'Người Thực Hiện'}</th>
                    <th class="px-4 py-3 text-left text-sm">${msg['audit_col_action']!'Hành Động'}</th>
                    <th class="px-4 py-3 text-left text-sm">${msg['audit_col_entity']!'Đối Tượng'}</th>
                    <th class="px-4 py-3 text-left text-sm">${msg['audit_col_details']!'Chi Tiết'}</th>
                </tr>
            </thead>
            <tbody class="divide-y divide-gray-200">
                <#list logs as log>
                <tr class="hover:bg-green-50">
                    <td class="px-4 py-3 text-xs text-gray-600 whitespace-nowrap">
                        ${log.createdAt?string?substring(0, 10)} ${log.createdAt?string?substring(11, 16)}
                    </td>
                    <td class="px-4 py-3 text-sm">${(log.username)!'—'}</td>
                    <td class="px-4 py-3 text-sm">
                        <span class="px-2 py-1 rounded text-xs font-medium
                            <#if log.action == 'CREATE'>bg-green-100 text-green-800
                            <#else>bg-blue-100 text-blue-800</#if>">
                            ${log.action}
                        </span>
                    </td>
                    <td class="px-4 py-3 text-sm">
                        ${log.entityType}<#if log.entityId??> #${log.entityId}</#if>
                    </td>
                    <td class="px-4 py-3 text-xs text-gray-500">${(log.details)!''}</td>
                </tr>
                </#list>
            </tbody>
        </table>
        <#if !logs?has_content>
        <div class="text-center py-8 text-gray-500">${msg['audit_empty']!'Chưa có hoạt động nào.'}</div>
        </#if>
    </div>
</div>
</@layout.page>
