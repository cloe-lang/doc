if(!self.define){let e,i={};const a=(a,r)=>(a=new URL(a+".js",r).href,i[a]||new Promise((i=>{if("document"in self){const e=document.createElement("script");e.src=a,e.onload=i,document.head.appendChild(e)}else e=a,importScripts(a),i()})).then((()=>{let e=i[a];if(!e)throw new Error(`Module ${a} didn’t register its module`);return e})));self.define=(r,l)=>{const d=e||("document"in self?document.currentScript.src:"")||location.href;if(i[d])return;let f={};const c=e=>a(e,d),s={module:{uri:d},exports:f,require:c};i[d]=Promise.all(r.map((e=>s[e]||c(e)))).then((e=>(l(...e),f)))}}define(["./workbox-7d6a3f4d"],(function(e){"use strict";self.addEventListener("message",(e=>{e.data&&"SKIP_WAITING"===e.data.type&&self.skipWaiting()})),e.precacheAndRoute([{url:"api-reference/builtin.html",revision:"e4ab031da932cee72728e9173cdcaeba"},{url:"api-reference/fs.html",revision:"5a984e3997e84acaf06da74ab4f06ea9"},{url:"api-reference/http.html",revision:"c66f05004a7e423f7e51fde500486b7f"},{url:"api-reference/index.html",revision:"53126a3cc80f466c002bb968a09570e0"},{url:"api-reference/json.html",revision:"88178b9700548f62c7aacf5d77c237a2"},{url:"api-reference/os.html",revision:"1d11dd25c4f9afecdba77f38d920c21b"},{url:"api-reference/random.html",revision:"aa9d3545d2b3153bf03fc06dc1e837f0"},{url:"api-reference/re.html",revision:"b05e482598ef3c15954d23bf8e58e5a7"},{url:"CNAME",revision:"4f60142ebf61d49da5dcaa49c16c38b1"},{url:"contribution-guide.html",revision:"0c62a76521571dba27dbbe93579d92f7"},{url:"examples/clutil.html",revision:"0b96689a27867df0669fad8e53934aad"},{url:"examples/collections.html",revision:"4c09ea730f85a54c89fb92b8f11bdb7a"},{url:"examples/comparison.html",revision:"52f15c0493267d38c74e8c7a8b54bbc3"},{url:"examples/data_types.html",revision:"a46df109746267f3ffd7524f2e6908c9"},{url:"examples/effects.html",revision:"dea7c0190dcdd16f56140f3166dab716"},{url:"examples/errors.html",revision:"4ed9634af6e176746539b5177a64e96b"},{url:"examples/functions.html",revision:"2cc6016fd4f5708260d2b863a54e7944"},{url:"examples/import.html",revision:"58b74390abc57f28fced35f5565efd29"},{url:"examples/index.html",revision:"b982c0a14a6ed1ea6e61772408359567"},{url:"examples/io.html",revision:"1fb847725c6bafea20de368cd7ae6064"},{url:"examples/match.html",revision:"469b51da5e5ee62cf570f4c677b2e0bf"},{url:"examples/math.html",revision:"7620e0cb8fce478b082274ea9d2fe66e"},{url:"examples/memory_leak.html",revision:"1db9c60f1fd96101b3dfba044e64f140"},{url:"examples/miscellaneous_functions.html",revision:"a47ee8185bbad2ac155636d2cb70b599"},{url:"examples/modules/fs.html",revision:"aaf63aa5d254845b5a274c715b284b5d"},{url:"examples/modules/http.html",revision:"1310a2bffa7d047dd3d9e757d6d5545e"},{url:"examples/modules/json.html",revision:"9779a3dfcc38a79dc2db1f8a30b9e0c9"},{url:"examples/modules/os.html",revision:"d67a2e66aaaba75d04c0b2e32e29d986"},{url:"examples/modules/random.html",revision:"17bf6257bd032fc9e34db5a059a1f81b"},{url:"examples/modules/re.html",revision:"806d3412c2fdd71ecc2aea047252eb3b"},{url:"examples/others.html",revision:"cd82cb15a2a6dc8680f165580cf8a7a5"},{url:"examples/parallelism.html",revision:"fcf833722801b59e700f1b1a433ecaef"},{url:"examples/recursion.html",revision:"201959241a018d4e6eaf8d7c4f20e971"},{url:"guide/clutil-command.html",revision:"be84989bf4f03b43e346c0f72aa3b08d"},{url:"guide/error-handling.html",revision:"ce99fc92a10073e4ba8085197c79d2eb"},{url:"guide/functions.html",revision:"f97754f4484840c68cd625910c919291"},{url:"guide/index.html",revision:"c657f6fadad8b768dfbbc911181f4401"},{url:"guide/modules.html",revision:"2b69ba0ef2f4e1cde08d0efa7041a6b8"},{url:"guide/pattern-matching.html",revision:"45f955401a6cd83ca3e65fdd6e832aab"},{url:"guide/types.html",revision:"bb88d2996eff530e65e24c8cd3964d1e"},{url:"guide/variables.html",revision:"570f3b25ea55fe1639934da19e30995b"},{url:"icon.svg",revision:"d6d30a89cf932212f8660f0d92fa6e38"},{url:"index.html",revision:"17e7fdf633df157105cd63471692856b"},{url:"index.js",revision:"3c83a2ce07855f807b99917705dea38e"},{url:"installation.html",revision:"119f32751d6266e700a113c300c43e0b"},{url:"manifest.json",revision:"5fb2a6edab7e5a46d8ce784b924e7c69"},{url:"overview/concept.html",revision:"e4a186134f4fe4f586da2c4ab85116d4"},{url:"overview/features.html",revision:"959c6aa988eb8cf0b4d6e3df02e0c919"},{url:"overview/index.html",revision:"3881536c34047fbbb1c71e213490f981"},{url:"/",revision:"f4dc7b4c58393671310a835f9ae42623"}],{})}));
//# sourceMappingURL=service-worker.js.map