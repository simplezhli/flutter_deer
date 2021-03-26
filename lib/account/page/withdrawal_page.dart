
import 'package:flutter/material.dart';
import 'package:flutter_deer/account/models/withdrawal_account_model.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/input_formatter/number_text_input_formatter.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:flutter_deer/widgets/my_button.dart';
import 'package:flutter_deer/widgets/my_scroll_view.dart';

import '../account_router.dart';

/// design/6店铺-账户/index.html#artboard3
class WithdrawalPage extends StatefulWidget {

  const WithdrawalPage({Key key}) : super(key: key);

  @override
  _WithdrawalPageState createState() => _WithdrawalPageState();
}

class _WithdrawalPageState extends State<WithdrawalPage> {
  
  final TextEditingController _controller = TextEditingController();
  int _withdrawalType = 0;
  bool _clickable = false;
  WithdrawalAccountModel _data = WithdrawalAccountModel('尾号5236 李艺', '工商银行', 0, '123');
  
  @override
  void initState() {
    super.initState();
    _controller.addListener(_verify);
  }

  @override
  void dispose() {
    _controller.removeListener(_verify);
    _controller.dispose();
    super.dispose();
  }
  
  void _verify() {
    final price = _controller.text;
    if (price.isEmpty || double.parse(price) < 1) {
      setState(() {
        _clickable = false;
      });
      return;
    }
    setState(() {
      _clickable = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        /// 拦截返回，关闭键盘，否则会造成上一页面短暂的组件溢出
        FocusManager.instance.primaryFocus?.unfocus();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: const MyAppBar(
          title: '提现',
        ),
        body: MyScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: <Widget>[
            Gaps.vGap5,
            InkWell(
              onTap: () {
                NavigatorUtils.pushResult(context, AccountRouter.withdrawalAccountListPage, (result) {
                  setState(() {
                    _data = result as WithdrawalAccountModel;
                  });
                });
              },
              child: Container(
                width: double.infinity,
                height: 74.0,
                alignment: Alignment.center,
                child: Row(
                  children: <Widget>[
                    LoadAssetImage(_data.type == 0 ? 'account/yhk' : 'account/wechat', width: 24.0),
                    Gaps.hGap16,
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(_data.typeName),
                          Gaps.vGap8,
                          Text(_data.name, style: Theme.of(context).textTheme.subtitle2),
                        ],
                      ),
                    ),
                    Images.arrowRight
                  ],
                ),
              ),
            ),
            Gaps.vGap16,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                Text('提现金额', style: TextStyles.textBold14),
                Text('单笔2万，单日2万', style: TextStyle(fontSize: Dimens.font_sp12, color: Color(0xFFFF8547)))
              ],
            ),
            Gaps.vGap8,
            Row(
              children: <Widget>[
                Container(
                  width: 15.0,
                  height: 40.0,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: LoadAssetImage('account/rmb', color: ThemeUtils.getIconColor(context),),
                ),
                Gaps.hGap8,
                Expanded(
                  child: TextField(
                    maxLength: 10,
                    controller: _controller,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [UsNumberTextInputFormatter()],
                    style: const TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 8.0),
                      hintStyle: TextStyle(
                        fontSize: Dimens.font_sp14,
                        fontWeight: FontWeight.normal,
                        color: Colours.text_gray_c,
                      ),
                      hintText: '不能少于1元',
                      counterText: '',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            Gaps.line,
            Gaps.vGap8,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('最多可提现70元', style: Theme.of(context).textTheme.subtitle2),
                GestureDetector(
                  onTap: () {
                    _controller.text = '70';
                  },    
                  child: SizedBox(
                    height: 48.0,
                    child: Text('全部提现', style: TextStyle(
                      fontSize: Dimens.font_sp12,
                      color: Theme.of(context).primaryColor,
                    )),
                  )
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                Text('转出方式', style: TextStyles.textBold14),
                LoadAssetImage('account/sm', width: 16.0)
              ],
            ),
            _buildWithdrawalType(0),
            Gaps.line,
            _buildWithdrawalType(1),
            Gaps.vGap24,
            MyButton(
              key: const Key('提现'),
              onPressed: _clickable ? () {
                NavigatorUtils.push(context, AccountRouter.withdrawalResultPage);
              } : null,
              text: '提现',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWithdrawalType(int type) {
    return InkWell(
      onTap: () {
        setState(() {
          _withdrawalType = type;
        });
      },
      child: SizedBox(
        width: double.infinity,
        height: 74.0,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 18.0,
              left: 0.0,
              child: LoadAssetImage(_withdrawalType == type ? 'account/txxz' : 'account/txwxz', width: 16.0),
            ),
            Positioned(
              top: 16.0,
              left: 24.0,
              right: 0.0,
              child: Text(type == 0 ? '快速到账' : '普通到账'),
            ),
            Positioned(
              bottom: 16.0,
              left: 24.0,
              right: 0.0,
              child: RichText(
                text: type == 0 ? TextSpan(
                  text: '手续费按',
                  style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: Dimens.font_sp12),
                  children: const <TextSpan>[
                    TextSpan(text: '0.3%', style: TextStyle(color: Color(0xFFFF8547))),
                    TextSpan(text: '收取'),
                  ],
                ) : TextSpan(
                  text: '预计',
                  style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: Dimens.font_sp12),
                  children: const <TextSpan>[
                    TextSpan(text: 'T+1天到账(免手续费，T为工作日)', style: TextStyle(color: Color(0xFFFF8547))),
                  ],
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
