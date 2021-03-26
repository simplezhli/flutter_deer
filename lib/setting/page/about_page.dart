
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/device_utils.dart';
import 'package:flutter_deer/util/other_utils.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';
import 'package:flutter_deer/widgets/click_item.dart';

class AboutPage extends StatefulWidget {

  const AboutPage({Key key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  final List<FlutterLogoStyle> _styles = <FlutterLogoStyle>[
    FlutterLogoStyle.stacked,
    FlutterLogoStyle.markOnly,
    FlutterLogoStyle.horizontal
  ];

  final List<Cubic> _curves = <Cubic>[
    Curves.ease, Curves.easeIn, Curves.easeInOutCubic, Curves.easeInOut,
    Curves.easeInQuad, Curves.easeInCirc, Curves.easeInBack, Curves.easeInOutExpo,
    Curves.easeInToLinear, Curves.easeOutExpo, Curves.easeInOutSine, Curves.easeOutSine,
  ];
  
  // 取随机颜色
  Color _randomColor() {
    final int red = Random.secure().nextInt(255);
    final int greed = Random.secure().nextInt(255);
    final int blue = Random.secure().nextInt(255);
    return Color.fromARGB(255, red, greed, blue);
  }

  Timer _countdownTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // 2s定时器
      _countdownTimer = Timer.periodic(const Duration(seconds: 2), (_) {
        // https://www.jianshu.com/p/e4106b829bff
        if (!mounted) {
          return;
        }
        setState(() {

        });
      });
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: '关于我们',
      ),
      body: Column(
        children: <Widget>[
          Gaps.vGap50,
          FlutterLogo(
            size: 100.0,
            textColor: _randomColor(),
            style: _styles[Random.secure().nextInt(3)],
            curve: _curves[Random.secure().nextInt(12)],
          ),
          Gaps.vGap10,
          ClickItem(
            title: 'Github',
            content: 'Go Star',
            onTap: () => _launchWebURL('Flutter Deer', 'https://github.com/simplezhli/flutter_deer')
          ),
          ClickItem(
            title: '作者博客',
            onTap: () => _launchWebURL('作者博客', 'https://weilu.blog.csdn.net')
          ),
        ],
      ),
    );
  }

  void _launchWebURL(String title, String url) {
    if (Device.isMobile) {
      NavigatorUtils.goWebViewPage(context, title, url);
    } else {
      Utils.launchWebURL(url);
    }
  }
}
