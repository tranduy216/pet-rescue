<#import "layout/base.ftl" as layout>
<#import "layout/macros.ftl" as macros>
<@layout.page title="${msg['site_name']!'Pet Rescue'}">

<#-- ═══════════════════════════════════════════════════════════════ -->
<#-- HERO SECTION                                                    -->
<#-- ═══════════════════════════════════════════════════════════════ -->
<section class="relative overflow-hidden -mt-4 sm:-mt-6 mb-8 sm:mb-10 bg-gradient-to-br from-green-800 via-green-700 to-emerald-600 text-white shadow-2xl min-h-56">
    <div class="absolute inset-0 opacity-10" style="background-image:url('https://images.unsplash.com/photo-1450778869180-41d0601e046e?w=1400&q=80');background-size:cover;background-position:center;"></div>
    <div class="relative z-10 flex flex-col items-center justify-center text-center py-6 sm:py-8 px-4 sm:px-8 lg:px-16">
        <div class="text-5xl sm:text-7xl mb-3 sm:mb-4 drop-shadow-lg">🐾</div>
        <h1 class="text-3xl sm:text-4xl lg:text-5xl font-extrabold mb-3 sm:mb-4 drop-shadow-md leading-tight">
            <#if lang == 'en'>
                <#if siteConfig?? && ((siteConfig['homepage_title_en'])!'')?has_content>${siteConfig['homepage_title_en']}<#else>${msg['home_hero_title']!'Love & Protect'}</#if>
            <#else>
                <#if siteConfig?? && ((siteConfig['homepage_title_vi'])!'')?has_content>${siteConfig['homepage_title_vi']}<#else>${msg['home_hero_title']!'Yêu Thương & Bảo Vệ'}</#if>
            </#if>
        </h1>
        <p class="text-base sm:text-lg lg:text-xl max-w-xs sm:max-w-xl lg:max-w-2xl text-green-100 mb-6 sm:mb-8 leading-relaxed">
            <#if lang == 'en'>
                <#if siteConfig?? && ((siteConfig['homepage_subtitle_en'])!'')?has_content>${siteConfig['homepage_subtitle_en']}<#else>${msg['home_hero_subtitle']!'We rescue, treat, and rehome pets in need.'}</#if>
            <#else>
                <#if siteConfig?? && ((siteConfig['homepage_subtitle_vi'])!'')?has_content>${siteConfig['homepage_subtitle_vi']}<#else>${msg['home_hero_subtitle']!'Chúng tôi giải cứu, chữa trị và tìm mái ấm cho những thú cưng cần giúp đỡ.'}</#if>
            </#if>
        </p>
        <div class="grid grid-cols-2 sm:flex sm:flex-wrap justify-center gap-3 sm:gap-4 w-full sm:w-auto">
            <a href="/pets" class="flex items-center justify-center gap-1 sm:gap-2 bg-emerald-500 text-white font-bold px-4 sm:px-6 py-2.5 sm:py-3 rounded-full shadow hover:bg-emerald-400 transition-all text-sm sm:text-base">
                🐶 ${msg['home_btn_browse_pets']!'Ngắm Các Bé'}
            </a>
            <a href="/donate" class="flex items-center justify-center gap-1 sm:gap-2 bg-yellow-400 text-green-900 font-bold px-4 sm:px-6 py-2.5 sm:py-3 rounded-full shadow hover:bg-yellow-300 transition-all text-sm sm:text-base">
                💝 ${msg['home_btn_donate']!'Động Viên'}
            </a>
            <#if session??>
            <a href="/rescues/new" class="flex items-center justify-center gap-1 sm:gap-2 bg-red-500 text-white font-bold px-4 sm:px-6 py-2.5 sm:py-3 rounded-full shadow hover:bg-red-400 transition-all text-sm sm:text-base">
                🚨 ${msg['home_btn_report_rescue']!'Báo Cứu Hộ'}
            </a>
            <#else>
            <a href="/register?redirect=/rescues/new" class="flex items-center justify-center gap-1 sm:gap-2 bg-red-500 text-white font-bold px-4 sm:px-6 py-2.5 sm:py-3 rounded-full shadow hover:bg-red-400 transition-all text-sm sm:text-base">
                🚨 ${msg['home_btn_report_rescue']!'Báo Cứu Hộ'}
            </a>
            </#if>
            <a href="/adoptions" class="flex items-center justify-center gap-1 sm:gap-2 bg-white text-green-800 font-bold px-4 sm:px-6 py-2.5 sm:py-3 rounded-full shadow hover:bg-green-100 transition-all text-sm sm:text-base">
                🏠 ${msg['home_btn_adopt']!'Nhận Nuôi'}
            </a>
        </div>
    </div>
</section>

<#-- ═══════════════════════════════════════════════════════════════ -->
<#-- URGENT APPEALS SECTION                                          -->
<#-- ═══════════════════════════════════════════════════════════════ -->
<#if urgentAppeals?? && urgentAppeals?has_content>
<section class="px-2 sm:px-4 mb-8 sm:mb-10">
    <h2 class="text-xl font-bold text-red-700 mb-4">🆘 ${msg['home_urgent_appeals_title']!'Đang Cần Hỗ Trợ Khẩn Cấp'}</h2>
    <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
        <#list urgentAppeals as appeal>
        <#assign prog = appeal.currentProgress>
        <#assign progText = macros.progressTextColor(prog)>
        <div class="bg-white rounded-2xl shadow-md border-t-4 border-red-400 overflow-hidden hover:shadow-lg transition-shadow flex flex-col">
            <a href="/urgent-appeals/${appeal.id}" class="block">
                <#if appeal.images?has_content>
                <div style="aspect-ratio:16/9;" class="overflow-hidden">
                    <img src="${appeal.images[0]}" alt="${appeal.title?html}" class="w-full h-full object-cover">
                </div>
                <#else>
                <div style="aspect-ratio:16/9;" class="bg-red-50 flex items-center justify-center text-4xl">🆘</div>
                </#if>
                <div class="p-4">
                    <h3 class="font-bold text-gray-800 text-sm mb-1 line-clamp-2">${appeal.title?html}</h3>
                    <p class="text-xs text-gray-500 mb-2 line-clamp-2">${appeal.content?html}</p>
                    <div class="flex justify-between text-xs mb-1">
                        <span class="text-gray-500">${msg['urgent_appeal_detail_progress']!'Tiến Độ'}</span>
                        <span class="${progText} font-bold">${prog}%</span>
                    </div>
                    <@macros.progressBar prog=prog label="${appeal.amount?string['###,###,###']} VNĐ" height="h-6"/>
                </div>
            </a>
            <div class="px-4 pb-4 mt-auto">
                <button onclick="followAppeal(${appeal.id}, this)"
                        data-appeal-id="${appeal.id}"
                        class="follow-btn w-full py-1.5 text-xs font-medium rounded-lg border border-red-400 text-red-600 hover:bg-red-50 transition-colors">
                    🔔 ${msg['appeal_follow_btn']!'Theo dõi'}
                </button>
            </div>
        </div>
        </#list>

        <#-- QR box -->
        <div class="bg-white rounded-2xl shadow-md border-t-4 border-green-500 p-4 flex flex-col items-center justify-center text-center gap-2">
            <h3 class="font-bold text-green-800 text-sm">💚 ${msg['home_urgent_appeals_qr_title']!'Ủng Hộ Ngay'}</h3>
            <img src="/static/qr-station.png" alt="QR" class="w-full max-w-[220px] object-contain rounded-lg cursor-pointer hover:opacity-80 transition-opacity"
                onclick="document.getElementById('qr-popup').style.display='flex'"
                onerror="this.style.display='none';this.nextElementSibling.style.display='flex'">
            <div style="display:none" class="w-full max-w-[220px] aspect-square border-2 border-dashed border-gray-300 rounded-xl flex flex-col items-center justify-center text-gray-400 text-xs gap-1">
                <span class="text-3xl">📷</span><span>QR</span>
            </div>
            <p class="text-xs text-gray-400">🔍 ${msg['home_urgent_appeals_qr_zoom']!'Nhấn để phóng to'}</p>
        </div>
    </div>
</section>
</#if>

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
            <div class="text-xs sm:text-sm text-gray-500 mt-1 leading-tight">${msg['stats_donors']!'Người động viên'}</div>
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
                <div style="aspect-ratio:16/9;" class="overflow-hidden">
                <#if pet.mediaList?has_content>
                    <img src="${pet.mediaList[0].fileUrl}" alt="${pet.name}" class="w-full h-full object-cover">
                <#else>
                    <div class="w-full h-full bg-gradient-to-br from-green-100 to-emerald-200 flex items-center justify-center">
                        <span class="text-5xl sm:text-7xl"><#if pet.type == "DOG">🐕<#elseif pet.type == "CAT">🐈<#else>🐾</#if></span>
                    </div>
                </#if>
                </div>
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
                        src="<#if siteConfig?? && siteConfig['homepage_video_url']??>${siteConfig['homepage_video_url']?html}<#else>https://www.youtube.com/embed/videoseries?list=PLbpi6ZahtOH6Ar_3GPy3workNMrCup5Ah</#if>"
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
<#-- RECENTLY RESCUED ANIMALS                                        -->
<#-- ═══════════════════════════════════════════════════════════════ -->
<#if recentPets?has_content>
<section class="px-2 sm:px-4 mb-8 sm:mb-12">
    <div class="text-center mb-6">
        <h2 class="text-xl sm:text-2xl font-bold text-green-800 mb-2">🐾 ${msg['recent_pets_title']!'Các Bé Vừa Được Giải Cứu'}</h2>
        <p class="text-gray-500 text-sm sm:text-base">${msg['recent_pets_subtitle']!'Những chú thú cưng mới nhất đang cần sự quan tâm của bạn.'}</p>
    </div>
    <div class="grid grid-cols-1 sm:grid-cols-3 gap-4 sm:gap-6">
        <#list recentPets as pet>
        <a href="/pets/${pet.id}" class="block bg-white rounded-2xl shadow-md overflow-hidden hover:shadow-xl transition-shadow group">
            <div style="aspect-ratio:16/9;" class="overflow-hidden">
            <#if pet.mediaList?has_content>
                <img src="${pet.mediaList[0].fileUrl}" alt="${pet.name}" class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300">
            <#else>
                <div class="w-full h-full bg-gradient-to-br from-green-100 to-emerald-200 flex items-center justify-center">
                    <span class="text-7xl"><#if pet.type == "DOG">🐕<#elseif pet.type == "CAT">🐈<#else>🐾</#if></span>
                </div>
            </#if>
            </div>
            <div class="p-4 sm:p-5">
                <h3 class="text-lg font-bold text-green-800 mb-1 truncate">${pet.name}</h3>
                <p class="text-sm text-green-600 mb-2 truncate">${pet.type}<#if pet.breed??> – ${pet.breed}</#if><#if pet.age??> · ${pet.age} ${msg['pet_years_old']!'tuổi'}</#if></p>
                <#if pet.description??>
                <p class="text-xs sm:text-sm text-gray-500 line-clamp-3">${pet.description?substring(0, [pet.description?length, 120]?min)}<#if pet.description?length gt 120>...</#if></p>
                </#if>
                <span class="mt-3 inline-block text-green-600 hover:text-green-800 text-sm font-semibold">${msg['recent_pets_view_detail']!'Xem chi tiết →'}</span>
            </div>
        </a>
        </#list>
    </div>
</section>
</#if>

<#-- ═══════════════════════════════════════════════════════════════ -->
<#-- COMMUNITY WISHES                                                -->
<#-- ═══════════════════════════════════════════════════════════════ -->
<#if approvedWishes?has_content>
<section class="px-2 sm:px-4 mb-8 sm:mb-12">
    <div class="text-center mb-6">
        <h2 class="text-xl sm:text-2xl font-bold text-green-800 mb-2">${msg['wish_section_title']!'💌 Lời Chúc Từ Cộng Đồng'}</h2>
        <p class="text-gray-500 text-sm sm:text-base">${msg['wish_section_subtitle']!'Những lời động viên ấm áp từ mọi người dành cho trạm cứu hộ'}</p>
    </div>
    <div class="grid grid-cols-1 sm:grid-cols-3 gap-4 sm:gap-6">
        <#list approvedWishes as wish>
        <div class="bg-white rounded-2xl shadow-md p-6 flex flex-col justify-between border-l-4 border-green-400">
            <p class="text-gray-700 text-sm sm:text-base leading-relaxed italic mb-4">"${(wish.message)!''?html}"</p>
            <p class="text-green-700 font-semibold text-sm text-right">${msg['home_wishes_from']!'— '}${wish.donorName?html}</p>
        </div>
        </#list>
    </div>
</section>
</#if>

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

<#-- QR Popup Modal -->
<div id="qr-popup" style="display:none" class="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-70"
    onclick="this.style.display='none'">
    <div class="relative" onclick="event.stopPropagation()">
        <button class="absolute -top-3 -right-3 bg-white rounded-full w-8 h-8 flex items-center justify-center shadow-lg text-gray-600 hover:text-gray-900 text-lg font-bold"
            onclick="document.getElementById('qr-popup').style.display='none'">✕</button>
        <img src="/static/qr-station.png" alt="QR" class="max-w-xs sm:max-w-md rounded-2xl shadow-2xl"
            onerror="this.style.display='none'">
    </div>
</div>

<#-- Follow toast -->
<div id="follow-toast" style="display:none"
    class="fixed bottom-6 left-1/2 -translate-x-1/2 bg-gray-800 text-white text-sm px-5 py-2.5 rounded-full shadow-xl z-50 transition-opacity"></div>

<#-- Firebase web push for appeal follow -->
<#if firebaseConfig?? && (firebaseConfig['apiKey'])?has_content>
<#include "urgent-appeals/follow-script.ftl">
</#if>
</@layout.page>
