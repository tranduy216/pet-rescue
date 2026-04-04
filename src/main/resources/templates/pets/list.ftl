<#import "../layout/base.ftl" as layout>
<@layout.page title="${msg['nav_pets']!'Pets'} - ${msg['site_name']!'Pet Rescue'}">
<div class="px-4">
    <div class="flex justify-between items-center mb-6">
        <h1 class="text-2xl font-bold text-green-800">🐾 ${msg['nav_pets']!'Pets'}</h1>
        <#if session?? && (session.role == "ADMIN" || session.role == "VOLUNTEER")>
        <a href="/pets/new" class="bg-green-600 text-white px-4 py-2 rounded-lg hover:bg-green-700">${msg['pet_add_btn']!'+ Add Pet'}</a>
        </#if>
    </div>

    <div class="bg-white rounded-xl shadow-md p-4 mb-6">
        <form method="get" action="/pets" id="pet-filter-form" class="flex flex-wrap gap-3">
            <input type="text" name="search" placeholder="${msg['pet_search_placeholder']!'Search by name...'}" value="${(search)!''}"
                onchange="this.form.submit()"
                class="border border-gray-300 rounded-lg px-3 py-2 flex-1 min-w-48 focus:outline-none focus:ring-2 focus:ring-green-500">
            <select name="type" onchange="this.form.submit()" class="border border-gray-300 rounded-lg px-2 py-1.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-500">
                <option value="">${msg['pet_type_all']!'All Types'}</option>
                <option value="DOG" <#if (type)! == 'DOG'>selected</#if>>${msg['pet_type_dog']!'🐕 Dog'}</option>
                <option value="CAT" <#if (type)! == 'CAT'>selected</#if>>${msg['pet_type_cat']!'🐈 Cat'}</option>
                <option value="OTHER" <#if (type)! == 'OTHER'>selected</#if>>${msg['pet_type_other']!'🐾 Other'}</option>
            </select>
            <select name="status" onchange="this.form.submit()" class="border border-gray-300 rounded-lg px-2 py-1.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-500">
                <option value="">${msg['pet_status_all']!'All Status'}</option>
                <option value="JUST_RESCUED" <#if (status)! == 'JUST_RESCUED'>selected</#if>>${msg['pet_status_just_rescued']!'Just Rescued'}</option>
                <option value="UNDER_TREATMENT" <#if (status)! == 'UNDER_TREATMENT'>selected</#if>>${msg['pet_status_under_treatment']!'Under Treatment'}</option>
                <option value="READY_TO_ADOPT" <#if (status)! == 'READY_TO_ADOPT'>selected</#if>>${msg['pet_status_ready_to_adopt']!'Ready to Adopt'}</option>
                <option value="ADOPT_REGISTERED" <#if (status)! == 'ADOPT_REGISTERED'>selected</#if>>${msg['pet_status_adopt_registered']!'Adopt Registered'}</option>
                <option value="ADOPTED" <#if (status)! == 'ADOPTED'>selected</#if>>${msg['pet_status_adopted']!'Adopted'}</option>
                <option value="CANNOT_ADOPT" <#if (status)! == 'CANNOT_ADOPT'>selected</#if>>${msg['pet_status_cannot_adopt']!'Cannot Adopt'}</option>
                <option value="GONE_AWAY" <#if (status)! == 'GONE_AWAY'>selected</#if>>${msg['pet_status_gone_away']!'Gone Away'}</option>
            </select>
        </form>
    </div>

    <div id="pet-list">
        <#include "list_partial.ftl">
    </div>
</div>
</@layout.page>
