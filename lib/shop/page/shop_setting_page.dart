

import 'package:flutter/material.dart';
import 'package:flutter_2d_amap/flutter_2d_amap.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/shop/page/input_text_page.dart';
import 'package:flutter_deer/shop/widgets/pay_type_dialog.dart';
import 'package:flutter_deer/shop/shop_router.dart';
import 'package:flutter_deer/shop/widgets/price_input_dialog.dart';
import 'package:flutter_deer/shop/widgets/send_type_dialog.dart';
import 'package:flutter_deer/util/app_navigator.dart';
import 'package:flutter_deer/util/utils.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:flutter_deer/widgets/click_item.dart';
import 'package:flutter_deer/widgets/my_button.dart';
import 'package:flutter_deer/widgets/my_scroll_view.dart';

/// design/7店铺-店铺配置/index.html#artboard17
class ShopSettingPage extends StatefulWidget {
  @override
  _ShopSettingPageState createState() => _ShopSettingPageState();
}

class _ShopSettingPageState extends State<ShopSettingPage> {

  bool _check = false;
  var _selectValue = [0];
  int _sendType = 0;
  String _sendPrice = '0.00';
  String _freePrice = '0.00';
  String _phone = '';
  String _shopIntroduction = '零食铺子坚果饮料美酒佳肴…';
  String _securityService = '假一赔十';
  String _address = '陕西省 西安市 长安区 郭杜镇郭北村韩林路圣方医院斜对面';
  
  _getPayType() {
    String payType = '';
    for (int s in _selectValue) {
      if (s == 0) {
        payType = '$payType在线支付+';
      } else if (s == 1) {
        payType = '$payType对公转账+';
      } else if (s == 2) {
        payType = '$payType货到付款+';
      }
    }
    return payType.substring(0, payType.length - 1);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 防止键盘弹出，提交按钮升起。。。
      resizeToAvoidBottomInset: false,
      appBar: const MyAppBar(),
      body: MyScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        children: <Widget>[
          Gaps.vGap5,
          Row(
            children: <Widget>[
              Gaps.hGap16,
              Text(
                _check ? '正在营业' : '暂停营业',
                style: TextStyles.textBold24,
              ),
              const Spacer(),
              Semantics(
                label: '店铺营业开关',
                child: Switch.adaptive(
                  value: _check,
                  onChanged: (bool val) {
                    setState(() {
                      _check = !_check;
                    });
                  },
                ),
              ),
              Gaps.hGap4,
            ],
          ),
          Gaps.vGap16,
          Gaps.vGap16,
          const Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: const Text('基础设置', style: TextStyles.textBold18),
          ),
          Gaps.vGap16,
          ClickItem(
            title: '店铺简介',
            content: _shopIntroduction,
            onTap: () {
              AppNavigator.pushResult(context,
                  InputTextPage(
                    title: '店铺简介',
                    hintText: '这里有一段完美的简介…',
                    content: _shopIntroduction,
                  ), (result) {
                    setState(() {
                      _shopIntroduction =result.toString();
                    });
                  });
            },
          ),
          ClickItem(
            title: '保障服务',
            content: _securityService,
            onTap: () {
              AppNavigator.pushResult(context,
                  InputTextPage(
                    title: '保障服务',
                    hintText: '这里有一段完美的说明…',
                    content: _securityService,
                  ), (result) {
                    setState(() {
                      _securityService =result.toString();
                    });
                  });
            },
          ),
          ClickItem(
            title: '支付方式',
            content: _getPayType(),
            onTap: () {
              showElasticDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return PayTypeDialog(
                      value: _selectValue,
                      onPressed: (value) {
                        setState(() {
                          _selectValue = value;
                        });
                      },
                    );
                  });
            },
          ),
          Gaps.vGap16,
          Gaps.vGap16,
          const Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: const Text('运费设置', style: TextStyles.textBold18),
          ),
          Gaps.vGap16,
          ClickItem(
            title: '运费配置',
            content: _sendType == 0 ? '运费满免配置' : '运费比例配置',
            onTap: () {
              showElasticDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return SendTypeDialog(
                      onPressed: (i, value) {
                        setState(() {
                          _sendType = i;
                        });
                      },
                    );
                  });
            },
          ),
          Visibility(
            visible: _sendType != 1,
            child: ClickItem(
              title: '运费满免',
              content: _freePrice,
              onTap: () {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return PriceInputDialog(
                        title: '配送费满免',
                        onPressed: (value) {
                          setState(() {
                            _freePrice = value;
                          });
                        },
                      );
                    });
              },
            ),
          ),
          Visibility(
            visible: _sendType != 1,
            child: ClickItem(
              title: '配送费用',
              content: _sendPrice,
              onTap: () {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return PriceInputDialog(
                        title: '配送费用',
                        onPressed: (value) {
                          setState(() {
                            _sendPrice = value;
                          });
                        },
                      );
                    });
              },
            ),
          ),
          Visibility(
            visible: _sendType != 0,
            child: ClickItem(
              maxLines: 10,
              title: '运费比例',
              content: '1、订单金额<20元，配送费为订单金额的1%\n2、订单金额≥20元，配送费为订单金额的1%',
              onTap: () => NavigatorUtils.push(context, ShopRouter.freightConfigPage),
            ),
          ),
          Gaps.vGap16,
          Gaps.vGap16,
          const Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: const Text('联系信息', style: TextStyles.textBold18,),
          ),
          Gaps.vGap16,
          ClickItem(
            title: '联系电话',
            content: _phone,
            onTap: () {
              AppNavigator.pushResult(context,
                  InputTextPage(
                    title: '联系电话',
                    hintText: '这里有一串神秘的数字…',
                    keyboardType: TextInputType.phone,
                    content: _phone,
                  ), (result) {
                    setState(() {
                      _phone =result.toString();
                    });
                  });
            },
          ),
          ClickItem(
            maxLines: 2,
            title: '店铺地址',
            content: _address,
            onTap: () {
              NavigatorUtils.pushResult(context, ShopRouter.addressSelectPage, (result) {
                setState(() {
                  PoiSearch model = result;
                  _address = model.provinceName + ' ' +
                      model.cityName + ' ' +
                      model.adName + ' ' +
                      model.title;
                });
              });
            },
          ),
          Gaps.vGap8,
        ],
        bottomButton: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
          child: MyButton(
            onPressed: () {
              NavigatorUtils.goBack(context);
            },
            text: '提交',
          ),
        ),
      )
    );
  }

}
