<#import "../layout/base.ftl" as layout>
<@layout.page title="${pet.name} - Pet Rescue">
<div class="px-4">
    <a href="/pets" class="text-green-600 hover:text-green-800 mb-4 inline-block">← Back to Pets</a>

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
                    ${pet.status}
                </span>
            </div>

            <div class="grid grid-cols-2 gap-4 mb-6">
                <div><span class="font-medium text-gray-600">Type:</span> <span class="text-gray-800">${pet.type}</span></div>
                <#if pet.breed??><div><span class="font-medium text-gray-600">Breed:</span> <span class="text-gray-800">${pet.breed}</span></div></#if>
                <#if pet.age??><div><span class="font-medium text-gray-600">Age:</span> <span class="text-gray-800">${pet.age} years</span></div></#if>
                <#if pet.gender??><div><span class="font-medium text-gray-600">Gender:</span> <span class="text-gray-800">${pet.gender}</span></div></#if>
            </div>

            <#if pet.description??>
            <div class="mb-6">
                <h2 class="text-lg font-semibold text-green-700 mb-2">About ${pet.name}</h2>
                <p class="text-gray-700">${pet.description}</p>
            </div>
            </#if>

            <div class="flex space-x-3">
                <#if session?? && pet.status == 'AVAILABLE'>
                <a href="/adoptions/request/${pet.id}" class="bg-green-600 text-white px-6 py-2 rounded-lg hover:bg-green-700">🏠 Request Adoption</a>
                </#if>
                <#if session?? && (session.role == "ADMIN" || session.role == "VOLUNTEER")>
                <a href="/pets/${pet.id}/edit" class="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700">✏️ Edit</a>
                </#if>
                <#if session?? && session.role == "ADMIN">
                <form method="POST" action="/pets/${pet.id}/delete" class="inline">
                    <button type="submit" class="bg-red-600 text-white px-4 py-2 rounded-lg hover:bg-red-700"
                        onclick="return confirm('Delete this pet?')">🗑️ Delete</button>
                </form>
                </#if>
            </div>
        </div>
    </div>
</div>
</@layout.page>
