<#import "../layout/base.ftl" as layout>
<@layout.page title="Pets - Pet Rescue">
<div class="px-4">
    <div class="flex justify-between items-center mb-6">
        <h1 class="text-2xl font-bold text-green-800">🐾 Pets</h1>
        <#if session?? && (session.role == "ADMIN" || session.role == "VOLUNTEER")>
        <a href="/pets/new" class="bg-green-600 text-white px-4 py-2 rounded-lg hover:bg-green-700">+ Add Pet</a>
        </#if>
    </div>

    <div class="bg-white rounded-xl shadow-md p-4 mb-6">
        <form hx-get="/pets" hx-target="#pet-list" hx-trigger="input delay:500ms, change" class="flex flex-wrap gap-3">
            <input type="text" name="search" placeholder="Search by name..." value="${(search)!''}"
                class="border border-gray-300 rounded-lg px-3 py-2 flex-1 min-w-48 focus:outline-none focus:ring-2 focus:ring-green-500">
            <select name="type" class="border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500">
                <option value="">${msg['pet_type_all']!'All Types'}</option>
                <option value="DOG" <#if (type)! == 'DOG'>selected</#if>>${msg['pet_type_dog']!'🐕 Dog'}</option>
                <option value="CAT" <#if (type)! == 'CAT'>selected</#if>>${msg['pet_type_cat']!'🐈 Cat'}</option>
                <option value="OTHER" <#if (type)! == 'OTHER'>selected</#if>>${msg['pet_type_other']!'🐾 Other'}</option>
            </select>
            <select name="status" class="border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500">
                <option value="">${msg['pet_status_all']!'All Status'}</option>
                <option value="AVAILABLE" <#if (status)! == 'AVAILABLE'>selected</#if>>${msg['pet_status_available']!'Available'}</option>
                <option value="ADOPTED" <#if (status)! == 'ADOPTED'>selected</#if>>${msg['pet_status_adopted']!'Adopted'}</option>
                <option value="RESCUED" <#if (status)! == 'RESCUED'>selected</#if>>${msg['pet_status_rescued']!'Rescued'}</option>
            </select>
        </form>
    </div>

    <div id="pet-list">
        <#include "list_partial.ftl">
    </div>
</div>
</@layout.page>
