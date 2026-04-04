<#import "../layout/base.ftl" as layout>
<@layout.page title="${msg['user_page_title']!'Users'} - ${msg['site_name']!'Pet Rescue'}">
<div class="px-4">
    <div class="flex justify-between items-center mb-6">
        <h1 class="text-2xl font-bold text-green-800">${msg['user_page_title']!'👥 Users'}</h1>
        <a href="/users/new" class="bg-green-600 text-white px-4 py-2 rounded-lg hover:bg-green-700">${msg['user_add_btn']!'+ New User'}</a>
    </div>
    <div class="bg-white rounded-xl shadow-md p-4 mb-6">
        <form method="get" action="/users" class="flex flex-wrap gap-3">
            <select name="role" onchange="this.form.submit()" class="border border-gray-300 rounded-lg px-2 py-1.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-500">
                <option value="">${msg['user_filter_role_all']!'Tất Cả Vai Trò'}</option>
                <option value="ADMIN" <#if (role)! == 'ADMIN'>selected</#if>>${msg['role_admin']!'Admin'}</option>
                <option value="VOLUNTEER" <#if (role)! == 'VOLUNTEER'>selected</#if>>${msg['role_volunteer']!'Volunteer'}</option>
                <option value="USER" <#if (role)! == 'USER'>selected</#if>>${msg['role_user']!'User'}</option>
            </select>
        </form>
    </div>
    <div class="bg-white rounded-xl shadow overflow-hidden">
        <table class="w-full">
            <thead class="bg-green-700 text-white">
                <tr>
                    <th class="px-4 py-3 text-left text-sm">${msg['user_col_name']!'Name'}</th>
                    <th class="px-4 py-3 text-left text-sm">${msg['user_col_username']!'Username'}</th>
                    <th class="px-4 py-3 text-left text-sm">${msg['user_col_email']!'Email'}</th>
                    <th class="px-4 py-3 text-left text-sm">${msg['user_col_role']!'Role'}</th>
                    <th class="px-4 py-3 text-left text-sm">${msg['user_col_status']!'Status'}</th>
                    <th class="px-4 py-3 text-left text-sm">${msg['user_col_actions']!'Actions'}</th>
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
                            <#if user.role == 'ADMIN'>${msg['role_admin']!'Admin'}
                            <#elseif user.role == 'VOLUNTEER'>${msg['role_volunteer']!'Volunteer'}
                            <#else>${msg['role_user']!'User'}</#if>
                        </span>
                    </td>
                    <td class="px-4 py-3 text-sm">
                        <span class="px-2 py-1 rounded text-xs <#if user.active>bg-green-100 text-green-800<#else>bg-red-100 text-red-800</#if>">
                            <#if user.active>${msg['status_active']!'Active'}<#else>${msg['status_inactive']!'Inactive'}</#if>
                        </span>
                    </td>
                    <td class="px-4 py-3 text-sm space-x-2">
                        <a href="/users/${user.id}/edit" class="text-green-600 hover:text-green-800">${msg['btn_edit']!'Edit'}</a>
                        <form method="POST" action="/users/${user.id}/delete" class="inline">
                            <button type="submit" class="text-red-600 hover:text-red-800"
                                onclick="return confirm('${msg['user_delete_confirm']!'Delete this user?'}')">${msg['btn_delete']!'Delete'}</button>
                        </form>
                    </td>
                </tr>
                </#list>
            </tbody>
        </table>
    </div>
</div>
</@layout.page>
