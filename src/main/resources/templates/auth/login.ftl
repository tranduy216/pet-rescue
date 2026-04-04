<#import "../layout/base.ftl" as layout>
<@layout.page title="${msg['auth_login_title']!'Login'} - ${msg['site_name']!'Pet Rescue'}">
<div class="max-w-md mx-auto mt-10">
    <div class="bg-white rounded-xl shadow-md p-8">
        <h1 class="text-2xl font-bold text-green-800 mb-6 text-center">${msg['auth_login_title']!'🌿 Login'}</h1>
        <#if error??>
        <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
            ${error}
        </div>
        </#if>
        <form method="POST" action="/login" class="space-y-4">
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">${msg['auth_field_username']!'Username'}</label>
                <input type="text" name="username" required
                    class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500">
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">${msg['auth_field_password']!'Password'}</label>
                <input type="password" name="password" required
                    class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500">
            </div>
            <button type="submit" class="w-full bg-green-600 text-white py-2 rounded-lg font-medium hover:bg-green-700">${msg['auth_btn_login']!'Login'}</button>
        </form>
        <p class="text-center mt-4 text-sm text-gray-600">
            ${msg['auth_no_account']!"Don't have an account?"} <a href="/register" class="text-green-600 hover:text-green-800">${msg['auth_register_link']!'Register'}</a>
        </p>
    </div>
</div>
</@layout.page>
