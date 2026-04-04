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
                <option value="PENDING" <#if (status)! == 'PENDING'>selected</#if>>${msg['wish_status_pending']!'Chờ Duyệt'}</option>
                <option value="APPROVED" <#if (status)! == 'APPROVED'>selected</#if>>${msg['wish_status_approved']!'Đã Duyệt'}</option>
                <option value="RECEIVED" <#if (status)! == 'RECEIVED'>selected</#if>>${msg['wish_status_received']!'Đã Nhận'}</option>
                <option value="DELETED" <#if (status)! == 'DELETED'>selected</#if>>${msg['wish_status_deleted']!'Đã Xóa'}</option>
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
                        <#elseif wish.status == "RECEIVED">
                            <span class="bg-blue-100 text-blue-700 text-xs px-2 py-1 rounded-full">${msg['wish_status_received']!'Đã Nhận'}</span>
                        <#elseif wish.status == "DELETED">
                            <span class="bg-red-100 text-red-700 text-xs px-2 py-1 rounded-full">Đã Xóa</span>
                        <#else>
                            <span class="bg-yellow-100 text-yellow-700 text-xs px-2 py-1 rounded-full">${msg['wish_status_pending']!'Chờ Duyệt'}</span>
                        </#if>
                    </td>
                    <td class="px-4 py-3 text-sm text-gray-500">${wish.createdAt?string?substring(0, 10)}</td>
                    <td class="px-4 py-3 text-sm">
                        <div class="flex flex-wrap gap-2">
                            <#if wish.status != "APPROVED" && wish.status != "DELETED">
                            <form method="POST" action="/wishes/${wish.id}/approve" class="inline">
                                <button type="submit" class="bg-green-600 text-white text-xs px-3 py-1.5 rounded hover:bg-green-700">${msg['wish_btn_approve']!'Duyệt'}</button>
                            </form>
                            </#if>
                            <#if wish.status == "PENDING">
                            <form method="POST" action="/wishes/${wish.id}/receive" class="inline">
                                <button type="submit" class="bg-blue-500 text-white text-xs px-3 py-1.5 rounded hover:bg-blue-600">${msg['wish_btn_receive']!'Đã Nhận'}</button>
                            </form>
                            </#if>
                            <#if wish.status != "DELETED">
                            <form method="POST" action="/wishes/${wish.id}/delete" class="inline">
                                <button type="submit"
                                    onclick="return confirm('${msg['wish_delete_confirm']!'Xóa lời chúc này?'}')"
                                    class="bg-red-500 text-white text-xs px-3 py-1.5 rounded hover:bg-red-600">${msg['btn_delete']!'Xóa'}</button>
                            </form>
                            </#if>
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
