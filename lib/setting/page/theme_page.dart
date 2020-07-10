
import 'package:flutter/material.dart';
import 'package:flutter_deer/common/common.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter_deer/provider/theme_provider.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';
import 'package:provider/provider.dart';

class ThemePage extends StatefulWidget {
  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {

  final List<String> _list = ['跟随系统', '开启', '关闭'];
//  StreamSubscription _subscription;
  
//  @override
//  void dispose() {
//    _subscription?.cancel();
//    super.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    String theme = SpUtil.getString(Constant.theme);
    String themeMode;
    switch(theme) {
      case 'Dark':
        themeMode = _list[1];
        break;
      case 'Light':
        themeMode = _list[2];
        break;
      default:
        themeMode = _list[0];
        break;
    }
    return Scaffold(
      appBar: const MyAppBar(
        title: '夜间模式',
      ),
      body: ListView.separated(
        itemCount: _list.length,
        separatorBuilder: (_, index) => const Divider(),
        itemBuilder: (_, index) {
          return InkWell(
            onTap: () {
              ThemeMode themeMode = index == 0 ? ThemeMode.system : (index == 1 ? ThemeMode.dark : ThemeMode.light);
//              Provider.of<ThemeProvider>(context, listen: false).setTheme(themeMode);
              /// 与上方等价，provider 4.1.0添加的拓展方法
              context.read<ThemeProvider>().setTheme(themeMode);
//              _subscription?.cancel();
//              /// 主题切换动画200毫秒
//              _subscription = Stream.value(1).delay(Duration(milliseconds: 200)).listen((_) {
//                if (!mounted) {
//                  return;
//                }
//                ThemeUtils.setSystemNavigationBarStyle(context, themeMode);
//              });
            },
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              height: 50.0,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(_list[index]),
                  ),
                  Opacity(
                    opacity: themeMode == _list[index] ? 1 : 0,
                    child: Icon(Icons.done, color: Colors.blue),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
