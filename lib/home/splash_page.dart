
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_deer/common/common.dart';
import 'package:flutter_deer/login/login_router.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/image_utils.dart';
import 'package:flutter_deer/util/log_utils.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flustars/flustars.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  int _status = 0;
  List<String> _guideList = ["app_start_1", "app_start_2", "app_start_3"];
  StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Log.init();
      await SpUtil.getInstance();
      if (SpUtil.getBool(Constant.key_guide, defValue: true)){
        /// 预先缓存图片，避免直接使用时因为首次加载造成闪动
        _guideList.forEach((image){
          precacheImage(ImageUtils.getAssetImage(image), context);
        });
      }
      _initSplash();
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _initGuide() {
    setState(() {
      _status = 1;
    });
  }

  void _initSplash(){
    _subscription = Observable.just(1).delay(Duration(milliseconds: 1500)).listen((_){
      if (SpUtil.getBool(Constant.key_guide, defValue: true)) {
        SpUtil.putBool(Constant.key_guide, false);
        _initGuide();
      } else {
        _goLogin();
      }
    });
  }

  _goLogin(){
    NavigatorUtils.push(context, LoginRouter.loginPage, replace: true);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: _status == 0 ? Image.asset(
        ImageUtils.getImgPath("start_page", format: "jpg"),
        width: double.infinity,
        fit: BoxFit.fill,
        height: double.infinity,
      ) : Swiper(
        key: const Key('swiper'),
        itemCount: _guideList.length,
        loop: false,
        itemBuilder: (_, index){
          return LoadAssetImage(
            _guideList[index],
            key: Key(_guideList[index]),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          );
        },
        onTap: (index){
          if (index == _guideList.length - 1){
            _goLogin();
          }
        },
      )
    );
  }
}
