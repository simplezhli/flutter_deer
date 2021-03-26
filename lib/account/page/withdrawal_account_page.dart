
import 'package:flutter/material.dart';
import 'package:flutter_deer/account/models/withdrawal_account_model.dart';
import 'package:flutter_deer/account/widgets/withdrawal_account_item.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';
import 'package:flutter_deer/widgets/my_button.dart';
import 'package:flutter_deer/widgets/state_layout.dart';

import '../account_router.dart';

/// design/6店铺-账户/index.html#artboard26
class WithdrawalAccountPage extends StatefulWidget {

  const WithdrawalAccountPage({Key key}) : super(key: key);

  @override
  _WithdrawalAccountPageState createState() => _WithdrawalAccountPageState();
}

class _WithdrawalAccountPageState extends State<WithdrawalAccountPage> {
  
  final List<WithdrawalAccountModel> _list = [];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final Duration _kDuration = const Duration(milliseconds: 300);
  
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
        onPressed: () {
          NavigatorUtils.pushResult(context, AccountRouter.addWithdrawalAccountPage, (result) {
            _insertItem(0);
          });
        }
      ),
      body: _list.isEmpty ? const StateLayout(type: StateType.account) :
      AnimatedList(
        key: _listKey,
        padding: const EdgeInsets.only(top: 8.0),
        initialItemCount: _list.length,
        itemBuilder: (_, index, animation) => sizeItem(_list[index], index, animation),
      ),
    );
  }
  
  Widget sizeItem(WithdrawalAccountModel data, int index, Animation<double> animation) {
    /// item插入、移除动画 
    return SizeTransition(
      axisAlignment: 1.0,
      sizeFactor: animation,
      child: WithdrawalAccountItem(
        key: ObjectKey(data), /// 这里注意必须添加key，原因见： https://weilu.blog.csdn.net/article/details/104745624
        data: data,
        onLongPress: () => _showDeleteBottomSheet(index),
      ),
    );
  }
  
  void _removeItem(int index) {
    /// 先移除数据
    final WithdrawalAccountModel item = _list.removeAt(index);
    _listKey.currentState.removeItem(
      index, (_, animation) => sizeItem(item, 0, animation), /// 构建移除Widget
      duration: _kDuration,
    );
    if (_list.isEmpty) {
      Future.delayed(_kDuration, () {
        if (mounted) {
          setState(() {

          });
        }
      });
    }
  }

  void _insertItem(int index) {
    final WithdrawalAccountModel item = WithdrawalAccountModel('weilu_deer', '微信', 1, '');
    _list.insert(index, item);
    if (_list.length == 1) {
      setState(() {

      });
    } else {
      _listKey.currentState.insertItem(
        index,
        duration: _kDuration,
      );
    }
  }

  void _showDeleteBottomSheet(int index) {
    showModalBottomSheet<void>(
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
                MyButton(
                  minHeight: 54.0,
                  textColor: Theme.of(context).errorColor,
                  text: '确认解绑',
                  backgroundColor: Colors.transparent,
                  onPressed: () {
                    _removeItem(index);
                    NavigatorUtils.goBack(context);
                  },
                ),
                Gaps.line,
                MyButton(
                  minHeight: 54.0,
                  textColor: Colours.text_gray,
                  text: '取消',
                  backgroundColor: Colors.transparent,
                  onPressed: () {
                    NavigatorUtils.goBack(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
