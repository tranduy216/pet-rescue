<#import "../layout/base.ftl" as layout>
<@layout.page title="Blog - Pet Rescue">
<div class="px-4">
    <div class="flex justify-between items-center mb-6">
        <h1 class="text-2xl font-bold text-green-800">📝 Blog</h1>
        <#if session?? && (session.role == "ADMIN" || session.role == "VOLUNTEER")>
        <a href="/blog/new" class="bg-green-600 text-white px-4 py-2 rounded-lg hover:bg-green-700">+ New Post</a>
        </#if>
    </div>
    <div class="space-y-6">
        <#list blogs as blog>
        <div class="bg-white rounded-xl shadow-md p-6 hover:shadow-lg transition-shadow">
            <div class="flex justify-between items-start mb-3">
                <h2 class="text-xl font-bold text-green-800">
                    <a href="/blog/${blog.id}" class="hover:text-green-600">${blog.title}</a>
                </h2>
                <#if !blog.isPublished>
                <span class="bg-gray-100 text-gray-600 text-xs px-2 py-1 rounded">Draft</span>
                </#if>
            </div>
            <p class="text-gray-600 line-clamp-3">${blog.content?substring(0, [blog.content?length, 200]?min)}<#if blog.content?length gt 200>...</#if></p>
            <div class="flex justify-between items-center mt-4">
                <div class="flex items-center space-x-4 text-xs text-gray-500">
                    <span>👁 ${blog.viewCount} views</span>
                    <span>${blog.createdAt?string('yyyy-MM-dd')}</span>
                    <#if blog.tags??><span class="text-green-600">${blog.tags}</span></#if>
                </div>
                <div class="flex space-x-2">
                    <a href="/blog/${blog.id}" class="text-green-600 hover:text-green-800 text-sm">Read more →</a>
                    <#if session?? && (session.role == "ADMIN" || session.role == "VOLUNTEER")>
                    <a href="/blog/${blog.id}/edit" class="text-blue-600 hover:text-blue-800 text-sm">Edit</a>
                    </#if>
                    <#if session?? && session.role == "ADMIN">
                    <form method="POST" action="/blog/${blog.id}/delete" class="inline">
                        <button type="submit" class="text-red-600 hover:text-red-800 text-sm"
                            onclick="return confirm('Delete this post?')">Delete</button>
                    </form>
                    </#if>
                </div>
            </div>
        </div>
        </#list>
        <#if !blogs?has_content>
        <div class="text-center py-8 text-gray-500">No blog posts yet.</div>
        </#if>
    </div>
</div>
</@layout.page>
