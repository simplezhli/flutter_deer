
import 'package:flutter/material.dart';
import 'package:flutter_deer/common/themes.dart';
import 'package:flutter_deer/provider/theme_provider.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:flutter_deer/widgets/click_item.dart';
import 'package:provider/provider.dart';

class ThemePage extends StatefulWidget {
  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {

  @override
  Widget build(BuildContext context) {
    ThemeProvider provider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: const MyAppBar(
        title: "夜间模式",
      ),
      body: Column(
        children: <Widget>[
          Gaps.vGap10,
          ClickItem(
            title: "跟随系统",
            onTap: (){
              //  MediaQuery.of(context).platformBrightness == Brightness.dark;
              provider?.setTheme(Themes.SYSTEM);
            }
          ),
          ClickItem(
            title: "开启",
            onTap: (){
              provider?.setTheme(Themes.DARK);
            }
          ),
          ClickItem(
            title: "关闭",
            onTap: (){
              provider?.setTheme(Themes.LIGHT);
            }
          ),
        ],
      ),
    );
  }
}
