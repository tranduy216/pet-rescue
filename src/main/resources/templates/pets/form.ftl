<#import "../layout/base.ftl" as layout>
<@layout.page title="${(pet??)?then(msg['pet_form_edit']!'Edit Pet', msg['pet_form_add']!'Add Pet')} - ${msg['site_name']!'Pet Rescue'}">
<div class="max-w-2xl mx-auto mt-6">
    <div class="bg-white rounded-xl shadow-md p-8">
        <h1 class="text-2xl font-bold text-green-800 mb-6">${(pet??)?then(msg['pet_form_edit']!'Edit Pet', msg['pet_form_add']!'Add Pet')}</h1>
        <#if error??>
        <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">${error}</div>
        </#if>
        <form method="POST" action="/pets/<#if pet??>${pet.id}/edit<#else>new</#if>" enctype="multipart/form-data" class="space-y-4">
            <#if pet??><input type="hidden" name="version" value="${pet.version}"></#if>
            <div class="grid grid-cols-2 gap-4">
                <div class="col-span-2">
                    <label class="block text-sm font-medium text-gray-700 mb-1">${msg['pet_field_name']!'Name'} *</label>
                    <input type="text" name="name" value="${(pet.name)!''}" required
                        class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">${msg['pet_field_type']!'Type'} *</label>
                    <select name="type" class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500">
                        <option value="DOG" <#if (pet.type)! == 'DOG'>selected</#if>>${msg['pet_type_dog']!'🐕 Dog'}</option>
                        <option value="CAT" <#if (pet.type)! == 'CAT'>selected</#if>>${msg['pet_type_cat']!'🐈 Cat'}</option>
                        <option value="OTHER" <#if (pet.type)! == 'OTHER'>selected</#if>>${msg['pet_type_other']!'🐾 Other'}</option>
                    </select>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">${msg['pet_field_status']!'Status'}</label>
                    <select name="status" class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500">
                        <option value="JUST_RESCUED" <#if (pet.status)! == 'JUST_RESCUED'>selected</#if>>${msg['pet_status_just_rescued']!'Just Rescued'}</option>
                        <option value="UNDER_TREATMENT" <#if (pet.status)! == 'UNDER_TREATMENT'>selected</#if>>${msg['pet_status_under_treatment']!'Under Treatment'}</option>
                        <option value="READY_TO_ADOPT" <#if (pet.status)! == 'READY_TO_ADOPT'>selected</#if>>${msg['pet_status_ready_to_adopt']!'Ready to Adopt'}</option>
                        <option value="ADOPT_REGISTERED" <#if (pet.status)! == 'ADOPT_REGISTERED'>selected</#if>>${msg['pet_status_adopt_registered']!'Adopt Registered'}</option>
                        <option value="ADOPTED" <#if (pet.status)! == 'ADOPTED'>selected</#if>>${msg['pet_status_adopted']!'Adopted'}</option>
                        <option value="CANNOT_ADOPT" <#if (pet.status)! == 'CANNOT_ADOPT'>selected</#if>>${msg['pet_status_cannot_adopt']!'Cannot Adopt'}</option>
                        <option value="GONE_AWAY" <#if (pet.status)! == 'GONE_AWAY'>selected</#if>>${msg['pet_status_gone_away']!'Gone Away'}</option>
                    </select>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">${msg['pet_field_breed']!'Breed'}</label>
                    <input type="text" name="breed" value="${(pet.breed)!''}"
                        class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">${msg['pet_field_age']!'Age (years)'}</label>
                    <input type="number" name="age" value="${(pet.age)!''}" min="0"
                        class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">${msg['pet_field_gender']!'Gender'}</label>
                    <select name="gender" class="w-full border border-gray-300 rounded-lg px-3 py-2">
                        <option value="">${msg['pet_gender_unknown']!'Unknown'}</option>
                        <option value="Male" <#if (pet.gender)! == 'Male'>selected</#if>>${msg['pet_gender_male']!'Male'}</option>
                        <option value="Female" <#if (pet.gender)! == 'Female'>selected</#if>>${msg['pet_gender_female']!'Female'}</option>
                    </select>
                </div>
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">${msg['pet_field_description']!'Description'}</label>
                <textarea name="description" rows="4"
                    class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500">${(pet.description)!''}</textarea>
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">${msg['pet_field_photos']!'Photos'}</label>
                <input type="file" name="media" multiple accept="image/*"
                    class="w-full border border-gray-300 rounded-lg px-3 py-2">
                <#if pet?? && pet.mediaList?has_content>
                <div class="mt-2 flex flex-wrap gap-2">
                    <#list pet.mediaList as media>
                    <div class="relative">
                        <img src="${media.fileUrl}" class="h-20 w-20 object-cover rounded">
                        <form method="POST" action="/pets/${pet.id}/media/${media.id}/delete" class="inline">
                            <button type="submit" class="absolute top-0 right-0 bg-red-500 text-white rounded-full w-5 h-5 text-xs flex items-center justify-center hover:bg-red-700">×</button>
                        </form>
                    </div>
                    </#list>
                </div>
                </#if>
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">${msg['pet_field_youtube']!'YouTube Video'}</label>
                <input type="url" name="youtubeUrl" value="${(pet.youtubeUrl)!''}"
                    placeholder="${msg['pet_field_youtube_placeholder']!'https://www.youtube.com/watch?v=...'}"
                    class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500">
            </div>
            <div class="flex space-x-3">
                <button type="submit" class="bg-green-600 text-white px-6 py-2 rounded-lg hover:bg-green-700">${msg['btn_save']!'Save'}</button>
                <a href="/pets<#if pet??>/${pet.id}</#if>" class="bg-gray-200 text-gray-700 px-6 py-2 rounded-lg hover:bg-gray-300">${msg['btn_cancel']!'Cancel'}</a>
            </div>
        </form>
    </div>
</div>
</@layout.page>
