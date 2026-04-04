<#import "../layout/base.ftl" as layout>
<@layout.page title="${msg['nav_blog']!'Blog'} - ${msg['site_name']!'Pet Rescue'}">
<div class="px-4">
    <div class="flex justify-between items-center mb-6">
        <h1 class="text-2xl font-bold text-green-800">📝 ${msg['nav_blog']!'Blog'}</h1>
        <#if session?? && (session.role == "ADMIN" || session.role == "VOLUNTEER")>
        <a href="/blog/new" class="bg-green-600 text-white px-4 py-2 rounded-lg hover:bg-green-700">${msg['blog_add_btn']!'+ New Post'}</a>
        </#if>
    </div>
    <div class="space-y-6">
        <#list blogs as blog>
        <div class="bg-white rounded-xl shadow-md p-6 hover:shadow-lg transition-shadow">
            <div class="flex justify-between items-start mb-3">
                <h2 class="text-xl font-bold text-green-800">
                    <a href="/blog/${blog.id}" class="hover:text-green-600">${blog.title}</a>
                </h2>
                <#if !blog.published>
                <span class="bg-gray-100 text-gray-600 text-xs px-2 py-1 rounded">${msg['blog_draft']!'Draft'}</span>
                </#if>
            </div>
            <p class="text-gray-600 line-clamp-3">${blog.excerpt}</p>
            <div class="flex justify-between items-center mt-4">
                <div class="flex items-center space-x-4 text-xs text-gray-500">
                    <span>👁 ${blog.viewCount} ${msg['blog_views']!'views'}</span>
                    <span>${blog.createdAt?string?substring(0, 10)}</span>
                    <#if blog.tags??><span class="text-green-600">${blog.tags}</span></#if>
                </div>
                <div class="flex space-x-2">
                    <a href="/blog/${blog.id}" class="text-green-600 hover:text-green-800 text-sm">${msg['blog_read_more']!'Read more →'}</a>
                    <#if session?? && (session.role == "ADMIN" || session.role == "VOLUNTEER")>
                    <a href="/blog/${blog.id}/edit" class="text-blue-600 hover:text-blue-800 text-sm">${msg['btn_edit']!'Edit'}</a>
                    </#if>
                    <#if session?? && session.role == "ADMIN">
                    <form method="POST" action="/blog/${blog.id}/delete" class="inline">
                        <button type="submit" class="text-red-600 hover:text-red-800 text-sm"
                            onclick="return confirm('${msg['blog_delete_confirm']!'Delete this post?'}')">${msg['btn_delete']!'Delete'}</button>
                    </form>
                    </#if>
                </div>
            </div>
        </div>
        </#list>
        <#if !blogs?has_content>
        <div class="text-center py-8 text-gray-500">${msg['blog_empty']!'No blog posts yet.'}</div>
        </#if>
    </div>
</div>
</@layout.page>
