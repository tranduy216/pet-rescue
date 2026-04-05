<#import "../layout/base.ftl" as layout>
<#assign activeTab = tab!'system'>
<@layout.page title="${msg['config_title']!'Cấu Hình'} - ${msg['site_name']!'Pet Rescue'}">

<div class="px-2 sm:px-4 py-6 max-w-6xl mx-auto">
    <div class="flex items-center gap-3 mb-6">
        <span class="text-3xl">⚙️</span>
        <h1 class="text-2xl font-bold text-green-800">${msg['config_title']!'Cấu Hình'}</h1>
    </div>

    <#-- Tabs -->
    <div class="flex border-b border-gray-200 mb-6">
        <a href="/config?tab=system"
            class="px-5 py-3 text-sm font-medium border-b-2 transition-colors <#if activeTab == 'system'>border-green-600 text-green-700<#else>border-transparent text-gray-500 hover:text-green-600</#if>">
            🖥️ ${msg['config_tab_system']!'Hệ Thống'}
        </a>
        <a href="/config?tab=users"
            class="px-5 py-3 text-sm font-medium border-b-2 transition-colors <#if activeTab == 'users'>border-green-600 text-green-700<#else>border-transparent text-gray-500 hover:text-green-600</#if>">
            👥 ${msg['config_tab_users']!'Người Dùng'}
        </a>
        <a href="/config?tab=wishes"
            class="px-5 py-3 text-sm font-medium border-b-2 transition-colors <#if activeTab == 'wishes'>border-green-600 text-green-700<#else>border-transparent text-gray-500 hover:text-green-600</#if>">
            💌 ${msg['config_tab_wishes']!'Lời Chúc'}
        </a>
    </div>

    <#-- ── SYSTEM TAB ── -->
    <#if activeTab == 'system'>
    <div class="bg-white rounded-2xl shadow-md p-6 sm:p-8">
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
        <#if qrError?? && qrError?has_content>
        <div class="mb-6 p-4 bg-red-50 border border-red-200 rounded-xl text-red-700 text-sm font-medium">
            ⚠️ ${qrError}
        </div>
        </#if>

        <form method="post" action="/config" enctype="multipart/form-data" class="space-y-6">
            <#-- Vietnamese content -->
            <div class="border border-gray-200 rounded-xl p-4 space-y-4">
                <h2 class="text-base font-semibold text-green-700">🇻🇳 ${msg['config_homepage_title_vi']!'Tiêu Đề Tiếng Việt'}</h2>
                <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-1">${msg['config_homepage_title_vi']!'Tiêu Đề Tiếng Việt'}</label>
                    <input type="text" name="homepage_title_vi" value="${(config['homepage_title_vi'])!''}"
                        placeholder="${msg['home_hero_title']!'Yêu Thương & Bảo Vệ'}"
                        class="w-full border border-gray-300 rounded-lg px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-400">
                    <p class="mt-1 text-xs text-gray-500">${msg['config_homepage_title_vi_hint']!''}</p>
                </div>
                <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-1">${msg['config_homepage_subtitle_vi']!'Mô Tả Tiếng Việt'}</label>
                    <textarea name="homepage_subtitle_vi" rows="3"
                        class="w-full border border-gray-300 rounded-lg px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-400 resize-y">${(config['homepage_subtitle_vi'])!''}</textarea>
                    <p class="mt-1 text-xs text-gray-500">${msg['config_homepage_subtitle_vi_hint']!''}</p>
                </div>
            </div>

            <#-- English content -->
            <div class="border border-gray-200 rounded-xl p-4 space-y-4">
                <h2 class="text-base font-semibold text-green-700">🇬🇧 ${msg['config_homepage_title_en']!'English Title'}</h2>
                <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-1">${msg['config_homepage_title_en']!'English Title'}</label>
                    <input type="text" name="homepage_title_en" value="${(config['homepage_title_en'])!''}"
                        placeholder="Love &amp; Protect"
                        class="w-full border border-gray-300 rounded-lg px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-400">
                    <p class="mt-1 text-xs text-gray-500">${msg['config_homepage_title_en_hint']!''}</p>
                </div>
                <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-1">${msg['config_homepage_subtitle_en']!'English Description'}</label>
                    <textarea name="homepage_subtitle_en" rows="3"
                        class="w-full border border-gray-300 rounded-lg px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-400 resize-y">${(config['homepage_subtitle_en'])!''}</textarea>
                    <p class="mt-1 text-xs text-gray-500">${msg['config_homepage_subtitle_en_hint']!''}</p>
                </div>
            </div>

            <#-- Video URL -->
            <div>
                <label class="block text-sm font-semibold text-gray-700 mb-1">${msg['config_homepage_video_url']!'URL Video Nhúng'}</label>
                <input type="text" name="homepage_video_url" value="${(config['homepage_video_url'])!''}"
                    placeholder="https://www.youtube.com/embed/..."
                    class="w-full border border-gray-300 rounded-lg px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-400">
                <p class="mt-1 text-xs text-gray-500">Đường dẫn nhúng YouTube, ví dụ: https://www.youtube.com/embed/videoseries?list=PLxxx</p>
            </div>

            <#-- Social media -->
            <div class="border border-gray-200 rounded-xl p-4 space-y-4">
                <h2 class="text-base font-semibold text-green-700">📱 Mạng Xã Hội</h2>
                <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-1">📘 ${msg['config_social_facebook']!'Facebook URL'}</label>
                    <input type="url" name="social_facebook_url" value="${(config['social_facebook_url'])!''}"
                        placeholder="https://facebook.com/..."
                        class="w-full border border-gray-300 rounded-lg px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-400">
                </div>
                <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-1">▶️ ${msg['config_social_youtube']!'YouTube URL'}</label>
                    <input type="url" name="social_youtube_url" value="${(config['social_youtube_url'])!''}"
                        placeholder="https://youtube.com/..."
                        class="w-full border border-gray-300 rounded-lg px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-400">
                </div>
            </div>

            <#-- QR Code upload -->
            <div class="border border-gray-200 rounded-xl p-4 space-y-4">
                <h2 class="text-base font-semibold text-green-700">📷 ${msg['config_qr_section']!'Ảnh QR Code'}</h2>
                <p class="text-xs text-gray-500">${msg['config_qr_hint']!'JPG, PNG hoặc WEBP, tối đa 2MB.'}</p>
                <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">
                    <#-- QR Station -->
                    <div class="flex flex-col items-center gap-3">
                        <p class="text-sm font-medium text-gray-700 self-start">🏥 ${msg['config_qr1_upload']!'Upload QR Ủng Hộ Trạm'}</p>
                        <img id="preview-qr-station" src="/static/qr-station.png" alt="QR Station"
                            class="w-36 h-36 object-contain rounded-xl border border-gray-200"
                            onerror="this.style.display='none';this.nextElementSibling.style.display='flex'">
                        <div id="placeholder-qr-station" style="display:none" class="w-36 h-36 border-2 border-dashed border-gray-300 rounded-xl flex flex-col items-center justify-center text-gray-400 text-xs gap-1">
                            <span class="text-3xl">📷</span><span>qr-station.png</span>
                        </div>
                        <input type="file" name="qr_station" accept="image/*"
                            class="w-full text-sm text-gray-600 file:mr-3 file:py-1.5 file:px-3 file:rounded-lg file:border-0 file:text-xs file:font-semibold file:bg-green-50 file:text-green-700 hover:file:bg-green-100"
                            onchange="previewQr(this,'preview-qr-station','placeholder-qr-station')">
                    </div>
                    <#-- QR Web -->
                    <div class="flex flex-col items-center gap-3">
                        <p class="text-sm font-medium text-gray-700 self-start">🌐 ${msg['config_qr2_upload']!'Upload QR Ủng Hộ Website'}</p>
                        <img id="preview-qr-web" src="/static/qr-web.png" alt="QR Web"
                            class="w-36 h-36 object-contain rounded-xl border border-gray-200"
                            onerror="this.style.display='none';this.nextElementSibling.style.display='flex'">
                        <div id="placeholder-qr-web" style="display:none" class="w-36 h-36 border-2 border-dashed border-gray-300 rounded-xl flex flex-col items-center justify-center text-gray-400 text-xs gap-1">
                            <span class="text-3xl">📷</span><span>qr-web.png</span>
                        </div>
                        <input type="file" name="qr_web" accept="image/*"
                            class="w-full text-sm text-gray-600 file:mr-3 file:py-1.5 file:px-3 file:rounded-lg file:border-0 file:text-xs file:font-semibold file:bg-green-50 file:text-green-700 hover:file:bg-green-100"
                            onchange="previewQr(this,'preview-qr-web','placeholder-qr-web')">
                    </div>
<script>
function previewQr(input, imgId, placeholderId) {
    var file = input.files && input.files[0];
    var img = document.getElementById(imgId);
    var placeholder = document.getElementById(placeholderId);
    if (file) {
        var url = URL.createObjectURL(file);
        img.src = url;
        img.style.display = '';
        placeholder.style.display = 'none';
    }
}
</script>
                </div>
            </div>

            <div class="pt-2">
                <button type="submit" class="w-full bg-green-600 hover:bg-green-700 text-white font-semibold px-6 py-3 rounded-xl transition-colors text-sm">
                    💾 ${msg['config_save']!'Lưu Thay Đổi'}
                </button>
            </div>
        </form>
    </div>

    <#-- ── USERS TAB ── -->
    <#elseif activeTab == 'users'>
    <div class="space-y-4">
        <div class="flex justify-between items-center">
            <h2 class="text-lg font-bold text-green-800">👥 ${msg['config_tab_users']!'Người Dùng'}</h2>
            <a href="/users/new" class="bg-green-600 text-white px-4 py-2 rounded-lg hover:bg-green-700 text-sm">${msg['user_add_btn']!'+ Thêm Người Dùng'}</a>
        </div>
        <div class="bg-white rounded-xl shadow overflow-hidden">
            <table class="w-full">
                <thead class="bg-green-700 text-white">
                    <tr>
                        <th class="px-4 py-3 text-left text-sm">${msg['user_col_name']!'Họ Tên'}</th>
                        <th class="px-4 py-3 text-left text-sm">${msg['user_col_username']!'Tên ĐN'}</th>
                        <th class="px-4 py-3 text-left text-sm">${msg['user_col_email']!'Email'}</th>
                        <th class="px-4 py-3 text-left text-sm">${msg['user_col_role']!'Vai Trò'}</th>
                        <th class="px-4 py-3 text-left text-sm">${msg['user_col_status']!'Trạng Thái'}</th>
                        <th class="px-4 py-3 text-left text-sm">${msg['user_col_actions']!'Thao Tác'}</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-gray-200">
                    <#if users?has_content>
                    <#list users as user>
                    <tr class="hover:bg-green-50">
                        <td class="px-4 py-3 text-sm">${user.fullName}</td>
                        <td class="px-4 py-3 text-sm">${user.username}</td>
                        <td class="px-4 py-3 text-sm">${user.email}</td>
                        <td class="px-4 py-3 text-sm">
                            <span class="px-2 py-1 rounded text-xs font-medium
                                <#if user.role == 'ADMIN'>bg-red-100 text-red-800
                                <#elseif user.role == 'VOLUNTEER'>bg-blue-100 text-blue-800
                                <#else>bg-gray-100 text-gray-800</#if>">
                                <#if user.role == 'ADMIN'>${msg['role_admin']!'Admin'}
                                <#elseif user.role == 'VOLUNTEER'>${msg['role_volunteer']!'Volunteer'}
                                <#else>${msg['role_user']!'User'}</#if>
                            </span>
                        </td>
                        <td class="px-4 py-3 text-sm">
                            <span class="px-2 py-1 rounded text-xs <#if user.active>bg-green-100 text-green-800<#else>bg-red-100 text-red-800</#if>">
                                <#if user.active>${msg['status_active']!'Active'}<#else>${msg['status_inactive']!'Inactive'}</#if>
                            </span>
                        </td>
                        <td class="px-4 py-3 text-sm space-x-2">
                            <a href="/users/${user.id}/edit" class="text-green-600 hover:text-green-800">${msg['btn_edit']!'Sửa'}</a>
                            <form method="POST" action="/users/${user.id}/delete" class="inline">
                                <button type="submit" class="text-red-600 hover:text-red-800"
                                    onclick="return confirm('${msg['user_delete_confirm']!'Xóa người dùng này?'}')">${msg['btn_delete']!'Xóa'}</button>
                            </form>
                        </td>
                    </tr>
                    </#list>
                    <#else>
                    <tr><td colspan="6" class="px-4 py-8 text-center text-gray-500">Chưa có người dùng nào.</td></tr>
                    </#if>
                </tbody>
            </table>
        </div>
    </div>

    <#-- ── WISHES TAB ── -->
    <#else>
    <div class="space-y-4">
        <div class="flex justify-between items-center">
            <h2 class="text-lg font-bold text-green-800">💌 ${msg['config_tab_wishes']!'Lời Chúc'}</h2>
            <form method="get" action="/config" class="flex gap-2">
                <input type="hidden" name="tab" value="wishes">
                <select name="wishStatus" onchange="this.form.submit()" class="border border-gray-300 rounded-lg px-3 py-1.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-500">
                    <option value="">${msg['filter_status_all']!'Tất Cả'}</option>
                    <option value="NEW" <#if (wishStatus)! == 'NEW'>selected</#if>>${msg['wish_status_new']!'Mới'}</option>
                    <option value="APPROVED" <#if (wishStatus)! == 'APPROVED'>selected</#if>>${msg['wish_status_approved']!'Đã Duyệt'}</option>
                </select>
            </form>
        </div>
        <div class="bg-white rounded-xl shadow-md overflow-hidden">
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-gray-50">
                    <tr>
                        <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">${msg['wish_col_sender']!'Người Gửi'}</th>
                        <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">${msg['wish_col_message']!'Nội Dung'}</th>
                        <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">${msg['wish_col_status']!'Trạng Thái'}</th>
                        <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">${msg['wish_col_date']!'Ngày'}</th>
                        <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">${msg['wish_col_actions']!'Thao Tác'}</th>
                    </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-100">
                    <#if wishes?has_content>
                    <#list wishes as wish>
                    <tr class="hover:bg-gray-50">
                        <td class="px-4 py-3 text-sm font-medium text-gray-900">${wish.donorName?html}</td>
                        <td class="px-4 py-3 text-sm text-gray-600 max-w-xs">
                            <#if wish.message??>${wish.message?html}<#else><span class="text-gray-400">—</span></#if>
                        </td>
                        <td class="px-4 py-3 text-sm">
                            <#if wish.status == "APPROVED">
                                <span class="bg-green-100 text-green-700 text-xs px-2 py-1 rounded-full">${msg['wish_status_approved']!'Đã Duyệt'}</span>
                            <#else>
                                <span class="bg-yellow-100 text-yellow-700 text-xs px-2 py-1 rounded-full">${msg['wish_status_new']!'Mới'}</span>
                            </#if>
                        </td>
                        <td class="px-4 py-3 text-sm text-gray-500">${wish.createdAt?string?substring(0, 10)}</td>
                        <td class="px-4 py-3 text-sm">
                            <div class="flex flex-wrap gap-2">
                                <#if wish.status != "APPROVED">
                                <form method="POST" action="/wishes/${wish.id}/approve" class="inline">
                                    <button type="submit" class="bg-green-600 text-white text-xs px-3 py-1.5 rounded hover:bg-green-700">${msg['wish_btn_approve']!'Duyệt'}</button>
                                </form>
                                </#if>
                                <form method="POST" action="/wishes/${wish.id}/delete" class="inline">
                                    <button type="submit"
                                        onclick="return confirm('${msg['wish_delete_confirm']!'Xóa lời chúc này?'}')"
                                        class="bg-red-500 text-white text-xs px-3 py-1.5 rounded hover:bg-red-600">${msg['btn_delete']!'Xóa'}</button>
                                </form>
                            </div>
                        </td>
                    </tr>
                    </#list>
                    <#else>
                    <tr><td colspan="5" class="px-4 py-8 text-center text-gray-500">${msg['wish_empty']!'Chưa có lời chúc nào.'}</td></tr>
                    </#if>
                </tbody>
            </table>
        </div>
    </div>
    </#if>
</div>

</@layout.page>
