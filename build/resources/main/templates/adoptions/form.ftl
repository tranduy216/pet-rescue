<#import "../layout/base.ftl" as layout>
<@layout.page title="Adopt ${pet.name} - Pet Rescue">
<div class="max-w-xl mx-auto mt-6">
    <div class="bg-white rounded-xl shadow-md p-8">
        <h1 class="text-2xl font-bold text-green-800 mb-2">Request Adoption</h1>
        <p class="text-green-600 mb-6">Pet: <strong>${pet.name}</strong> (${pet.type})</p>
        <#if error??>
        <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">${error}</div>
        </#if>
        <form method="POST" action="/adoptions/request/${pet.id}" class="space-y-4">
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Phone Number *</label>
                <input type="tel" name="phone" required
                    class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500">
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Facebook Link *</label>
                <input type="url" name="facebookLink" required placeholder="https://facebook.com/yourprofile"
                    class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500">
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Notes</label>
                <textarea name="notes" rows="3" placeholder="Tell us about yourself and why you want to adopt..."
                    class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500"></textarea>
            </div>
            <div class="flex space-x-3">
                <button type="submit" class="bg-green-600 text-white px-6 py-2 rounded-lg hover:bg-green-700">Submit Request</button>
                <a href="/pets/${pet.id}" class="bg-gray-200 text-gray-700 px-6 py-2 rounded-lg hover:bg-gray-300">Cancel</a>
            </div>
        </form>
    </div>
</div>
</@layout.page>
