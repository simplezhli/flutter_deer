import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/widgets/base_dialog.dart';
import 'package:flutter_deer/widgets/load_image.dart';


/// design/7店铺-店铺配置/index.html#artboard9
class SendTypeDialog extends StatefulWidget {

  const SendTypeDialog({
    Key? key,
    required this.onPressed,
  }) : super(key : key);

  final Function(int, String) onPressed;
  
  @override
  _SendTypeDialog createState() => _SendTypeDialog();
}

class _SendTypeDialog extends State<SendTypeDialog> {

  int _value = 0;
  final _list = ['运费满免配置', '运费比例配置'];

  Widget _buildItem(int index) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        child: SizedBox(
          height: 42.0,
          child: Row(
            children: <Widget>[
              Gaps.hGap16,
              Expanded(
                child: Text(
                  _list[index],
                  style: _value == index ? TextStyle(
                    fontSize: Dimens.font_sp14,
                    color: Theme.of(context).primaryColor,
                  ) : null,
                ),
              ),
              Visibility(
                visible: _value == index,
                child: const LoadAssetImage('order/ic_check', width: 16.0, height: 16.0)),
              Gaps.hGap16,
            ],
          ),
        ),
        onTap: () {
          if (mounted) {
            setState(() {
              _value = index;
            });
          }
        },
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: '运费配置',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(_list.length, (i) => _buildItem(i))
      ),
      onPressed: () {
        NavigatorUtils.goBack(context);
        widget.onPressed(_value, _list[_value]);
      },
    );
  }
}