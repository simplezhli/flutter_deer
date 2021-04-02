# Flutter Deer

<img src="preview/logo.jpg"/>

本项目为个人学习Flutter的练习项目。

通过设置、修改、组合自带部件以及自定义来实现具体的设计效果，满足日常开发的需求。

本项目设计图见design目录，你可以通过我提供的设计图有目标的去练习。所有的实现仅是个人的学习理解，如果有更好的实现方案欢迎交流。

## 预览

部分页面效果如下：

| ![](./preview/Screenshot_1.png)    |  ![](./preview/Screenshot_2.png)    | ![](./preview/Screenshot_3.png)   |  ![](./preview/Screenshot_4.png)   |
| :--------------------------------: | :---------------------------------: | :-------------------------------: | :-------------------------------:  |
| ![](./preview/Screenshot_5.png)    |  ![](./preview/Screenshot_6.png)    | ![](./preview/Screenshot_7.png)   |  ![](./preview/Screenshot_8.png)   |
| ![](./preview/Screenshot_9.png)    |  ![](./preview/Screenshot_10.png)   | ![](./preview/Screenshot_11.png)  |  ![](./preview/Screenshot_12.png)  |
| ![](./preview/Screenshot_13.png)   |  ![](./preview/Screenshot_14.png)   | ![](./preview/Screenshot_15.png)  |  ![](./preview/Screenshot_17.png)  |
| ![](./preview/Screenshot_18.png)   |  ![](./preview/Screenshot_19.png)   | ![](./preview/Screenshot_20.png)  |  ![](./preview/Screenshot_21.png)  |
| ![](./preview/Screenshot_22.jpg)   |  ![](./preview/Screenshot_23.jpg)   | ![](./preview/Screenshot_24.jpg)  |  ![](./preview/Screenshot_25.jpg)  |
| ![](./preview/Screenshot_26.jpg)   |  ![](./preview/Screenshot_27.jpg)   |  |  |

**觉得还可以的话，来个Star、Fork支持一波！有问题欢迎提Issue。**

## 实现内容

* mvp模式
* 使用`provider` (5.x 版本)做状态管理
* 基于`dio` （4.x 版本）的网络请求封装
* 完整的集成测试、可访问性测试。
* 支持深色模式
* 本地化（感谢 @ghedwards）
* 使用`Sliver` 系列组件实现复杂滚动效果
* 使用高德地图定位选择地址（支持Web）
* 通用Widget的处理封装
* 下拉刷新 + 上拉加载更多
* 应用检查更新
* PopupWindow
* 扫码功能（qr_code_scanner插件）
* 菜单切换动画（圆形扩散、3D翻转）
* 侧滑删除
* 城市选择
* 类似京东选择城市的三级联动
* 各种自定义Dialog
* 列表头部吸顶
* 密码输入键盘
* 验证码输入框
* 自定义简易日历
* 曲线图及[饼状图](https://dartpad.cn/d06f8f737d6eb2d87978eb2d14b87864)
* 模块化路由管理
* 更多的细节优化

具体可以下载体验：

Android版安装包：[点击下载](https://www.pgyer.com/gYXj)，安装密码：`111111`。

iOS需要自行下载代码运行。

Web体验地址：https://simplezhli.github.io/flutter_deer/

## 项目运行环境

[![Build Status](https://github.com/simplezhli/flutter_deer/workflows/flutter_deer%20driver/badge.svg?branch=master)](https://github.com/simplezhli/flutter_deer/actions?query=workflow%3A%22flutter_deer+driver%22+branch%3Amaster)

    1. Flutter version 2.0.3
     
    2. Dart version 2.12.2

## 注意事项

- `debug`模式下会有部分卡顿现象，这属于正常现象。良好的体验需要打`release` 包。
    iOS可以执行命令`flutter build ios` 以创建`release`版本。
    Android可以执行命令`flutter build apk` 以创建`release`版本。

- 项目运行有问题可以在[iOS问题汇总](./docs/iOS问题汇总.md)、[Android问题汇总](./docs/Android问题汇总.md)中尝试寻找解决办法。

- 由于部分插件的原因，本项目在Windows、macOS仅做预览（主要为原生功能方面，UI问题不大）。有兴趣的可自行运行体验。
        
- 可以执行集成测试命令`flutter drive --target=test_driver/driver.dart` 查看功能演示。

- 因为页面有点多，一开始可能会导致页面无法与设计图对应上。我在代码注释中有添加设计图的相对路径，可以搜索或查找到对应页面，希望对你有帮助。

- 本项目使用FlutterJsonBeanFactory插件来生成Bean。FlutterJsonBeanFactory插件使用可以查看[这篇文章](https://www.jianshu.com/p/14cbcbaa74b7)。

- Web受制于js等资源过大和部署在Github上，访问会慢一些。

## 心得总结（推荐阅读）

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
    
## 使用到的三方库

| 库                         | 功能             |
| -------------------------- | --------------- |
| [dio](https://github.com/flutterchina/dio)                            | **网络库**       |
| [provider](https://github.com/rrousselGit/provider)                   | **状态管理**     |
| [flutter_2d_amap](https://github.com/simplezhli/flutter_2d_amap)      | **高德2D地图**   |
| [cached_network_image](https://github.com/renefloor/flutter_cached_network_image)       | **图片加载**       |
| [fluro](https://github.com/theyakka/fluro)                            | **路由管理**     |
| [flutter_oktoast](https://github.com/OpenFlutter/flutter_oktoast)     | **Toast**        |
| [common_utils](https://github.com/Sky24n/common_utils)                | **Dart 常用工具类库**     |
| [flutter_slidable](https://github.com/letsar/flutter_slidable)        | **侧滑删除**     |
| [flustars](https://github.com/Sky24n/flustars)                        | **Flutter 常用工具类库**       |
| [flutter_swiper](https://github.com/best-flutter/flutter_swiper)      | **Flutter 轮播组件**       |
| [url_launcher](https://github.com/flutter/plugins/tree/master/packages/url_launcher)   | **启动URL的插件**       |
| [image_picker](https://github.com/flutter/plugins/tree/master/packages/image_picker)   | **图片选择插件** |
| [rxdart](https://github.com/ReactiveX/rxdart)                         | **Dart的响应式扩展** |
| [webview_flutter](https://github.com/flutter/plugins/tree/master/packages/webview_flutter)    | **WebView插件**       |
| [keyboard_actions](https://github.com/diegoveloper/flutter_keyboard_actions)                  | **处理键盘事件**       |
| [sticky_headers](https://github.com/fluttercommunity/flutter_sticky_headers)   | **列表悬浮头**       |
| [azlistview](https://github.com/flutterchina/azlistview)              | **城市选择列表**   |
| [date_utils](https://github.com/apptreesoftware/date_utils)           | **常用的日期工具类** |
| [bezier_chart](https://github.com/aeyrium/bezier-chart)               | **曲线图表**       |
| [sprintf](https://github.com/Naddiseo/dart-sprintf)                   | **格式化String**   |
| [qr_code_scanner](https://github.com/juliuscanute/qr_code_scanner)     | **扫码功能** |
| [intl](https://github.com/dart-lang/intl)     | **本地化** |
| [vibration](https://github.com/benjamindean/flutter_vibration)     | **振动** |

详细内容可以参看[pubspec.yaml](https://github.com/simplezhli/flutter_deer/blob/master/pubspec.yaml)文件    

## 后续计划：

* [x] 添加地图功能，具体实现插件见 [flutter_2d_amap](https://github.com/simplezhli/flutter_2d_amap)

* [x] 下拉刷新 + 上拉加载更多

* [x] 引入状态管理，预计使用 [provider](https://github.com/rrousselGit/provider)

* [x] 页面添加设计图路径注释，方便寻找对应的设计图。

* [x] 项目中有使用这一套框架及组件，会同步修复及优化遇到的问题。

* [x] 添加集成测试。

* [x] 深色模式支持。

* [x] 添加`Semantics`（语义）

* [x] Web端支持。

* [ ] 迁移到空安全。

## 已知存在问题：

- 2.0.0 已知存在问题(#68571 #73351 #73388)

- ListView在没有设置分割线的情况下，个别Item之间存在大约1像素的间隔（[像素对齐问题](https://github.com/flutter/flutter/issues/14288)）。

- 其他历史问题见docs目录下的问题汇总。

## Thanks For

- [flutter_wanandroid](https://github.com/Sky24n/flutter_wanandroid)

## License

	Copyright 2019 simplezhli

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
