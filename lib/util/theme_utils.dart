import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/device_utils.dart';

class ThemeUtils {

  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Color getDarkColor(BuildContext context, Color darkColor) {
    return isDark(context) ? darkColor : null;
  }

  static Color getIconColor(BuildContext context) {
    return isDark(context) ? Colours.dark_text : null;
  }
  
  static Color getStickyHeaderColor(BuildContext context) {
    return isDark(context) ? Colours.dark_bg_gray_ : Colours.bg_gray_;
  }

  static Color getDialogTextFieldColor(BuildContext context) {
    return isDark(context) ? Colours.dark_bg_gray_ : Colours.bg_gray;
  }

  static Color getKeyboardActionsColor(BuildContext context) {
    return isDark(context) ? Colours.dark_bg_color : Colors.grey[200];
  }

  static StreamSubscription _subscription;

  /// 设置NavigationBar样式，使得导航栏颜色与深色模式的设置相符。
  static void setSystemNavigationBar(ThemeMode mode) {
    /// 主题切换动画（AnimatedTheme）时间为200毫秒，延时设置导航栏颜色，这样过渡相对自然。
    _subscription?.cancel();
    _subscription = Stream.value(1).delay(const Duration(milliseconds: 200)).listen((_) {
      bool _isDark = false;
      if (mode == ThemeMode.dark || (mode == ThemeMode.system && window.platformBrightness == Brightness.dark)) {
        _isDark = true;
      }
      setSystemBarStyle(isDark: _isDark);
    });
  }

  /// 设置StatusBar、NavigationBar样式。(仅针对安卓)
  /// 本项目在android MainActivity中已设置，不需要覆盖设置。
  static void setSystemBarStyle({bool isDark}) {
    if (Device.isAndroid) {

      final bool _isDark = isDark ?? window.platformBrightness == Brightness.dark;
      debugPrint('isDark: $_isDark');
      final SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        /// 透明状态栏
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: _isDark ? Colours.dark_bg_color : Colors.white,
        systemNavigationBarIconBrightness: _isDark ? Brightness.light : Brightness.dark,
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }
}

extension ThemeExtension on BuildContext {
  bool get isDark => ThemeUtils.isDark(this);
  Color get backgroundColor => Theme.of(this).scaffoldBackgroundColor;
  Color get dialogBackgroundColor => Theme.of(this).canvasColor;
}