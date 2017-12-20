importScripts('workbox-sw.prod.v2.1.2.js');

/**
 * DO NOT EDIT THE FILE MANIFEST ENTRY
 *
 * The method precache() does the following:
 * 1. Cache URLs in the manifest to a local cache.
 * 2. When a network request is made for any of these URLs the response
 *    will ALWAYS comes from the cache, NEVER the network.
 * 3. When the service worker changes ONLY assets with a revision change are
 *    updated, old cache entries are left as is.
 *
 * By changing the file manifest manually, your users may end up not receiving
 * new versions of files because the revision hasn't changed.
 *
 * Please use workbox-build or some other tool / approach to generate the file
 * manifest which accounts for changes to local files and update the revision
 * accordingly.
 */
const fileManifest = [
  {
    "url": "contribution-guide.html",
    "revision": "e2e6aaac8911a3aa5a6e5130d9e459bb"
  },
  {
    "url": "favicon.png",
    "revision": "2ad237ac31c8c047fbd725c8db78b1f9"
  },
  {
    "url": "index.html",
    "revision": "259bf1bc3cc758e965bfb9eef52a94c0"
  },
  {
    "url": "microlight.js",
    "revision": "720e012457b8b63a83d60c81bfd7473f"
  },
  {
    "url": "register-service-worker.js",
    "revision": "75f7fdd9c9739dfeb745c8a69d468618"
  },
  {
    "url": "service-worker.js",
    "revision": "38b6f3e20fa1f2a9a7b3109c7cfef22e"
  },
  {
    "url": "workbox-sw.prod.v2.1.2.js",
    "revision": "685d1ceb6b9a9f94aacf71d6aeef8b51"
  }
];

const workboxSW = new self.WorkboxSW();
workboxSW.precache(fileManifest);
