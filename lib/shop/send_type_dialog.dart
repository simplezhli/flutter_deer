
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/utils.dart';
import 'package:flutter_deer/widgets/base_dialog.dart';

class SendTypeDialog extends StatefulWidget{

  SendTypeDialog({
    Key key,
    this.onPressed,
  }) : super(key : key);

  final Function(int, String) onPressed;
  
  @override
  _SendTypeDialog createState() => _SendTypeDialog();
  
}

class _SendTypeDialog extends State<SendTypeDialog>{

  int _value = 0;
  var _list = ["运费满免配置", "运费比例配置"];

  Widget getItem(int index){
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        child: Container(
          height: 42.0,
          child: Row(
            children: <Widget>[
              Gaps.hGap16,
              Expanded(
                child: Text(
                  _list[index],
                  style: _value == index ? TextStyles.textMain14 : TextStyles.textDark14,
                ),
              ),
              Offstage(
                  offstage: _value != index,
                  child: Image.asset(Utils.getImgPath("order/ic_check"), width: 16.0, height: 16.0)),
              Gaps.hGap16,
            ],
          ),
        ),
        onTap: (){
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
      title: "运费配置",
      height: 205.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          getItem(0),
          getItem(1),
        ],
      ),
      onPressed: (){
        widget.onPressed(_value, _list[_value]);
        Navigator.of(context).pop();
      },
    );
  }
}