
import 'package:flutter/material.dart';
import 'package:flutter_deer/goods/goods_page.dart';
import 'package:flutter_deer/order/order_page.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/shop/shop_page.dart';
import 'package:flutter_deer/statistics/statistics_page.dart';
import 'package:flutter_deer/util/image_utils.dart';
import 'package:flutter_deer/util/toast.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  int _tabIndex = 0;
  var _pageList;
  var _tabImages;
  var _appBarTitles = ['订单', '商品', '统计', '店铺'];
  final _pageController = PageController();
  
  @override
  void initState() {
    super.initState();
    initData();
  }
  
  void initData(){
    _pageList = [
      Order(),
      Goods(),
      Statistics(),
      Shop(),
    ];

    _tabImages = [
      [
        loadAssetImage("home/icon_Order_n"),
        loadAssetImage("home/icon_Order_s"),
      ],
      [
        loadAssetImage("home/icon_commodity_n"),
        loadAssetImage("home/icon_commodity_s"),
      ],
      [
        loadAssetImage("home/icon_statistics_n"),
        loadAssetImage("home/icon_statistics_s"),
      ],
      [
        loadAssetImage("home/icon_Shop_n"),
        loadAssetImage("home/icon_Shop_s"),
      ]
    ];
  }

  Image _getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return _tabImages[curIndex][1];
    }
    return _tabImages[curIndex][0];
  }

  Widget _buildTabText(int curIndex) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Text(_appBarTitles[curIndex]),
    );
  }

  DateTime  _lastTime;
  
  Future<bool> _isExit(){
    if (_lastTime == null || DateTime.now().difference(_lastTime) > Duration(milliseconds: 2500)) {
      _lastTime = DateTime.now();
      Toast.show("再次点击退出应用");
      return Future.value(false);
    } 
    Toast.cancelToast();
    return Future.value(true);
  }
  
  @override
  Widget build(BuildContext context) {
    
    return WillPopScope(
      onWillPop: _isExit,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          items: List.generate(_appBarTitles.length, (i) => BottomNavigationBarItem(
              icon: _getTabIcon(i),
              title: _buildTabText(i)
          )),
          type: BottomNavigationBarType.fixed,
          currentIndex: _tabIndex,
          elevation: 5.0,
          iconSize: 21.0,
          selectedFontSize: Dimens.font_sp10,
          unselectedFontSize: Dimens.font_sp10,
          selectedItemColor: Colours.app_main,
          unselectedItemColor: Color(0xffbfbfbf),
          onTap: (index){
            _pageController.jumpToPage(index);
          },
        ),
        // 使用PageView的原因参看 https://zhuanlan.zhihu.com/p/58582876
        body: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: _pageList,
          physics: NeverScrollableScrollPhysics(), // 禁止滑动
        )
      ),
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _tabIndex = index;
    });
  }

}
