<#import "../layout/base.ftl" as layout>
<@layout.page title="${pet.name} - ${msg['site_name']!'Pet Rescue'}">
<div class="px-4">
    <a href="/pets" class="text-green-600 hover:text-green-800 mb-4 inline-block">${msg['pet_back']!'← Back to List'}</a>

    <div class="bg-white rounded-xl shadow-md overflow-hidden">
        <#if pet.mediaList?has_content>
        <div class="flex overflow-x-auto gap-2 p-2 bg-gray-50">
            <#list pet.mediaList as media>
            <img src="${media.fileUrl}" alt="${pet.name}" class="h-64 w-auto rounded object-cover">
            </#list>
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
                    <#if pet.status == 'AVAILABLE'>bg-green-100 text-green-800
                    <#elseif pet.status == 'ADOPTED'>bg-blue-100 text-blue-800
                    <#else>bg-yellow-100 text-yellow-800</#if>">
                    <#if pet.status == 'AVAILABLE'>${msg['pet_status_available']!'Available'}
                    <#elseif pet.status == 'ADOPTED'>${msg['pet_status_adopted']!'Adopted'}
                    <#else>${msg['pet_status_rescued']!'Rescued'}</#if>
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
                <h2 class="text-lg font-semibold text-green-700 mb-2">${pet.name}</h2>
                <p class="text-gray-700">${pet.description}</p>
            </div>
            </#if>

            <div class="flex space-x-3">
                <#if session?? && pet.status == 'AVAILABLE'>
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
</@layout.page>
