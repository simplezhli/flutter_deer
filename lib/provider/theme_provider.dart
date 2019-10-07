import 'dart:ui';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/common/common.dart';
import 'package:flutter_deer/common/themes.dart';
import 'package:flutter_deer/res/resources.dart';


class ThemeProvider extends ChangeNotifier {

  static const Map<Themes, String> themes = {
    Themes.DARK: "Dark", Themes.LIGHT : "Light", Themes.SYSTEM : "System"
  };

  void setTheme(Themes theme) {
    SpUtil.putString(Constant.theme, themes[theme]);
    notifyListeners();
  }

  getTheme({bool isDarkMode: false}) {
    String theme = SpUtil.getString(Constant.theme);
    switch(theme){
      case "Dark":
        isDarkMode = true;
        break;
      case "Light":
        isDarkMode = false;
        break;
      default:
        break;
    }

    return ThemeData(
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      primaryColor: Colours.app_main,
      accentColor: Colours.app_main,
      indicatorColor: Colours.app_main,
      canvasColor: isDarkMode ? Colours.dark_bg_color : Colors.white,
      textSelectionColor: Colours.app_main.withAlpha(70),
      textSelectionHandleColor: Colours.app_main,
      textTheme: TextTheme(
        // TextField输入文字颜色
        subhead: isDarkMode ? TextStyles.textWhite14 : TextStyles.textDark14,
        body1: isDarkMode ? TextStyles.textWhite14 : TextStyles.textDark14,
      ),
      inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyles.textGray14
      ),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        color: isDarkMode ? Colours.dark_bg_color : Colors.white,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      dividerTheme: DividerThemeData(
        color: isDarkMode ? Colours.dark_line : Colours.line,
        space: 0.6,
        thickness: 0.6
      )
    );
  }

}