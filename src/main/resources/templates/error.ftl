<#import "layout/base.ftl" as layout>
<@layout.page title="Error ${code} - Pet Rescue">
<div class="max-w-md mx-auto mt-20 text-center">
    <p class="text-8xl mb-6">😿</p>
    <h1 class="text-4xl font-bold text-green-800 mb-4">Oops! Error ${code}</h1>
    <p class="text-gray-600 mb-8">${message}</p>
    <a href="/" class="bg-green-600 text-white px-6 py-3 rounded-lg font-medium hover:bg-green-700">🏠 Go Home</a>
</div>
</@layout.page>
