<#import "layout/base.ftl" as layout>
<@layout.page title="${msg['config_title']!'Cấu Hình Trang Chủ'}">

<div class="px-2 sm:px-4 py-6 max-w-2xl mx-auto">
    <div class="bg-white rounded-2xl shadow-md p-6 sm:p-8">
        <div class="flex items-center gap-3 mb-6">
            <span class="text-3xl">⚙️</span>
            <h1 class="text-2xl font-bold text-green-800">${msg['config_title']!'Cấu Hình Trang Chủ'}</h1>
        </div>

        <#if success?? && success>
        <div class="mb-6 p-4 bg-green-50 border border-green-200 rounded-xl text-green-800 text-sm font-medium">
            ✅ ${msg['config_saved']!'Đã lưu cấu hình thành công!'}
        </div>
        </#if>

        <form method="post" action="/config" class="space-y-6">
            <div>
                <label class="block text-sm font-semibold text-gray-700 mb-1">${msg['config_homepage_title']!'Tiêu Đề Chính'}</label>
                <input type="text" name="homepage_title"
                    value="${(config['homepage_title'])!''}"
                    placeholder="${msg['home_hero_title']!'Yêu Thương & Bảo Vệ'}"
                    class="w-full border border-gray-300 rounded-lg px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-400">
                <p class="mt-1 text-xs text-gray-500">Tiêu đề lớn hiển thị ở đầu trang chủ.</p>
            </div>

            <div>
                <label class="block text-sm font-semibold text-gray-700 mb-1">${msg['config_homepage_subtitle']!'Nội Dung Giới Thiệu'}</label>
                <textarea name="homepage_subtitle" rows="3"
                    placeholder="${msg['home_hero_subtitle']!'Chúng tôi giải cứu, chữa trị và tìm mái ấm...'}"
                    class="w-full border border-gray-300 rounded-lg px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-400 resize-y">${(config['homepage_subtitle'])!''}</textarea>
                <p class="mt-1 text-xs text-gray-500">Mô tả ngắn hiển thị bên dưới tiêu đề.</p>
            </div>

            <div>
                <label class="block text-sm font-semibold text-gray-700 mb-1">${msg['config_homepage_video_url']!'URL Video Nhúng'}</label>
                <input type="text" name="homepage_video_url"
                    value="${(config['homepage_video_url'])!''}"
                    placeholder="https://www.youtube.com/embed/..."
                    class="w-full border border-gray-300 rounded-lg px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-400">
                <p class="mt-1 text-xs text-gray-500">Đường dẫn nhúng YouTube, ví dụ: https://www.youtube.com/embed/videoseries?list=PLxxx</p>
            </div>

            <div class="pt-2">
                <button type="submit" class="w-full bg-green-600 hover:bg-green-700 text-white font-semibold px-6 py-3 rounded-xl transition-colors text-sm">
                    💾 ${msg['config_save']!'Lưu Thay Đổi'}
                </button>
            </div>
        </form>
    </div>
</div>

</@layout.page>
