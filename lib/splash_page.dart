
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_deer/util/app_navigator.dart';
import 'package:flutter_deer/util/utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flukit/flukit.dart';
import 'common/common.dart';
import 'login/login_page.dart';
import 'util/sp_util.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  int _status = 0;
  List<String> _guideList = [
    Utils.getImgPath("app_start_1"),
    Utils.getImgPath("app_start_2"),
    Utils.getImgPath("app_start_3"),
  ];
  List<Widget> _bannerList = new List();
  StreamSubscription _subscription;
  
  @override
  void initState() {
    super.initState();
    _initSplash();
  }
  
  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
  
  void _initAsync() async {
    await SpUtil.getInstance();
    if (SpUtil.getBool(Constant.key_guide, defValue: true)) {
      SpUtil.putBool(Constant.key_guide, false);
      _initGuide();
    } else {
      _goLogin();
    }
  }

  void _initGuide() {
    _initBannerData();
    setState(() {
      _status = 1;
    });
  }
  
  void _initSplash(){
    _subscription = Observable.just(1).delay(Duration(milliseconds: 2000)).listen((_){
      _initAsync();
    });
  }
  
  _goLogin(){
    AppNavigator.pushAndRemoveUntil(context, Login());
  }

  void _initBannerData() {
    for (int i = 0, length = _guideList.length; i < length; i++) {
      if (i == length - 1) {
        _bannerList.add(InkWell(
          onTap: (){
            _goLogin();
          },
          child: Image.asset(
            _guideList[i],
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
        ));
      } else {
        _bannerList.add(Image.asset(
          _guideList[i],
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ));
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          Offstage(
            offstage: !(_status == 0),
            child: Image.asset(
              Utils.getImgPath("start_page", format: "jpg"),
              width: double.infinity,
              fit: BoxFit.fill,
              height: double.infinity,
            ),
          ),
          Offstage(
            offstage: !(_status == 1),
            child: ObjectUtil.isEmpty(_bannerList) 
                ? Container() 
                : Swiper(
                autoStart: false,
                circular: false,
                indicator: null,
                children: _bannerList),
          )
        ],
      ),
    );
  }
}
