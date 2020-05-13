
import 'package:flutter/material.dart';
import 'package:flutter_deer/account/models/withdrawal_account_model.dart';
import 'package:flutter_deer/account/widgets/withdrawal_account_item.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:flutter_deer/widgets/state_layout.dart';

import '../account_router.dart';

/// design/6店铺-账户/index.html#artboard26
class WithdrawalAccountPage extends StatefulWidget {
  @override
  _WithdrawalAccountPageState createState() => _WithdrawalAccountPageState();
}

class _WithdrawalAccountPageState extends State<WithdrawalAccountPage> {
  
  List<WithdrawalAccountModel> _list = [];
  
  @override
  void initState() {
    super.initState();
    _list.clear();
    _list.add(WithdrawalAccountModel('唯鹿', '微信', 1, ''));
    _list.add(WithdrawalAccountModel('李*', '工商银行', 0, '**** **** **** 5236'));
    _list.add(WithdrawalAccountModel('李*', '渤海银行', 0, '**** **** **** 2165'));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: '提现账号',
        actionName: '添加',
        onPressed: () => NavigatorUtils.push(context, AccountRouter.addWithdrawalAccountPage)
      ),
      body: _list.isEmpty ? const StateLayout(type: StateType.account) :
      ListView.builder(
        itemCount: _list.length,
        itemExtent: 151.0,
        itemBuilder: (_, index) {
          return WithdrawalAccountItem(
            key: ObjectKey( _list[index]), /// 这里注意必须添加key，原因见： https://weilu.blog.csdn.net/article/details/104745624
            data: _list[index], 
            onLongPress: () => _showDeleteBottomSheet(index),
          );
        }
      ),
    );
  }

  void _showDeleteBottomSheet(int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Material(
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(
                  height: 52.0,
                  child: Center(
                    child: Text(
                      '是否确认解绑，防止错误操作',
                      style: TextStyles.textSize16,
                    ),
                  ),
                ),
                Gaps.line,
                Container(
                  height: 54.0,
                  width: double.infinity,
                  child: FlatButton(
                    textColor: Theme.of(context).errorColor,
                    child: const Text('确认解绑', style: TextStyle(fontSize: Dimens.font_sp18)),
                    onPressed: () {
                      setState(() {
                        _list.removeAt(index);
                      });
                      NavigatorUtils.goBack(context);
                    },
                  ),
                ),
                Gaps.line,
                Container(
                  height: 54.0,
                  width: double.infinity,
                  child: FlatButton(
                    textColor: Colours.text_gray,
                    child: const Text('取消', style: TextStyle(fontSize: Dimens.font_sp18)),
                    onPressed: () {
                      NavigatorUtils.goBack(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
