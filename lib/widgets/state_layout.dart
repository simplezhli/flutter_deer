
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/image_utils.dart';
import 'package:flutter_deer/util/theme_utils.dart';

/// design/9暂无状态页面/index.html#artboard3
class StateLayout extends StatefulWidget {
  
  const StateLayout({
    Key key,
    @required this.type,
    this.hintText
  }):super(key: key);
  
  final StateType type;
  final String hintText;
  
  @override
  _StateLayoutState createState() => _StateLayoutState();
}

class _StateLayoutState extends State<StateLayout> {
  
  String _img;
  String _hintText;
  
  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case StateType.order:
        _img = 'zwdd';
        _hintText = '暂无订单';
        break;
      case StateType.goods:
        _img = 'zwsp';
        _hintText = '暂无商品';
        break;
      case StateType.network:
        _img = 'zwwl';
        _hintText = '无网络连接';
        break;
      case StateType.message:
        _img = 'zwxx';
        _hintText = '暂无消息';
        break;
      case StateType.account:
        _img = 'zwzh';
        _hintText = '马上添加提现账号吧';
        break;
      case StateType.loading:
        _img = '';
        _hintText = '';
        break;
      case StateType.empty:
        _img = '';
        _hintText = '';
        break;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (widget.type == StateType.loading) 
          const CupertinoActivityIndicator(radius: 16.0) 
        else 
          widget.type == StateType.empty ? 
          Gaps.empty : Opacity(
          opacity: ThemeUtils.isDark(context) ? 0.5 : 1,
          child: Container(
            height: 120.0,
            width: 120.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ImageUtils.getAssetImage('state/$_img'),
              ),
            ),
          )),
        const SizedBox(width: double.infinity, height: Dimens.gap_dp16,),
        Text(
          widget.hintText ?? _hintText,
          style: Theme.of(context).textTheme.subtitle2.copyWith(fontSize: Dimens.font_sp14),
        ),
        Gaps.vGap50,
      ],
    );
  }
}

enum StateType {
  /// 订单
  order,
  /// 商品
  goods,
  /// 无网络
  network,
  /// 消息
  message,
  /// 无提现账号
  account,
  /// 加载中
  loading,
  /// 空
  empty
}