<#import "../layout/base.ftl" as layout>
<#assign canManage = session?? && (session.role == "ADMIN" || session.role == "VOLUNTEER")>
<#assign prog = appeal.currentProgress>
<#assign borderColor = "border-red-400">
<#assign bgColor = "bg-red-50">
<#assign textColor = "text-red-700">
<#assign barColor = "bg-red-500">
<#if prog == 100>
  <#assign borderColor = "border-green-700"><#assign bgColor = "bg-green-50"><#assign textColor = "text-green-800"><#assign barColor = "bg-green-700">
<#elseif prog <= 90>
  <#assign borderColor = "border-green-400"><#assign bgColor = "bg-green-50"><#assign textColor = "text-green-700"><#assign barColor = "bg-green-400">
<#elseif prog <= 75>
  <#assign borderColor = "border-yellow-400"><#assign bgColor = "bg-yellow-50"><#assign textColor = "text-yellow-700"><#assign barColor = "bg-yellow-400">
<#elseif prog <= 60>
  <#assign borderColor = "border-orange-400"><#assign bgColor = "bg-orange-50"><#assign textColor = "text-orange-700"><#assign barColor = "bg-orange-400">
</#if>

<@layout.page title="${appeal.title?html} - ${msg['site_name']!'Pet Rescue'}">
<div class="px-2 sm:px-4 py-6 max-w-4xl mx-auto">

    <#-- Back link + action buttons -->
    <div class="flex justify-between items-center mb-6">
        <a href="/urgent-appeals" class="text-sm text-gray-500 hover:text-gray-700">← ${msg['urgent_appeal_btn_back']!'Quay Lại'}</a>
        <#if canManage>
        <a href="/urgent-appeals/${appeal.id}/update/new"
            class="bg-red-600 text-white px-4 py-2 rounded-lg hover:bg-red-700 text-sm font-medium">
            ${msg['urgent_appeal_btn_add_update']!'+ Thêm Cập Nhật'}
        </a>
        </#if>
    </div>

    <#-- Header: QR left, title right -->
    <div class="bg-white rounded-2xl shadow-md border-2 ${borderColor} p-6 mb-6">
        <div class="flex flex-col sm:flex-row gap-6">
            <#-- QR code left -->
            <div class="flex-shrink-0 flex flex-col items-center justify-center">
                <img src="/static/qr-station.png" alt="QR"
                    class="w-36 h-36 object-contain rounded-xl border border-gray-200"
                    onerror="this.style.display='none';this.nextElementSibling.style.display='flex'">
                <div style="display:none" class="w-36 h-36 border-2 border-dashed border-gray-300 rounded-xl flex flex-col items-center justify-center text-gray-400 text-xs gap-1">
                    <span class="text-3xl">📷</span><span>QR</span>
                </div>
                <p class="text-xs text-gray-500 mt-2 text-center">${msg['home_urgent_appeals_qr_subtitle']!'Quét để ủng hộ'}</p>
            </div>

            <#-- Title & info right -->
            <div class="flex-1">
                <h1 class="text-2xl font-bold text-gray-800 mb-2">${appeal.title?html}</h1>
                <p class="text-sm text-gray-500 mb-1">📅 ${msg['urgent_appeal_detail_created']!'Ngày tạo'}: ${appeal.createdAt?string?substring(0, 10)}</p>
                <p class="text-sm text-gray-500 mb-4">💰 ${msg['urgent_appeal_detail_amount']!'Số tiền cần'}: <strong>${appeal.amount?string["###,###,###"]} VNĐ</strong></p>

                <#-- Progress bar with amount text overlay -->
                <div class="mb-2">
                    <div class="flex justify-between text-xs text-gray-500 mb-1">
                        <span>${msg['urgent_appeal_detail_progress']!'Tiến Độ'}</span>
                        <span class="${textColor} font-semibold">${prog}%</span>
                    </div>
                    <div class="relative h-7 bg-gray-100 rounded-full overflow-hidden">
                        <div class="${barColor} h-full rounded-full transition-all" style="width: ${prog}%"></div>
                        <span class="absolute inset-0 flex items-center justify-center text-xs font-bold text-white drop-shadow">
                            ${appeal.amount?string["###,###,###"]} VNĐ
                        </span>
                    </div>
                </div>

                <p class="text-sm text-gray-700 mt-4 leading-relaxed">${appeal.content?html}</p>

                <#-- Initial images -->
                <#if appeal.images?has_content>
                <div class="flex flex-wrap gap-2 mt-4">
                    <#list appeal.images as img>
                    <img src="${img}" alt="" class="w-20 h-20 object-cover rounded-lg border border-gray-200 cursor-pointer hover:opacity-90"
                        onclick="document.getElementById('lightbox').src=this.src;document.getElementById('lightbox-modal').classList.remove('hidden')">
                    </#list>
                </div>
                </#if>

                <#-- Initial video -->
                <#if appeal.videoUrl?? && appeal.videoUrl?has_content>
                <a href="${appeal.videoUrl}" target="_blank" class="inline-flex items-center gap-1 mt-3 text-sm text-blue-600 hover:text-blue-800">▶️ Xem video</a>
                </#if>
            </div>
        </div>
    </div>

    <#-- Timeline -->
    <h2 class="text-lg font-bold text-gray-700 mb-4">🕐 ${msg['urgent_appeal_detail_timeline']!'Dòng Thời Gian'}</h2>

    <#if appeal.updates?has_content>
    <div class="relative">
        <div class="absolute left-4 top-0 bottom-0 w-0.5 bg-gray-200"></div>
        <div class="space-y-6 pl-10">
            <#list appeal.updates as upd>
            <#assign upProg = upd.progress>
            <#assign upBorder = "border-red-300">
            <#assign upBar = "bg-red-400">
            <#assign upDot = "bg-red-400">
            <#if upProg == 100>
              <#assign upBorder = "border-green-600"><#assign upBar = "bg-green-700"><#assign upDot = "bg-green-600">
            <#elseif upProg <= 90>
              <#assign upBorder = "border-green-400"><#assign upBar = "bg-green-400"><#assign upDot = "bg-green-400">
            <#elseif upProg <= 75>
              <#assign upBorder = "border-yellow-400"><#assign upBar = "bg-yellow-400"><#assign upDot = "bg-yellow-400">
            <#elseif upProg <= 60>
              <#assign upBorder = "border-orange-400"><#assign upBar = "bg-orange-400"><#assign upDot = "bg-orange-400">
            </#if>

            <div class="relative">
                <div class="absolute -left-6 top-4 w-3 h-3 rounded-full ${upDot} border-2 border-white shadow"></div>
                <div class="bg-white rounded-xl shadow-sm border ${upBorder} p-4">
                    <div class="flex flex-wrap justify-between items-center gap-2 mb-2">
                        <span class="text-sm font-semibold text-gray-700">📅 ${upd.updateDate?string("dd/MM/yyyy")}</span>
                        <span class="text-sm font-bold" style="color: <#if upProg == 100>#15803d<#elseif upProg <= 90>#22c55e<#elseif upProg <= 75>#eab308<#elseif upProg <= 60>#f97316<#else>#ef4444</#if>">${upProg}%</span>
                    </div>

                    <#-- Mini progress bar -->
                    <div class="relative h-4 bg-gray-100 rounded-full overflow-hidden mb-3">
                        <div class="${upBar} h-full rounded-full" style="width: ${upProg}%"></div>
                        <span class="absolute inset-0 flex items-center justify-center text-xs font-bold text-white drop-shadow">${upProg}%</span>
                    </div>

                    <p class="text-sm text-gray-700 mb-3">${upd.content?html}</p>

                    <#if upd.images?has_content>
                    <div class="flex flex-wrap gap-2 mb-2">
                        <#list upd.images as img>
                        <img src="${img}" alt="" class="w-16 h-16 object-cover rounded-lg border border-gray-200 cursor-pointer hover:opacity-90"
                            onclick="document.getElementById('lightbox').src=this.src;document.getElementById('lightbox-modal').classList.remove('hidden')">
                        </#list>
                    </div>
                    </#if>

                    <#if upd.videoUrl?? && upd.videoUrl?has_content>
                    <a href="${upd.videoUrl}" target="_blank" class="text-xs text-blue-600 hover:text-blue-800">▶️ Xem video</a>
                    </#if>
                </div>
            </div>
            </#list>
        </div>
    </div>
    <#else>
    <div class="text-center py-8 text-gray-400 text-sm">Chưa có cập nhật nào.</div>
    </#if>
</div>

<#-- Lightbox -->
<div id="lightbox-modal" class="hidden fixed inset-0 bg-black bg-opacity-80 flex items-center justify-center z-50 p-4" onclick="this.classList.add('hidden')">
    <img id="lightbox" src="" alt="" class="max-w-full max-h-full rounded-xl shadow-2xl">
</div>

</@layout.page>
