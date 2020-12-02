import 'dart:ui';

import 'package:sp_util/sp_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/common/common.dart';

class LocaleProvider extends ChangeNotifier {

  final List<Locale> supportedLocales = const <Locale>[
    Locale('zh', 'CN'),
    Locale('en', 'US')
  ];

  Locale get locale {
    final String locale = SpUtil.getString(Constant.locale);
    switch(locale) {
      case 'zh':
        return supportedLocales[0];
      case 'en':
        return supportedLocales[1];
      default:
        return null;
    }
  }

  void setLocale(String locale) {
    SpUtil.putString(Constant.locale, locale);
    notifyListeners();
  }

}