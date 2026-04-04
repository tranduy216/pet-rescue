<#import "../layout/base.ftl" as layout>
<@layout.page title="Rescues - Pet Rescue">
<div class="px-4">
    <div class="flex justify-between items-center mb-6">
        <h1 class="text-2xl font-bold text-green-800">🚨 Rescue Reports</h1>
        <a href="/rescues/new" class="bg-yellow-500 text-white px-4 py-2 rounded-lg hover:bg-yellow-600">+ Report Rescue</a>
    </div>
    <div class="space-y-4">
        <#list rescues as r>
        <div class="bg-white rounded-xl shadow-md p-6">
            <div class="flex justify-between items-start mb-3">
                <div>
                    <h3 class="font-semibold text-green-800">📍 ${r.location}</h3>
                    <p class="text-sm text-gray-600 mt-1">${r.description}</p>
                    <p class="text-xs text-gray-500 mt-1">Contact: ${r.contactInfo}</p>
                </div>
                <span class="px-3 py-1 rounded-full text-xs font-medium
                    <#if r.status == 'RESCUED'>bg-green-100 text-green-800
                    <#elseif r.status == 'IN_PROGRESS'>bg-blue-100 text-blue-800
                    <#elseif r.status == 'FAILED'>bg-red-100 text-red-800
                    <#else>bg-yellow-100 text-yellow-800</#if>">
                    ${r.status}
                </span>
            </div>
            <div class="flex justify-between items-center">
                <span class="text-xs text-gray-400">${r.createdAt?string('yyyy-MM-dd HH:mm')}</span>
                <#if session?? && (session.role == "ADMIN" || session.role == "VOLUNTEER")>
                <div class="flex items-center space-x-2">
                    <form method="POST" action="/rescues/${r.id}/status" class="flex items-center space-x-2">
                        <select name="status" class="border border-gray-300 rounded px-2 py-1 text-sm">
                            <option value="REPORTED" <#if r.status == 'REPORTED'>selected</#if>>Reported</option>
                            <option value="IN_PROGRESS" <#if r.status == 'IN_PROGRESS'>selected</#if>>In Progress</option>
                            <option value="RESCUED" <#if r.status == 'RESCUED'>selected</#if>>Rescued</option>
                            <option value="FAILED" <#if r.status == 'FAILED'>selected</#if>>Failed</option>
                        </select>
                        <button type="submit" class="bg-blue-600 text-white px-3 py-1 rounded text-sm hover:bg-blue-700">Update</button>
                    </form>
                    <#if session.role == "ADMIN">
                    <form method="POST" action="/rescues/${r.id}/delete" class="inline">
                        <button type="submit" class="text-red-600 hover:text-red-800 text-sm"
                            onclick="return confirm('Delete this rescue report?')">Delete</button>
                    </form>
                    </#if>
                </div>
                </#if>
            </div>
        </div>
        </#list>
        <#if !rescues?has_content>
        <div class="text-center py-8 text-gray-500">No rescue reports found.</div>
        </#if>
    </div>
</div>
</@layout.page>
