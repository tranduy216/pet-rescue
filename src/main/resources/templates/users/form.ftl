<#import "../layout/base.ftl" as layout>
<@layout.page title="${(user??)?then(msg['user_form_edit']!'Edit User', msg['user_form_add']!'New User')} - ${msg['site_name']!'Pet Rescue'}">
<div class="max-w-xl mx-auto mt-6">
    <div class="bg-white rounded-xl shadow-md p-8">
        <h1 class="text-2xl font-bold text-green-800 mb-6">${(user??)?then(msg['user_form_edit']!'Edit User', msg['user_form_add']!'New User')}</h1>
        <#if error??>
        <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">${error}</div>
        </#if>
        <form method="POST" action="/users/<#if user??>${user.id}/edit<#else>new</#if>" class="space-y-4">
            <#if !user??>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">${msg['user_field_username']!'Username'} *</label>
                <input type="text" name="username" required
                    class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500">
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">${msg['user_field_password']!'Password'} *</label>
                <input type="password" name="password" required
                    class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500">
            </div>
            </#if>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">${msg['user_field_fullname']!'Full Name'} *</label>
                <input type="text" name="fullName" value="${(user.fullName)!''}" required
                    class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500">
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">${msg['user_field_email']!'Email'} *</label>
                <input type="email" name="email" value="${(user.email)!''}" required
                    class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500">
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">${msg['user_field_phone']!'Phone'}</label>
                <input type="text" name="phone" value="${(user.phone)!''}"
                    class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500">
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">${msg['user_field_role']!'Role'}</label>
                <select name="role" class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500">
                    <option value="USER" <#if (user.role)! == 'USER'>selected</#if>>${msg['role_user']!'USER'}</option>
                    <option value="VOLUNTEER" <#if (user.role)! == 'VOLUNTEER'>selected</#if>>${msg['role_volunteer']!'VOLUNTEER'}</option>
                    <option value="ADMIN" <#if (user.role)! == 'ADMIN'>selected</#if>>${msg['role_admin']!'ADMIN'}</option>
                </select>
            </div>
            <#if user??>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">${msg['user_field_active']!'Active'}</label>
                <select name="isActive" class="w-full border border-gray-300 rounded-lg px-3 py-2">
                    <option value="true" <#if user.active>selected</#if>>${msg['status_active']!'Active'}</option>
                    <option value="false" <#if !user.active>selected</#if>>${msg['status_inactive']!'Inactive'}</option>
                </select>
            </div>
            </#if>
            <div class="flex space-x-3">
                <button type="submit" class="bg-green-600 text-white px-6 py-2 rounded-lg hover:bg-green-700">${msg['btn_save']!'Save'}</button>
                <a href="/users" class="bg-gray-200 text-gray-700 px-6 py-2 rounded-lg hover:bg-gray-300">${msg['btn_cancel']!'Cancel'}</a>
            </div>
        </form>
    </div>
</div>
</@layout.page>
