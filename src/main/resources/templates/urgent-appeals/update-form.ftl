<#import "../layout/base.ftl" as layout>
<@layout.page title="${msg['urgent_appeal_update_form_title']!'Thêm Cập Nhật'} - ${msg['site_name']!'Pet Rescue'}">
<div class="px-2 sm:px-4 py-6 max-w-2xl mx-auto">
    <div class="bg-white rounded-2xl shadow-md p-6 sm:p-8">
        <div class="flex items-center gap-3 mb-6">
            <span class="text-3xl">📊</span>
            <div>
                <h1 class="text-2xl font-bold text-red-700">${msg['urgent_appeal_update_form_title']!'Thêm Cập Nhật Tiến Độ'}</h1>
                <p class="text-sm text-gray-500 mt-0.5">${appeal.title?html}</p>
            </div>
        </div>

        <#if error??>
        <div class="mb-4 p-4 bg-red-50 border border-red-200 rounded-xl text-red-700 text-sm">⚠️ ${error}</div>
        </#if>

        <form method="post" action="/urgent-appeals/${appeal.id}/update/new" enctype="multipart/form-data" class="space-y-5">
            <div>
                <label class="block text-sm font-semibold text-gray-700 mb-1">${msg['urgent_appeal_update_field_progress']!'Tiến Độ (%)'} *</label>
                <select name="progress" required
                    class="w-full border border-gray-300 rounded-lg px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-red-400">
                    <option value="15">15%</option>
                    <option value="30">30%</option>
                    <option value="45">45%</option>
                    <option value="60">60%</option>
                    <option value="75">75%</option>
                    <option value="90">90%</option>
                    <option value="100">100% ✅ Hoàn Thành</option>
                </select>
            </div>
            <div>
                <label class="block text-sm font-semibold text-gray-700 mb-1">${msg['urgent_appeal_update_field_date']!'Ngày Cập Nhật'} *</label>
                <input type="date" name="updateDate" required
                    min="${appeal.createdAt?string?substring(0, 10)}"
                    value="${.now?string("yyyy-MM-dd")}"
                    class="w-full border border-gray-300 rounded-lg px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-red-400">
                <p class="mt-1 text-xs text-gray-500">Ngày phải từ ${appeal.createdAt?string?substring(0, 10)} trở đi</p>
            </div>
            <div>
                <label class="block text-sm font-semibold text-gray-700 mb-1">${msg['urgent_appeal_update_field_content']!'Nội Dung Cập Nhật'} *</label>
                <textarea name="content" rows="4" required
                    class="w-full border border-gray-300 rounded-lg px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-red-400 resize-y"></textarea>
            </div>
            <div>
                <label class="block text-sm font-semibold text-gray-700 mb-1">${msg['urgent_appeal_update_field_images']!'Ảnh (tối đa 3)'}</label>
                <input type="file" name="images" accept="image/*" multiple
                    class="w-full text-sm text-gray-600 file:mr-4 file:py-2 file:px-4 file:rounded-lg file:border-0 file:text-sm file:font-semibold file:bg-red-50 file:text-red-700 hover:file:bg-red-100">
                <p class="mt-1 text-xs text-gray-500">Chọn tối đa 3 ảnh (JPG, PNG, WEBP, tối đa 5MB mỗi ảnh)</p>
            </div>
            <div>
                <label class="block text-sm font-semibold text-gray-700 mb-1">${msg['urgent_appeal_update_field_video']!'Link Video (tùy chọn)'}</label>
                <input type="url" name="videoUrl"
                    placeholder="https://youtube.com/..."
                    class="w-full border border-gray-300 rounded-lg px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-red-400">
            </div>
            <div class="flex gap-3 pt-2">
                <button type="submit" class="flex-1 bg-red-600 hover:bg-red-700 text-white font-semibold px-6 py-3 rounded-xl transition-colors text-sm">
                    💾 ${msg['urgent_appeal_update_btn']!'Lưu Cập Nhật'}
                </button>
                <a href="/urgent-appeals/${appeal.id}" class="flex-1 text-center bg-gray-100 hover:bg-gray-200 text-gray-700 font-semibold px-6 py-3 rounded-xl transition-colors text-sm">
                    ${msg['urgent_appeal_btn_back']!'← Quay Lại'}
                </a>
            </div>
        </form>
    </div>
</div>
</@layout.page>
