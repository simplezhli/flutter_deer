import 'package:flutter/material.dart';
import 'package:flutter_deer/account/models/withdrawal_account_model.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';
import 'package:flutter_deer/widgets/load_image.dart';

import '../account_router.dart';

/// design/6店铺-账户/index.html#artboard7
class WithdrawalAccountListPage extends StatefulWidget {

  const WithdrawalAccountListPage({Key? key}) : super(key: key);

  @override
  _WithdrawalAccountListPageState createState() => _WithdrawalAccountListPageState();
}

class _WithdrawalAccountListPageState extends State<WithdrawalAccountListPage> {
  
  final int _selectIndex = 0;
  final List<WithdrawalAccountModel> _list = [];
  
  @override
  void initState() {
    super.initState();
    _list.clear();
    _list.add(WithdrawalAccountModel('尾号5236 李艺', '工商银行', 0, '123'));
    _list.add(WithdrawalAccountModel('唯鹿', '微信', 1, ''));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: '选择账号',
        actionName: '添加',
        onPressed: () => NavigatorUtils.push(context, AccountRouter.addWithdrawalAccountPage)
      ),
      body: ListView.separated(
        itemCount: _list.length,
        separatorBuilder: (_, index) => const Divider(height: 0.6),
        itemBuilder: (_, index) => _buildItem(index),
      ),
    );
  }

  Widget _buildItem(int index) {
    return InkWell(
      onTap: () => NavigatorUtils.goBackWithParams(context, _list[index]),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        width: double.infinity,
        height: 74.0,
        alignment: Alignment.center,
        child: Row(
          children: <Widget>[
            LoadAssetImage(_list[index].type == 0 ? 'account/yhk' : 'account/wechat', width: 24.0),
            Gaps.hGap16,
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(_list[index].typeName),
                  Gaps.vGap8,
                  Text(_list[index].name, style: TextStyles.textSize12),
                ],
              ),
            ),
            Visibility(
              visible: _selectIndex == index,
              child: const LoadAssetImage(
                'account/selected',
                height: 24.0,
                width: 24.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
