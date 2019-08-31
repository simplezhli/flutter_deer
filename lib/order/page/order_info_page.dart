

import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/utils.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:flutter_deer/widgets/load_image.dart';

import '../order_router.dart';

class OrderInfoPage extends StatefulWidget {
  @override
  _OrderInfoPageState createState() => _OrderInfoPageState();
}

class _OrderInfoPageState extends State<OrderInfoPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        actionName: '订单跟踪',
        onPressed: (){
          NavigatorUtils.push(context, OrderRouter.orderTrackPage);
        },
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        "暂未接单",
                        style: TextStyles.textBoldDark24,
                      ),
                      Gaps.vGap16,
                      Gaps.vGap16,
                      const Text(
                        "客户信息",
                        style: TextStyles.textBoldDark18,
                      ),
                      Gaps.vGap16,
                      Row(
                        children: <Widget>[
                          ClipOval(
                            child: const LoadAssetImage("order/icon_avatar", width: 44.0, height: 44.0),
                          ),
                          Gaps.hGap8,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("郭李", style: TextStyles.textDark14),
                                Gaps.vGap8,
                                Text("15000000000", style: TextStyles.textDark14),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 1.0,
                            height: 24.0,
                            child: const DecoratedBox(decoration: BoxDecoration(color: Colours.order_line)),
                          ),
                          Gaps.hGap16,
                          InkWell(
                            child: const LoadAssetImage("order/icon_phone", width: 24.0, height: 24.0),
                            onTap: (){
                              _showCallPhoneDialog("15000000000");
                            },
                          )
                        ],
                      ),
                      Gaps.vGap10,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const LoadAssetImage("order/icon_address", width: 16.0, height: 20.0),
                          Gaps.hGap4,
                          Expanded(child: Text("西安市雁塔区 鱼化寨街道唐兴路唐兴数码3楼318", maxLines: 2, style: TextStyles.textDark14)),
                        ],
                      ),
                      Gaps.vGap16,
                      Gaps.vGap16,
                      const Text(
                        "商品信息",
                        style: TextStyles.textBoldDark18,
                      ),
                      ListView.builder(
                        // 如果滚动视图在滚动方向无界约束，那么shrinkWrap必须为true
                        shrinkWrap: true,
                        // 禁用ListView滑动，使用外层的ScrollView滑动
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 2,
                        itemBuilder: (_, index){
                          return DecoratedBox(
                            decoration: BoxDecoration(
                                border: Border(
                                  bottom: Divider.createBorderSide(context, color: Colours.line, width: 0.8),
                                )
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: const LoadAssetImage("order/icon_goods", width: 56.0, height: 56.0),
                                    margin: const EdgeInsets.only(top: 5.0),
                                  ),
                                  Gaps.hGap8,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                            index % 2 == 0 ? "泊泉雅花瓣·浪漫亲肤玫瑰沐浴乳" : "日本纳鲁火多橙饮",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyles.textDark14
                                        ),
                                        Gaps.vGap4,
                                        Text(index % 2 == 0 ? "玫瑰香 520ml" : "125ml", style: TextStyles.textGray12),
                                        Gaps.vGap8,
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              decoration: BoxDecoration(
                                                color: Colours.text_red,
                                                borderRadius: BorderRadius.circular(2.0),
                                              ),
                                              height: 16.0,
                                              alignment: Alignment.center,
                                              child: Text(
                                                "立减2.50元",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: Dimens.font_sp10
                                                ),
                                              ),
                                            ),
                                            Gaps.hGap4,
                                            Offstage(
                                              offstage: index % 2 != 0,
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                decoration: BoxDecoration(
                                                  color: Colours.app_main,
                                                  borderRadius: BorderRadius.circular(2.0),
                                                ),
                                                height: 16.0,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "抵扣2.50元",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: Dimens.font_sp10
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Gaps.hGap8,
                                  Text("x1", style: TextStyles.textDark12),
                                  Gaps.hGap16,
                                  Gaps.hGap16,
                                  Text("¥25", style: TextStyles.textBoldDark14),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      Gaps.vGap8,
                      getGoodsInfoItem("共2件商品", "¥50"),
                      getGoodsInfoItem("配送费", "¥5"),
                      getGoodsInfoItem("立减", "-¥2.5", contentTextColor: Colours.text_red),
                      getGoodsInfoItem("优惠券", "-¥2.5", contentTextColor: Colours.text_red),
                      getGoodsInfoItem("社区币抵扣", "-¥2.5", contentTextColor: Colours.text_red),
                      getGoodsInfoItem("佣金", "-¥1", contentTextColor: Colours.text_red),
                      Gaps.line,
                      Gaps.vGap8,
                      getGoodsInfoItem("合计", "¥46.5"),
                      Gaps.vGap8,
                      Gaps.line,
                      Gaps.vGap16,
                      Gaps.vGap16,
                      const Text(
                        "订单信息",
                        style: TextStyles.textBoldDark18,
                      ),
                      Gaps.vGap12,
                      getOrderInfoItem("订单编号:", "1256324856942"),
                      getOrderInfoItem("下单时间:", "2018/08/26 12:20"),
                      getOrderInfoItem("支付方式:", "在线支付/支付宝"),
                      getOrderInfoItem("配送方式:", "送货上门"),
                      getOrderInfoItem("客户备注:", "无"),
                      Gaps.vGap50,
                      Gaps.vGap50,
                    ],
                  ),
                ],
              )
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Material(
              color: Colors.white,
              child: SafeArea(
                child: Container(
                  height: 60.0,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Theme(
                    data: ThemeData(
                      buttonTheme: ButtonThemeData(
                        height: 44.0,
                      )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: FlatButton(
                            color: const Color(0xFFE1EAFA),
                            textColor: Colours.app_main,
                            child: const Text(
                              "拒单",
                              style: TextStyle(
                                  fontSize: Dimens.font_sp18
                              ),
                            ),
                            onPressed: (){},
                          ),
                        ),
                        Gaps.hGap16,
                        Expanded(
                          flex: 1,
                          child: FlatButton(
                            color: Colours.app_main,
                            textColor: Colors.white,
                            child: const Text(
                              "接单",
                              style: TextStyle(
                                  fontSize: Dimens.font_sp18
                              ),
                            ),
                            onPressed: (){},
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getOrderInfoItem(String title, String content){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: <Widget>[
          Text(title, style: TextStyles.textGray14),
          Gaps.hGap8,
          Text(content, style: TextStyles.textDark14)
        ],
      ),
    );
  }
  
  Widget getGoodsInfoItem(String title, String content, {Color contentTextColor = Colours.text_dark}){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(title, style: TextStyles.textDark14),
          Text(content, style: TextStyle(
            color: contentTextColor,
            fontWeight: FontWeight.bold
          ))
        ],
      ),
    );
  }

  void _showCallPhoneDialog(String phone){
    showDialog(
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
                onPressed: (){
                  Utils.launchTelURL(phone);
                  NavigatorUtils.goBack(context);
                },
                textColor: Colours.text_red,
                child: const Text('拨打'),
              ),
            ],
          );
        });
  }
}
