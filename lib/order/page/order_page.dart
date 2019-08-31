

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/order/widgets/order_list.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/image_utils.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:flutter_deer/widgets/my_card.dart';
import 'package:flutter_deer/widgets/my_flexible_space_bar.dart';

import '../order_router.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with AutomaticKeepAliveClientMixin<OrderPage>, SingleTickerProviderStateMixin{

  @override
  bool get wantKeepAlive => true;
  
  TabController _tabController;
  int _index = 0;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      /// 预先缓存剩余切换图片
      _preCacheImage();
    });
  }

  _preCacheImage(){
    precacheImage(AssetImage(ImageUtils.getImgPath("order/xdd_n")), context);
    precacheImage(AssetImage(ImageUtils.getImgPath("order/dps_s")), context);
    precacheImage(AssetImage(ImageUtils.getImgPath("order/dwc_s")), context);
    precacheImage(AssetImage(ImageUtils.getImgPath("order/ywc_s")), context);
    precacheImage(AssetImage(ImageUtils.getImgPath("order/yqx_s")), context);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          /// 像素对齐问题的临时解决方法
          const SafeArea(
            child: const SizedBox(
              height: 105,
              width: double.infinity,
              child: const DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: const [Color(0xFF5793FA), Color(0xFF4647FA)])
                  )
              ),
            ),
          ),
          NestedScrollView(
            physics: ClampingScrollPhysics(),
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return _sliverBuilder(context);
            },
            body: PageView.builder(
              itemCount: 5,
              onPageChanged: _onPageChange,
              controller: _pageController,
              itemBuilder: (_, index) {
                return OrderList(index: index, tabIndex: _index);
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _sliverBuilder(BuildContext context) {
    return <Widget>[
      SliverOverlapAbsorber(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        child: SliverAppBar(
          leading: Gaps.empty,
          actions: <Widget>[
            IconButton(
              onPressed: (){
                NavigatorUtils.push(context, OrderRouter.orderSearchPage);
              },
              icon: const LoadAssetImage("order/icon_search",
                width: 22.0,
                height: 22.0,
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
            background: const LoadAssetImage("order/order_bg",
              width: double.infinity,
              height: 113.0,
              fit: BoxFit.fill,
            ),
            centerTitle: true,
            titlePadding: const EdgeInsetsDirectional.only(start: 16.0, bottom: 14.0),
            collapseMode: CollapseMode.pin,
            title: Text('订单'),
          ),
        ),
      ),
      SliverPersistentHeader(
        pinned: true,
        delegate: SliverAppBarDelegate(
            DecoratedBox(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(ImageUtils.getImgPath("order/order_bg1")),
                      fit: BoxFit.fill
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: MyCard(
                  child: Container(
                    height: 80.0,
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TabBar(
                      labelPadding: const EdgeInsets.symmetric(horizontal: 0),
                      controller: _tabController,
                      labelColor: Colours.text_dark,
                      unselectedLabelColor: Colours.text_dark,
                      labelStyle: TextStyles.textBoldDark14,
                      unselectedLabelStyle: TextStyles.textDark14,
                      indicatorColor: Colors.transparent,
                      tabs: <Widget>[
                        _TabView(0, "order/xdd_s", "order/xdd_n", '新订单', _index),
                        _TabView(1, "order/dps_s", "order/dps_n", '待配送', _index),
                        _TabView(2, "order/dwc_s", "order/dwc_n", '待完成', _index),
                        _TabView(3, "order/ywc_s", "order/ywc_n", '已完成', _index),
                        _TabView(4, "order/yqx_s", "order/yqx_n", '已取消', _index),
                      ],
                      onTap: (index){
                        if (!mounted){
                          return;
                        }
                        _pageController.jumpToPage(index);
                      },
                    ),
                  ),
                ),
              ),
            )
            , 80.0
        ),
      ),

    ];
  }

  PageController _pageController = PageController(initialPage: 0);
  _onPageChange(int index) {
    _tabController.animateTo(index);
    _index = index;
    setState(() {

    });
  }

}

class _TabView extends StatelessWidget {

  const _TabView(this.index, this.selImg, this.unImg, this.text, this.selectIndex);

  final int index;
  final String selImg;
  final String unImg;
  final String text;
  final int selectIndex;
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: 46.0,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              LoadAssetImage(selectIndex == index ? selImg : unImg, width: 24.0, height: 24.0,),
              Gaps.vGap4,
              Text(text)
            ],
          ),
        ),
        Positioned(
          right: 0.0,
          child: index < 3 ? DecoratedBox(
            decoration: BoxDecoration(
              color: Colours.text_red,
              borderRadius: BorderRadius.circular(11.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.5, vertical: 2.0),
              child: Text("10", style: TextStyle(color: Colors.white, fontSize: Dimens.font_sp12),),
            ),
          ) : Gaps.empty,
        )
      ],
    );
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget widget;
  final double height;
  SliverAppBarDelegate(this.widget, this.height);

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