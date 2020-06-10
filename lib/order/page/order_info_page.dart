

import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/utils.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:flutter_deer/widgets/my_scroll_view.dart';

import '../order_router.dart';


/// design/3订单/index.html#artboard10
class OrderInfoPage extends StatefulWidget {
  @override
  _OrderInfoPageState createState() => _OrderInfoPageState();
}

class _OrderInfoPageState extends State<OrderInfoPage> {
  
  @override
  Widget build(BuildContext context) {
    final Color red = Theme.of(context).errorColor;
    final Color blue = Theme.of(context).primaryColor;
    final bool isDark = ThemeUtils.isDark(context);

    Widget bottomMenu = Container(
      height: 60.0,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Theme(
        data: Theme.of(context).copyWith(
          buttonTheme: const ButtonThemeData(
            height: 44.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: FlatButton(
                color: isDark ? Colours.dark_material_bg : const Color(0xFFE1EAFA),
                textColor: isDark ? Colours.dark_text : Colours.app_main,
                child: const Text(
                  '拒单',
                  style: TextStyle(fontSize: Dimens.font_sp18),
                ),
                onPressed: () {},
              ),
            ),
            Gaps.hGap16,
            Expanded(
              flex: 1,
              child: FlatButton(
                color: blue,
                textColor: isDark ? Colours.dark_button_text : Colors.white,
                child: const Text(
                  '接单',
                  style: TextStyle(fontSize: Dimens.font_sp18),
                ),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );

    List<Widget> children = [
      const Text(
        '暂未接单',
        style: TextStyles.textBold24,
      ),
      Gaps.vGap32,
      const Text(
        '客户信息',
        style: TextStyles.textBold18,
      ),
      Gaps.vGap16,
      Row(
        children: <Widget>[
          const ClipOval(
            child: LoadAssetImage('order/icon_avatar', width: 44.0, height: 44.0),
          ),
          Gaps.hGap8,
          Expanded(
            // 合并Text的语义
            child: MergeSemantics(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('郭李'),
                  Gaps.vGap8,
                  const Text('15000000000'),
                ],
              ),
            ),
          ),
          Gaps.vLine,
          //Gaps.hGap16,
          Semantics(
            label: '拨打电话',
            child: GestureDetector(
              child: const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: LoadAssetImage('order/icon_phone', width: 24.0, height: 44.0),
              ),
              onTap: () => _showCallPhoneDialog('15000000000'),
            ),
          )
        ],
      ),
      Gaps.vGap10,
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const LoadAssetImage('order/icon_address', width: 16.0, height: 20.0),
          Gaps.hGap4,
          const Expanded(child: Text('西安市雁塔区 鱼化寨街道唐兴路唐兴数码3楼318', maxLines: 2)),
        ],
      ),
      Gaps.vGap32,
      const Text(
        '商品信息',
        style: TextStyles.textBold18,
      ),
      ListView.builder(
        // 如果滚动视图在滚动方向无界约束，那么shrinkWrap必须为true
          shrinkWrap: true,
          // 禁用ListView滑动，使用外层的ScrollView滑动
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 2,
          itemBuilder: (_, index) => _getOrderGoodsItem(index)
      ),
      Gaps.vGap8,
      _getGoodsInfoItem('共2件商品', Utils.formatPrice('50.00')),
      _getGoodsInfoItem('配送费', Utils.formatPrice('5.00')),
      _getGoodsInfoItem('立减', Utils.formatPrice('-2.50'), contentTextColor: red),
      _getGoodsInfoItem('优惠券', Utils.formatPrice('-2.50'), contentTextColor: red),
      _getGoodsInfoItem('社区币抵扣', Utils.formatPrice('-2.50'), contentTextColor: red),
      _getGoodsInfoItem('佣金', Utils.formatPrice('-1.0'), contentTextColor: red),
      Gaps.line,
      Gaps.vGap8,
      _getGoodsInfoItem('合计', Utils.formatPrice('46.50')),
      Gaps.vGap8,
      Gaps.line,
      Gaps.vGap32,
      const Text(
        '订单信息',
        style: TextStyles.textBold18,
      ),
      Gaps.vGap12,
      _getOrderInfoItem('订单编号:', '1256324856942'),
      _getOrderInfoItem('下单时间:', '2018/08/26 12:20'),
      _getOrderInfoItem('支付方式:', '在线支付/支付宝'),
      _getOrderInfoItem('配送方式:', '送货上门'),
      _getOrderInfoItem('客户备注:', '无'),
    ];

    return Scaffold(
      appBar: MyAppBar(
        actionName: '订单跟踪',
        onPressed: () {
          NavigatorUtils.push(context, OrderRouter.orderTrackPage);
        },
      ),
      body: MyScrollView(
        key: const Key('order_info'),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: children,
        bottomButton: bottomMenu,
      )
    );
  }

  Widget _getOrderInfoItem(String title, String content) {
    return MergeSemantics(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: <Widget>[
            Text(title, style: Theme.of(context).textTheme.subtitle2.copyWith(fontSize: Dimens.font_sp14)),
            Gaps.hGap8,
            Text(content)
          ],
        ),
      ),
    );
  }

  Widget _getOrderGoodsItem(int index) {
    var item = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: const LoadAssetImage('order/icon_goods', width: 56.0, height: 56.0),
          margin: const EdgeInsets.only(top: 5.0),
        ),
        Gaps.hGap8,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                index % 2 == 0 ? '泊泉雅花瓣·浪漫亲肤玫瑰沐浴乳' : '日本纳鲁火多橙饮',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Gaps.vGap4,
              Text(index % 2 == 0 ? '玫瑰香 520ml' : '125ml', style: Theme.of(context).textTheme.subtitle2),
              Gaps.vGap8,
              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).errorColor,
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    height: 16.0,
                    alignment: Alignment.center,
                    child: Text(
                      '立减2.50元',
                      style: const TextStyle(color: Colors.white, fontSize: Dimens.font_sp10,),
                    ),
                  ),
                  Gaps.hGap4,
                  Offstage(
                    offstage: index % 2 != 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                      height: 16.0,
                      alignment: Alignment.center,
                      child: const Text(
                        '抵扣2.50元',
                        style: TextStyle(color: Colors.white, fontSize: Dimens.font_sp10),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Gaps.hGap8,
        Text('x1', style: TextStyles.textSize12),
        Gaps.hGap32,
        Text(Utils.formatPrice('25'), style: TextStyles.textBold14),
      ],
    );

    return DecoratedBox(
      decoration: BoxDecoration(
          border: Border(
            bottom: Divider.createBorderSide(context, width: 0.8),
          )
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: item
      ),
    );
  }
  
  Widget _getGoodsInfoItem(String title, String content, {Color contentTextColor}) {
    return MergeSemantics(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(title),
            Text(content, style: TextStyle(
              color: contentTextColor ?? Theme.of(context).textTheme.bodyText2.color,
              fontWeight: FontWeight.bold
            ))
          ],
        ),
      ),
    );
  }

  void _showCallPhoneDialog(String phone) {
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('提示'),
            content: Text('是否拨打：$phone ?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => NavigatorUtils.goBack(context),
                child: const Text('取消'),
              ),
              FlatButton(
                onPressed: () {
                  Utils.launchTelURL(phone);
                  NavigatorUtils.goBack(context);
                },
                textColor: Theme.of(context).errorColor,
                child: const Text('拨打'),
              ),
            ],
          );
        });
  }
}
