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
                <label class="block text-sm font-semibold text-gray-700 mb-1">${msg['urgent_appeal_field_amount']!'Số Tiền Cần'}</label>
                <div class="space-y-2">
                    <div class="flex items-center justify-between text-sm">
                        <span class="text-gray-500">5 ${msg['urgent_appeal_amount_unit_short']!'triệu'}</span>
                        <span id="amount-display" class="font-bold text-red-700 text-base">5 ${msg['urgent_appeal_amount_unit']!'triệu đồng'}</span>
                        <span class="text-gray-500">50 ${msg['urgent_appeal_amount_unit_short']!'triệu'}</span>
                    </div>
                    <input id="amount-slider" type="range" min="5" max="50" step="2" value="5"
                        class="w-full accent-red-600 cursor-pointer"
                        oninput="syncAmount(this.value)">
                    <input type="hidden" name="amount" id="amount-hidden" value="5000000">
                </div>
            </div>
            <div>
                <label class="block text-sm font-semibold text-gray-700 mb-1">${msg['urgent_appeal_field_images']!'Ảnh (tùy chọn, tối đa 3)'}</label>
                <div class="grid grid-cols-3 gap-3">
                    <#list 1..3 as i>
                    <div class="flex flex-col items-center gap-2">
                        <div id="preview-${i}" class="w-full aspect-square rounded-xl border-2 border-dashed border-gray-300 flex flex-col items-center justify-center text-gray-400 text-xs gap-1 overflow-hidden bg-gray-50 cursor-pointer"
                            onclick="document.getElementById('image-input-${i}').click()">
                            <span class="text-2xl">📷</span>
                            <span>${msg['urgent_appeal_image_label']!'Ảnh'} ${i}</span>
                        </div>
                        <input id="image-input-${i}" type="file" name="image${i}" accept="image/*" class="hidden"
                            onchange="previewImage(this, 'preview-${i}')">
                        <button type="button"
                            class="w-full text-xs font-semibold py-1.5 px-2 rounded-lg bg-red-50 text-red-700 hover:bg-red-100 transition-colors border border-red-200"
                            onclick="document.getElementById('image-input-${i}').click()">
                            ${msg['urgent_appeal_select_image']!'Chọn ảnh'} ${i}
                        </button>
                    </div>
                    </#list>
                </div>
                <p class="mt-1 text-xs text-gray-500">${msg['urgent_appeal_image_hint']!'JPG, PNG, WEBP — tối đa 5MB mỗi ảnh'}</p>
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

<script>
var amountUnit = "${msg['urgent_appeal_amount_unit']!'triệu đồng'}";
function syncAmount(val) {
    var v = parseInt(val, 10);
    document.getElementById('amount-hidden').value = v * 1000000;
    document.getElementById('amount-display').textContent = v + ' ' + amountUnit;
}
function previewImage(input, previewId) {
    var preview = document.getElementById(previewId);
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            preview.innerHTML = '<img src="' + e.target.result + '" class="w-full h-full object-cover">';
        };
        reader.readAsDataURL(input.files[0]);
    }
}
</script>
</@layout.page>
