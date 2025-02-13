# Flutter Deer

<img src="preview/logo.jpg"/>

## English | [中文](README.md)

This project is an exercise in learning Flutter for personal growth and development.

To achieve specific design outcomes and meet the demands of daily development, one may employ the methods of configuring, modifying, combining pre-existing components, and customizing.

The design plans for this project can be found in the "design" directory. You may utilize these plans to practice with a specific goal in mind. Any implementation is solely based on personal comprehension and learning. Should there be any superior implementation strategies, I welcome the opportunity for discussion.

## Preview

Some of the page effects are as follows:

| ![](./preview/Screenshot_1.png)    |  ![](./preview/Screenshot_2.png)    | ![](./preview/Screenshot_3.png)   |  ![](./preview/Screenshot_4.png)   |
| :--------------------------------: | :---------------------------------: | :-------------------------------: | :-------------------------------:  |
| ![](./preview/Screenshot_5.png)    |  ![](./preview/Screenshot_6.png)    | ![](./preview/Screenshot_7.png)   |  ![](./preview/Screenshot_8.png)   |
| ![](./preview/Screenshot_9.png)    |  ![](./preview/Screenshot_10.png)   | ![](./preview/Screenshot_11.png)  |  ![](./preview/Screenshot_12.png)  |
| ![](./preview/Screenshot_13.png)   |  ![](./preview/Screenshot_14.png)   | ![](./preview/Screenshot_15.png)  |  ![](./preview/Screenshot_17.png)  |
| ![](./preview/Screenshot_18.png)   |  ![](./preview/Screenshot_19.png)   | ![](./preview/Screenshot_20.png)  |  ![](./preview/Screenshot_21.png)  |
| ![](./preview/Screenshot_22.jpg)   |  ![](./preview/Screenshot_23.jpg)   | ![](./preview/Screenshot_24.jpg)  |  ![](./preview/Screenshot_25.jpg)  |
| ![](./preview/Screenshot_26.jpg)   |  ![](./preview/Screenshot_27.jpg)   | ![](./preview/lottie.gif)         |  |

**If you find this project satisfactory, kindly show your support by giving it a Star or Fork. Rest assured, this project is being continuously maintained and any issues can be brought to our attention by submitting an Issue.**

## Realizing the content.

* MVP pattern
* State management using `provider` (version 6.x)
* Network request encapsulation based on `dio` (version 5.x)
* Integration testing and accessibility testing
* Support for dark mode
* Localization（Thanks to @ghedwards）
* Implementation of complex scrolling effects using `Sliver` series components
* Location selection using AMap (supports Web)
* Encapsulation of common widgets handling
* Pull-to-refresh and load-more functionality
* Application update check
* PopupWindow
* QR code scanning functionality (using the qr_code_scanner plugin)
* Menu switching animations (circular expansion, 3D flip)
* Swipe-to-delete
* City selection
* Three-level linkage selection similar to JD's city selection
* Various custom dialogs
* Sticky header for lists
* Password input keyboard
* Verification code input box
* Custom simple calendar
* Line chart and [pie charts](https://dartpad.cn/d06f8f737d6eb2d87978eb2d14b87864)
* Modularized route management
* More demos (ripple animation, scratch card, lottie)
* More detailed optimizations

You may download and experience it specifically by accessing the following links:

For the Android version, kindly click on the link provided: [Download here](https://www.pgyer.com/oEm8me), and enter the password: `111111`.

As for iOS, you will need to download and run the code on your own.

For web experience, please visit: https://simplezhli.github.io/flutter_deer/

## The project's operational environment.

[![flutter_deer driver](https://github.com/simplezhli/flutter_deer/actions/workflows/flutter-drive.yml/badge.svg?branch=master)](https://github.com/simplezhli/flutter_deer/actions/workflows/flutter-drive.yml)

    1. Flutter version 3.29.0

    2. Dart version 3.7.0

## Precautions to be taken.

- In debug mode, there may be some lagging, which is considered a normal occurrence. A satisfactory experience requires the creation of a release package. To create a release version for iOS, execute the command `flutter build ios`. For Android, execute the command `flutter build apk`.

- If there are any issues with the project's execution, please refer to the [iOS issue summary](./docs/iOS问题汇总.md) and [Android issue summary](./docs/Android问题汇总.md) for possible solutions.

- Due to certain plugin limitations, this project is only available for preview on Windows and macOS. Those interested may run and experience it themselves.
        
- To view the functionality demonstration, execute the integration test command `flutter drive --target=test_driver/driver.dart`.

- Due to the abundance of pages, it may be difficult to match the design at first. However, I have added the relative path of the design in the code comments, which can be searched or located for the corresponding page. I hope this will be helpful to you.

- This project uses the [FlutterJsonBeanFactory](https://github.com/zhangruiyu/FlutterJsonBeanFactory) plugin to generate Beans.

- Web performance may be slower due to large resource files such as js and deployment on Github.

## Summary of Experience

- [Flutter开发中的一些Tips(一)](https://weilu.blog.csdn.net/article/details/90546727)

- [Flutter开发中的一些Tips(二)](https://weilu.blog.csdn.net/article/details/94849020)

- [Flutter开发中的一些Tips(三)](https://weilu.blog.csdn.net/article/details/100108123)

- [Flutter适配深色模式（DarkMode）](https://weilu.blog.csdn.net/article/details/102531559)

- [说说Flutter中的RepaintBoundary](https://weilu.blog.csdn.net/article/details/103452637)

- [说说Flutter中的Semantics](https://weilu.blog.csdn.net/article/details/103823259)

- [说说Flutter中最熟悉的陌生人 —— Key](https://weilu.blog.csdn.net/article/details/104745624)

- [说说Flutter中的无名英雄 —— Focus](https://weilu.blog.csdn.net/article/details/107132031)

- [Flutter性能优化实践 —— UI篇](https://weilu.blog.csdn.net/article/details/106046434)

- [玩玩Flutter的拖拽——实现一款万能遥控器](https://weilu.blog.csdn.net/article/details/105237677)

- [玩玩Flutter Web —— 实现高德地图插件](https://weilu.blog.csdn.net/article/details/106465792)

- [在GitHub Actions上进行Flutter 的测试和部署](https://weilu.blog.csdn.net/article/details/114744416)

- [Flutter动画曲线Curves 效果一览](https://weilu.blog.csdn.net/article/details/95632571)

- [Flutter状态管理之Riverpod](https://weilu.blog.csdn.net/article/details/108352306)

- [【译】正确操作Dart中的字符串](https://weilu.blog.csdn.net/article/details/107857569)

- [【译】学习Flutter中新的Navigator和Router系统](https://weilu.blog.csdn.net/article/details/108902282)
    
## Tripartite library used

| library                         | Functionality             |
| -------------------------- | --------------- |
| [dio](https://github.com/cfug/dio)                            | **Networking library**       |
| [provider](https://github.com/rrousselGit/provider)                   | **State management**     |
| [flutter_2d_amap](https://github.com/simplezhli/flutter_2d_amap)      | **2D map from Amap**   |
| [cached_network_image](https://github.com/renefloor/flutter_cached_network_image)       | **Image loading**       |
| [fluro](https://github.com/theyakka/fluro)                            | **Routing management**     |
| [flutter_oktoast](https://github.com/OpenFlutter/flutter_oktoast)     | **Toast notifications**        |
| [common_utils](https://github.com/Sky24n/common_utils)                | **Common Dart utility library**     |
| [flutter_slidable](https://github.com/letsar/flutter_slidable)        | **Swipe-to-delete**     |
| [flustars](https://github.com/Sky24n/flustars)                        | **Common Flutter utility library**       |
| [flutter_swiper](https://github.com/best-flutter/flutter_swiper)      | **Flutter carousel component**       |
| [url_launcher](https://github.com/flutter/plugins/tree/master/packages/url_launcher)   | **Plugin for launching URLs**       |
| [image_picker](https://github.com/flutter/plugins/tree/master/packages/image_picker)   | **Plugin for selecting images** |
| [rxdart](https://github.com/ReactiveX/rxdart)                         | **Reactive extensions for Dart** |
| [webview_flutter](https://github.com/flutter/plugins/tree/master/packages/webview_flutter)    | **WebView plugin**       |
| [keyboard_actions](https://github.com/diegoveloper/flutter_keyboard_actions)                  | **Handling keyboard events**       |
| [azlistview](https://github.com/flutterchina/azlistview)              | **City selection list**   |
| [date_utils](https://github.com/apptreesoftware/date_utils)           | **Common date utility classes** |
| [bezier_chart](https://github.com/aeyrium/bezier-chart)               | **Bezier chart**       |
| [sprintf](https://github.com/Naddiseo/dart-sprintf)                   | **String formatting**   |
| [qr_code_scanner](https://github.com/juliuscanute/qr_code_scanner)     | **Scanning QR codes** |
| [intl](https://github.com/dart-lang/intl)     | **Localization** |
| [device_info_plus](https://github.com/fluttercommunity/plus_plugins/tree/main/packages/device_info_plus)     | **Getting device information** |
| [vibration](https://github.com/benjamindean/flutter_vibration)     | **Vibration** |
| [lottie](https://github.com/xvrh/lottie-flutter)     | **Animation effects** |

For details, please refer to the [pubspec.yaml](https://github.com/simplezhli/flutter_deer/blob/master/pubspec.yaml) file.  

## Plan:

* [x] Web support.

* [x] Migrate to null-safety.

* [ ] Migrate to Navigator 2.0.

## Thanks For

- [flutter_wanandroid](https://github.com/Sky24n/flutter_wanandroid)

## License

	Copyright 2019 simplezhli

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
