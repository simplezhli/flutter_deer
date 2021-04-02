

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
import 'package:flutter_deer/util/other_utils.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';
import 'package:flutter_deer/widgets/click_item.dart';
import 'package:flutter_deer/widgets/my_button.dart';
import 'package:flutter_deer/widgets/my_scroll_view.dart';

/// design/7店铺-店铺配置/index.html#artboard17
class ShopSettingPage extends StatefulWidget {

  const ShopSettingPage({Key key}) : super(key: key);

  @override
  _ShopSettingPageState createState() => _ShopSettingPageState();
}

class _ShopSettingPageState extends State<ShopSettingPage> {

  bool _check = false;
  List<int> _selectValue = [0];
  int _sendType = 0;
  String _sendPrice = '0.00';
  String _freePrice = '0.00';
  String _phone = '';
  String _shopIntroduction = '零食铺子坚果饮料美酒佳肴…';
  String _securityService = '假一赔十';
  String _address = '陕西省 西安市 长安区 郭杜镇郭北村韩林路圣方医院斜对面';
  
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
                      _check = val;
                    });
                  },
                ),
              ),
              Gaps.hGap4,
            ],
          ),
          Gaps.vGap32,
          const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text('基础设置', style: TextStyles.textBold18),
          ),
          Gaps.vGap16,
          ClickItem(
            title: '店铺简介',
            content: _shopIntroduction,
            onTap: () {
              _goInputTextPage(context, '店铺简介', '这里有一段完美的简介…', _shopIntroduction, (result) {
                setState(() {
                  _shopIntroduction = result.toString();
                });
              },);
            },
          ),
          ClickItem(
            title: '保障服务',
            content: _securityService,
            onTap: () {
              _goInputTextPage(context, '保障服务', '这里有一段完美的说明…', _securityService, (result) {
                setState(() {
                  _securityService = result.toString();
                });
              },);
            },
          ),
          ClickItem(
            title: '支付方式',
            content: _getPayType(),
            onTap: _showPayTypeDialog,
          ),
          Gaps.vGap32,
          const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text('运费设置', style: TextStyles.textBold18),
          ),
          Gaps.vGap16,
          ClickItem(
            title: '运费配置',
            content: _sendType == 0 ? '运费满免配置' : '运费比例配置',
            onTap: _showSendTypeDialog,
          ),
          Visibility(
            visible: _sendType != 1,
            child: ClickItem(
              title: '运费满免',
              content: _freePrice,
              onTap: () {
                _showInputDialog('配送费满免', (value) {
                  setState(() {
                    _freePrice = value;
                  });
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
                _showInputDialog('配送费用', (value) {
                  setState(() {
                    _sendPrice = value;
                  });
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
          Gaps.vGap32,
          const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text('联系信息', style: TextStyles.textBold18,),
          ),
          Gaps.vGap16,
          ClickItem(
            title: '联系电话',
            content: _phone,
            onTap: () {
              _goInputTextPage(context, '联系电话', '这里有一串神秘的数字…', _phone, (result) {
                setState(() {
                  _phone = result.toString();
                });
              }, keyboardType: TextInputType.phone,);
            },
          ),
          ClickItem(
            maxLines: 2,
            title: '店铺地址',
            content: _address,
            onTap: () {
              NavigatorUtils.pushResult(context, ShopRouter.addressSelectPage, (result) {
                setState(() {
                  final PoiSearch model = result as PoiSearch;
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
            text: '提交',
            onPressed: () => NavigatorUtils.goBack(context),
          ),
        ),
      )
    );
  }

  String _getPayType() {
    String payType = '';
    for (final int s in _selectValue) {
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

  void _goInputTextPage(BuildContext context, String title,
      String hintText, String content, Function(Object) function, {TextInputType keyboardType}) {
    AppNavigator.pushResult(
      context,
      InputTextPage(
        title: title,
        hintText: hintText,
        content: content,
        keyboardType: keyboardType,
      ),
      function,
    );
  }

  void _showInputDialog(String title, Function(String) onPressed) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PriceInputDialog(
          title: title,
          onPressed: onPressed,
        );
      },
    );
  }

  void _showPayTypeDialog() {
    showElasticDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PayTypeDialog(
          value: _selectValue,
          onPressed: (value) {
            setState(() {
              _selectValue = value.cast<int>();
            });
          },
        );
      },
    );
  }

  void _showSendTypeDialog() {
    showElasticDialog <void>(
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
      },
    );
  }
}
