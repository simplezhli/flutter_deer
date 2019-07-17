

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/image_utils.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/util/utils.dart';
import 'package:flutter_deer/widgets/my_card.dart';
import 'package:flutter_deer/widgets/my_flexible_space_bar.dart';
import 'package:flutter_deer/widgets/state_layout.dart';

import 'order_router.dart';
import 'pay_type_dialog.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> with AutomaticKeepAliveClientMixin<Order>{

  @override
  bool get wantKeepAlive => true;
  
  int _index = 0;
  var _orderLeftButtonText = ["拒单", "拒单", "订单跟踪", "订单跟踪", "订单跟踪"];
  var _orderRightButtonText = ["接单", "开始配送", "完成", "", ""];
  
  /// 是否正在加载数据
  bool _isLoading = false;
  int _page = 1;
  final int _maxPage = 3;
  StateType _stateType = StateType.loading;
  
  @override
  void initState() {
    super.initState();
    _onRefresh();
  }
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: NotificationListener(
        onNotification: (ScrollNotification note){
          if(note.metrics.pixels == note.metrics.maxScrollExtent){
            _loadMore();
          }
        },
        /// 问题参看：https://github.com/flutter/flutter/issues/34727 
        /// 原生方案中，暂时可以采取的最好方案了
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: CustomScrollView(
            physics: ClampingScrollPhysics(),
            slivers: _sliverBuilder(),
          ),
        ),
      ),
    );
  }
  
  List<Widget> _sliverBuilder() {
    return <Widget>[
      SliverAppBar(
        leading: Container(),
        actions: <Widget>[
          IconButton(
            onPressed: (){
              NavigatorUtils.push(context, OrderRouter.orderSearchPage);
            },
            icon: loadAssetImage("order/icon_search",
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
          background: loadAssetImage("order/order_bg",
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
      SliverPersistentHeader(
        pinned: true,
        delegate: SliverAppBarDelegate(
            DecoratedBox(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Utils.getImgPath("order/order_bg1")),
                    fit: BoxFit.fill
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: <Widget>[
                    MyCard(
                      child: Container(
                        height: 80.0,
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            _buildTabView(0, "order/xdd_s", "order/xdd_n", '新订单'),
                            _buildTabView(1, "order/dps_s", "order/dps_n", '待配送'),
                            _buildTabView(2, "order/dwc_s", "order/dwc_n", '待完成'),
                            _buildTabView(3, "order/ywc_s", "order/ywc_n", '已完成'),
                            _buildTabView(4, "order/yqx_s", "order/yqx_n", '已取消'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          , 80.0
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        sliver: _list.isEmpty ? SliverFillRemaining(child: StateLayout(type: _stateType)) : SliverList(
          delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.only(top: 8.0),
              child: index < _list.length ? (index % 5 == 0 ? _buildTimeTag() : _buildOrderItem()) : _buildMoreWidget(),
            );
          },
          childCount: _list.length + 1),
        ),
      ),
    ];
  }

  List _list = [];

  Future _onRefresh() async {
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _page = 1;
        _list = List.generate(10, (i) => 'newItem：$i');
      });
    });
  }
  
  bool _hasMore(){
    return _page < _maxPage;
  }

  Future _loadMore() async {
    if (_isLoading) {
      return;
    }
    if (!_hasMore()){
      return;
    }
    _isLoading = true;
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _list.addAll(List.generate(10, (i) => 'newItem：$i'));
        _page ++;
        _isLoading = false;
      });
    });
  }
  
  Widget _buildMoreWidget(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Offstage(offstage: !_hasMore(), child: const CupertinoActivityIndicator()),
          Offstage(offstage: !_hasMore(), child: Gaps.hGap5),
          Text(!_hasMore() ? '没有了呦~' : '正在加载中...', style: TextStyle(color: const Color(0x8A000000))),
        ],
      ),
    );
  }
  
  Widget _buildOrderItem(){
    return MyCard(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: InkWell(
          onTap: (){
            NavigatorUtils.push(context, OrderRouter.orderInfoPage);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "15000000000（郭李）",
                      style: TextStyles.textDark14,
                    ),
                  ),
                  Text(
                    "货到付款",
                    style: TextStyle(
                        fontSize: Dimens.font_sp12,
                        color: Colours.text_red
                    ),
                  ),
                ],
              ),
              Gaps.vGap8,
              Text(
                "西安市雁塔区 鱼化寨街道唐兴路唐兴数码3楼318",
                style: TextStyles.textNormal12,
              ),
              Gaps.vGap8,
              Gaps.line,
              Gaps.vGap8,
              RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: '清凉一度抽纸', style: TextStyles.textDark12),
                      TextSpan(text: '  x1', style: TextStyles.textGray12),
                    ],
                  )
              ),
              Gaps.vGap8,
              RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: '清凉一度抽纸', style: TextStyles.textDark12),
                      TextSpan(text: '  x2', style: TextStyles.textGray12),
                    ],
                  )
              ),
              Gaps.vGap12,
              Row(
                children: <Widget>[
                  Expanded(
                    child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(text: '¥20.00', style: TextStyles.textDark12),
                            TextSpan(text: '  共3件商品', style: TextStyles.textGray10),
                          ],
                        )
                    ),
                  ),
                  Text(
                    "2018.02.05 10:00",
                    style: TextStyles.textDark12,
                  ),
                ],
              ),
              Gaps.vGap8,
              Gaps.line,
              Gaps.vGap8,
              Theme( // 修改button默认的最小宽度与padding
                data: Theme.of(context).copyWith(
                  buttonTheme: ButtonThemeData(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    minWidth: 64.0,
                    height: 30.0,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // 距顶部距离为0
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    )
                  ),
                  textTheme: TextTheme(
                    button: TextStyle(
                      fontSize: Dimens.font_sp14,
                    )
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    FlatButton(
                      color: Colours.bg_gray,
                      child: Text("联系客户"),
                      onPressed: (){
                        _showCallPhoneDialog("15000000000");
                      },
                    ),
                    Expanded(
                      child: Gaps.empty,
                    ),
                    FlatButton(
                      color: Colours.bg_gray,
                      child: Text(_orderLeftButtonText[_index]),
                      onPressed: (){
                        if (_index >= 2){
                          NavigatorUtils.push(context, OrderRouter.orderTrackPage);
                        }
                      },
                    ),
                    Offstage(
                      offstage: _orderRightButtonText[_index].length == 0,
                      child: Gaps.hGap10,
                    ),
                    Offstage(
                      offstage: _orderRightButtonText[_index].length == 0,
                      child: FlatButton(
                        color: Colours.app_main,
                        textColor: Colors.white,
                        onPressed: (){
                          if (_index == 2){
                            showElasticDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return PayTypeDialog(
                                    onPressed: (index, type){
                                      Toast.show("收款类型：$type");
                                    },
                                  );
                                });
                          }
                        },
                        child: Text(_orderRightButtonText[_index]),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  
  void _showCallPhoneDialog(String phone){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('提示'),
            content: Text('是否拨打：$phone ?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => NavigatorUtils.goBack(context),
                child: Text('取消'),
              ),
              FlatButton(
                onPressed: (){
                  Utils.launchTelURL(phone);
                  NavigatorUtils.goBack(context);
                },
                textColor: Colours.text_red,
                child: Text('拨打'),
              ),
            ],
          );
        });
  }

  Widget _buildTimeTag(){
    return MyCard(
        child: Container(
          height: 34.0,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: <Widget>[
              loadAssetImage("order/icon_calendar", width: 14.0, height: 14.0),
              Gaps.hGap10,
              Text(
                "2019年2月5日",
                style: TextStyles.textDark14,
              ),
              Expanded(child: Container()),
              Text(
                "4单",
                style: TextStyles.textDark14,
              )
            ],
          ),
        ));
  }
  
  Widget _buildTabView(int index, String selImg, String unImg, String text){
    return InkWell(
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                loadAssetImage(_index == index ? selImg : unImg, width: 24.0, height: 24.0,),
                Gaps.vGap4,
                Text(text, style: TextStyle(fontWeight: _index == index ? FontWeight.bold : FontWeight.normal))
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
                padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                child: Text("10", style: TextStyle(color: Colors.white, fontSize: Dimens.font_sp12),),
              ),
            ) : Gaps.empty,
          )
        ],
      ),
      onTap: (){
        setState(() {
          _index = index;
        });
      },
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