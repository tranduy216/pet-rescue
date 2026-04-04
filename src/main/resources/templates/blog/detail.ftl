<#import "../layout/base.ftl" as layout>
<@layout.page title="${blog.title} - ${msg['site_name']!'Pet Rescue'}">
<div class="max-w-3xl mx-auto px-4">
    <a href="/blog" class="text-green-600 hover:text-green-800 mb-4 inline-block">${msg['blog_back']!'← Back to Blog'}</a>
    <div class="bg-white rounded-xl shadow-md p-8">
        <div class="flex justify-between items-start mb-4">
            <h1 class="text-3xl font-bold text-green-800">${blog.title}</h1>
            <#if !blog.published>
            <span class="bg-gray-100 text-gray-600 text-xs px-2 py-1 rounded">${msg['blog_draft']!'Draft'}</span>
            </#if>
        </div>
        <div class="flex items-center space-x-4 text-sm text-gray-500 mb-6">
            <span>📅 ${blog.createdAt?string('yyyy-MM-dd')}</span>
            <span>👁 ${blog.viewCount} ${msg['blog_views']!'views'}</span>
            <#if blog.tags??><span class="text-green-600">🏷 ${blog.tags}</span></#if>
        </div>
        <div class="prose max-w-none text-gray-700 leading-relaxed">${blog.content}</div>
        <#if session?? && (session.role == "ADMIN" || session.role == "VOLUNTEER")>
        <div class="mt-6 flex space-x-3 pt-4 border-t">
            <a href="/blog/${blog.id}/edit" class="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700">✏️ ${msg['btn_edit']!'Edit'}</a>
            <#if session.role == "ADMIN">
            <form method="POST" action="/blog/${blog.id}/delete" class="inline">
                <button type="submit" class="bg-red-600 text-white px-4 py-2 rounded-lg hover:bg-red-700"
                    onclick="return confirm('${msg['blog_delete_confirm']!'Delete this post?'}')">🗑️ ${msg['btn_delete']!'Delete'}</button>
            </form>
            </#if>
        </div>
        </#if>
    </div>
</div>
</@layout.page>
