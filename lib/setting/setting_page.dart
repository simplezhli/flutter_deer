
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/app_navigator.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:flutter_deer/widgets/click_item.dart';

import 'about_page.dart';
import 'account_manager_page.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: "设置",
      ),
      body: Column(
        children: <Widget>[
          Gaps.vGap5,
          ClickItem(
            title: "账号管理",
            onTap: (){
              AppNavigator.push(context, AccountManagerPage());
            }
          ),
          ClickItem(
            title: "清除缓存",
            content: "23.5MB",
            onTap: (){}
          ),
          ClickItem(
            title: "检查更新",
            onTap: (){
              Toast.show("已是最新版本");
            }
          ),
          ClickItem(
            title: "关于我们",
            onTap: (){
              AppNavigator.push(context, About());
            }
          ),
          ClickItem(
            title: "退出当前账号",
            onTap: (){}
          ),
        ],
      ),
    );
  }
}
