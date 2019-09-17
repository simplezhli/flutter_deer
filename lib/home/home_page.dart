
import 'package:flutter/material.dart';
import 'package:flutter_deer/goods/page/goods_page.dart';
import 'package:flutter_deer/home/provider/home_provider.dart';
import 'package:flutter_deer/order/page/order_page.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/shop/page/shop_page.dart';
import 'package:flutter_deer/statistics/page/statistics_page.dart';
import 'package:flutter_deer/util/image_utils.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var _pageList;
  var _tabImages;
  var _appBarTitles = ['订单', '商品', '统计', '店铺'];
  final _pageController = PageController();

  HomeProvider provider = HomeProvider();

  List<BottomNavigationBarItem> _list;

  @override
  void initState() {
    super.initState();
    initData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _preCacheImage();
    });
  }

  _preCacheImage(){
    /// 预先缓存剩余图片
    precacheImage(ImageUtils.getAssetImage("home/icon_Order_n"), context);
    precacheImage(ImageUtils.getAssetImage("home/icon_commodity_s"), context);
    precacheImage(ImageUtils.getAssetImage("home/icon_statistics_s"), context);
    precacheImage(ImageUtils.getAssetImage("home/icon_Shop_s"), context);
  }
  
  void initData(){
    _pageList = [
      OrderPage(),
      GoodsPage(),
      StatisticsPage(),
      ShopPage(),
    ];

    _tabImages = [
      [
        const LoadAssetImage("home/icon_Order_n"),
        const LoadAssetImage("home/icon_Order_s"),
      ],
      [
        const LoadAssetImage("home/icon_commodity_n"),
        const LoadAssetImage("home/icon_commodity_s"),
      ],
      [
        const LoadAssetImage("home/icon_statistics_n"),
        const LoadAssetImage("home/icon_statistics_s"),
      ],
      [
        const LoadAssetImage("home/icon_Shop_n"),
        const LoadAssetImage("home/icon_Shop_s"),
      ]
    ];

    _list = List.generate(4, (i){
      return BottomNavigationBarItem(
          icon: _tabImages[i][0],
          activeIcon: _tabImages[i][1],
          title: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(_appBarTitles[i], key: Key(_appBarTitles[i]),),
          )
      );
    });
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
    return ChangeNotifierProvider<HomeProvider>(
      builder: (_) => provider,
      child: WillPopScope(
        onWillPop: _isExit,
        child: Scaffold(
          bottomNavigationBar: Consumer<HomeProvider>(
            builder: (_, provider, __){
              return BottomNavigationBar(
                backgroundColor: Colors.white,
                items: _list,
                type: BottomNavigationBarType.fixed,
                currentIndex: provider.value,
                elevation: 5.0,
                iconSize: 21.0,
                selectedFontSize: Dimens.font_sp10,
                unselectedFontSize: Dimens.font_sp10,
                selectedItemColor: Colours.app_main,
                unselectedItemColor: const Color(0xffbfbfbf),
                onTap: (index){
                  _pageController.jumpToPage(index);
                },
              );
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
      ),
    );
  }

  void _onPageChanged(int index) {
    provider.value = index;
  }

}
