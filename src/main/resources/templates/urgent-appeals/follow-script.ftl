<#-- Shared Firebase follow script – included by appeal pages when firebaseConfig is set -->
<script src="https://www.gstatic.com/firebasejs/10.12.0/firebase-app-compat.js"></script>
<script src="https://www.gstatic.com/firebasejs/10.12.0/firebase-messaging-compat.js"></script>
<script>
(function() {
    var fbCfg = {
        apiKey: "${(firebaseConfig['apiKey'])!''}",
        authDomain: "${(firebaseConfig['authDomain'])!''}",
        projectId: "${(firebaseConfig['projectId'])!''}",
        storageBucket: "${(firebaseConfig['storageBucket'])!''}",
        messagingSenderId: "${(firebaseConfig['messagingSenderId'])!''}",
        appId: "${(firebaseConfig['appId'])!''}"
    };
    var vapidKey = "${(firebaseConfig['vapidKey'])!''}";

    function showToast(msg) {
        var t = document.getElementById('follow-toast');
        if (!t) return;
        t.textContent = msg;
        t.style.display = 'block';
        t.style.opacity = '1';
        setTimeout(function() {
            t.style.opacity = '0';
            setTimeout(function() { t.style.display = 'none'; }, 400);
        }, 3000);
    }

    window.followAppeal = function(appealId, btn) {
        if (!('Notification' in window)) { showToast('Trình duyệt không hỗ trợ thông báo.'); return; }
        btn.disabled = true;
        btn.textContent = '⏳ Đang đăng ký...';
        navigator.serviceWorker.register('/firebase-messaging-sw.js').then(function() {
            if (!firebase.apps.length) firebase.initializeApp(fbCfg);
            var messaging = firebase.messaging();
            Notification.requestPermission().then(function(permission) {
                if (permission !== 'granted') {
                    showToast('Bạn đã từ chối nhận thông báo.');
                    btn.disabled = false; btn.textContent = '🔔 Theo dõi';
                    return;
                }
                messaging.getToken({ vapidKey: vapidKey }).then(function(token) {
                    var params = new URLSearchParams({ fcmToken: token });
                    fetch('/urgent-appeals/' + appealId + '/follow', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                        body: params.toString()
                    }).then(function(res) {
                        if (res.ok) {
                            markFollowed(btn, appealId, token);
                            showToast('Đã theo dõi! Bạn sẽ nhận thông báo khi có cập nhật.');
                        } else {
                            showToast('Đăng ký thất bại, vui lòng thử lại.');
                            btn.disabled = false; btn.textContent = '🔔 Theo dõi';
                        }
                    });
                }).catch(function() {
                    showToast('Không thể lấy token. Kiểm tra VAPID key.');
                    btn.disabled = false; btn.textContent = '🔔 Theo dõi';
                });
            });
        }).catch(function() {
            showToast('Không thể đăng ký service worker.');
            btn.disabled = false; btn.textContent = '🔔 Theo dõi';
        });
    };

    function markFollowed(btn, appealId, token) {
        btn.textContent = '✅ Đang theo dõi';
        btn.classList.remove('border-red-400', 'text-red-600');
        btn.classList.add('border-green-500', 'text-green-700');
        if (token) localStorage.setItem('follow_' + appealId, token);
    }

    // Restore state for already-followed appeals
    document.querySelectorAll('.follow-btn').forEach(function(btn) {
        var id = btn.dataset.appealId;
        if (id && localStorage.getItem('follow_' + id)) markFollowed(btn, id, null);
    });
}());
</script>
