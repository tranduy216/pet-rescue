<#import "../layout/base.ftl" as layout>
<@layout.page title="Users - Pet Rescue">
<div class="px-4">
    <div class="flex justify-between items-center mb-6">
        <h1 class="text-2xl font-bold text-green-800">👥 Users</h1>
        <a href="/users/new" class="bg-green-600 text-white px-4 py-2 rounded-lg hover:bg-green-700">+ New User</a>
    </div>
    <div class="bg-white rounded-xl shadow overflow-hidden">
        <table class="w-full">
            <thead class="bg-green-700 text-white">
                <tr>
                    <th class="px-4 py-3 text-left text-sm">Name</th>
                    <th class="px-4 py-3 text-left text-sm">Username</th>
                    <th class="px-4 py-3 text-left text-sm">Email</th>
                    <th class="px-4 py-3 text-left text-sm">Role</th>
                    <th class="px-4 py-3 text-left text-sm">Status</th>
                    <th class="px-4 py-3 text-left text-sm">Actions</th>
                </tr>
            </thead>
            <tbody class="divide-y divide-gray-200">
                <#list users as user>
                <tr class="hover:bg-green-50">
                    <td class="px-4 py-3 text-sm">${user.fullName}</td>
                    <td class="px-4 py-3 text-sm">${user.username}</td>
                    <td class="px-4 py-3 text-sm">${user.email}</td>
                    <td class="px-4 py-3 text-sm">
                        <span class="px-2 py-1 rounded text-xs font-medium
                            <#if user.role == 'ADMIN'>bg-red-100 text-red-800
                            <#elseif user.role == 'VOLUNTEER'>bg-blue-100 text-blue-800
                            <#else>bg-gray-100 text-gray-800</#if>">
                            ${user.role}
                        </span>
                    </td>
                    <td class="px-4 py-3 text-sm">
                        <span class="px-2 py-1 rounded text-xs <#if user.isActive>bg-green-100 text-green-800<#else>bg-red-100 text-red-800</#if>">
                            <#if user.isActive>Active<#else>Inactive</#if>
                        </span>
                    </td>
                    <td class="px-4 py-3 text-sm space-x-2">
                        <a href="/users/${user.id}/edit" class="text-green-600 hover:text-green-800">Edit</a>
                        <form method="POST" action="/users/${user.id}/delete" class="inline">
                            <button type="submit" class="text-red-600 hover:text-red-800"
                                onclick="return confirm('Delete this user?')">Delete</button>
                        </form>
                    </td>
                </tr>
                </#list>
            </tbody>
        </table>
    </div>
</div>
</@layout.page>
