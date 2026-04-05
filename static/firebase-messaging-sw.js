// Firebase Cloud Messaging Service Worker
// This file must be served from the root scope (/firebase-messaging-sw.js)
importScripts('https://www.gstatic.com/firebasejs/10.12.0/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/10.12.0/firebase-messaging-compat.js');

// Firebase config is injected at runtime via a message from the main page
// (see appeal-follow.js). Default empty config prevents errors on first load.
self.addEventListener('message', (event) => {
    if (event.data && event.data.type === 'FIREBASE_CONFIG') {
        const config = event.data.config;
        if (!firebase.apps.length) {
            firebase.initializeApp(config);
        }
        const messaging = firebase.messaging();
        messaging.onBackgroundMessage((payload) => {
            const { title, body } = payload.notification || {};
            self.registration.showNotification(title || 'Pet Rescue', {
                body: body || '',
                icon: '/static/icon.png'
            });
        });
    }
});
