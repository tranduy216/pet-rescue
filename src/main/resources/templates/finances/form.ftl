<#import "../layout/base.ftl" as layout>
<@layout.page title="${msg['finance_form_title']!'Add Finance Entry'} - ${msg['site_name']!'Pet Rescue'}">
<div class="max-w-xl mx-auto mt-6">
    <div class="bg-white rounded-xl shadow-md p-8">
        <h1 class="text-2xl font-bold text-green-800 mb-6">${msg['finance_form_title']!'Add Finance Entry'}</h1>
        <#if error??>
        <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">${error}</div>
        </#if>
        <form method="POST" action="/finances/new" class="space-y-4">
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">${msg['finance_field_type']!'Type'} *</label>
                <select name="type" class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500">
                    <option value="INCOME">${msg['finance_type_income']!'Income'}</option>
                    <option value="EXPENSE">${msg['finance_type_expense']!'Expense'}</option>
                </select>
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">${msg['finance_field_amount']!'Amount'} *</label>
                <input type="number" name="amount" step="0.01" min="0" required
                    class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500">
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">${msg['finance_field_description']!'Description'} *</label>
                <textarea name="description" rows="3" required
                    class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500"></textarea>
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">${msg['finance_field_category']!'Category'}</label>
                <input type="text" name="category" placeholder="${msg['finance_field_category_placeholder']!'e.g., Food, Vet, Donation'}"
                    class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500">
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">${msg['finance_field_date']!'Date'} *</label>
                <input type="date" name="date" required
                    class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-green-500">
            </div>
            <div class="flex space-x-3">
                <button type="submit" class="bg-green-600 text-white px-6 py-2 rounded-lg hover:bg-green-700">${msg['btn_save']!'Save'}</button>
                <a href="/finances" class="bg-gray-200 text-gray-700 px-6 py-2 rounded-lg hover:bg-gray-300">${msg['btn_cancel']!'Cancel'}</a>
            </div>
        </form>
    </div>
</div>
</@layout.page>
