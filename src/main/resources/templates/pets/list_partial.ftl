<#if pets?has_content>
<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
    <#list pets as pet>
    <div class="bg-white rounded-lg shadow-md overflow-hidden hover:shadow-lg transition-shadow">
        <#if pet.mediaList?has_content>
            <img src="${pet.mediaList[0].fileUrl}" alt="${pet.name}" class="w-full h-48 object-cover">
        <#else>
            <div class="w-full h-48 bg-green-100 flex items-center justify-center">
                <span class="text-6xl"><#if pet.type == "DOG">🐕<#elseif pet.type == "CAT">🐈<#else>🐾</#if></span>
            </div>
        </#if>
        <div class="p-4">
            <div class="flex justify-between items-start">
                <h3 class="text-lg font-bold text-green-800">${pet.name}</h3>
                <span class="text-xs px-2 py-1 rounded
                    <#if pet.status == 'AVAILABLE'>bg-green-100 text-green-800
                    <#elseif pet.status == 'ADOPTED'>bg-blue-100 text-blue-800
                    <#else>bg-yellow-100 text-yellow-800</#if>">
                    <#if pet.status == 'AVAILABLE'>${msg['pet_status_available']!'Available'}
                    <#elseif pet.status == 'ADOPTED'>${msg['pet_status_adopted']!'Adopted'}
                    <#else>${msg['pet_status_rescued']!'Rescued'}</#if>
                </span>
            </div>
            <p class="text-sm text-green-600"><#if pet.type == 'DOG'>${msg['pet_type_dog']!'🐕 Dog'}<#elseif pet.type == 'CAT'>${msg['pet_type_cat']!'🐈 Cat'}<#else>${msg['pet_type_other']!'🐾 Other'}</#if><#if pet.breed??> - ${pet.breed}</#if></p>
            <#if pet.age??><p class="text-sm text-gray-500">${pet.age} ${msg['pet_years_old']!'years old'}</p></#if>
            <#if pet.gender??><p class="text-sm text-gray-500"><#if pet.gender == 'Male'>${msg['pet_gender_male']!'Male'}<#elseif pet.gender == 'Female'>${msg['pet_gender_female']!'Female'}<#else>${msg['pet_gender_unknown']!'Unknown'}</#if></p></#if>
            <div class="mt-3 flex space-x-2">
                <a href="/pets/${pet.id}" class="flex-1 text-center bg-green-600 text-white px-3 py-1.5 rounded text-sm hover:bg-green-700">${msg['btn_view']!'View'}</a>
                <#if session?? && pet.status == 'AVAILABLE'>
                <a href="/adoptions/request/${pet.id}" class="flex-1 text-center bg-green-100 text-green-800 px-3 py-1.5 rounded text-sm hover:bg-green-200">${msg['btn_adopt']!'Adopt'}</a>
                </#if>
            </div>
        </div>
    </div>
    </#list>
</div>
<#else>
<div class="text-center py-12 text-gray-500">
    <p class="text-4xl mb-4">🐾</p>
    <p>${msg['pet_empty']!'No pets found.'}</p>
</div>
</#if>
