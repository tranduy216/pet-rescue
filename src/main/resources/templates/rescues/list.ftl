<#import "../layout/base.ftl" as layout>
<@layout.page title="${msg['rescue_page_title']!'Rescue Reports'} - ${msg['site_name']!'Pet Rescue'}">
<div class="px-4">
    <div class="flex justify-between items-center mb-6">
        <h1 class="text-2xl font-bold text-green-800">${msg['rescue_page_title']!'🚨 Rescue Reports'}</h1>
        <a href="/rescues/new" class="bg-yellow-500 text-white px-4 py-2 rounded-lg hover:bg-yellow-600">${msg['rescue_add_btn']!'+ Report Rescue'}</a>
    </div>
    <div class="space-y-4">
        <#list rescues as r>
        <div class="bg-white rounded-xl shadow-md p-6">
            <div class="flex justify-between items-start mb-3">
                <div>
                    <h3 class="font-semibold text-green-800">📍 ${r.location}</h3>
                    <p class="text-sm text-gray-600 mt-1">${r.description}</p>
                    <p class="text-xs text-gray-500 mt-1">${msg['rescue_contact_label']!'Contact:'} ${r.contactInfo}</p>
                </div>
                <span class="px-3 py-1 rounded-full text-xs font-medium
                    <#if r.status == 'SUCCESS'>bg-green-100 text-green-800
                    <#elseif r.status == 'PROCESSING'>bg-blue-100 text-blue-800
                    <#elseif r.status == 'RECEIVED'>bg-indigo-100 text-indigo-800
                    <#elseif r.status == 'FAILED'>bg-red-100 text-red-800
                    <#else>bg-yellow-100 text-yellow-800</#if>">
                    <#if r.status == 'NEW'>${msg['rescue_status_new']!'New'}
                    <#elseif r.status == 'RECEIVED'>${msg['rescue_status_received']!'Received'}
                    <#elseif r.status == 'PROCESSING'>${msg['rescue_status_processing']!'Processing'}
                    <#elseif r.status == 'SUCCESS'>${msg['rescue_status_success']!'Success'}
                    <#else>${msg['rescue_status_failed']!'Failed'}</#if>
                </span>
            </div>
            <div class="flex justify-between items-center">
                <span class="text-xs text-gray-400">${r.createdAt?string?substring(0, 10)} ${r.createdAt?string?substring(11, 16)}</span>
                <#if session?? && (session.role == "ADMIN" || session.role == "VOLUNTEER")>
                <div class="flex items-center space-x-2">
                    <form method="POST" action="/rescues/${r.id}/status" class="flex items-center space-x-2">
                        <select name="status" class="border border-gray-300 rounded px-2 py-1 text-sm">
                            <option value="NEW" <#if r.status == 'NEW'>selected</#if>>${msg['rescue_status_new']!'New'}</option>
                            <option value="RECEIVED" <#if r.status == 'RECEIVED'>selected</#if>>${msg['rescue_status_received']!'Received'}</option>
                            <option value="PROCESSING" <#if r.status == 'PROCESSING'>selected</#if>>${msg['rescue_status_processing']!'Processing'}</option>
                            <option value="SUCCESS" <#if r.status == 'SUCCESS'>selected</#if>>${msg['rescue_status_success']!'Success'}</option>
                            <option value="FAILED" <#if r.status == 'FAILED'>selected</#if>>${msg['rescue_status_failed']!'Failed'}</option>
                        </select>
                        <button type="submit" class="bg-blue-600 text-white px-3 py-1 rounded text-sm hover:bg-blue-700">${msg['btn_update']!'Update'}</button>
                    </form>
                    <#if session.role == "ADMIN">
                    <form method="POST" action="/rescues/${r.id}/delete" class="inline">
                        <button type="submit" class="text-red-600 hover:text-red-800 text-sm"
                            onclick="return confirm('${msg['rescue_delete_confirm']!'Delete this rescue report?'}')">${msg['btn_delete']!'Delete'}</button>
                    </form>
                    </#if>
                </div>
                </#if>
            </div>
        </div>
        </#list>
        <#if !rescues?has_content>
        <div class="text-center py-8 text-gray-500">${msg['rescue_empty']!'No rescue reports found.'}</div>
        </#if>
    </div>
</div>
</@layout.page>
