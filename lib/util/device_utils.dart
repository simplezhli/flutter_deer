import 'dart:io';
import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_deer/res/constant.dart';

/// https://medium.com/gskinner-team/flutter-simplify-platform-screen-size-detection-4cb6fc4f7ed1
class Device {
  static bool get isDesktop => !isWeb && (isWindows || isLinux || isMacOS);
  static bool get isMobile => isAndroid || isIOS;
  static bool get isWeb => kIsWeb;

  static bool get isWindows => !isWeb && Platform.isWindows;
  static bool get isLinux => !isWeb && Platform.isLinux;
  static bool get isMacOS => !isWeb && Platform.isMacOS;
  static bool get isAndroid => !isWeb && Platform.isAndroid;
  static bool get isFuchsia => !isWeb && Platform.isFuchsia;
  static bool get isIOS => !isWeb && Platform.isIOS;

  static late AndroidDeviceInfo _androidInfo;

  static Future<void> initDeviceInfo() async {
    if (isAndroid) {
      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      _androidInfo = await deviceInfo.androidInfo;
    }
  }

  /// 使用前记得初始化
  static int getAndroidSdkInt() {
    if (Constant.isDriverTest) {
      return -1;
    }
    if (isAndroid) {
      return _androidInfo.version.sdkInt;
    } else {
      return -1;
    }
  }

  /// iOS 26 及以上：启用液态玻璃（Liquid Glass）原生组件，其余平台/旧系统一律走原有实现。
  /// PlatformInfo 内部同步解析 Platform.operatingSystemVersion，无需初始化。
  static bool get isIOS26Plus =>
      !Constant.isDriverTest && PlatformInfo.isIOS26OrHigher();

  /// iOS 26+ 非 Duo 设备上，底部悬浮液态玻璃 tab 栏悬浮于内容之上，
  /// 各 tab 页列表需预留的底部内边距；其余情况返回 0。
  ///
  /// 通过 [context] 依赖 MediaQuery：屏幕旋转、Duo 折叠/展开换屏等尺寸变化
  /// 会自动触发调用方重建并取到新值。系统侧边条判断须读 view 的原始
  /// viewPadding（main.dart 全局 SafeArea 会清零子树的 padding/viewPadding）。
  static double glassTabBarBottomInsetOf(BuildContext context) {
    if (!isIOS26Plus) {
      return 0.0;
    }
    final EdgeInsets viewPadding =
        MediaQueryData.fromView(View.of(context)).viewPadding;
    /// iPhone Duo 等双屏设备存在系统侧边条（左右边缘 ≈84），tab 栏停靠侧边条，不遮挡底部内容
    final bool hasSystemSideBar =
        viewPadding.left >= 80 || viewPadding.right >= 80;
    if (hasSystemSideBar) {
      return 0.0;
    }
    return 60.0;
  }
}
