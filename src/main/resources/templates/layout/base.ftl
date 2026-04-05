<#macro page title="Pet Rescue" headContent="">
<!DOCTYPE html>
<html lang="${lang!'vi'}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${title} 🐾</title>
    <link rel="icon" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><text y='.9em' font-size='90'>🐾</text></svg>">
    <link rel="stylesheet" href="/assets/tailwind.min.css">
    ${headContent}
</head>
<body class="min-h-screen bg-green-50">
    <nav class="bg-green-700 shadow-lg">
        <div class="w-full px-3 sm:px-4 lg:px-8">
            <div class="flex h-14 sm:h-16 items-center">
                <#-- Logo (left) -->
                <a href="/" class="text-white text-lg sm:text-xl font-bold flex-shrink-0">
                    🐾 <#if msg??>${msg['site_name']!'Pet Rescue'}<#else>Pet Rescue</#if>
                </a>

                <#-- Desktop nav links (left-aligned after logo) -->
                <div class="hidden md:flex items-center space-x-1 lg:space-x-2 ml-4 lg:ml-6">
                    <a href="/urgent-appeals" class="text-red-200 hover:text-white px-2 lg:px-3 py-2 rounded-md text-sm font-medium whitespace-nowrap font-semibold">🆘 <#if msg??>${msg['nav_urgent_appeals']!'Khẩn Cầu'}<#else>Khẩn Cầu</#if></a>
                    <a href="/pets" class="text-green-100 hover:text-white px-2 lg:px-3 py-2 rounded-md text-sm font-medium whitespace-nowrap">🐾 <#if msg??>${msg['nav_pets']!'Các Bé'}<#else>Các Bé</#if></a>
                    <a href="/donate" class="text-green-100 hover:text-white px-2 lg:px-3 py-2 rounded-md text-sm font-medium whitespace-nowrap">💚 <#if msg??>${msg['nav_donate']!'Động Viên'}<#else>Động Viên</#if></a>
                    <#if session?? && session.role != "GUEST">
                        <a href="/rescues" class="text-green-100 hover:text-white px-2 lg:px-3 py-2 rounded-md text-sm font-medium whitespace-nowrap">🚨 <#if msg??>${msg['nav_rescue']!'Rescue'}<#else>Rescue</#if></a>
                    </#if>
                    <a href="<#if session??>/adoptions<#else>/register?redirect=/adoptions</#if>" class="text-green-100 hover:text-white px-2 lg:px-3 py-2 rounded-md text-sm font-medium whitespace-nowrap">🏠 <#if msg??>${msg['nav_adoptions']!'Nhận Nuôi'}<#else>Nhận Nuôi</#if></a>
                </div>

                <#-- Right side: social icons + auth + hamburger -->
                <div class="flex items-center gap-2 ml-auto">
                    <#-- Social media icons (desktop) -->
                    <#if siteConfig??>
                    <#assign fbUrl = (siteConfig['social_facebook_url'])!''>
                    <#assign ytUrl = (siteConfig['social_youtube_url'])!''>
                    <#else>
                    <#assign fbUrl = ''>
                    <#assign ytUrl = ''>
                    </#if>
                    <#if fbUrl?has_content>
                        <a href="${fbUrl}" target="_blank" rel="noopener noreferrer" class="hidden md:inline-flex items-center text-green-200 hover:text-white" title="Facebook">
                            <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24"><path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"/></svg>
                        </a>
                    </#if>
                    <#if ytUrl?has_content>
                        <a href="${ytUrl}" target="_blank" rel="noopener noreferrer" class="hidden md:inline-flex items-center text-green-200 hover:text-white" title="YouTube">
                            <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24"><path d="M23.495 6.205a3.007 3.007 0 0 0-2.088-2.088c-1.87-.501-9.396-.501-9.396-.501s-7.507-.01-9.396.501A3.007 3.007 0 0 0 .527 6.205a31.247 31.247 0 0 0-.522 5.805 31.247 31.247 0 0 0 .522 5.783 3.007 3.007 0 0 0 2.088 2.088c1.868.502 9.396.502 9.396.502s7.506 0 9.396-.502a3.007 3.007 0 0 0 2.088-2.088 31.247 31.247 0 0 0 .5-5.783 31.247 31.247 0 0 0-.5-5.805zM9.609 15.601V8.408l6.264 3.602z"/></svg>
                        </a>
                    </#if>

                    <#-- Auth (desktop only) -->
                    <div class="hidden md:flex items-center gap-2">
                        <#if session??>
                            <#-- User dropdown -->
                            <div class="relative" id="user-dropdown-wrapper">
                                <button
                                    id="user-dropdown-btn"
                                    onclick="toggleUserDropdown()"
                                    class="flex items-center gap-1.5 bg-green-800 hover:bg-green-900 text-white px-3 py-1.5 rounded-md text-sm font-medium focus:outline-none whitespace-nowrap">
                                    👤 ${session.username}
                                    <svg class="w-3.5 h-3.5 ml-0.5 opacity-75" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M19 9l-7 7-7-7"/>
                                    </svg>
                                </button>
                                <div id="user-dropdown-menu"
                                    class="hidden absolute right-0 mt-1 w-44 bg-white rounded-xl shadow-lg border border-gray-100 py-1 z-50">
                                    <a href="/profile"
                                        class="flex items-center gap-2 px-4 py-2.5 text-sm text-gray-700 hover:bg-green-50 hover:text-green-800">
                                        🪪 <#if msg??>${msg['nav_profile']!'Hồ Sơ'}<#else>Hồ Sơ</#if>
                                    </a>
                                    <#if session.role == "ADMIN">
                                    <a href="/config"
                                        class="flex items-center gap-2 px-4 py-2.5 text-sm text-gray-700 hover:bg-green-50 hover:text-green-800">
                                        ⚙️ <#if msg??>${msg['nav_config']!'Cấu Hình'}<#else>Cấu Hình</#if>
                                    </a>
                                    <a href="/audit"
                                        class="flex items-center gap-2 px-4 py-2.5 text-sm text-gray-700 hover:bg-green-50 hover:text-green-800">
                                        📋 <#if msg??>${msg['nav_audit']!'Nhật Ký'}<#else>Nhật Ký</#if>
                                    </a>
                                    </#if>
                                    <div class="border-t border-gray-100 my-1"></div>
                                    <a href="/logout"
                                        class="flex items-center gap-2 px-4 py-2.5 text-sm text-red-600 hover:bg-red-50">
                                        🚪 <#if msg??>${msg['nav_logout']!'Đăng Xuất'}<#else>Đăng Xuất</#if>
                                    </a>
                                </div>
                            </div>
                        <#else>
                            <a href="/login" class="text-green-100 hover:text-white px-2 py-2 rounded-md text-sm font-medium whitespace-nowrap"><#if msg??>${msg['nav_login']!'Login'}<#else>Login</#if></a>
                            <a href="/register" class="bg-green-600 text-white px-3 py-1.5 rounded-md text-sm font-medium hover:bg-green-500 whitespace-nowrap"><#if msg??>${msg['nav_register']!'Register'}<#else>Register</#if></a>
                        </#if>
                    </div>

                    <#-- Hamburger button (mobile only) -->
                    <button id="nav-toggle" class="md:hidden text-white p-1 rounded focus:outline-none" aria-label="Menu" onclick="document.getElementById('mobile-menu').classList.toggle('hidden')">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"/>
                        </svg>
                    </button>

                    <#-- Language toggle (far right) -->
                    <#if lang?? && lang == "en">
                        <a href="/lang/vi" class="hidden sm:inline text-xs bg-green-600 hover:bg-green-500 text-white px-2 py-1 rounded font-medium border border-green-400 whitespace-nowrap ml-2">🇻🇳 <#if msg??>${msg['lang_toggle']!'Tiếng Việt'}<#else>Tiếng Việt</#if></a>
                    <#else>
                        <a href="/lang/en" class="hidden sm:inline text-xs bg-green-600 hover:bg-green-500 text-white px-2 py-1 rounded font-medium border border-green-400 whitespace-nowrap ml-2">🇬🇧 <#if msg??>${msg['lang_toggle']!'English'}<#else>English</#if></a>
                    </#if>
                </div>
            </div>
        </div>

        <#-- Mobile menu -->
        <div id="mobile-menu" class="hidden md:hidden bg-green-800 px-4 pb-4 pt-2">
            <div class="flex flex-col space-y-1">
                <a href="/urgent-appeals" class="text-red-200 hover:text-white px-3 py-2 rounded-md text-sm font-semibold">🆘 <#if msg??>${msg['nav_urgent_appeals']!'Khẩn Cầu'}<#else>Khẩn Cầu</#if></a>
                <a href="/pets" class="text-green-100 hover:text-white px-3 py-2 rounded-md text-sm font-medium">🐾 <#if msg??>${msg['nav_pets']!'Các Bé'}<#else>Các Bé</#if></a>
                <a href="/donate" class="text-green-100 hover:text-white px-3 py-2 rounded-md text-sm font-medium">💚 <#if msg??>${msg['nav_donate']!'Động Viên'}<#else>Động Viên</#if></a>
                <#if session?? && session.role != "GUEST">
                    <a href="/rescues" class="text-green-100 hover:text-white px-3 py-2 rounded-md text-sm font-medium">🚨 <#if msg??>${msg['nav_rescue']!'Rescue'}<#else>Rescue</#if></a>
                </#if>
                <a href="<#if session??>/adoptions<#else>/register?redirect=/adoptions</#if>" class="text-green-100 hover:text-white px-3 py-2 rounded-md text-sm font-medium">🏠 <#if msg??>${msg['nav_adoptions']!'Nhận Nuôi'}<#else>Nhận Nuôi</#if></a>
                <div class="border-t border-green-700 pt-2 mt-1 flex flex-col space-y-1">
                    <#-- Social links in mobile -->
                    <#if siteConfig??>
                    <#assign fbUrlM = (siteConfig['social_facebook_url'])!''>
                    <#assign ytUrlM = (siteConfig['social_youtube_url'])!''>
                    <#else>
                    <#assign fbUrlM = ''>
                    <#assign ytUrlM = ''>
                    </#if>
                    <#if fbUrlM?has_content>
                        <a href="${fbUrlM}" target="_blank" rel="noopener noreferrer" class="text-green-100 hover:text-white px-3 py-2 rounded-md text-sm font-medium">📘 Facebook</a>
                    </#if>
                    <#if ytUrlM?has_content>
                        <a href="${ytUrlM}" target="_blank" rel="noopener noreferrer" class="text-green-100 hover:text-white px-3 py-2 rounded-md text-sm font-medium">▶️ YouTube</a>
                    </#if>
                    <#if lang?? && lang == "en">
                        <a href="/lang/vi" class="text-green-100 hover:text-white px-3 py-2 rounded-md text-sm font-medium">🇻🇳 <#if msg??>${msg['lang_toggle']!'Tiếng Việt'}<#else>Tiếng Việt</#if></a>
                    <#else>
                        <a href="/lang/en" class="text-green-100 hover:text-white px-3 py-2 rounded-md text-sm font-medium">🇬🇧 <#if msg??>${msg['lang_toggle']!'English'}<#else>English</#if></a>
                    </#if>
                    <#if session??>
                        <span class="text-green-200 text-xs px-3">👤 ${session.username} (${session.role})</span>
                        <a href="/profile" class="text-green-100 hover:text-white px-3 py-2 rounded-md text-sm font-medium">🪪 <#if msg??>${msg['nav_profile']!'Hồ Sơ'}<#else>Hồ Sơ</#if></a>
                        <#if session.role == "ADMIN">
                        <a href="/config" class="text-green-100 hover:text-white px-3 py-2 rounded-md text-sm font-medium">⚙️ <#if msg??>${msg['nav_config']!'Cấu Hình'}<#else>Cấu Hình</#if></a>
                        </#if>
                        <a href="/logout" class="text-red-300 hover:text-red-100 px-3 py-2 rounded-md text-sm font-medium">🚪 <#if msg??>${msg['nav_logout']!'Đăng Xuất'}<#else>Đăng Xuất</#if></a>
                    <#else>
                        <a href="/login" class="text-green-100 hover:text-white px-3 py-2 rounded-md text-sm font-medium"><#if msg??>${msg['nav_login']!'Login'}<#else>Login</#if></a>
                        <a href="/register" class="text-green-100 hover:text-white px-3 py-2 rounded-md text-sm font-medium"><#if msg??>${msg['nav_register']!'Register'}<#else>Register</#if></a>
                    </#if>
                </div>
            </div>
        </div>
    </nav>

    <main class="w-full py-4 sm:py-6">
        <#nested>
    </main>

    <footer class="bg-green-800 text-green-100 mt-8 sm:mt-12 py-6 sm:py-8">
        <div class="w-full px-4 text-center">
            <p class="text-sm sm:text-base">🌱 <#if msg??>${msg['footer_text']!'Pet Rescue System - Saving lives one paw at a time 🐾'}<#else>Pet Rescue System - Saving lives one paw at a time 🐾</#if></p>
        </div>
    </footer>

    <script>
    function toggleUserDropdown() {
        var menu = document.getElementById('user-dropdown-menu');
        if (menu) menu.classList.toggle('hidden');
    }
    document.addEventListener('click', function(e) {
        var wrapper = document.getElementById('user-dropdown-wrapper');
        var menu = document.getElementById('user-dropdown-menu');
        if (wrapper && menu && !wrapper.contains(e.target)) {
            menu.classList.add('hidden');
        }
    });
    </script>
</body>
</html>
</#macro>
