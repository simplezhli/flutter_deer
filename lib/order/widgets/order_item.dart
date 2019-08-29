
import 'package:flutter/material.dart';
import 'package:flutter_deer/common/common.dart';
import 'package:flutter_deer/order/widgets/pay_type_dialog.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/util/utils.dart';
import 'package:flutter_deer/widgets/my_card.dart';

import '../order_router.dart';

class OrderItem extends StatelessWidget {

  const OrderItem({
    Key key,
    @required this.index,
  }) : super(key: key);
  
  final int index;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      child: MyCard(
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
                    const Text(
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
                        child: const Text("联系客户"),
                        onPressed: (){
                          _showCallPhoneDialog(context, "15000000000");
                        },
                      ),
                      Expanded(
                        child: Gaps.empty,
                      ),
                      FlatButton(
                        color: Colours.bg_gray,
                        child: Text(Constant.orderLeftButtonText[index]),
                        onPressed: (){
                          if (index >= 2){
                            NavigatorUtils.push(context, OrderRouter.orderTrackPage);
                          }
                        },
                      ),
                      Offstage(
                        offstage: Constant.orderRightButtonText[index].length == 0,
                        child: Gaps.hGap10,
                      ),
                      Offstage(
                        offstage: Constant.orderRightButtonText[index].length == 0,
                        child: FlatButton(
                          color: Colours.app_main,
                          textColor: Colors.white,
                          onPressed: (){
                            if (index == 2){
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
                          child: Text(Constant.orderRightButtonText[index]),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }

  void _showCallPhoneDialog(BuildContext context, String phone){
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