<#import "../layout/base.ftl" as layout>
<@layout.page title="Donate - Pet Rescue">
<div class="max-w-xl mx-auto mt-6">
    <#if success>
    <div class="bg-green-100 border border-green-400 text-green-800 px-6 py-6 rounded-xl mb-6 text-center">
        <p class="text-2xl mb-2">💚 Thank you for your donation!</p>
        <p class="text-green-700">Your contribution of $${donation.amount} has been recorded. We will confirm it shortly.</p>
        <a href="/" class="mt-4 inline-block text-green-600 hover:text-green-800">Return to Home</a>
    </div>
    <#else>
    <div class="bg-white rounded-xl shadow-md p-8">
        <h1 class="text-2xl font-bold text-green-800 mb-2">💚 Make a Donation</h1>
        <p class="text-green-600 mb-6">Your support helps us rescue and care for animals in need.</p>
        <#if error??>
        <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">${error}</div>
        </#if>
        <form method="POST" action="/donate" class="space-y-4">
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Your Name *</label>
                <input type="text" name="donorName" required
                    class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500">
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Email *</label>
                <input type="email" name="donorEmail" required
                    class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500">
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Amount (USD) *</label>
                <input type="number" name="amount" min="1" step="0.01" required placeholder="10.00"
                    class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500">
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Message (optional)</label>
                <textarea name="message" rows="3" placeholder="Leave a message of support..."
                    class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500"></textarea>
            </div>
            <button type="submit" class="w-full bg-green-600 text-white py-3 rounded-lg font-medium hover:bg-green-700">💚 Donate Now</button>
        </form>
    </div>
    </#if>
</div>
</@layout.page>
