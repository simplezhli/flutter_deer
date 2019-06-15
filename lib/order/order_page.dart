

import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/app_navigator.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/util/utils.dart';
import 'package:flutter_deer/widgets/my_card.dart';
import 'package:flutter_deer/widgets/my_flexible_space_bar.dart';

import 'order_info_page.dart';
import 'order_search_page.dart';
import 'order_track_page.dart';
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
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: _sliverBuilder(),
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
              AppNavigator.push(context, OrderSearch());
            },
            icon: Image.asset(
              Utils.getImgPath("order/icon_search"),
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
          background: Image.asset(
            Utils.getImgPath("order/order_bg"),
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
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.only(top: 8.0),
              child: index % 5 == 0 ? _getTimeTag() : _getOrderItem(),
            );
          },
          childCount: 50),
        ),
      ),
    ];
  }
  
  Widget _getOrderItem(){
    return MyCard(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: InkWell(
          onTap: (){
            AppNavigator.push(context, OrderInfo());
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
                          AppNavigator.push(context, OrderTrack());
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
                            showDialog(
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
                onPressed: () => Navigator.of(context).pop(),
                child: Text('取消'),
              ),
              FlatButton(
                onPressed: (){
                  Utils.launchTelURL(phone);
                  Navigator.of(context).pop();
                },
                textColor: Colours.text_red,
                child: Text('拨打'),
              ),
            ],
          );
        });
  }

  Widget _getTimeTag(){
    return MyCard(
        child: Container(
          height: 34.0,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: <Widget>[
              Image.asset(Utils.getImgPath("order/icon_calendar"), width: 14.0, height: 14.0),
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
                Image.asset(Utils.getImgPath(_index == index ? selImg : unImg), width: 24.0, height: 24.0,),
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