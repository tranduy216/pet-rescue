<#import "../layout/base.ftl" as layout>
<@layout.page title="${msg['donate_title']!'Động Viên'} - ${msg['site_name']!'Pet Rescue'}">
<div class="px-4 py-6 max-w-6xl mx-auto">
    <h1 class="text-2xl font-bold text-green-800 mb-2 text-center">💚 ${msg['donate_title']!'Động Viên & Ủng Hộ'}</h1>
    <p class="text-center text-green-700 mb-8 text-sm">${msg['donate_subtitle']!'Sự hỗ trợ của bạn giúp chúng tôi cứu hộ và chăm sóc động vật.'}</p>

    <div id="wish-toast" class="hidden mb-6 p-4 bg-green-50 border border-green-300 text-green-800 rounded-xl text-center font-medium text-sm">
        ✅ ${msg['donate_wish_sent']!'Lời chúc của bạn đã được gửi! Cảm ơn bạn 💚'}
    </div>

    <div class="flex flex-col lg:flex-row gap-6" id="donate-layout">
        <#-- Left: Send wishes form -->
        <div class="flex-1 bg-white rounded-2xl shadow-md p-6 flex flex-col" id="wish-card">
            <h2 class="text-lg font-bold text-green-800 mb-1">💌 ${msg['donate_wish_title']!'Gửi Lời Chúc'}</h2>
            <p class="text-sm text-gray-500 mb-5">${msg['donate_wish_subtitle']!'Gửi lời động viên đến trạm cứu hộ'}</p>

            <form id="wish-form" class="flex flex-col flex-1 space-y-4">
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">${msg['donate_field_name']!'Tên Của Bạn'} *</label>
                    <input type="text" name="donorName" required
                        placeholder="${msg['donate_field_name_placeholder']!'Nguyễn Văn A'}"
                        class="w-full border border-gray-300 rounded-lg px-3 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-400">
                </div>
                <div class="flex-1 flex flex-col">
                    <label class="block text-sm font-medium text-gray-700 mb-1">${msg['donate_field_message']!'Lời Nhắn'}</label>
                    <textarea name="message" rows="6"
                        placeholder="${msg['donate_field_message_placeholder']!'Gửi lời động viên tới các bạn tình nguyện...'}"
                        class="flex-1 w-full border border-gray-300 rounded-lg px-3 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-400 resize-none"></textarea>
                </div>
                <button id="send-btn" type="submit"
                    data-text="${msg['donate_btn_send']!'💌 Gửi Lời Chúc'}"
                    class="w-full bg-green-600 hover:bg-green-700 text-white font-semibold py-3 rounded-xl transition-colors text-sm">
                    ${msg['donate_btn_send']!'💌 Gửi Lời Chúc'}
                </button>
            </form>
        </div>

        <#-- Right: QR codes (equal height to left via flex stretch) -->
        <div class="w-full lg:w-5/12 flex flex-col gap-4">
            <#-- QR 1: Support station -->
            <div class="flex-1 bg-white rounded-2xl shadow-md p-5 flex flex-col items-center justify-center text-center min-h-48">
                <h3 class="text-base font-bold text-green-800 mb-1">🏥 ${msg['donate_qr1_title']!'Ủng Hộ Trạm Cứu Hộ'}</h3>
                <p class="text-xs text-gray-500 mb-3">${msg['donate_qr1_subtitle']!'Quét mã để chuyển khoản hỗ trợ trạm'}</p>
                <div class="flex-1 flex items-center justify-center w-full">
                    <img src="/static/qr-station.png"
                        alt="${msg['donate_qr1_title']!'QR Ủng Hộ Trạm'}"
                        class="max-w-full max-h-52 object-contain rounded-lg"
                        onerror="this.style.display='none';this.nextElementSibling.style.display='flex'">
                    <div style="display:none" class="w-48 h-48 border-2 border-dashed border-gray-300 rounded-xl flex flex-col items-center justify-center text-gray-400 text-xs gap-2 mx-auto">
                        <span class="text-4xl">📷</span>
                        <span>qr-station.png</span>
                    </div>
                </div>
            </div>
            <#-- QR 2: Support web -->
            <div class="flex-1 bg-white rounded-2xl shadow-md p-5 flex flex-col items-center justify-center text-center min-h-48">
                <h3 class="text-base font-bold text-green-800 mb-1">🌐 ${msg['donate_qr2_title']!'Ủng Hộ Website'}</h3>
                <p class="text-xs text-gray-500 mb-3">${msg['donate_qr2_subtitle']!'Quét mã để chuyển khoản duy trì website'}</p>
                <div class="flex-1 flex items-center justify-center w-full">
                    <img src="/static/qr-web.png"
                        alt="${msg['donate_qr2_title']!'QR Ủng Hộ Web'}"
                        class="max-w-full max-h-52 object-contain rounded-lg"
                        onerror="this.style.display='none';this.nextElementSibling.style.display='flex'">
                    <div style="display:none" class="w-48 h-48 border-2 border-dashed border-gray-300 rounded-xl flex flex-col items-center justify-center text-gray-400 text-xs gap-2 mx-auto">
                        <span class="text-4xl">📷</span>
                        <span>qr-web.png</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
(function () {
    var COOLDOWN_MS = 30000;
    var btn = document.getElementById('send-btn');
    var form = document.getElementById('wish-form');
    var originalText = btn ? (btn.getAttribute('data-text') || btn.textContent.trim()) : '';

    function startCooldown(seconds) {
        if (!btn) return;
        btn.disabled = true;
        btn.classList.add('opacity-50', 'cursor-not-allowed');
        btn.classList.remove('hover:bg-green-700');
        var remaining = seconds;
        btn.textContent = 'Bạn có thể gửi lời chúc mới sau ' + remaining + 's';
        var timer = setInterval(function () {
            remaining--;
            if (remaining <= 0) {
                clearInterval(timer);
                btn.disabled = false;
                btn.classList.remove('opacity-50', 'cursor-not-allowed');
                btn.classList.add('hover:bg-green-700');
                btn.textContent = originalText;
            } else {
                btn.textContent = 'Bạn có thể gửi lời chúc mới sau ' + remaining + 's';
            }
        }, 1000);
    }

    // Restore cooldown after page reload
    var lastSent = localStorage.getItem('wishLastSent');
    if (lastSent) {
        var elapsed = Date.now() - parseInt(lastSent, 10);
        if (elapsed < COOLDOWN_MS) {
            startCooldown(Math.ceil((COOLDOWN_MS - elapsed) / 1000));
        }
    }

    if (form && btn) {
        form.addEventListener('submit', function (e) {
            e.preventDefault();
            if (btn.disabled) return;
            var params = new URLSearchParams(new FormData(form)).toString();
            fetch('/donate', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: params
            }).then(function (res) {
                if (res.ok) {
                    var toast = document.getElementById('wish-toast');
                    if (toast) {
                        toast.classList.remove('hidden');
                        setTimeout(function () { toast.classList.add('hidden'); }, 4000);
                    }
                    form.reset();
                    localStorage.setItem('wishLastSent', Date.now().toString());
                    startCooldown(30);
                }
            });
        });
    }

    // Match right column height to left card height on large screens
    function syncHeight() {
        var layout = document.getElementById('donate-layout');
        var wishCard = document.getElementById('wish-card');
        if (!layout || !wishCard) return;
        if (window.innerWidth >= 1024) {
            layout.style.alignItems = 'stretch';
        }
    }
    syncHeight();
    window.addEventListener('resize', syncHeight);
})();
</script>
</@layout.page>
