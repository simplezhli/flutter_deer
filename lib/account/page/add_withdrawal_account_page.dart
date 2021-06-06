import 'package:flutter/material.dart';
import 'package:flutter_deer/account/account_router.dart';
import 'package:flutter_deer/account/models/bank_entity.dart';
import 'package:flutter_deer/account/models/city_entity.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/other_utils.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';
import 'package:flutter_deer/widgets/my_button.dart';
import 'package:flutter_deer/widgets/my_scroll_view.dart';
import 'package:flutter_deer/widgets/selected_item.dart';
import 'package:flutter_deer/widgets/text_field_item.dart';


/// design/6店铺-账户/index.html#artboard29
class AddWithdrawalAccountPage extends StatefulWidget {

  const AddWithdrawalAccountPage({Key? key}) : super(key: key);

  @override
  _AddWithdrawalAccountPageState createState() => _AddWithdrawalAccountPageState();
}

class _AddWithdrawalAccountPageState extends State<AddWithdrawalAccountPage> {
  bool _isWechat = false;
  String _accountType = '银行卡(对私账户)';
  String _city = '';
  String _bank = '';
  String _bank1 = '';
  
  @override
  Widget build(BuildContext context) {
    final TextStyle? style = Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: Dimens.font_sp14);
    final List<Widget> children = <Widget>[
      Gaps.vGap5,
      SelectedItem(
        title: '账号类型',
        content: _accountType,
        onTap: () => _showSelectAccountTypeDialog(),
      ),
      Visibility(
        maintainState: true, /// 是为了保留填写信息，其实就是Offstage，这里只是展示另一种方法。
        visible: !_isWechat,
        child: Column(
          children: <Widget>[
            const TextFieldItem(
              title: '持  卡  人',
              hintText: '填写您的真实姓名',
            ),
            const TextFieldItem(
              title: '银行卡号',
              keyboardType: TextInputType.number,
              hintText: '填写银行卡号',
            ),
            SelectedItem(
              title: '开  户  地',
              content: _city.isEmpty ? '选择开户城市' : _city,
              style: _city.isEmpty ? style : null,
              onTap: () {
                NavigatorUtils.pushResult(context, AccountRouter.citySelectPage, (Object result) {
                  setState(() {
                    final CityEntity model = result as CityEntity;
                    _city = model.name;
                  });
                });
              },
            ),
            SelectedItem(
              title: '银行名称',
              content: _bank.isEmpty ? '选择开户银行' : _bank,
              style: _bank.isEmpty ? style : null,
              onTap: () {
                NavigatorUtils.pushResult(context, '${AccountRouter.bankSelectPage}?type=0', (Object result) {
                  setState(() {
                    final BankEntity model = result as BankEntity;
                    _bank = model.bankName.nullSafe;
                  });
                });
              },
            ),
            SelectedItem(
              title: '支行名称',
              content: _bank1.isEmpty ? '选择开户支行' : _bank1,
              style: _bank1.isEmpty ? style : null,
              onTap: () {
                NavigatorUtils.pushResult(context, '${AccountRouter.bankSelectPage}?type=1', (Object result) {
                  setState(() {
                    final BankEntity model = result as BankEntity;
                    _bank1 = model.bankName.nullSafe;
                  });
                });
              },
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 16.0),
        child: Text(
          _isWechat ? '绑定本机当前登录的微信号' : '绑定持卡人本人的银行卡',
          style: Theme.of(context).textTheme.subtitle2,
        ),
      ),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const MyAppBar(
        title: '添加账号',
      ),
      body: MyScrollView(
        children: children,
        bottomButton: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
          child: MyButton(
            onPressed: () => NavigatorUtils.goBackWithParams(context, 'add'),
            text: '确定',
          ),
        )
      ),
    );
  }

  void _dialogSelect(bool flag) {
    setState(() {
      _isWechat = flag;
    });
    NavigatorUtils.goBack(context);
  }

  /// design/6店铺-账户/index.html#artboard30
  void _showSelectAccountTypeDialog() {
    /// 关闭输入法，避免弹出
    FocusManager.instance.primaryFocus?.unfocus();
    showElasticDialog<void>(
      context: context,
      builder: (BuildContext context) {
        const OutlinedBorder buttonShape = RoundedRectangleBorder(borderRadius: BorderRadius.zero);

        final Widget content = Column(
          children: <Widget>[
            const Text(
              '账号类型',
              style: TextStyles.textBold18,
            ),
            Gaps.vGap16,
            Gaps.line,
            Expanded(
              child: TextButton(
                child: const Text('微信'),
                onPressed: () {
                  _accountType = '微信';
                  _dialogSelect(true);
                },
              ),
            ),
            Gaps.line,
            Expanded(
              child: TextButton(
                child: const Text('银行卡(对私账户)'),
                onPressed: () {
                  _accountType = '银行卡(对私账户)';
                  _dialogSelect(false);
                },
              ),
            ),
            Gaps.line,
            Expanded(
              child: TextButton(
                child: const Text('银行卡(对公账户)'),
                onPressed: () {
                  _accountType = '银行卡(对公账户)';
                  _dialogSelect(false);
                },
              ),
            ),
          ],
        );

        final Widget decoration = Container(
          decoration: BoxDecoration(
            color: context.dialogBackgroundColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          width: 270.0,
          height: 190.0,
          padding: const EdgeInsets.only(top: 24.0),
          child: TextButtonTheme(
            data: TextButtonThemeData(
              style: TextButton.styleFrom(
                // 文字颜色
                primary: Theme.of(context).primaryColor,
                // 按钮大小
                minimumSize: Size.infinite,
                // 修改默认圆角
                shape: buttonShape,
              ),
            ),
            child: content,
          ),
        );

        return Material(
          type: MaterialType.transparency,
          child: Center(
            child: decoration,
          ),
        );
      },
    );        
  }
}
