import 'dart:io';

import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/goods/page/goods_page.dart';
import 'package:flutter_deer/home/provider/home_provider.dart';
import 'package:flutter_deer/order/page/order_page.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/shop/page/shop_page.dart';
import 'package:flutter_deer/statistics/page/statistics_page.dart';
import 'package:flutter_deer/util/device_utils.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/widgets/double_tap_back_exit_app.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {

  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with RestorationMixin{

  static const double _imageSize = 25.0;

  late List<Widget> _pageList;
  final List<String> _appBarTitles = ['订单', '商品', '统计', '店铺'];
  final PageController _pageController = PageController();

  HomeProvider provider = HomeProvider();

  List<BottomNavigationBarItem>? _list;
  List<BottomNavigationBarItem>? _listDark;

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void initData() {
    _pageList = [
      const OrderPage(),
      const GoodsPage(),
      const StatisticsPage(),
      const ShopPage(),
    ];
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBarItem() {
    if (_list == null) {
      const tabImages = [
        [
          LoadAssetImage('home/icon_order', width: _imageSize, color: Colours.unselected_item_color,),
          LoadAssetImage('home/icon_order', width: _imageSize, color: Colours.app_main,),
        ],
        [
          LoadAssetImage('home/icon_commodity', width: _imageSize, color: Colours.unselected_item_color,),
          LoadAssetImage('home/icon_commodity', width: _imageSize, color: Colours.app_main,),
        ],
        [
          LoadAssetImage('home/icon_statistics', width: _imageSize, color: Colours.unselected_item_color,),
          LoadAssetImage('home/icon_statistics', width: _imageSize, color: Colours.app_main,),
        ],
        [
          LoadAssetImage('home/icon_shop', width: _imageSize, color: Colours.unselected_item_color,),
          LoadAssetImage('home/icon_shop', width: _imageSize, color: Colours.app_main,),
        ]
      ];
      _list = List.generate(tabImages.length, (i) {
        return BottomNavigationBarItem(
          icon: tabImages[i][0],
          activeIcon: tabImages[i][1],
          label: _appBarTitles[i],
          tooltip: _appBarTitles[i],
        );
      });
    }
    return _list!;
  }

  List<BottomNavigationBarItem> _buildDarkBottomNavigationBarItem() {
    if (_listDark == null) {
      const tabImagesDark = [
        [
          LoadAssetImage('home/icon_order', width: _imageSize),
          LoadAssetImage('home/icon_order', width: _imageSize, color: Colours.dark_app_main,),
        ],
        [
          LoadAssetImage('home/icon_commodity', width: _imageSize),
          LoadAssetImage('home/icon_commodity', width: _imageSize, color: Colours.dark_app_main,),
        ],
        [
          LoadAssetImage('home/icon_statistics', width: _imageSize),
          LoadAssetImage('home/icon_statistics', width: _imageSize, color: Colours.dark_app_main,),
        ],
        [
          LoadAssetImage('home/icon_shop', width: _imageSize),
          LoadAssetImage('home/icon_shop', width: _imageSize, color: Colours.dark_app_main,),
        ]
      ];

      _listDark = List.generate(tabImagesDark.length, (i) {
        return BottomNavigationBarItem(
          icon: tabImagesDark[i][0],
          activeIcon: tabImagesDark[i][1],
          label: _appBarTitles[i],
          tooltip: _appBarTitles[i],
        );
      });
    }
    return _listDark!;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Widget home = Device.isIOS26Plus
        ? _buildGlassHome(context, isDark)
        : _buildHome(context, isDark);
    return ChangeNotifierProvider<HomeProvider>(
      create: (_) => provider,
      child: DoubleTapBackExitApp(child: home),
    );
  }

  /// iOS 26+：底部导航换用原生 UITabBar（液态玻璃），内容延伸至栏下方以呈现玻璃透出效果。
  /// 必须走 AdaptiveScaffold 才能使用包的原生路径，配合 main.dart 安装的 AdaptiveToolbarHost，
  /// 在 iPhone Duo 上 tab 栏会停靠到侧边栏成为液态玻璃胶囊。
  Widget _buildGlassHome(BuildContext context, bool isDark) {
    return Consumer<HomeProvider>(
      builder: (_, provider, __) {
        return AdaptiveScaffold(
          backgroundColor: context.backgroundColor,
          bottomNavigationBar: AdaptiveBottomNavigationBar(
            items: _buildGlassDestinations(),
            selectedIndex: provider.value,
            onTap: (index) => _pageController.jumpToPage(index),
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: isDark
                ? Colours.dark_unselected_item_color
                : Colours.unselected_item_color,
          ),
          // 底部悬浮玻璃 tab 栏的让位距离由各 tab 页面的列表自行预留
          // （见 Device.glassTabBarBottomInset），此处不做整体裁剪，内容可滑至栏下。
          // 使用PageView的原因参看 https://zhuanlan.zhihu.com/p/58582876
          body: PageView(
            physics: const NeverScrollableScrollPhysics(), // 禁止滑动
            controller: _pageController,
            onPageChanged: (int index) => provider.value = index,
            children: _pageList,
          ),
        );
      },
    );
  }

  /// 原生 UITabBar 的图标使用 SF Symbols（PNG 资产在原生侧无法着色）
  List<AdaptiveNavigationDestination> _buildGlassDestinations() {
    const icons = [
      ['list.clipboard', 'list.clipboard.fill'],
      ['shippingbox', 'shippingbox.fill'],
      ['chart.bar', 'chart.bar.fill'],
      ['storefront', 'storefront.fill'],
    ];
    return List<AdaptiveNavigationDestination>.generate(
      icons.length,
      (i) => AdaptiveNavigationDestination(
        icon: icons[i][0],
        selectedIcon: icons[i][1],
        label: _appBarTitles[i],
      ),
    );
  }

  Widget _buildHome(BuildContext context, bool isDark) {
    return Scaffold(
      bottomNavigationBar: Consumer<HomeProvider>(
        builder: (_, provider, __) {
          return BottomNavigationBar(
            backgroundColor: context.backgroundColor,
            items: isDark ? _buildDarkBottomNavigationBarItem() : _buildBottomNavigationBarItem(),
            type: BottomNavigationBarType.fixed,
            currentIndex: provider.value,
            elevation: Platform.isIOS ? 0.0 : 5.0,
            iconSize: 21.0,
            selectedFontSize: Dimens.font_sp10,
            unselectedFontSize: Dimens.font_sp10,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: isDark ? Colours.dark_unselected_item_color : Colours.unselected_item_color,
            onTap: (index) => _pageController.jumpToPage(index),
          );
        },
      ),
      // 使用PageView的原因参看 https://zhuanlan.zhihu.com/p/58582876
      body: PageView(
        physics: const NeverScrollableScrollPhysics(), // 禁止滑动
        controller: _pageController,
        onPageChanged: (int index) => provider.value = index,
        children: _pageList,
      ),
    );
  }

  @override
  String? get restorationId => 'home';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(provider, 'BottomNavigationBarCurrentIndex');
  }

}
