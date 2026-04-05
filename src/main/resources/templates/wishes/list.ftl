<#import "../layout/base.ftl" as layout>
<@layout.page title="${msg['wish_page_title']!'Quản Lý Lời Chúc'} - ${msg['site_name']!'Pet Rescue'}">
<div class="px-4">
    <div class="flex justify-between items-center mb-6">
        <h1 class="text-2xl font-bold text-green-800">${msg['wish_page_title']!'💌 Quản Lý Lời Chúc'}</h1>
    </div>

    <div class="bg-white rounded-xl shadow-md p-4 mb-6">
        <form method="get" action="/wishes" class="flex flex-wrap gap-3">
            <select name="status" onchange="this.form.submit()" class="border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500">
                <option value="">${msg['filter_status_all']!'Tất Cả Trạng Thái'}</option>
                <option value="NEW" <#if (status)! == 'NEW'>selected</#if>>${msg['wish_status_new']!'Mới'}</option>
                <option value="APPROVED" <#if (status)! == 'APPROVED'>selected</#if>>${msg['wish_status_approved']!'Đã Duyệt'}</option>
            </select>
        </form>
    </div>

    <div class="bg-white rounded-xl shadow-md overflow-hidden">
        <table class="min-w-full divide-y divide-gray-200">
            <thead class="bg-gray-50">
                <tr>
                    <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">${msg['wish_col_sender']!'Người Gửi'}</th>
                    <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">${msg['wish_col_message']!'Nội Dung'}</th>
                    <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">${msg['wish_col_status']!'Trạng Thái'}</th>
                    <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">${msg['wish_col_date']!'Ngày'}</th>
                    <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">${msg['wish_col_actions']!'Thao Tác'}</th>
                </tr>
            </thead>
            <tbody class="bg-white divide-y divide-gray-100">
                <#list wishes as wish>
                <tr class="hover:bg-gray-50">
                    <td class="px-4 py-3 text-sm font-medium text-gray-900">${wish.donorName?html}</td>
                    <td class="px-4 py-3 text-sm text-gray-600 max-w-xs">
                        <#if wish.message??>${wish.message?html}<#else><span class="text-gray-400">—</span></#if>
                    </td>
                    <td class="px-4 py-3 text-sm">
                        <#if wish.status == "APPROVED">
                            <span class="bg-green-100 text-green-700 text-xs px-2 py-1 rounded-full">${msg['wish_status_approved']!'Đã Duyệt'}</span>
                        <#else>
                            <span class="bg-yellow-100 text-yellow-700 text-xs px-2 py-1 rounded-full">${msg['wish_status_new']!'Mới'}</span>
                        </#if>
                    </td>
                    <td class="px-4 py-3 text-sm text-gray-500">${wish.createdAt?string?substring(0, 10)}</td>
                    <td class="px-4 py-3 text-sm">
                        <div class="flex flex-wrap gap-2">
                            <#if wish.status != "APPROVED">
                            <form method="POST" action="/wishes/${wish.id}/approve" class="inline">
                                <button type="submit" class="bg-green-600 text-white text-xs px-3 py-1.5 rounded hover:bg-green-700">${msg['wish_btn_approve']!'Duyệt'}</button>
                            </form>
                            </#if>
                            <form method="POST" action="/wishes/${wish.id}/delete" class="inline">
                                <button type="submit"
                                    onclick="return confirm('${msg['wish_delete_confirm']!'Xóa lời chúc này?'}')"
                                    class="bg-red-500 text-white text-xs px-3 py-1.5 rounded hover:bg-red-600">${msg['btn_delete']!'Xóa'}</button>
                            </form>
                        </div>
                    </td>
                </tr>
                </#list>
                <#if !wishes?has_content>
                <tr>
                    <td colspan="5" class="px-4 py-8 text-center text-gray-500">${msg['wish_empty']!'Chưa có lời chúc nào.'}</td>
                </tr>
                </#if>
            </tbody>
        </table>
    </div>
</div>
</@layout.page>
