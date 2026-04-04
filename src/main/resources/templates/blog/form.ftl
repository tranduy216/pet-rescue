<#import "../layout/base.ftl" as layout>
<@layout.page title="${(blog??)?then(msg['blog_form_edit']!'Edit Post', msg['blog_form_new']!'New Post')} - ${msg['site_name']!'Pet Rescue'}" headContent='<link href="https://cdn.quilljs.com/1.3.7/quill.snow.css" rel="stylesheet">'>
<div class="max-w-3xl mx-auto mt-6">
    <div class="bg-white rounded-xl shadow-md p-8">
        <h1 class="text-2xl font-bold text-green-800 mb-6">${(blog??)?then(msg['blog_form_edit']!'Edit Post', msg['blog_form_new']!'New Post')}</h1>
        <#if error??>
        <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">${error}</div>
        </#if>
        <form method="POST" action="/blog/<#if blog??>${blog.id}/edit<#else>new</#if>" id="blog-form" class="space-y-4">
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">${msg['blog_field_title']!'Title'} *</label>
                <input type="text" name="title" value="${(blog.title)!''}" required
                    class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500">
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">${msg['blog_field_content']!'Content'} *</label>
                <div id="quill-editor" class="border border-gray-300 rounded-lg" style="min-height: 320px;"></div>
                <input type="hidden" name="content" id="content-input">
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">${msg['blog_field_tags']!'Tags'}</label>
                <input type="text" name="tags" value="${(blog.tags)!''}" placeholder="animal, rescue, adoption"
                    class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500">
            </div>
            <div class="flex items-center space-x-3">
                <input type="checkbox" name="isPublished" value="true" id="published"
                    <#if (blog.published)!false>checked</#if>
                    class="rounded border-gray-300 text-green-600">
                <label for="published" class="text-sm font-medium text-gray-700">${msg['blog_field_publish']!'Publish immediately'}</label>
            </div>
            <div class="flex space-x-3">
                <button type="submit" class="bg-green-600 text-white px-6 py-2 rounded-lg hover:bg-green-700">${msg['btn_save']!'Save'}</button>
                <a href="/blog<#if blog??>/${blog.id}</#if>" class="bg-gray-200 text-gray-700 px-6 py-2 rounded-lg hover:bg-gray-300">${msg['btn_cancel']!'Cancel'}</a>
            </div>
        </form>
    </div>
</div>
<script src="https://cdn.quilljs.com/1.3.7/quill.min.js"></script>
<script>
(function () {
    var toolbarOptions = [
        [{ 'header': [1, 2, 3, false] }],
        ['bold', 'italic', 'underline', 'strike'],
        [{ 'list': 'ordered' }, { 'list': 'bullet' }],
        ['blockquote', 'code-block'],
        ['link', 'image'],
        [{ 'align': [] }],
        ['clean']
    ];

    var quill = new Quill('#quill-editor', {
        theme: 'snow',
        modules: { toolbar: toolbarOptions }
    });

    var toolbar = quill.getModule('toolbar');
    toolbar.addHandler('image', function () {
        var input = document.createElement('input');
        input.setAttribute('type', 'file');
        input.setAttribute('accept', 'image/*');
        input.click();
        input.addEventListener('change', function () {
            var file = input.files[0];
            if (!file) return;
            var formData = new FormData();
            formData.append('file', file);
            fetch('/blog/upload-image', { method: 'POST', body: formData })
                .then(function (r) { return r.json(); })
                .then(function (data) {
                    var range = quill.getSelection(true);
                    quill.insertEmbed(range.index, 'image', data.url);
                    quill.setSelection(range.index + 1);
                });
        });
    });

    <#if blog?? && blog.content?has_content>
    quill.clipboard.dangerouslyPasteHTML("${blog.content?js_string}");
    </#if>

    document.getElementById('blog-form').addEventListener('submit', function () {
        document.getElementById('content-input').value = quill.root.innerHTML;
    });
})();
</script>
</@layout.page>
