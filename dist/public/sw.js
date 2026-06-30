self.addEventListener("install", () => self.skipWaiting());
self.addEventListener("activate", (e) => e.waitUntil(self.clients.claim()));

self.addEventListener("notificationclick", (event) => {
  event.notification.close();
  const url = event.notification.data?.url || "/";
  event.waitUntil(
    self.clients.matchAll({ type: "window", includeUncontrolled: true }).then((list) => {
      for (const client of list) {
        if (client.url.includes(self.location.origin) && "focus" in client) {
          return client.focus();
        }
      }
      if (self.clients.openWindow) return self.clients.openWindow(url);
    })
  );
});

self.addEventListener("message", (event) => {
  if (event.data?.type === "SHOW_NOTIFICATION") {
    const { title, body, icon, tag, url } = event.data;
    event.waitUntil(
      self.registration.showNotification(title, {
        body,
        icon: icon || "/mgs-logo.png",
        badge: "/mgs-logo.png",
        tag: tag || "express-sms-" + Date.now(),
        requireInteraction: false,
        vibrate: [200, 100, 200],
        data: { url: url || "/" },
      })
    );
  }
});
