
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';

class GoodsDeleteBottomSheet extends StatelessWidget {
  
  const GoodsDeleteBottomSheet({
    Key key,
    @required this.onTapDelete,
  }): super(key: key);

  final Function onTapDelete;
  
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Container(
            height: 161.2,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  height: 52.0,
                  child: const Text(
                    "是否确认删除，防止错误操作",
                    style: TextStyles.textDark16,
                  ),
                ),
                Gaps.line,
                Container(
                  height: 54.0,
                  width: double.infinity,
                  child: FlatButton(
                    textColor: Colours.text_red,
                    child: const Text("确认删除", style: TextStyle(fontSize: Dimens.font_sp18)),
                    onPressed: (){
                      NavigatorUtils.goBack(context);
                      onTapDelete();
                    },
                  ),
                ),
                Gaps.line,
                Container(
                  height: 54.0,
                  width: double.infinity,
                  child: FlatButton(
                    textColor: Colours.text_gray,
                    child: const Text("取消", style: TextStyle(fontSize: Dimens.font_sp18)),
                    onPressed: (){
                      NavigatorUtils.goBack(context);
                    },
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}