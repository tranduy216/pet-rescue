<#import "layout/base.ftl" as layout>
<@layout.page title="Home - Pet Rescue">
<div class="px-4 py-6">
    <div class="text-center mb-12">
        <h1 class="text-4xl font-bold text-green-800 mb-4">🌿 Welcome to Pet Rescue</h1>
        <p class="text-lg text-green-600 max-w-2xl mx-auto">We save and rehome animals in need. Help us by adopting, donating, or reporting animals that need rescue.</p>
        <div class="mt-6 flex justify-center space-x-4">
            <a href="/pets" class="bg-green-600 text-white px-6 py-3 rounded-lg font-medium hover:bg-green-700">Find a Pet 🐾</a>
            <a href="/donate" class="bg-green-100 text-green-800 border border-green-600 px-6 py-3 rounded-lg font-medium hover:bg-green-200">Donate 💚</a>
            <a href="/rescues/new" class="bg-yellow-500 text-white px-6 py-3 rounded-lg font-medium hover:bg-yellow-600">Report Rescue 🚨</a>
        </div>
    </div>

    <#if pets?has_content>
    <section class="mb-12">
        <h2 class="text-2xl font-bold text-green-800 mb-6">🐾 Available Pets</h2>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <#list pets as pet>
            <div class="bg-white rounded-lg shadow-md overflow-hidden hover:shadow-lg transition-shadow">
                <#if pet.mediaList?has_content>
                    <img src="${pet.mediaList[0].fileUrl}" alt="${pet.name}" class="w-full h-48 object-cover">
                <#else>
                    <div class="w-full h-48 bg-green-100 flex items-center justify-center">
                        <span class="text-6xl"><#if pet.type == "DOG">🐕<#elseif pet.type == "CAT">🐈<#else>🐾</#if></span>
                    </div>
                </#if>
                <div class="p-4">
                    <h3 class="text-lg font-bold text-green-800">${pet.name}</h3>
                    <p class="text-sm text-green-600">${pet.type}<#if pet.breed??> - ${pet.breed}</#if></p>
                    <#if pet.age??><p class="text-sm text-gray-500">${pet.age} years old</p></#if>
                    <a href="/pets/${pet.id}" class="mt-3 inline-block bg-green-600 text-white px-4 py-2 rounded text-sm hover:bg-green-700">View Details</a>
                </div>
            </div>
            </#list>
        </div>
        <div class="text-center mt-6">
            <a href="/pets" class="text-green-600 hover:text-green-800 font-medium">View all pets →</a>
        </div>
    </section>
    </#if>

    <#if blogs?has_content>
    <section class="mb-12">
        <h2 class="text-2xl font-bold text-green-800 mb-6">📝 Latest News</h2>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
            <#list blogs as blog>
            <div class="bg-white rounded-lg shadow-md p-6 hover:shadow-lg transition-shadow">
                <h3 class="text-lg font-bold text-green-800 mb-2">${blog.title}</h3>
                <p class="text-gray-600 text-sm line-clamp-3">${blog.content?substring(0, [blog.content?length, 150]?min)}<#if blog.content?length gt 150>...</#if></p>
                <a href="/blog/${blog.id}" class="mt-3 inline-block text-green-600 hover:text-green-800 text-sm font-medium">Read more →</a>
            </div>
            </#list>
        </div>
    </section>
    </#if>

    <section class="bg-green-100 rounded-xl p-8 text-center">
        <h2 class="text-2xl font-bold text-green-800 mb-4">💚 Support Our Mission</h2>
        <p class="text-green-700 mb-6">Your donation helps us rescue, care for, and rehome animals in need.</p>
        <a href="/donate" class="bg-green-600 text-white px-8 py-3 rounded-lg font-medium hover:bg-green-700">Donate Now</a>
    </section>
</div>
</@layout.page>
