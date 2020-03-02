
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';

/// design/4商品/index.html#artboard2
class GoodsDeleteBottomSheet extends StatelessWidget {
  
  const GoodsDeleteBottomSheet({
    Key key,
    @required this.onTapDelete,
  }): super(key: key);

  final Function onTapDelete;
  
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(
              height: 52.0,
              child: const Center(
                child: const Text(
                  '是否确认删除，防止错误操作',
                  style: TextStyles.textSize16,
                ),
              ),
            ),
            Gaps.line,
            SizedBox(
              height: 54.0,
              width: double.infinity,
              child: FlatButton(
                textColor: Theme.of(context).errorColor,
                child: const Text('确认删除', style: TextStyle(fontSize: Dimens.font_sp18)),
                onPressed: () {
                  NavigatorUtils.goBack(context);
                  onTapDelete();
                },
              ),
            ),
            Gaps.line,
            SizedBox(
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
  }
}