
import 'package:flutter/material.dart';
import 'package:flutter_deer/order/order_page.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/statistics/statistics_page.dart';
import 'package:flutter_deer/util/utils.dart';

import 'goods/goods_page.dart';
import 'shop/shop_page.dart';

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
        Image.asset(Utils.getImgPath("home/icon_Order_n")),
        Image.asset(Utils.getImgPath("home/icon_Order_s")),
      ],
      [
        Image.asset(Utils.getImgPath("home/icon_commodity_n")),
        Image.asset(Utils.getImgPath("home/icon_commodity_s")),
      ],
      [
        Image.asset(Utils.getImgPath("home/icon_statistics_n")),
        Image.asset(Utils.getImgPath("home/icon_statistics_s")),
      ],
      [
        Image.asset(Utils.getImgPath("home/icon_Shop_n")),
        Image.asset(Utils.getImgPath("home/icon_Shop_s")),
      ]
    ];
  }

  Image getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return _tabImages[curIndex][1];
    }
    return _tabImages[curIndex][0];
  }

  Widget getTabText(int curIndex) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Text(_appBarTitles[curIndex]),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: getTabIcon(0),
            title: getTabText(0)
          ),
          BottomNavigationBarItem(
            icon: getTabIcon(1),
            title: getTabText(1)
          ),
          BottomNavigationBarItem(
            icon: getTabIcon(2),
            title: getTabText(2)
          ),
          BottomNavigationBarItem(
            icon: getTabIcon(3),
            title: getTabText(3)
          ),
        ],
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
        onPageChanged: onPageChanged,
        children: _pageList,
        physics: NeverScrollableScrollPhysics(), // 禁止滑动
      )
    );
  }

  void onPageChanged(int index) {
    setState(() {
      _tabIndex = index;
    });
  }

}
