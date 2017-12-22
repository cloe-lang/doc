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
    "revision": "201e1f5a327df31bfb6c8fbca70c800c"
  },
  {
    "url": "favicon.png",
    "revision": "2ad237ac31c8c047fbd725c8db78b1f9"
  },
  {
    "url": "highlight.css",
    "revision": "f4e20c4f5e211150ceda8709fd25f808"
  },
  {
    "url": "highlight.js",
    "revision": "87cfd4f9aaf9cbe85f70454128541748"
  },
  {
    "url": "index.html",
    "revision": "0c7c9b8dc99955abccb28a98b6f7488f"
  },
  {
    "url": "jquery.js",
    "revision": "c9f5aeeca3ad37bf2aa006139b935f0a"
  },
  {
    "url": "style.css",
    "revision": "9b387db18f27672dd7b18cf4ef3c8fa2"
  },
  {
    "url": "workbox-sw.prod.v2.1.2.js",
    "revision": "685d1ceb6b9a9f94aacf71d6aeef8b51"
  }
];

const workboxSW = new self.WorkboxSW();
workboxSW.precache(fileManifest);
