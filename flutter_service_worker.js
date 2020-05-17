'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "main.dart.js": "eab168610ff0cbeb2e2c2eab7f953923",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/FontManifest.json": "893f1009e14d4733d711f57fc627c69c",
"assets/LICENSE": "ea53ff0cd0f4dd7a6eff2c0fb0294027",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "5a37ae808cf9f652198acde612b5328d",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "2bca5ec802e40d3f4b60343e346cedde",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "2aa350bd2aeab88b601a593f793734c0",
"assets/assets/images/socialgist-logo-full.png": "42d822769034cdfdc28a5bf9f9c911c6",
"assets/AssetManifest.json": "ba15fc8b939c87b764b5cc55b971f5fd",
"favicon.png": "b0d81efc9b1e97b03ccc41cf97d9b462",
"manifest.json": "96fee4048b06de310e8bc30a590a941f",
"icons/Icon-512.png": "e8bbc98a18758ee53d39b2a82174d4e8",
"icons/Icon-192.png": "3c04d2d09b5f5aa5bb4ff852c60ea2c2",
"index.html": "7bca8ad2e1fda65da62dc64f8edee61d",
"/": "7bca8ad2e1fda65da62dc64f8edee61d"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request);
      })
  );
});
