<#macro page title="Pet Rescue">
<!DOCTYPE html>
<html lang="${lang!'vi'}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${title} 🐾</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        /* Smooth line-clamp support */
        .line-clamp-3 {
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
    </style>
</head>
<body class="min-h-screen bg-green-50">
    <nav class="bg-green-700 shadow-lg">
        <div class="max-w-7xl mx-auto px-3 sm:px-4 lg:px-8">
            <div class="flex h-14 sm:h-16 items-center">
                <#-- Logo (left) -->
                <a href="/" class="text-white text-lg sm:text-xl font-bold flex-shrink-0">
                    🌿 <#if msg??>${msg['site_name']!'Pet Rescue'}<#else>Pet Rescue</#if>
                </a>

                <#-- Desktop nav links (left-aligned after logo) -->
                <div class="hidden md:flex items-center space-x-1 lg:space-x-2 ml-4 lg:ml-6">
                    <a href="/pets" class="text-green-100 hover:text-white px-2 lg:px-3 py-2 rounded-md text-sm font-medium whitespace-nowrap">🐾 <#if msg??>${msg['nav_pets']!'Pets'}<#else>Pets</#if></a>
                    <a href="/blog" class="text-green-100 hover:text-white px-2 lg:px-3 py-2 rounded-md text-sm font-medium whitespace-nowrap">📝 <#if msg??>${msg['nav_blog']!'Blog'}<#else>Blog</#if></a>
                    <a href="/donate" class="text-green-100 hover:text-white px-2 lg:px-3 py-2 rounded-md text-sm font-medium whitespace-nowrap">💚 <#if msg??>${msg['nav_donate']!'Donate'}<#else>Donate</#if></a>
                    <#if session?? && session.role != "GUEST">
                        <a href="/rescues" class="text-green-100 hover:text-white px-2 lg:px-3 py-2 rounded-md text-sm font-medium whitespace-nowrap">🚨 <#if msg??>${msg['nav_rescue']!'Rescue'}<#else>Rescue</#if></a>
                        <a href="/adoptions" class="text-green-100 hover:text-white px-2 lg:px-3 py-2 rounded-md text-sm font-medium whitespace-nowrap">🏠 <#if msg??>${msg['nav_adoptions']!'Adoptions'}<#else>Adoptions</#if></a>
                    </#if>
                    <#if session?? && session.role == "ADMIN">
                        <a href="/users" class="text-green-100 hover:text-white px-2 lg:px-3 py-2 rounded-md text-sm font-medium whitespace-nowrap">👥 <#if msg??>${msg['nav_users']!'Users'}<#else>Users</#if></a>
                    </#if>
                    <a href="/donations" class="text-green-100 hover:text-white px-2 lg:px-3 py-2 rounded-md text-sm font-medium whitespace-nowrap">🤝 <#if msg??>${msg['nav_donations']!'Patrons'}<#else>Patrons</#if></a>
                </div>

                <#-- Right side: auth + hamburger -->
                <div class="flex items-center gap-2 ml-auto">
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
                <a href="/pets" class="text-green-100 hover:text-white px-3 py-2 rounded-md text-sm font-medium">🐾 <#if msg??>${msg['nav_pets']!'Pets'}<#else>Pets</#if></a>
                <a href="/blog" class="text-green-100 hover:text-white px-3 py-2 rounded-md text-sm font-medium">📝 <#if msg??>${msg['nav_blog']!'Blog'}<#else>Blog</#if></a>
                <a href="/donate" class="text-green-100 hover:text-white px-3 py-2 rounded-md text-sm font-medium">💚 <#if msg??>${msg['nav_donate']!'Donate'}<#else>Donate</#if></a>
                <#if session?? && session.role != "GUEST">
                    <a href="/rescues" class="text-green-100 hover:text-white px-3 py-2 rounded-md text-sm font-medium">🚨 <#if msg??>${msg['nav_rescue']!'Rescue'}<#else>Rescue</#if></a>
                    <a href="/adoptions" class="text-green-100 hover:text-white px-3 py-2 rounded-md text-sm font-medium">🏠 <#if msg??>${msg['nav_adoptions']!'Adoptions'}<#else>Adoptions</#if></a>
                </#if>
                <#if session?? && session.role == "ADMIN">
                    <a href="/users" class="text-green-100 hover:text-white px-3 py-2 rounded-md text-sm font-medium">👥 <#if msg??>${msg['nav_users']!'Users'}<#else>Users</#if></a>
                </#if>
                <a href="/donations" class="text-green-100 hover:text-white px-3 py-2 rounded-md text-sm font-medium">🤝 <#if msg??>${msg['nav_donations']!'Patrons'}<#else>Patrons</#if></a>
                <div class="border-t border-green-700 pt-2 mt-1 flex flex-col space-y-1">
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

    <main class="max-w-7xl mx-auto py-4 sm:py-6 px-0 sm:px-2 lg:px-4">
        <#nested>
    </main>

    <footer class="bg-green-800 text-green-100 mt-8 sm:mt-12 py-6 sm:py-8">
        <div class="max-w-7xl mx-auto px-4 text-center">
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
