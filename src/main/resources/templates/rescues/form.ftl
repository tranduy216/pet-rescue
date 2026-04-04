<#import "../layout/base.ftl" as layout>
<@layout.page title="${msg['rescue_form_title']!'Report Animal Rescue'} - ${msg['site_name']!'Pet Rescue'}">
<div class="max-w-xl mx-auto mt-6">
    <div class="bg-white rounded-xl shadow-md p-8">
        <h1 class="text-2xl font-bold text-green-800 mb-6">${msg['rescue_form_title']!'🚨 Report Animal Rescue'}</h1>
        <#if error??>
        <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">${error}</div>
        </#if>
        <form method="POST" action="/rescues/new" class="space-y-4">

            <#-- Reporter info (read-only, from account) -->
            <div class="bg-green-50 border border-green-200 rounded-lg p-4 space-y-3">
                <p class="text-xs text-green-700 font-medium">👤 ${msg['rescue_field_reporter_readonly']!'Thông tin người báo cáo được lấy từ tài khoản của bạn'}</p>
                <div class="grid grid-cols-2 gap-3">
                    <div>
                        <label class="block text-xs font-medium text-gray-500 mb-1">${msg['user_col_name']!'Họ Tên'}</label>
                        <input type="text" value="${(user.fullName)!''}" disabled
                            class="w-full border border-gray-200 rounded-lg px-3 py-2 bg-gray-100 text-gray-600 text-sm cursor-not-allowed">
                    </div>
                    <div>
                        <label class="block text-xs font-medium text-gray-500 mb-1">${msg['user_col_username']!'Tên đăng nhập'}</label>
                        <input type="text" value="${(user.username)!''}" disabled
                            class="w-full border border-gray-200 rounded-lg px-3 py-2 bg-gray-100 text-gray-600 text-sm cursor-not-allowed">
                    </div>
                </div>
            </div>

            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">${msg['rescue_field_location']!'Location'} *</label>
                <input type="text" name="location" required placeholder="${msg['rescue_field_location_placeholder']!'Address or landmark'}"
                    class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500">
            </div>

            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">${msg['rescue_field_description']!'Description'} *</label>
                <textarea name="description" rows="4" required
                    placeholder="${msg['rescue_field_description_placeholder']!'Describe the animal and situation...'}"
                    class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500"></textarea>
                <p class="text-xs text-amber-600 mt-1 bg-amber-50 border border-amber-200 rounded px-3 py-2">
                    ${msg['rescue_field_description_hint']!'💡 Nếu bạn chỉ là người chuyển tiếp, hãy ghi thêm số điện thoại người trực tiếp phát hiện vào phần mô tả.'}
                </p>
            </div>

            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">${msg['rescue_field_contact']!'Contact Info'} *</label>
                <#if (user.phone)?has_content>
                <input type="hidden" name="contactInfo" value="${user.phone}">
                <input type="text" value="${user.phone}" disabled
                    class="w-full border border-gray-200 rounded-lg px-3 py-2 bg-gray-100 text-gray-600 cursor-not-allowed focus:outline-none">
                <p class="text-xs text-gray-400 mt-1">${msg['rescue_field_contact_readonly']!'Số điện thoại từ tài khoản của bạn'}</p>
                <#else>
                <input type="text" name="contactInfo" required placeholder="${msg['rescue_field_contact_placeholder']!'Phone or other contact'}"
                    class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500">
                </#if>
            </div>

            <div class="flex space-x-3 pt-2">
                <button type="submit" class="bg-yellow-500 text-white px-6 py-2 rounded-lg hover:bg-yellow-600 font-medium">${msg['rescue_submit']!'Submit Report'}</button>
                <a href="/rescues" class="bg-gray-200 text-gray-700 px-6 py-2 rounded-lg hover:bg-gray-300">${msg['btn_cancel']!'Cancel'}</a>
            </div>
        </form>
    </div>
</div>
</@layout.page>
