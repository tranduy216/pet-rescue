<#import "../layout/base.ftl" as layout>
<@layout.page title="${pet.name} - ${msg['site_name']!'Pet Rescue'}">
<div class="px-4">
    <a href="/pets" class="text-green-600 hover:text-green-800 mb-4 inline-block">${msg['pet_back']!'← Back to List'}</a>

    <div class="bg-white rounded-xl shadow-md overflow-hidden">
    <#-- Helper: extract YouTube video ID from watch or short URL -->
    <#assign hasImages = pet.mediaList?has_content>
    <#assign hasVideo = (pet.youtubeUrl!'')?has_content>

    <#if hasImages || hasVideo>
    <div>
        <#-- Tab buttons -->
        <div class="flex border-b border-gray-200 bg-gray-50">
            <#if hasImages>
            <button id="tab-images" onclick="showTab('images')"
                class="tab-btn px-6 py-3 text-sm font-medium text-green-700 border-b-2 border-green-600 focus:outline-none">
                ${msg['pet_tab_images']!'🖼️ Ảnh'}
            </button>
            </#if>
            <#if hasVideo>
            <button id="tab-videos" onclick="showTab('videos')"
                class="tab-btn px-6 py-3 text-sm font-medium text-gray-500 hover:text-green-700 border-b-2 border-transparent focus:outline-none">
                ${msg['pet_tab_videos']!'▶️ Video'}
            </button>
            </#if>
        </div>

        <#-- Images tab -->
        <#if hasImages>
        <div id="panel-images" class="tab-panel">
            <div class="flex overflow-x-auto gap-2 p-2 bg-gray-50">
                <#list pet.mediaList as media>
                <img src="${media.fileUrl}" alt="${pet.name}" class="h-64 w-auto rounded object-cover">
                </#list>
            </div>
        </div>
        </#if>

        <#-- Video tab -->
        <#if hasVideo>
        <#assign rawUrl = pet.youtubeUrl!''>
        <#-- Convert watch?v= or youtu.be/ to embed URL -->
        <#if rawUrl?contains("youtube.com/watch?v=")>
            <#assign videoId = rawUrl?keep_after("watch?v=")?keep_before("&")>
            <#assign embedUrl = "https://www.youtube.com/embed/" + videoId>
        <#elseif rawUrl?contains("youtu.be/")>
            <#assign videoId = rawUrl?keep_after("youtu.be/")?keep_before("?")>
            <#assign embedUrl = "https://www.youtube.com/embed/" + videoId>
        <#elseif rawUrl?contains("youtube.com/embed/")>
            <#assign embedUrl = rawUrl>
        <#else>
            <#assign embedUrl = rawUrl>
        </#if>
        <div id="panel-videos" class="tab-panel hidden">
            <div class="p-2 bg-gray-50">
                <div class="relative w-full" style="padding-top: 56.25%;">
                    <iframe src="${embedUrl}"
                        class="absolute inset-0 w-full h-full rounded"
                        frameborder="0"
                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                        allowfullscreen></iframe>
                </div>
            </div>
        </div>
        </#if>
    </div>
    <#else>
    <div class="h-64 bg-green-100 flex items-center justify-center">
        <span class="text-8xl"><#if pet.type == "DOG">🐕<#elseif pet.type == "CAT">🐈<#else>🐾</#if></span>
    </div>
    </#if>

        <div class="p-6">
            <div class="flex justify-between items-start mb-4">
                <h1 class="text-3xl font-bold text-green-800">${pet.name}</h1>
                <span class="px-3 py-1 rounded-full text-sm font-medium
                    <#if pet.status == 'JUST_RESCUED'>bg-orange-100 text-orange-800
                    <#elseif pet.status == 'UNDER_TREATMENT'>bg-yellow-100 text-yellow-800
                    <#elseif pet.status == 'READY_TO_ADOPT'>bg-green-100 text-green-800
                    <#elseif pet.status == 'ADOPT_REGISTERED'>bg-blue-100 text-blue-800
                    <#elseif pet.status == 'ADOPTED'>bg-indigo-100 text-indigo-800
                    <#elseif pet.status == 'CANNOT_ADOPT'>bg-gray-100 text-gray-800
                    <#elseif pet.status == 'GONE_AWAY'>bg-red-100 text-red-800
                    <#else>bg-yellow-100 text-yellow-800</#if>">
                    <#if pet.status == 'JUST_RESCUED'>${msg['pet_status_just_rescued']!'Just Rescued'}
                    <#elseif pet.status == 'UNDER_TREATMENT'>${msg['pet_status_under_treatment']!'Under Treatment'}
                    <#elseif pet.status == 'READY_TO_ADOPT'>${msg['pet_status_ready_to_adopt']!'Ready to Adopt'}
                    <#elseif pet.status == 'ADOPT_REGISTERED'>${msg['pet_status_adopt_registered']!'Adopt Registered'}
                    <#elseif pet.status == 'ADOPTED'>${msg['pet_status_adopted']!'Adopted'}
                    <#elseif pet.status == 'CANNOT_ADOPT'>${msg['pet_status_cannot_adopt']!'Cannot Adopt'}
                    <#elseif pet.status == 'GONE_AWAY'>${msg['pet_status_gone_away']!'Gone Away'}
                    <#else>${pet.status}</#if>
                </span>
            </div>

            <div class="grid grid-cols-2 gap-4 mb-6">
                <div><span class="font-medium text-gray-600">${msg['pet_detail_type']!'Type:'}</span> <span class="text-gray-800"><#if pet.type == 'DOG'>${msg['pet_type_dog']!'🐕 Dog'}<#elseif pet.type == 'CAT'>${msg['pet_type_cat']!'🐈 Cat'}<#else>${msg['pet_type_other']!'🐾 Other'}</#if></span></div>
                <#if pet.breed??><div><span class="font-medium text-gray-600">${msg['pet_detail_breed']!'Breed:'}</span> <span class="text-gray-800">${pet.breed}</span></div></#if>
                <#if pet.age??><div><span class="font-medium text-gray-600">${msg['pet_detail_age']!'Age:'}</span> <span class="text-gray-800">${pet.age} ${msg['pet_years_old']!'years old'}</span></div></#if>
                <#if pet.gender??><div><span class="font-medium text-gray-600">${msg['pet_detail_gender']!'Gender:'}</span> <span class="text-gray-800"><#if pet.gender == 'Male'>${msg['pet_gender_male']!'Male'}<#elseif pet.gender == 'Female'>${msg['pet_gender_female']!'Female'}<#else>${msg['pet_gender_unknown']!'Unknown'}</#if></span></div></#if>
            </div>

            <#if pet.description??>
            <div class="mb-6">
                <h2 class="text-lg font-semibold text-green-700 mb-2">${msg['pet_detail_about']!'About'} ${pet.name}</h2>
                <p class="text-gray-700">${pet.description}</p>
            </div>
            </#if>

            <div class="flex space-x-3">
                <#if session?? && pet.status == 'READY_TO_ADOPT'>
                <a href="/adoptions/request/${pet.id}" class="bg-green-600 text-white px-6 py-2 rounded-lg hover:bg-green-700">${msg['pet_request_adoption']!'🏠 Request Adoption'}</a>
                </#if>
                <#if session?? && (session.role == "ADMIN" || session.role == "VOLUNTEER")>
                <a href="/pets/${pet.id}/edit" class="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700">✏️ ${msg['btn_edit']!'Edit'}</a>
                </#if>
                <#if session?? && session.role == "ADMIN">
                <form method="POST" action="/pets/${pet.id}/delete" class="inline">
                    <button type="submit" class="bg-red-600 text-white px-4 py-2 rounded-lg hover:bg-red-700"
                        onclick="return confirm('${msg['pet_delete_confirm']!'Delete this pet?'}')">🗑️ ${msg['btn_delete']!'Delete'}</button>
                </form>
                </#if>
            </div>
        </div>
    </div>
</div>
<script>
function showTab(name) {
    document.querySelectorAll('.tab-panel').forEach(function(p) { p.classList.add('hidden'); });
    document.querySelectorAll('.tab-btn').forEach(function(b) {
        b.classList.remove('text-green-700', 'border-green-600');
        b.classList.add('text-gray-500', 'border-transparent');
    });
    var panel = document.getElementById('panel-' + name);
    var btn = document.getElementById('tab-' + name);
    if (panel) panel.classList.remove('hidden');
    if (btn) {
        btn.classList.remove('text-gray-500', 'border-transparent');
        btn.classList.add('text-green-700', 'border-green-600');
    }
}
</script>
</@layout.page>
