<#import "layout/base.ftl" as layout>
<@layout.page title="${msg['site_name']!'Pet Rescue'}">

<#-- ═══════════════════════════════════════════════════════════════ -->
<#-- HERO SECTION                                                    -->
<#-- ═══════════════════════════════════════════════════════════════ -->
<section class="relative overflow-hidden rounded-2xl mx-2 sm:mx-4 mt-4 mb-8 sm:mb-10 bg-gradient-to-br from-green-800 via-green-700 to-emerald-600 text-white shadow-2xl" style="min-height:360px;">
    <div class="absolute inset-0 opacity-10" style="background-image:url('https://images.unsplash.com/photo-1450778869180-41d0601e046e?w=1400&q=80');background-size:cover;background-position:center;"></div>
    <div class="relative z-10 flex flex-col items-center justify-center text-center py-14 sm:py-20 px-4 sm:px-8 lg:px-16">
        <div class="text-5xl sm:text-7xl mb-3 sm:mb-4 drop-shadow-lg">🐾</div>
        <h1 class="text-3xl sm:text-4xl lg:text-5xl font-extrabold mb-3 sm:mb-4 drop-shadow-md leading-tight">
            ${msg['home_hero_title']!'Yêu Thương & Bảo Vệ'}
        </h1>
        <p class="text-base sm:text-lg lg:text-xl max-w-xs sm:max-w-xl lg:max-w-2xl text-green-100 mb-8 sm:mb-10 leading-relaxed">
            ${msg['home_hero_subtitle']!'Chúng tôi giải cứu, chữa trị và tìm mái ấm cho những thú cưng cần giúp đỡ.'}
        </p>
        <div class="grid grid-cols-2 sm:flex sm:flex-wrap justify-center gap-3 sm:gap-4 w-full sm:w-auto">
            <a href="/register" class="flex items-center justify-center gap-1 sm:gap-2 bg-white text-green-800 font-bold px-4 sm:px-6 py-2.5 sm:py-3 rounded-full shadow hover:bg-green-100 transition-all text-sm sm:text-base">
                🙋 ${msg['home_btn_volunteer']!'Tình Nguyện'}
            </a>
            <a href="/donate" class="flex items-center justify-center gap-1 sm:gap-2 bg-yellow-400 text-green-900 font-bold px-4 sm:px-6 py-2.5 sm:py-3 rounded-full shadow hover:bg-yellow-300 transition-all text-sm sm:text-base">
                💝 ${msg['home_btn_donate']!'Đóng Góp'}
            </a>
            <a href="/pets" class="flex items-center justify-center gap-1 sm:gap-2 bg-emerald-500 text-white font-bold px-4 sm:px-6 py-2.5 sm:py-3 rounded-full shadow hover:bg-emerald-400 transition-all text-sm sm:text-base">
                🐶 ${msg['home_btn_browse_pets']!'Ngắm Các Bé'}
            </a>
            <a href="/finances" class="flex items-center justify-center gap-1 sm:gap-2 bg-green-900 text-white font-bold px-4 sm:px-6 py-2.5 sm:py-3 rounded-full shadow hover:bg-green-800 transition-all text-sm sm:text-base">
                📊 ${msg['home_btn_stats']!'Thống Kê'}
            </a>
        </div>
    </div>
</section>

<#-- ═══════════════════════════════════════════════════════════════ -->
<#-- STATS SECTION                                                   -->
<#-- ═══════════════════════════════════════════════════════════════ -->
<section class="px-2 sm:px-4 mb-8 sm:mb-12">
    <div class="grid grid-cols-2 lg:grid-cols-4 gap-3 sm:gap-4">
        <div class="bg-white rounded-2xl shadow-md p-4 sm:p-6 text-center border-t-4 border-green-500 hover:shadow-lg transition-shadow">
            <div class="text-3xl sm:text-4xl mb-1 sm:mb-2">🐶</div>
            <div class="text-3xl sm:text-4xl font-extrabold text-green-700">${statsAvailable!0}</div>
            <div class="text-xs sm:text-sm text-gray-500 mt-1 leading-tight">${msg['stats_available']!'Thú cưng đang có'}</div>
        </div>
        <div class="bg-white rounded-2xl shadow-md p-4 sm:p-6 text-center border-t-4 border-blue-500 hover:shadow-lg transition-shadow">
            <div class="text-3xl sm:text-4xl mb-1 sm:mb-2">🏠</div>
            <div class="text-3xl sm:text-4xl font-extrabold text-blue-600">${statsAdopted!0}</div>
            <div class="text-xs sm:text-sm text-gray-500 mt-1 leading-tight">${msg['stats_adopted']!'Đã nhận nuôi'}</div>
        </div>
        <div class="bg-white rounded-2xl shadow-md p-4 sm:p-6 text-center border-t-4 border-purple-500 hover:shadow-lg transition-shadow">
            <div class="text-3xl sm:text-4xl mb-1 sm:mb-2">💉</div>
            <div class="text-3xl sm:text-4xl font-extrabold text-purple-600">${statsTreated!0}</div>
            <div class="text-xs sm:text-sm text-gray-500 mt-1 leading-tight">${msg['stats_treated']!'Đã chữa trị'}</div>
        </div>
        <div class="bg-white rounded-2xl shadow-md p-4 sm:p-6 text-center border-t-4 border-red-400 hover:shadow-lg transition-shadow">
            <div class="text-3xl sm:text-4xl mb-1 sm:mb-2">❤️</div>
            <div class="text-3xl sm:text-4xl font-extrabold text-red-500">${statsDonors!0}</div>
            <div class="text-xs sm:text-sm text-gray-500 mt-1 leading-tight">${msg['stats_donors']!'Người đóng góp'}</div>
        </div>
    </div>
</section>

<#-- ═══════════════════════════════════════════════════════════════ -->
<#-- PET PANORAMA / SLIDER                                           -->
<#-- ═══════════════════════════════════════════════════════════════ -->
<#if pets?has_content>
<section class="px-2 sm:px-4 mb-8 sm:mb-12">
    <h2 class="text-xl sm:text-2xl font-bold text-green-800 mb-4 sm:mb-6 text-center">${msg['slider_title']!'Những Bé Đang Chờ Bạn'}</h2>

    <div class="relative overflow-hidden rounded-2xl">
        <div id="pet-slider" class="flex gap-3 sm:gap-4 transition-transform duration-500 ease-in-out" style="will-change:transform;">
            <#list pets as pet>
            <div class="flex-none w-48 sm:w-56 md:w-64 bg-white rounded-xl shadow-md overflow-hidden hover:shadow-xl transition-shadow">
                <#if pet.mediaList?has_content>
                    <img src="${pet.mediaList[0].fileUrl}" alt="${pet.name}" class="w-full h-36 sm:h-44 md:h-48 object-cover">
                <#else>
                    <div class="w-full h-36 sm:h-44 md:h-48 bg-gradient-to-br from-green-100 to-emerald-200 flex items-center justify-center">
                        <span class="text-5xl sm:text-7xl"><#if pet.type == "DOG">🐕<#elseif pet.type == "CAT">🐈<#else>🐾</#if></span>
                    </div>
                </#if>
                <div class="p-3 sm:p-4">
                    <h3 class="text-base sm:text-lg font-bold text-green-800 truncate">${pet.name}</h3>
                    <p class="text-xs sm:text-sm text-green-600 truncate">${pet.type}<#if pet.breed??> – ${pet.breed}</#if></p>
                    <#if pet.age??><p class="text-xs text-gray-500">${pet.age} ${msg['pet_years_old']!'tuổi'}</p></#if>
                    <a href="/pets/${pet.id}" class="mt-2 sm:mt-3 inline-block bg-green-600 text-white px-3 sm:px-4 py-1.5 sm:py-2 rounded-lg text-xs sm:text-sm hover:bg-green-700 w-full text-center">
                        Xem chi tiết →
                    </a>
                </div>
            </div>
            </#list>
        </div>

        <button onclick="slideMove(-1)"
            class="absolute left-1 sm:left-2 top-1/2 -translate-y-1/2 bg-white/90 hover:bg-white text-green-800 rounded-full w-8 h-8 sm:w-10 sm:h-10 flex items-center justify-center shadow-md text-lg sm:text-xl font-bold z-10 touch-manipulation">
            ‹
        </button>
        <button onclick="slideMove(1)"
            class="absolute right-1 sm:right-2 top-1/2 -translate-y-1/2 bg-white/90 hover:bg-white text-green-800 rounded-full w-8 h-8 sm:w-10 sm:h-10 flex items-center justify-center shadow-md text-lg sm:text-xl font-bold z-10 touch-manipulation">
            ›
        </button>
    </div>

    <#-- Dot indicators -->
    <div id="slider-dots" class="flex justify-center gap-2 mt-4"></div>

    <div class="text-center mt-4 sm:mt-6">
        <a href="/pets" class="inline-flex items-center gap-2 bg-green-600 text-white px-6 sm:px-8 py-2.5 sm:py-3 rounded-full font-semibold hover:bg-green-700 transition-all shadow-md text-sm sm:text-base">
            🐾 ${msg['slider_view_all']!'Xem Tất Cả'}
        </a>
    </div>
</section>
</#if>

<#-- ═══════════════════════════════════════════════════════════════ -->
<#-- VIDEO STORY SECTION                                             -->
<#-- ═══════════════════════════════════════════════════════════════ -->
<section class="px-2 sm:px-4 mb-8 sm:mb-12">
    <div class="bg-white rounded-2xl shadow-md overflow-hidden">
        <div class="flex flex-col md:flex-row">
            <div class="w-full md:w-1/2 bg-gray-900 flex items-center justify-center" style="min-height:220px;">
                <div class="w-full" style="aspect-ratio:16/9;">
                    <iframe class="w-full h-full"
                        src="https://www.youtube.com/embed/videoseries?list=PLbpi6ZahtOH6Ar_3GPy3workNMrCup5Ah"
                        title="Pet Rescue Stories"
                        frameborder="0"
                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                        allowfullscreen>
                    </iframe>
                </div>
            </div>
            <div class="w-full md:w-1/2 p-6 sm:p-8 flex flex-col justify-center">
                <div class="text-3xl sm:text-4xl mb-3 sm:mb-4">🎬</div>
                <h2 class="text-xl sm:text-2xl font-bold text-green-800 mb-3 sm:mb-4">${msg['video_title']!'Câu Chuyện Của Các Bé'}</h2>
                <p class="text-gray-600 leading-relaxed text-sm sm:text-base">${msg['video_subtitle']!'Mỗi thú cưng đều có một câu chuyện.'}</p>
                <div class="mt-5 sm:mt-6 flex flex-wrap gap-3">
                    <a href="/pets" class="bg-green-600 text-white px-4 sm:px-5 py-2 rounded-full text-sm font-semibold hover:bg-green-700">🐾 Nhận nuôi ngay</a>
                    <a href="/donate" class="border border-green-600 text-green-700 px-4 sm:px-5 py-2 rounded-full text-sm font-semibold hover:bg-green-50">💚 Ủng hộ chúng tôi</a>
                </div>
            </div>
        </div>
    </div>
</section>

<#-- ═══════════════════════════════════════════════════════════════ -->
<#-- STATION INTRODUCTION                                            -->
<#-- ═══════════════════════════════════════════════════════════════ -->
<section class="px-2 sm:px-4 mb-8 sm:mb-12">
    <div class="bg-gradient-to-br from-green-50 to-emerald-50 rounded-2xl p-6 sm:p-8 border border-green-200">
        <div class="text-center mb-6 sm:mb-8">
            <h2 class="text-2xl sm:text-3xl font-bold text-green-800 mb-3 sm:mb-4">${msg['station_title']!'Về Trạm Cứu Hộ'}</h2>
            <p class="text-gray-600 max-w-xs sm:max-w-xl md:max-w-3xl mx-auto leading-relaxed text-sm sm:text-base">${msg['station_text']!'Chúng tôi là trạm cứu hộ phi lợi nhuận.'}</p>
        </div>
        <div class="grid grid-cols-1 sm:grid-cols-3 gap-4 sm:gap-6">
            <div class="bg-white rounded-xl p-5 sm:p-6 shadow-sm text-center hover:shadow-md transition-shadow">
                <div class="text-3xl sm:text-4xl mb-2 sm:mb-3">🎯</div>
                <h3 class="font-bold text-green-800 mb-2 text-sm sm:text-base">${msg['station_mission_title']!'Sứ Mệnh'}</h3>
                <p class="text-gray-600 text-xs sm:text-sm">${msg['station_mission_text']!'Giải cứu, chữa trị và tìm mái ấm.'}</p>
            </div>
            <div class="bg-white rounded-xl p-5 sm:p-6 shadow-sm text-center hover:shadow-md transition-shadow">
                <div class="text-3xl sm:text-4xl mb-2 sm:mb-3">🌟</div>
                <h3 class="font-bold text-green-800 mb-2 text-sm sm:text-base">${msg['station_vision_title']!'Tầm Nhìn'}</h3>
                <p class="text-gray-600 text-xs sm:text-sm">${msg['station_vision_text']!'Một xã hội không thú cưng bị bỏ rơi.'}</p>
            </div>
            <div class="bg-white rounded-xl p-5 sm:p-6 shadow-sm text-center hover:shadow-md transition-shadow">
                <div class="text-3xl sm:text-4xl mb-2 sm:mb-3">🤝</div>
                <h3 class="font-bold text-green-800 mb-2 text-sm sm:text-base">${msg['station_volunteer_title']!'Tình Nguyện Viên'}</h3>
                <p class="text-gray-600 text-xs sm:text-sm">${msg['station_volunteer_text']!'Hơn 50 tình nguyện viên tận tâm.'}</p>
            </div>
        </div>
        <div class="text-center mt-6 sm:mt-8">
            <a href="/register" class="inline-flex items-center gap-2 bg-green-700 text-white px-6 sm:px-8 py-2.5 sm:py-3 rounded-full font-semibold hover:bg-green-800 transition-all shadow-md text-sm sm:text-base">
                🙋 ${msg['station_cta']!'Tham Gia Cùng Chúng Tôi'}
            </a>
        </div>
    </div>
</section>

<#-- ═══════════════════════════════════════════════════════════════ -->
<#-- LATEST BLOG NEWS                                                -->
<#-- ═══════════════════════════════════════════════════════════════ -->
<#if blogs?has_content>
<section class="px-2 sm:px-4 mb-8 sm:mb-12">
    <h2 class="text-xl sm:text-2xl font-bold text-green-800 mb-4 sm:mb-6">📝 ${(lang!'vi') == 'en'?then('Latest News', 'Tin Tức Mới Nhất')}</h2>
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4 sm:gap-6">
        <#list blogs as blog>
        <div class="bg-white rounded-xl shadow-md p-5 sm:p-6 hover:shadow-lg transition-shadow flex flex-col">
            <h3 class="text-base sm:text-lg font-bold text-green-800 mb-2">${blog.title}</h3>
            <p class="text-gray-600 text-xs sm:text-sm line-clamp-3 flex-1">${blog.content?substring(0, [blog.content?length, 150]?min)}<#if blog.content?length gt 150>...</#if></p>
            <a href="/blog/${blog.id}" class="mt-3 sm:mt-4 inline-block text-green-600 hover:text-green-800 text-sm font-semibold">Đọc thêm →</a>
        </div>
        </#list>
    </div>
</section>
</#if>

<#-- Slider JS with touch support -->
<script>
(function() {
    let current = 0;
    const slider = document.getElementById('pet-slider');
    const dotsContainer = document.getElementById('slider-dots');
    if (!slider) return;

    const cards = Array.from(slider.children);
    const totalCards = cards.length;

    function getCardWidth() {
        if (!cards[0]) return 200;
        return cards[0].offsetWidth + parseInt(getComputedStyle(slider).gap || '16');
    }

    function getVisible() {
        return Math.max(1, Math.floor(slider.parentElement.offsetWidth / getCardWidth()));
    }

    function getMaxStep() {
        return Math.max(0, totalCards - getVisible());
    }

    function update() {
        const offset = current * getCardWidth();
        slider.style.transform = 'translateX(-' + offset + 'px)';
        // update dots
        Array.from(dotsContainer.children).forEach(function(dot, i) {
            dot.className = i === current
                ? 'w-3 h-3 rounded-full bg-green-600 transition-colors'
                : 'w-3 h-3 rounded-full bg-green-200 transition-colors cursor-pointer';
        });
    }

    // Build dots
    for (let i = 0; i <= getMaxStep(); i++) {
        const dot = document.createElement('button');
        dot.className = i === 0 ? 'w-3 h-3 rounded-full bg-green-600' : 'w-3 h-3 rounded-full bg-green-200 cursor-pointer';
        dot.addEventListener('click', function() { current = i; update(); });
        dotsContainer.appendChild(dot);
    }

    window.slideMove = function(dir) {
        current = Math.max(0, Math.min(current + dir, getMaxStep()));
        update();
    };

    // Auto-play every 3.5 s
    var autoplay = setInterval(function() {
        current = current >= getMaxStep() ? 0 : current + 1;
        update();
    }, 3500);

    // Pause on hover/touch
    slider.parentElement.addEventListener('mouseenter', function() { clearInterval(autoplay); });
    slider.parentElement.addEventListener('touchstart', function() { clearInterval(autoplay); }, {passive:true});

    // Touch/swipe support
    var touchStartX = 0;
    slider.addEventListener('touchstart', function(e) { touchStartX = e.touches[0].clientX; }, {passive:true});
    slider.addEventListener('touchend', function(e) {
        var diff = touchStartX - e.changedTouches[0].clientX;
        if (Math.abs(diff) > 40) slideMove(diff > 0 ? 1 : -1);
    });

    // Recalculate on resize
    window.addEventListener('resize', function() { update(); });
})();
</script>
</@layout.page>
