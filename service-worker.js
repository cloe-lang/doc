if(!self.define){let e,i={};const a=(a,r)=>(a=new URL(a+".js",r).href,i[a]||new Promise((i=>{if("document"in self){const e=document.createElement("script");e.src=a,e.onload=i,document.head.appendChild(e)}else e=a,importScripts(a),i()})).then((()=>{let e=i[a];if(!e)throw new Error(`Module ${a} didn’t register its module`);return e})));self.define=(r,l)=>{const c=e||("document"in self?document.currentScript.src:"")||location.href;if(i[c])return;let d={};const s=e=>a(e,c),f={module:{uri:c},exports:d,require:s};i[c]=Promise.all(r.map((e=>f[e]||s(e)))).then((e=>(l(...e),d)))}}define(["./workbox-7d6a3f4d"],(function(e){"use strict";self.addEventListener("message",(e=>{e.data&&"SKIP_WAITING"===e.data.type&&self.skipWaiting()})),e.precacheAndRoute([{url:"api-reference/builtin.html",revision:"fc3357e443b1fdcc0df69a7e984dca6f"},{url:"api-reference/fs.html",revision:"a79c6fd8a29693f83ecb61aa70454c3b"},{url:"api-reference/http.html",revision:"8920397587676b4b483a03c815e90644"},{url:"api-reference/index.html",revision:"f6eb6ad51c27b27dd40cc60656e0e1fb"},{url:"api-reference/json.html",revision:"05b7269b98526b74456f9ea6e0f0dc92"},{url:"api-reference/os.html",revision:"dcab4fbe76b901ca539cead99ff1f116"},{url:"api-reference/random.html",revision:"37314ecba008f40ad54fd68ef88ba313"},{url:"api-reference/re.html",revision:"b01d11c43dbd3798c8a08a6bf815f97f"},{url:"contribution-guide.html",revision:"63a2590c08f14ca894bc5819d1cadb66"},{url:"examples/clutil.html",revision:"17dcd36253f4e0a36ea02af1aa53cdd4"},{url:"examples/collections.html",revision:"f2ff8398ce2d19e4251d13852ed2cf3f"},{url:"examples/comparison.html",revision:"aefa6aaecedd6a760abf0d77bbac33c8"},{url:"examples/data_types.html",revision:"99673df8fd1ac01ef21d88b3cab7e875"},{url:"examples/effects.html",revision:"c9e3c0d176bcee104375dac42ea77001"},{url:"examples/errors.html",revision:"e821f9205a2ae3f0ce99865bd1022882"},{url:"examples/functions.html",revision:"3423c749e1a3b514e7bb5557c19274a7"},{url:"examples/import.html",revision:"c15dda97df1df33803919cbfbe5eba0e"},{url:"examples/index.html",revision:"789538aa2376f4c0813a274857cf1017"},{url:"examples/io.html",revision:"c4db34a3eacc04f51ca603df3bd7da5a"},{url:"examples/match.html",revision:"bf74e103bee908a76eb9f53b7f7b4e97"},{url:"examples/math.html",revision:"8d894d6050b8f423234c655ec36e6eac"},{url:"examples/memory_leak.html",revision:"7c659bb70d2c995cb5f1fd3a3927b201"},{url:"examples/miscellaneous_functions.html",revision:"e048804c922b6f65cb2d61a5955e90d0"},{url:"examples/modules/fs.html",revision:"9bd92af047276173941e29223695e962"},{url:"examples/modules/http.html",revision:"5a2204e05fc52d7c25626c951f33e152"},{url:"examples/modules/json.html",revision:"a734271eb58b096888771a4d8016cbc0"},{url:"examples/modules/os.html",revision:"3176cca497a5c0d618bbfbc041c55f34"},{url:"examples/modules/random.html",revision:"53f6dd5aed677d2f13c9cd1a5d17d789"},{url:"examples/modules/re.html",revision:"bbc7dcd928d33bf06ebd1a4a90424bb8"},{url:"examples/others.html",revision:"30365dbbd3cc0c7e3082c43e48d6ea7e"},{url:"examples/parallelism.html",revision:"2764ad41100fb505de763bb8a23ccea6"},{url:"examples/recursion.html",revision:"ffdf7a5835a552675360a20256d058e4"},{url:"guide/clutil-command.html",revision:"2402a9bcede32f06f3baf49690417cba"},{url:"guide/error-handling.html",revision:"d592989b125a1570b0c42f31b2016a2c"},{url:"guide/functions.html",revision:"d9f3624579402814a9c59ec7b3ceecb2"},{url:"guide/index.html",revision:"533eb99d5d9b01da391d215b8fbd9d89"},{url:"guide/modules.html",revision:"1bb5a457f2c5befa9c96dada1fb2aa9b"},{url:"guide/pattern-matching.html",revision:"5c3d2817b4f10e9dfd42ce17672ba86f"},{url:"guide/types.html",revision:"f7c88b8689a59925f7ccb0f57fff043b"},{url:"guide/variables.html",revision:"911bd6710a4d88fdee36ff11360f3c8e"},{url:"icon.svg",revision:"d6d30a89cf932212f8660f0d92fa6e38"},{url:"index.html",revision:"35afb53573530cd19260dc2cc5b3aa5e"},{url:"index.js",revision:"3c83a2ce07855f807b99917705dea38e"},{url:"installation.html",revision:"d0044126a3b837e6a0e641d49feabfbe"},{url:"manifest.json",revision:"5fb2a6edab7e5a46d8ce784b924e7c69"},{url:"overview/concept.html",revision:"9459e389c866cbbb76f981e4aa05cacd"},{url:"overview/features.html",revision:"583b4824e1d473dafb1411b99861d82d"},{url:"overview/index.html",revision:"3dfa3989104e9ba062fde1134a8d6725"},{url:"/",revision:"f4dc7b4c58393671310a835f9ae42623"}],{})}));
//# sourceMappingURL=service-worker.js.map
