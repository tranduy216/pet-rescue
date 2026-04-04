<#import "../layout/base.ftl" as layout>
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
        <#if videoUrlError?? && videoUrlError>
        <div class="mb-6 p-4 bg-red-50 border border-red-200 rounded-xl text-red-700 text-sm font-medium">
            ⚠️ ${msg['config_video_url_error']!'URL video không hợp lệ. Chỉ chấp nhận URL nhúng YouTube.'}
        </div>
        </#if>

        <form method="post" action="/config" class="space-y-6">
            <div class="border border-gray-200 rounded-xl p-4 space-y-4">
                <h2 class="text-base font-semibold text-green-700">🇻🇳 ${msg['config_homepage_title_vi']!'Tiêu Đề Tiếng Việt'}</h2>
                <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-1">${msg['config_homepage_title_vi']!'Tiêu Đề Tiếng Việt'}</label>
                    <input type="text" name="homepage_title_vi"
                        value="${(config['homepage_title_vi'])!''}"
                        placeholder="${msg['home_hero_title']!'Yêu Thương & Bảo Vệ'}"
                        class="w-full border border-gray-300 rounded-lg px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-400">
                    <p class="mt-1 text-xs text-gray-500">${msg['config_homepage_title_vi_hint']!'Tiêu đề lớn hiển thị ở đầu trang chủ (Tiếng Việt).'}</p>
                </div>
                <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-1">${msg['config_homepage_subtitle_vi']!'Mô Tả Tiếng Việt'}</label>
                    <textarea name="homepage_subtitle_vi" rows="3"
                        placeholder="${msg['home_hero_subtitle']!'Chúng tôi giải cứu, chữa trị và tìm mái ấm...'}"
                        class="w-full border border-gray-300 rounded-lg px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-400 resize-y">${(config['homepage_subtitle_vi'])!''}</textarea>
                    <p class="mt-1 text-xs text-gray-500">${msg['config_homepage_subtitle_vi_hint']!'Mô tả ngắn hiển thị bên dưới tiêu đề (Tiếng Việt).'}</p>
                </div>
            </div>

            <div class="border border-gray-200 rounded-xl p-4 space-y-4">
                <h2 class="text-base font-semibold text-green-700">🇬🇧 ${msg['config_homepage_title_en']!'English Title'}</h2>
                <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-1">${msg['config_homepage_title_en']!'English Title'}</label>
                    <input type="text" name="homepage_title_en"
                        value="${(config['homepage_title_en'])!''}"
                        placeholder="Love &amp; Protect"
                        class="w-full border border-gray-300 rounded-lg px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-400">
                    <p class="mt-1 text-xs text-gray-500">${msg['config_homepage_title_en_hint']!'Main title displayed at the top of the homepage (English).'}</p>
                </div>
                <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-1">${msg['config_homepage_subtitle_en']!'English Description'}</label>
                    <textarea name="homepage_subtitle_en" rows="3"
                        placeholder="We rescue, treat, and rehome pets in need..."
                        class="w-full border border-gray-300 rounded-lg px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-400 resize-y">${(config['homepage_subtitle_en'])!''}</textarea>
                    <p class="mt-1 text-xs text-gray-500">${msg['config_homepage_subtitle_en_hint']!'Short description displayed below the title (English).'}</p>
                </div>
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
