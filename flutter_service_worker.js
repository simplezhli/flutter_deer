'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "36553baf59b65e80c5324afaaef9e881",
"index.html": "280f1c87559489b6a9bd3afe73378962",
"/": "280f1c87559489b6a9bd3afe73378962",
"main.dart.js": "69355d0bd88836a086aea28a0296e1fa",
"favicon.png": "bfe1871cdc5a274d061bca9f260efc06",
"icons/Icon-192.png": "f8a609a995f13600fa916e57562c693e",
"icons/Icon-512.png": "7d80e4606a3a2f3191ba4da5642f9d75",
"manifest.json": "3ac0a70ed4edff773afb51be5323db6c",
"index1.html": "13196af40fbe22e31a664b544aedec0d",
"assets/AssetManifest.json": "9ce481fa2fa315e7c02686b334865b66",
"assets/NOTICES": "8f68e2a7ecc2fa2983685d964532fa93",
"assets/FontManifest.json": "fa660e1b9e2f9a9df483c14e9b860289",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"assets/assets/images/order/order_bg.png": "635477e5f2472aadf0cd0ddab421b32d",
"assets/assets/images/order/dwc_n.png": "7af3227a13d95813d31b8aa979a0e1f5",
"assets/assets/images/order/order_search.png": "847c377712d790558888b363cbd81ad5",
"assets/assets/images/order/icon_search.png": "5ee82fb17b9bb2bcef3d27d387903c85",
"assets/assets/images/order/ywc_n.png": "691256603145981129d159838329bb91",
"assets/assets/images/order/icon_phone.png": "08bfbacd78ede9b6c223c23531e901b2",
"assets/assets/images/order/dps_n.png": "2ddf52dc5d4f715c102faa633f55c783",
"assets/assets/images/order/xdd_s.png": "52d68048ff30f52fd3e68409e9cc22b9",
"assets/assets/images/order/yqx_n.png": "b18e8cee936ace7a2acc364f53e088fc",
"assets/assets/images/order/dps_s.png": "fba40991a1456b1a1c23ab94f421898e",
"assets/assets/images/order/order_bg1.png": "f286e2ca2445881865e976b70b659c74",
"assets/assets/images/order/xdd_n.png": "d45ac7156d526e20ccc2730bb41dfa4f",
"assets/assets/images/order/yqx_s.png": "954d212f3f4d6c63ed79e5c582af1642",
"assets/assets/images/order/icon_calendar.png": "98a9a4f28d453a0479a5f73090b7d78b",
"assets/assets/images/order/icon_goods.png": "b7e811fc1d99754e1034827550fce41b",
"assets/assets/images/order/dark/icon_ywc_s.png": "ded822a77cc2fe1d866a89e8d0ca6151",
"assets/assets/images/order/dark/icon_dwc_s.png": "98c162a5f76b5e628d82db0c25ece64e",
"assets/assets/images/order/dark/icon_phone.png": "0a8146bdb647ca59e4db497f0b64f1bb",
"assets/assets/images/order/dark/icon_xdd_n.png": "92908fde3f99f3af9faa26328981f40d",
"assets/assets/images/order/dark/icon_yqx_s.png": "d9f4220c66e7e3986def1c0e5c176b22",
"assets/assets/images/order/dark/icon_selected.png": "3b01bd4901f13949d820547f3d4377e9",
"assets/assets/images/order/dark/icon_dps_s.png": "2ea9090c6f091610d43c488d2c1d278f",
"assets/assets/images/order/dark/icon_xdd_s.png": "60587c07877e187059743541bcc7f48e",
"assets/assets/images/order/dark/icon_yqx_n.png": "d0bda282622351aae9557cd52cd23ffc",
"assets/assets/images/order/dark/icon_dps_n.png": "2bf7bcdc1fe027e7ebf175cb6f0640dc",
"assets/assets/images/order/dark/icon_ywc_n.png": "25ea500be238a876c36715f0443d6bfc",
"assets/assets/images/order/dark/icon_dwc_n.png": "7660512719f221006e72fdf6ebe903ba",
"assets/assets/images/order/dark/icon_address.png": "1fde4c7a996eddf7233d9a0790871e41",
"assets/assets/images/order/dwc_s.png": "c6fb8089209775c5efc9d41b2e2183c2",
"assets/assets/images/order/ic_check.png": "43d861315969a5ef289b710ee3cd181d",
"assets/assets/images/order/icon_avatar.png": "56e957f63624d11da0daece33f5138a7",
"assets/assets/images/order/order_delete.png": "b829ebb5954756ac72831835628c5fa8",
"assets/assets/images/order/icon_calendar_dark.png": "f8d6733099a27a48c2f9e52bdf1e475f",
"assets/assets/images/order/ywc_s.png": "19ceca72ba970cd364834b1339ba4a7f",
"assets/assets/images/order/icon_address.png": "ba0ba3098ce4bdd70b9284acc7a55f03",
"assets/assets/images/app_start_2.webp": "2afa39926c33cb782f324cd882c1b9fc",
"assets/assets/images/home/icon_statistics.png": "f4383be759de80d02b4ec9502698bc2f",
"assets/assets/images/home/icon_shop.png": "7fd29b808df8a639d1a65026075d65ba",
"assets/assets/images/home/icon_commodity.png": "13b0556dd77514c02d60a37065fa52d7",
"assets/assets/images/home/icon_order.png": "7c73bf5a8c6227f13f5a1abb70779177",
"assets/assets/images/ic_arrow_right.png": "4c4083af1f6f6094e692617e90cacd0d",
"assets/assets/images/app_start_3.webp": "59b566c7ffd70e02fa1a7741eb6ec070",
"assets/assets/images/shop/xztm.png": "13c6d2fc2bfde448f4d6fa08df4bb5dc",
"assets/assets/images/shop/dark_zhls.png": "017a86f5259034718b73fd1aa95d1bad",
"assets/assets/images/shop/zybq.png": "07288cd0dfc08423ebb1766a161bb824",
"assets/assets/images/shop/wxzyf.png": "1eb08c294cfebf8fe0290037854af9c3",
"assets/assets/images/shop/zhls.png": "926734ccf70def19c867a57389aa8412",
"assets/assets/images/shop/xz.png": "d72af6672c77d3997a89e7e078be6f1e",
"assets/assets/images/shop/txzh.png": "0e85fa3432721f2b10c59dc76c90954b",
"assets/assets/images/shop/xzyf.png": "71a4be5f046c02706c296a568fd6e9dc",
"assets/assets/images/shop/tx.png": "59a859c6fb56e703f04935088feb2f4f",
"assets/assets/images/shop/dark_dpsz.png": "fdc8ff4c8ab3848701a5816bee80d4c2",
"assets/assets/images/shop/zjgl.png": "76159d540a4611bf3095f0d34bc3b244",
"assets/assets/images/shop/dpsz.png": "ab5b891878d9bc31240c17de222dfa95",
"assets/assets/images/shop/message.png": "b00a57a08273ce341788a1086b460934",
"assets/assets/images/shop/dark_zjgl.png": "206fccc40070df5b67d2c9a536000d49",
"assets/assets/images/shop/setting.png": "e1a96fff95e7a9d262a03cb15a76fc44",
"assets/assets/images/shop/dark_txzh.png": "ee18c8334eda2a80854efd072da34f42",
"assets/assets/images/shop/tj.png": "d18e7966a27795a6d613fa2020bebe9d",
"assets/assets/images/ic_back_black.png": "1effe43c51129c0cb4d81d6dae6bec43",
"assets/assets/images/state/zwsp.png": "ec8675baa5ebdc992148c6d22b2a2c7e",
"assets/assets/images/state/zwzh.png": "aaf78dc743277bf0be023acf9f9b2d6d",
"assets/assets/images/state/zwwl.png": "5d36bf6253e965e54168c620a1476b50",
"assets/assets/images/state/zwxx.png": "97f8fa3f8a415ca82cecc37b8933ce4b",
"assets/assets/images/state/zwdd.png": "37a7d5968b84eddd9994a8969c16f020",
"assets/assets/images/logo.png": "70d0ba18eb881a597bcba293a62eeb1b",
"assets/assets/images/update_head.jpg": "670e412faeda9a6481cdf95a1a3e3ea7",
"assets/assets/images/none.png": "ced946a89625c77946e8662d0f79385a",
"assets/assets/images/goods/add.png": "febb0823ff4bf1ef35a4b99ace2cb3cd",
"assets/assets/images/goods/goods_delete.png": "e6b733f090904f206536a78d5bb185ac",
"assets/assets/images/goods/expand.png": "fb21453dbb72d62ea0ed02214097507e",
"assets/assets/images/goods/jt.png": "d8a4b29b6955e58dc812b4d064207166",
"assets/assets/images/goods/icon_sm.png": "3714997c666de3db93654382ab3bc778",
"assets/assets/images/goods/ydss.png": "f5c9f2121b8f90c4c560be09ac0e9af9",
"assets/assets/images/goods/search.png": "f2ac00305c4474083418c8b21fef6fa7",
"assets/assets/images/goods/scanning.png": "fffc867509854ac7f7839a11d9c44abb",
"assets/assets/images/goods/add2.png": "09e000cd141ac9e8ba58bd61db0d3286",
"assets/assets/images/goods/ellipsis.png": "dbf1117203af3d9899312d1ea452cbd8",
"assets/assets/images/goods/icon_dialog_close.png": "1dc5650867c6687f0094fda790490a53",
"assets/assets/images/goods/icon_goods.png": "ffb80be4f59faadc61288769acb54a3a",
"assets/assets/images/goods/xz.png": "ee6cd2339cbd80aa5e66d8ffe0c2f97c",
"assets/assets/images/goods/goods_size_2.png": "6e8cf02c6a1df117d948e8b11d502334",
"assets/assets/images/goods/goods_size_1.png": "d85b55af634f8fb5f5b460a1aa0f1b48",
"assets/assets/images/statistic/sptj.png": "418ef6095bb8c53db2ebdbad197f1518",
"assets/assets/images/statistic/thirdplace.png": "9e499402cf4c5f06dd2e0f118194caef",
"assets/assets/images/statistic/xdd.png": "a6e3f1509bfe17977724f49a9bca7d0b",
"assets/assets/images/statistic/jyetj.png": "d5dabdce75687fe50757cd61d24b404a",
"assets/assets/images/statistic/runnerup.png": "b9f5caa8f5c866be9efe53a80adf3e79",
"assets/assets/images/statistic/up.png": "ee8d4b5233673da37a8bb9b90be99ddc",
"assets/assets/images/statistic/statistic_bg1.png": "afeaaefb46d0422f81d7d1942491ff5d",
"assets/assets/images/statistic/down.png": "15a03a54893ff18b14f7fd42def41a66",
"assets/assets/images/statistic/chart_fg.png": "37f3a099057550e725fee53a44a54adf",
"assets/assets/images/statistic/dps.png": "a46706228921522a14acd759a61f32f2",
"assets/assets/images/statistic/statistic_bg.png": "cb93568d87bc93638267445d347f80b6",
"assets/assets/images/statistic/sjzs.png": "8f3749bc702da7dfaa26a6301ccf4eca",
"assets/assets/images/statistic/icon_selected.png": "ac879982327893af154047678ab0d903",
"assets/assets/images/statistic/jrjye.png": "52a95ba4c3932d6525dada27bbf23f69",
"assets/assets/images/statistic/champion.png": "f3c19eed099a1a19520d20796333b506",
"assets/assets/images/account/gongshang.png": "048052840b8a26b493e15e8b20811f10",
"assets/assets/images/account/jianhang.png": "5f228f24732933635d69f4d4ab99eec4",
"assets/assets/images/account/jiaohang.png": "efcefd28109a572912f3024a472f0388",
"assets/assets/images/account/txxz.png": "360b93dcc93ce0a481080a5fa744ec30",
"assets/assets/images/account/rmb.png": "0366dc9401c86f54cb534d75f4da87dc",
"assets/assets/images/account/zhonghang.png": "ef0c1a59568d04474901056972c98444",
"assets/assets/images/account/sqcg.png": "f86118a462472bc8fc7a447dd6f1f4e7",
"assets/assets/images/account/txwxz.png": "298a50abc95f8ff3308c0450395c1905",
"assets/assets/images/account/pufa.png": "42a06a0cc2d1735ff3ca105a54561789",
"assets/assets/images/account/zhongxin.png": "66b317664490275d32755da3956614bd",
"assets/assets/images/account/nonghang.png": "8913e9ef2a594b194ecdf211d1ff42e9",
"assets/assets/images/account/selected.png": "c6745c841d23c38bf93649225c9fa99d",
"assets/assets/images/account/zhaohang.png": "f5fa592edfa21aa49cbd88698a6a8f91",
"assets/assets/images/account/del.png": "8b59f8728620f6027629ac9d2c05a1cd",
"assets/assets/images/account/minsheng.png": "db83c950de351f4a9930353eb22ad2db",
"assets/assets/images/account/yhk.png": "db3f10387894edb1d696e2b6c929e8b3",
"assets/assets/images/account/sm.png": "ae57139304afdb606e2284c928290962",
"assets/assets/images/account/xingye.png": "d7f0eda1fe671612d175611ff72e2c98",
"assets/assets/images/account/wechat.png": "1ff267fcb38e680ce4603a20ed1db300",
"assets/assets/images/account/sqsb.png": "a32631a509d9ae736d66c37a0249bc3d",
"assets/assets/images/account/bg.png": "c2f0020e08cf8e8c6e78228861079e0f",
"assets/assets/images/login/qyg_shop_icon_display.png": "56cff51e28d7e10f12f605aa281986d4",
"assets/assets/images/login/qyg_shop_icon_hide.png": "bc8a2bf2f7790ee16cae9a839896bafd",
"assets/assets/images/login/qyg_shop_icon_delete.png": "90f2e8c7f5296a7b696411fbf4c04503",
"assets/assets/images/store/icon_success.png": "665791e0d32c06e21bc819ef5ce02cc1",
"assets/assets/images/store/icon_wait.png": "d6114cb4866ef2446ac5a670a43ad179",
"assets/assets/images/store/2.0x/icon_success.png": "ea99d3a18826591ec793d98c48ebf4d2",
"assets/assets/images/store/2.0x/icon_wait.png": "e90c802bd84492c6c8c82d9fb5b1c5e3",
"assets/assets/images/store/2.0x/icon_failure.png": "7dde3afede0f1be0c158fd76e258b1f9",
"assets/assets/images/store/2.0x/icon_zj.png": "d548a93d3c6513742990b8f512661796",
"assets/assets/images/store/icon_failure.png": "888af4b1a882b301c34e5db48c92c2ec",
"assets/assets/images/store/3.0x/icon_success.png": "7f5d43b9137253f9d6fa2cefa43f22a2",
"assets/assets/images/store/3.0x/icon_wait.png": "0829df7dea8ddd51af6d9f482641eb86",
"assets/assets/images/store/3.0x/icon_failure.png": "d4b03a293aef1c90c11686726773e691",
"assets/assets/images/store/3.0x/icon_zj.png": "1dcfda95c2ed4b9787c0e1ce06bee3db",
"assets/assets/images/store/icon_zj.png": "5364c26fbcad5f3073aee71551ab4f36",
"assets/assets/images/app_start_1.webp": "db0fbb793bef9aee6514b874c568db2d",
"assets/assets/lottie/bunny_new_mouth.json": "1518f57a2db6026c5ca7fd0073b011f3",
"assets/assets/fonts/Roboto-Thin.ttf": "5ecbc99d1a81fed7dc71cb068ec0a74d",
"assets/assets/data/bank.json": "b6de98140f9889da70760eeefc5d476d",
"assets/assets/data/bank_2.json": "b3b8c25f5c70c6527ea853db12d59e8a",
"assets/assets/data/sort_0.json": "84991cd78d13adca922e531bc85ac697",
"assets/assets/data/city.json": "e8f7263ff0b6e335b61b2287c77d7067",
"assets/assets/data/sort_1.json": "522adb0dfc666c103dd966266859c3fa",
"assets/assets/data/sort_2.json": "762a4a595de0c8e82c266fc703961108"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
