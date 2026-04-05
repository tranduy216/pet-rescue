<#import "../layout/base.ftl" as layout>
<#import "../layout/macros.ftl" as macros>
<#assign canManage = session?? && (session.role == "ADMIN" || session.role == "VOLUNTEER")>

<@layout.page title="${msg['urgent_appeal_list_title']!'Khẩn Cầu'} - ${msg['site_name']!'Pet Rescue'}">
<div class="px-2 sm:px-4 py-6 max-w-5xl mx-auto">
    <div class="flex justify-between items-center mb-6">
        <h1 class="text-2xl font-bold text-red-700">📢 ${msg['urgent_appeal_list_title']!'Danh Sách Lời Khẩn Cầu'}</h1>
        <#if canManage>
        <a href="/urgent-appeals/new" class="bg-red-600 text-white px-4 py-2 rounded-lg hover:bg-red-700 text-sm font-medium">
            ${msg['urgent_appeal_new']!'+ Tạo Lời Khẩn Cầu Mới'}
        </a>
        </#if>
    </div>

    <#if appeals?has_content>
    <div class="space-y-4">
        <#list appeals as appeal>
        <#assign prog = appeal.currentProgress>
        <#assign textColor = macros.progressTextColor(prog)>
        <div class="bg-white rounded-2xl shadow-md border-l-4 border-gray-200 p-5 hover:shadow-lg transition-shadow">
            <div class="flex flex-col sm:flex-row gap-4">
                <#-- Image -->
                <#if appeal.images?has_content>
                <div class="w-full sm:w-40 flex-shrink-0 overflow-hidden rounded-xl" style="aspect-ratio:16/9;">
                    <img src="${appeal.images[0]}" alt="${appeal.title?html}" class="w-full h-full object-cover rounded-xl">
                </div>
                </#if>
                <div class="flex-1 min-w-0">
                    <div class="flex flex-wrap justify-between items-start gap-2 mb-2">
                        <h2 class="text-lg font-bold text-gray-800">${appeal.title?html}</h2>
                        <span class="text-xs text-gray-400">${appeal.createdAt?string?substring(0, 10)}</span>
                    </div>
                    <p class="text-sm text-gray-600 mb-3 line-clamp-2">${appeal.content?html?substring(0, (appeal.content?length > 120)?then(120, appeal.content?length))}<#if appeal.content?length gt 120>...</#if></p>

                    <#-- Progress bar -->
                    <div class="mb-2">
                        <div class="flex justify-end mb-0.5">
                            <span class="text-xs font-bold ${textColor}">${prog}%</span>
                        </div>
                        <@macros.progressBar prog=prog label="${appeal.amount?string['###,###,###']} VNĐ" height="h-5"/>
                    </div>

                    <div class="flex flex-wrap justify-between items-center gap-2">
                        <span class="text-xs text-gray-500">💰 ${appeal.amount?string["###,###,###"]} VNĐ</span>
                        <div class="flex items-center gap-2">
                            <button onclick="followAppeal(${appeal.id}, this)"
                                    data-appeal-id="${appeal.id}"
                                    class="follow-btn text-xs px-3 py-1 rounded-lg border border-red-400 text-red-600 hover:bg-red-50 transition-colors">
                                🔔 ${msg['appeal_follow_btn']!'Theo dõi'}
                            </button>
                            <a href="/urgent-appeals/${appeal.id}" class="text-sm text-red-600 hover:text-red-800 font-medium">
                                ${msg['home_urgent_appeals_view']!'Xem Chi Tiết'} →
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </#list>
    </div>
    <#else>
    <div class="text-center py-16 text-gray-500">
        <div class="text-5xl mb-4">📢</div>
        <p>${msg['urgent_appeal_empty']!'Chưa có lời khẩn cầu nào.'}</p>
    </div>
    </#if>
</div>

<div id="follow-toast" style="display:none"
    class="fixed bottom-6 left-1/2 -translate-x-1/2 bg-gray-800 text-white text-sm px-5 py-2.5 rounded-full shadow-xl z-50 transition-opacity"></div>

<#if firebaseConfig?? && (firebaseConfig['apiKey'])!''>
<#include "../urgent-appeals/follow-script.ftl">
</#if>
</@layout.page>
