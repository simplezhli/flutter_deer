
import 'package:flutter/material.dart';
import 'package:flutter_deer/order/page/order_list_page.dart';
import 'package:flutter_deer/order/provider/order_page_provider.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/image_utils.dart';
import 'package:flutter_deer/util/screen_utils.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:flutter_deer/widgets/my_card.dart';
import 'package:flutter_deer/widgets/my_flexible_space_bar.dart';
import 'package:provider/provider.dart';

import '../order_router.dart';


/// design/3订单/index.html
class OrderPage extends StatefulWidget {

  const OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with AutomaticKeepAliveClientMixin<OrderPage>, SingleTickerProviderStateMixin {

  @override
  bool get wantKeepAlive => true;
  
  TabController? _tabController;
  OrderPageProvider provider = OrderPageProvider();

  int _lastReportedPage = 0;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      /// 预先缓存剩余切换图片
      _preCacheImage();
    });
  }

  void _preCacheImage() {
    precacheImage(ImageUtils.getAssetImage('order/xdd_n'), context);
    precacheImage(ImageUtils.getAssetImage('order/dps_s'), context);
    precacheImage(ImageUtils.getAssetImage('order/dwc_s'), context);
    precacheImage(ImageUtils.getAssetImage('order/ywc_s'), context);
    precacheImage(ImageUtils.getAssetImage('order/yqx_s'), context);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    isDark = context.isDark;
    return ChangeNotifierProvider<OrderPageProvider>(
      create: (_) => provider,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            /// 像素对齐问题的临时解决方法
            SafeArea(
              child: SizedBox(
                height: 105,
                width: double.infinity,
                child: isDark ? null : const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Colours.gradient_blue, Color(0xFF4647FA)]),
                  ),
                ),
              ),
            ),
            NestedScrollView(
              key: const Key('order_list'),
              physics: const ClampingScrollPhysics(),
              headerSliverBuilder: (context, innerBoxIsScrolled) => _sliverBuilder(context),
              body: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification notification) {
                  /// PageView的onPageChanged是监听ScrollUpdateNotification，会造成滑动中卡顿。这里修改为监听滚动结束再更新、
                  if (notification.depth == 0 && notification is ScrollEndNotification) {
                    final PageMetrics metrics = notification.metrics as PageMetrics;
                    final int currentPage = (metrics.page ?? 0).round();
                    if (currentPage != _lastReportedPage) {
                      _lastReportedPage = currentPage;
                      _onPageChange(currentPage);
                    }
                  }
                  return false;
                },
                child: PageView.builder(
                  key: const Key('pageView'),
                  itemCount: 5,
                  controller: _pageController,
                  itemBuilder: (_, index) => OrderListPage(index: index),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _sliverBuilder(BuildContext context) {
    return <Widget>[
      SliverOverlapAbsorber(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        sliver: SliverAppBar(
          brightness: Brightness.dark,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                NavigatorUtils.push(context, OrderRouter.orderSearchPage);
              },
              tooltip: '搜索',
              icon: LoadAssetImage('order/icon_search',
                width: 22.0,
                height: 22.0,
                color: ThemeUtils.getIconColor(context),
              ),
            )
          ],
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          expandedHeight: 100.0,
          floating: false, // 不随着滑动隐藏标题
          pinned: true, // 固定在顶部
          flexibleSpace: MyFlexibleSpaceBar(
            background: isDark ? Container(height: 113.0, color: Colours.dark_bg_color,) : LoadAssetImage('order/order_bg',
              width: context.width,
              height: 113.0,
              fit: BoxFit.fill,
            ),
            centerTitle: true,
            titlePadding: const EdgeInsetsDirectional.only(start: 16.0, bottom: 14.0),
            collapseMode: CollapseMode.pin,
            title: Text('订单', style: TextStyle(color: ThemeUtils.getIconColor(context)),),
          ),
        ),
      ),
      SliverPersistentHeader(
        pinned: true,
        delegate: SliverAppBarDelegate(
          DecoratedBox(
            decoration: BoxDecoration(
              color: isDark ? Colours.dark_bg_color : null,
              image: isDark ? null : DecorationImage(
                image: ImageUtils.getAssetImage('order/order_bg1'),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: MyCard(
                child: Container(
                  height: 80.0,
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TabBar(
                    labelPadding: EdgeInsets.zero,
                    controller: _tabController,
                    labelColor: context.isDark ? Colours.dark_text : Colours.text,
                    unselectedLabelColor: context.isDark ? Colours.dark_text_gray : Colours.text,
                    labelStyle: TextStyles.textBold14,
                    unselectedLabelStyle: const TextStyle(
                      fontSize: Dimens.font_sp14,
                    ),
                    indicatorColor: Colors.transparent,
                    tabs: const <Widget>[
                      _TabView(0, '新订单'),
                      _TabView(1, '待配送'),
                      _TabView(2, '待完成'),
                      _TabView(3, '已完成'),
                      _TabView(4, '已取消'),
                    ],
                    onTap: (index) {
                      if (!mounted) {
                        return;
                      }
                      _pageController.jumpToPage(index);
                    },
                  ),
                ),
              ),
            ),
          ), 80.0,
        ),
      ),
    ];
  }

  final PageController _pageController = PageController(initialPage: 0);
  Future<void> _onPageChange(int index) async {
    provider.setIndex(index);
    /// 这里没有指示器，所以缩短过渡动画时间，减少不必要的刷新
    _tabController?.animateTo(index, duration: Duration.zero);
  }
}

List<List<String>> img = [
  ['order/xdd_s', 'order/xdd_n'],
  ['order/dps_s', 'order/dps_n'],
  ['order/dwc_s', 'order/dwc_n'],
  ['order/ywc_s', 'order/ywc_n'],
  ['order/yqx_s', 'order/yqx_n']
];

List<List<String>> darkImg = [
  ['order/dark/icon_xdd_s', 'order/dark/icon_xdd_n'],
  ['order/dark/icon_dps_s', 'order/dark/icon_dps_n'],
  ['order/dark/icon_dwc_s', 'order/dark/icon_dwc_n'],
  ['order/dark/icon_ywc_s', 'order/dark/icon_ywc_n'],
  ['order/dark/icon_yqx_s', 'order/dark/icon_yqx_n']
];

class _TabView extends StatelessWidget {

  const _TabView(this.index, this.text);

  final int index;
  final String text;
  
  @override
  Widget build(BuildContext context) {
    final List<List<String>> imgList = context.isDark ? darkImg : img;
    return Stack(
      children: <Widget>[
        Container(
          width: 46.0,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              /// 使用context.select替代Consumer
              LoadAssetImage(context.select<OrderPageProvider, int>((value) => value.index) == index ? 
              imgList[index][0] : 
              imgList[index][1], width: 24.0, height: 24.0,),
              Gaps.vGap4,
              Text(text),
            ],
          ),
        ),
        Positioned(
          right: 0.0,
          child: index < 3 ? DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).errorColor,
              borderRadius: BorderRadius.circular(11.0),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.5, vertical: 2.0),
              child: Text('10', style: TextStyle(color: Colors.white, fontSize: Dimens.font_sp12),),
            ),
          ) : Gaps.empty,
        )
      ],
    );
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {

  SliverAppBarDelegate(this.widget, this.height);

  final Widget widget;
  final double height;

  // minHeight 和 maxHeight 的值设置为相同时，header就不会收缩了
  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return widget;
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return true;
  }
}