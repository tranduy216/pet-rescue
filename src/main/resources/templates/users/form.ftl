<#import "../layout/base.ftl" as layout>
<@layout.page title="${(user??)?then('Edit', 'New')} User - Pet Rescue">
<div class="max-w-xl mx-auto mt-6">
    <div class="bg-white rounded-xl shadow-md p-8">
        <h1 class="text-2xl font-bold text-green-800 mb-6">${(user??)?then('Edit', 'New')} User</h1>
        <#if error??>
        <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">${error}</div>
        </#if>
        <form method="POST" action="/users/<#if user??>${user.id}/edit<#else>new</#if>" class="space-y-4">
            <#if !user??>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Username *</label>
                <input type="text" name="username" required
                    class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500">
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Password *</label>
                <input type="password" name="password" required
                    class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500">
            </div>
            </#if>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Full Name *</label>
                <input type="text" name="fullName" value="${(user.fullName)!''}" required
                    class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500">
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Email *</label>
                <input type="email" name="email" value="${(user.email)!''}" required
                    class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500">
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Phone</label>
                <input type="text" name="phone" value="${(user.phone)!''}"
                    class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500">
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Role</label>
                <select name="role" class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500">
                    <option value="USER" <#if (user.role)! == 'USER'>selected</#if>>USER</option>
                    <option value="VOLUNTEER" <#if (user.role)! == 'VOLUNTEER'>selected</#if>>VOLUNTEER</option>
                    <option value="ADMIN" <#if (user.role)! == 'ADMIN'>selected</#if>>ADMIN</option>
                </select>
            </div>
            <#if user??>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Active</label>
                <select name="isActive" class="w-full border border-gray-300 rounded-lg px-3 py-2">
                    <option value="true" <#if user.active>selected</#if>>Active</option>
                    <option value="false" <#if !user.active>selected</#if>>Inactive</option>
                </select>
            </div>
            </#if>
            <div class="flex space-x-3">
                <button type="submit" class="bg-green-600 text-white px-6 py-2 rounded-lg hover:bg-green-700">Save</button>
                <a href="/users" class="bg-gray-200 text-gray-700 px-6 py-2 rounded-lg hover:bg-gray-300">Cancel</a>
            </div>
        </form>
    </div>
</div>
</@layout.page>
