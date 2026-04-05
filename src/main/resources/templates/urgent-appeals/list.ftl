<#import "../layout/base.ftl" as layout>
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
        <#assign borderColor = "border-red-400">
        <#assign textColor = "text-red-500">
        <#if prog == 100>
          <#assign borderColor = "border-green-700"><#assign textColor = "text-green-700">
        <#elseif prog <= 90>
          <#assign borderColor = "border-green-400"><#assign textColor = "text-green-600">
        <#elseif prog <= 75>
          <#assign borderColor = "border-yellow-400"><#assign textColor = "text-yellow-600">
        <#elseif prog <= 60>
          <#assign borderColor = "border-orange-400"><#assign textColor = "text-orange-600">
        </#if>
        <div class="bg-white rounded-2xl shadow-md border-l-4 ${borderColor} p-5 hover:shadow-lg transition-shadow">
            <div class="flex flex-col sm:flex-row gap-4">
                <#-- Image -->
                <#if appeal.images?has_content>
                <div class="w-full sm:w-32 h-32 flex-shrink-0">
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
                    <#assign barColor = "bg-red-500">
                    <#if prog == 100><#assign barColor = "bg-green-700">
                    <#elseif prog <= 90><#assign barColor = "bg-green-400">
                    <#elseif prog <= 75><#assign barColor = "bg-yellow-400">
                    <#elseif prog <= 60><#assign barColor = "bg-orange-400">
                    </#if>
                    <div class="mb-2">
                        <div class="flex justify-end mb-0.5">
                            <span class="text-xs font-bold ${textColor}">${prog}%</span>
                        </div>
                        <div class="border-2 ${borderColor} rounded-full p-0.5">
                            <div class="relative h-5 bg-gray-100 rounded-full overflow-hidden">
                                <div class="${barColor} h-full rounded-full transition-all" style="width: ${prog}%"></div>
                                <span class="absolute inset-0 flex items-center justify-center text-xs font-bold text-white drop-shadow">
                                    ${appeal.amount?string["###,###,###"]} VNĐ
                                </span>
                            </div>
                        </div>
                    </div>

                    <div class="flex justify-between items-center">
                        <span class="text-xs text-gray-500">💰 ${appeal.amount?string["###,###,###"]} VNĐ</span>
                        <a href="/urgent-appeals/${appeal.id}" class="text-sm text-red-600 hover:text-red-800 font-medium">
                            ${msg['home_urgent_appeals_view']!'Xem Chi Tiết'} →
                        </a>
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
</@layout.page>
