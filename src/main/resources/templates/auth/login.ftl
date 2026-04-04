<#import "../layout/base.ftl" as layout>
<@layout.page title="Login - Pet Rescue">
<div class="max-w-md mx-auto mt-10">
    <div class="bg-white rounded-xl shadow-md p-8">
        <h1 class="text-2xl font-bold text-green-800 mb-6 text-center">🌿 Login</h1>
        <#if error??>
        <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
            ${error}
        </div>
        </#if>
        <form method="POST" action="/login" class="space-y-4">
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Username</label>
                <input type="text" name="username" required
                    class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500">
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Password</label>
                <input type="password" name="password" required
                    class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500">
            </div>
            <button type="submit" class="w-full bg-green-600 text-white py-2 rounded-lg font-medium hover:bg-green-700">Login</button>
        </form>
        <p class="text-center mt-4 text-sm text-gray-600">
            Don't have an account? <a href="/register" class="text-green-600 hover:text-green-800">Register</a>
        </p>
    </div>
</div>
</@layout.page>
