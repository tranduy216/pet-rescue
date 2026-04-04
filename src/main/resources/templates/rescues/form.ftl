<#import "../layout/base.ftl" as layout>
<@layout.page title="Report Rescue - Pet Rescue">
<div class="max-w-xl mx-auto mt-6">
    <div class="bg-white rounded-xl shadow-md p-8">
        <h1 class="text-2xl font-bold text-green-800 mb-6">🚨 Report Animal Rescue</h1>
        <#if error??>
        <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">${error}</div>
        </#if>
        <form method="POST" action="/rescues/new" class="space-y-4">
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Location *</label>
                <input type="text" name="location" required placeholder="Address or landmark"
                    class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500">
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Description *</label>
                <textarea name="description" rows="4" required placeholder="Describe the animal and situation..."
                    class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500"></textarea>
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Contact Info *</label>
                <input type="text" name="contactInfo" required placeholder="Phone or other contact"
                    class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500">
            </div>
            <div class="flex space-x-3">
                <button type="submit" class="bg-yellow-500 text-white px-6 py-2 rounded-lg hover:bg-yellow-600">Submit Report</button>
                <a href="/rescues" class="bg-gray-200 text-gray-700 px-6 py-2 rounded-lg hover:bg-gray-300">Cancel</a>
            </div>
        </form>
    </div>
</div>
</@layout.page>
