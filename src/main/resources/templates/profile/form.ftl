<#import "../layout/base.ftl" as layout>
<@layout.page title="${msg['profile_title']!'Hồ Sơ Của Tôi'}">

<div class="px-2 sm:px-4 py-6 max-w-lg mx-auto">
    <div class="bg-white rounded-2xl shadow-md p-6 sm:p-8">
        <div class="flex items-center gap-3 mb-6">
            <div class="w-12 h-12 rounded-full bg-green-100 flex items-center justify-center text-2xl">👤</div>
            <div>
                <h1 class="text-xl font-bold text-green-800">${msg['profile_title']!'Hồ Sơ Của Tôi'}</h1>
                <p class="text-sm text-gray-500">${session.username} &middot; <span class="text-xs font-medium bg-green-100 text-green-700 px-2 py-0.5 rounded-full">${session.role}</span></p>
            </div>
        </div>

        <#if success?? && success>
        <div class="mb-5 p-4 bg-green-50 border border-green-200 rounded-xl text-green-800 text-sm font-medium">
            ✅ ${msg['profile_saved']!'Đã cập nhật hồ sơ thành công!'}
        </div>
        </#if>
        <#if error?? && error?has_content>
        <div class="mb-5 p-4 bg-red-50 border border-red-200 rounded-xl text-red-700 text-sm font-medium">
            ⚠️ ${error}
        </div>
        </#if>

        <form method="post" action="/profile" class="space-y-5">
            <div>
                <label class="block text-sm font-semibold text-gray-700 mb-1">${msg['profile_email']!'Email'}</label>
                <input type="email" name="email"
                    value="${(user.email)!''}"
                    required
                    class="w-full border border-gray-300 rounded-lg px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-400">
            </div>
            <div>
                <label class="block text-sm font-semibold text-gray-700 mb-1">${msg['profile_phone']!'Số Điện Thoại'}</label>
                <input type="text" name="phone"
                    value="${(user.phone)!''}"
                    placeholder="0912 345 678"
                    class="w-full border border-gray-300 rounded-lg px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-400">
            </div>
            <div class="pt-1">
                <button type="submit" class="w-full bg-green-600 hover:bg-green-700 text-white font-semibold px-6 py-3 rounded-xl transition-colors text-sm">
                    💾 ${msg['profile_save']!'Lưu Thay Đổi'}
                </button>
            </div>
        </form>
    </div>
</div>

</@layout.page>
