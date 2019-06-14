
import 'package:flutter/cupertino.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/utils.dart';

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
  
  String img;
  String hintText;
  
  @override
  Widget build(BuildContext context) {
    switch (widget.type){
      case StateType.order:
        img = "zwdd";
        hintText = "暂无订单";
        break;
      case StateType.goods:
        img = "zwsp";
        hintText = "暂无商品";
        break;
      case StateType.network:
        img = "zwwl";
        hintText = "无网络连接";
        break;
      case StateType.message:
        img = "zwxx";
        hintText = "暂无消息";
        break;
      case StateType.account:
        img = "zwzh";
        hintText = "马上添加提现账号吧";
        break;
      case StateType.loading:
        img = "";
        hintText = "";
        break;
    }
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          widget.type != StateType.loading ? Container(
            height: 120.0,
            width: 120.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Utils.getImgPath("state/" + img)),
              ),
            ),
          ): CupertinoActivityIndicator(radius: 18.0),
          Gaps.vGap16,
          Text(
            widget.hintText ?? hintText,
            style: TextStyles.textGray14,
          ),
          Gaps.vGap50,
        ],
      ),
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
  loading
}