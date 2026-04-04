<#macro page title="Pet Rescue">
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${title} 🐾</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/htmx.org@1.9.10"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body class="min-h-screen bg-green-50">
    <nav class="bg-green-700 shadow-lg">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16">
                <div class="flex items-center">
                    <a href="/" class="text-white text-xl font-bold">🌿 Pet Rescue</a>
                    <div class="ml-10 flex items-baseline space-x-4">
                        <a href="/pets" class="text-green-100 hover:text-white px-3 py-2 rounded-md text-sm font-medium">🐾 Pets</a>
                        <a href="/blog" class="text-green-100 hover:text-white px-3 py-2 rounded-md text-sm font-medium">📝 Blog</a>
                        <a href="/donate" class="text-green-100 hover:text-white px-3 py-2 rounded-md text-sm font-medium">💚 Donate</a>
                        <#if session?? && session.role != "GUEST">
                            <a href="/rescues" class="text-green-100 hover:text-white px-3 py-2 rounded-md text-sm font-medium">🚨 Rescue</a>
                            <a href="/adoptions" class="text-green-100 hover:text-white px-3 py-2 rounded-md text-sm font-medium">🏠 Adoptions</a>
                        </#if>
                        <#if session?? && (session.role == "ADMIN" || session.role == "VOLUNTEER")>
                            <a href="/finances" class="text-green-100 hover:text-white px-3 py-2 rounded-md text-sm font-medium">💰 Finance</a>
                        </#if>
                        <#if session?? && session.role == "ADMIN">
                            <a href="/users" class="text-green-100 hover:text-white px-3 py-2 rounded-md text-sm font-medium">👥 Users</a>
                            <a href="/donations" class="text-green-100 hover:text-white px-3 py-2 rounded-md text-sm font-medium">📋 Donations</a>
                        </#if>
                    </div>
                </div>
                <div class="flex items-center space-x-4">
                    <#if session??>
                        <span class="text-green-100 text-sm">👤 ${session.username} (${session.role})</span>
                        <a href="/logout" class="bg-green-900 text-white px-4 py-2 rounded-md text-sm font-medium hover:bg-green-800">Logout</a>
                    <#else>
                        <a href="/login" class="text-green-100 hover:text-white px-3 py-2 rounded-md text-sm font-medium">Login</a>
                        <a href="/register" class="bg-green-600 text-white px-4 py-2 rounded-md text-sm font-medium hover:bg-green-500">Register</a>
                    </#if>
                </div>
            </div>
        </div>
    </nav>

    <main class="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
        <#nested>
    </main>

    <footer class="bg-green-800 text-green-100 mt-12 py-8">
        <div class="max-w-7xl mx-auto px-4 text-center">
            <p>🌱 Pet Rescue System - Saving lives one paw at a time 🐾</p>
        </div>
    </footer>
</body>
</html>
</#macro>
