import 'package:flutter_deer/demo/demo_page.dart';
import 'package:flutter_deer/util/device_utils.dart';
import 'package:sp_util/sp_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/constant.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/setting/widgets/exit_dialog.dart';
import 'package:flutter_deer/setting/widgets/update_dialog.dart';
import 'package:flutter_deer/util/app_navigator.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';
import 'package:flutter_deer/widgets/click_item.dart';

import '../setting_router.dart';


/// design/8设置/index.html
class SettingPage extends StatefulWidget {

  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        centerTitle: '设置',
      ),
      body: Column(
        children: <Widget>[
          Gaps.vGap5,
          ClickItem(
            title: '账号管理',
            onTap: () => NavigatorUtils.push(context, SettingRouter.accountManagerPage),
          ),
          if (Device.isMobile) ClickItem(
            title: '清除缓存',
            content: '23.5MB',
            onTap: () {},
          ),
          ClickItem(
            title: '夜间模式',
            content: _getCurrentTheme(),
            onTap: () => NavigatorUtils.push(context, SettingRouter.themePage),
          ),
          ClickItem(
            title: '多语言',
            content: _getCurrentLocale(),
            onTap: () => NavigatorUtils.push(context, SettingRouter.localePage),
          ),
          if (Device.isMobile) ClickItem(
            title: '检查更新',
            onTap: _showUpdateDialog,
          ),
          ClickItem(
            title: '关于我们',
            onTap: () => NavigatorUtils.push(context, SettingRouter.aboutPage),
          ),
          ClickItem(
            title: '退出当前账号',
            onTap: _showExitDialog,
          ),
          if (Device.isMobile) ClickItem(
            title: 'Deer Web版',
            onTap: () => NavigatorUtils.goWebViewPage(context, 'Flutter Deer', 'https://simplezhli.github.io/flutter_deer/'),
          ),
          ClickItem(
            title: '其他Demo',
            onTap: () => AppNavigator.push(context, const DemoPage()),
          ),
        ],
      ),
    );
  }

  String _getCurrentTheme() {
    final String? theme = SpUtil.getString(Constant.theme);
    String themeMode;
    switch(theme) {
      case 'Dark':
        themeMode = '开启';
        break;
      case 'Light':
        themeMode = '关闭';
        break;
      default:
        themeMode = '跟随系统';
        break;
    }
    return themeMode;
  }

  String _getCurrentLocale() {
    final String? locale = SpUtil.getString(Constant.locale);
    String localeMode;
    switch(locale) {
      case 'zh':
        localeMode = '中文';
        break;
      case 'en':
        localeMode = 'English';
        break;
      default:
        localeMode = '跟随系统';
        break;
    }
    return localeMode;
  }

  void _showExitDialog() {
    showDialog<void>(
      context: context,
      builder: (_) => const ExitDialog()
    );
  }

  void _showUpdateDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const UpdateDialog()
    );
  }
}
