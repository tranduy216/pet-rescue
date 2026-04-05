<#import "../layout/base.ftl" as layout>
<@layout.page title="${msg['urgent_appeal_form_create']!'Tạo Lời Khẩn Cầu'} - ${msg['site_name']!'Pet Rescue'}">
<div class="px-2 sm:px-4 py-6 max-w-2xl mx-auto">
    <div class="bg-white rounded-2xl shadow-md p-6 sm:p-8">
        <div class="flex items-center gap-3 mb-6">
            <span class="text-3xl">🆘</span>
            <h1 class="text-2xl font-bold text-red-700">${msg['urgent_appeal_form_create']!'Tạo Lời Khẩn Cầu'}</h1>
        </div>

        <#if error??>
        <div class="mb-4 p-4 bg-red-50 border border-red-200 rounded-xl text-red-700 text-sm">⚠️ ${error}</div>
        </#if>

        <form method="post" action="/urgent-appeals/new" enctype="multipart/form-data" class="space-y-5">
            <div>
                <label class="block text-sm font-semibold text-gray-700 mb-1">${msg['urgent_appeal_field_title']!'Tiêu Đề'} *</label>
                <input type="text" name="title" required
                    class="w-full border border-gray-300 rounded-lg px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-red-400">
            </div>
            <div>
                <label class="block text-sm font-semibold text-gray-700 mb-1">${msg['urgent_appeal_field_content']!'Nội Dung'} *</label>
                <textarea name="content" rows="5" required
                    class="w-full border border-gray-300 rounded-lg px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-red-400 resize-y"></textarea>
            </div>
            <div>
                <label class="block text-sm font-semibold text-gray-700 mb-1">${msg['urgent_appeal_field_amount']!'Số Tiền Cần (VNĐ)'}</label>
                <input type="number" name="amount" min="0" step="1000" value="0"
                    class="w-full border border-gray-300 rounded-lg px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-red-400">
            </div>
            <div>
                <label class="block text-sm font-semibold text-gray-700 mb-1">${msg['urgent_appeal_field_images']!'Ảnh (tối đa 3)'}</label>
                <input type="file" name="images" accept="image/*" multiple
                    class="w-full text-sm text-gray-600 file:mr-4 file:py-2 file:px-4 file:rounded-lg file:border-0 file:text-sm file:font-semibold file:bg-red-50 file:text-red-700 hover:file:bg-red-100">
                <p class="mt-1 text-xs text-gray-500">Chọn tối đa 3 ảnh (JPG, PNG, WEBP, tối đa 5MB mỗi ảnh)</p>
            </div>
            <div>
                <label class="block text-sm font-semibold text-gray-700 mb-1">${msg['urgent_appeal_field_video']!'Link Video (tùy chọn)'}</label>
                <input type="url" name="videoUrl"
                    placeholder="https://youtube.com/..."
                    class="w-full border border-gray-300 rounded-lg px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-red-400">
            </div>
            <div class="flex gap-3 pt-2">
                <button type="submit" class="flex-1 bg-red-600 hover:bg-red-700 text-white font-semibold px-6 py-3 rounded-xl transition-colors text-sm">
                    🆘 ${msg['urgent_appeal_btn_create']!'Tạo Lời Khẩn Cầu'}
                </button>
                <a href="/urgent-appeals" class="flex-1 text-center bg-gray-100 hover:bg-gray-200 text-gray-700 font-semibold px-6 py-3 rounded-xl transition-colors text-sm">
                    ${msg['urgent_appeal_btn_back']!'← Quay Lại'}
                </a>
            </div>
        </form>
    </div>
</div>
</@layout.page>
