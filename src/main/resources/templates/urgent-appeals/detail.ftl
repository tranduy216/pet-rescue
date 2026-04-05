<#import "../layout/base.ftl" as layout>
<#import "../layout/macros.ftl" as macros>
<#assign canManage = canManage!false>
<#assign prog = appeal.currentProgress>
<#assign textColor = macros.progressTextColor(prog)>

<@layout.page title="${appeal.title?html} - ${msg['site_name']!'Pet Rescue'}">
<div class="px-2 sm:px-4 py-6 max-w-4xl mx-auto">

    <#-- Back link + action buttons -->
    <div class="flex justify-between items-center mb-6">
        <a href="/urgent-appeals" class="text-sm text-gray-500 hover:text-gray-700">← ${msg['urgent_appeal_btn_back']!'Quay Lại'}</a>
        <div class="flex items-center gap-2 flex-wrap justify-end">
            <button onclick="followAppeal(${appeal.id}, this)"
                    data-appeal-id="${appeal.id}"
                    class="follow-btn text-sm px-4 py-2 rounded-lg border border-red-400 text-red-600 hover:bg-red-50 transition-colors font-medium">
                🔔 ${msg['appeal_follow_btn']!'Theo dõi'}
            </button>
            <#if canManage>
            <a href="/urgent-appeals/${appeal.id}/update/new"
                class="bg-red-600 text-white px-4 py-2 rounded-lg hover:bg-red-700 text-sm font-medium">
                ${msg['urgent_appeal_btn_add_update']!'+ Thêm Cập Nhật'}
            </a>
            <button onclick="document.getElementById('notify-panel').classList.toggle('hidden')"
                    class="bg-orange-500 text-white px-4 py-2 rounded-lg hover:bg-orange-600 text-sm font-medium">
                📣 ${msg['appeal_notify_btn']!'Gửi Thông Báo'}
            </button>
            </#if>
        </div>
    </div>

    <#-- Admin: send notification panel -->
    <#if canManage>
    <div id="notify-panel" class="hidden mb-6 bg-orange-50 border border-orange-200 rounded-xl p-4">
        <h3 class="font-semibold text-orange-800 mb-3">📣 ${msg['appeal_notify_panel_title']!'Gửi Thông Báo Tới Người Theo Dõi'}</h3>
        <form method="POST" action="/urgent-appeals/${appeal.id}/notify">
            <div class="mb-3">
                <label class="block text-xs font-medium text-gray-700 mb-1">${msg['appeal_notify_title']!'Tiêu đề'}</label>
                <input type="text" name="title" value="📢 ${appeal.title?html}"
                       class="w-full border border-gray-200 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-orange-400">
            </div>
            <div class="mb-3">
                <label class="block text-xs font-medium text-gray-700 mb-1">${msg['appeal_notify_body']!'Nội dung'}</label>
                <textarea name="body" rows="2"
                          class="w-full border border-gray-200 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-orange-400">Có cập nhật mới từ lời khẩn cầu.</textarea>
            </div>
            <button type="submit" class="bg-orange-500 text-white px-4 py-2 rounded-lg hover:bg-orange-600 text-sm font-medium">
                ${msg['appeal_notify_send']!'Gửi Ngay'}
            </button>
        </form>
    </div>
    </#if>

    <#-- Header: QR left, title right -->
    <div class="bg-white rounded-2xl shadow-md border-2 border-gray-200 p-6 mb-6">
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
                <#if siteConfig??>
                <#assign qrHolder = (siteConfig['bank1_holder'])!''>
                <#assign qrName = (siteConfig['bank1_name'])!''>
                <#assign qrAcct = (siteConfig['bank1_account'])!''>
                <#if qrHolder?has_content || qrName?has_content || qrAcct?has_content>
                <div class="mt-1 text-xs text-gray-600 text-center space-y-0.5">
                    <#if qrHolder?has_content><p class="font-bold text-green-900 uppercase tracking-wide">${qrHolder}</p></#if>
                    <#if qrName?has_content><p class="font-semibold text-green-800">${qrName}</p></#if>
                    <#if qrAcct?has_content><p class="font-mono tracking-wide">${qrAcct}</p></#if>
                </div>
                </#if>
                </#if>
            </div>

            <#-- Title & info right -->
            <div class="flex-1">
                <h1 class="text-2xl font-bold text-gray-800 mb-2">${appeal.title?html}</h1>
                <p class="text-sm text-gray-500 mb-1">📅 ${msg['urgent_appeal_detail_created']!'Ngày tạo'}: ${appeal.createdAt?string?substring(0, 10)}</p>
                <p class="text-sm text-gray-500 mb-4">💰 ${msg['urgent_appeal_detail_amount']!'Số tiền cần'}: <strong>${appeal.amount?string["###,###,###"]} VNĐ</strong></p>

                <#-- Progress bar with amount text overlay -->
                <div class="mb-2">
                    <div class="flex justify-between text-xs mb-1">
                        <span class="text-gray-500">${msg['urgent_appeal_detail_progress']!'Tiến Độ'}</span>
                        <span class="${textColor} font-bold">${prog}%</span>
                    </div>
                    <@macros.progressBar prog=prog label="${appeal.amount?string['###,###,###']} VNĐ" height="h-6"/>
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
            <#list appeal.updates?reverse as upd>
            <#assign upProg = upd.progress>
            <#assign upDot  = macros.progressBarColor(upProg)>
            <#assign upText = macros.progressTextColor(upProg)>

            <div class="relative">
                <div class="absolute -left-6 top-4 w-3 h-3 rounded-full ${upDot} border-2 border-white shadow"></div>
                <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-4">
                    <div class="flex flex-wrap justify-between items-center gap-2 mb-2">
                        <span class="text-sm font-semibold text-gray-700">📅 ${upd.updateDate.dayOfMonth?string["00"]}/${upd.updateDate.monthValue?string["00"]}/${upd.updateDate.year?c}</span>
                        <span class="text-sm font-bold ${upText}">${upProg}%</span>
                    </div>

                    <#-- Mini progress bar -->
                    <div class="mb-3"><@macros.progressBar prog=upProg height="h-4"/></div>

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

<div id="follow-toast" style="display:none"
    class="fixed bottom-6 left-1/2 -translate-x-1/2 bg-gray-800 text-white text-sm px-5 py-2.5 rounded-full shadow-xl z-50 transition-opacity"></div>

<#if firebaseConfig?? && (firebaseConfig['apiKey'])!''>
<#include "follow-script.ftl">
</#if>

</@layout.page>
