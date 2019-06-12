
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/utils.dart';
import 'package:flutter_deer/widgets/base_dialog.dart';

class PayTypeDialog extends StatefulWidget{

  PayTypeDialog({
    Key key,
    this.onPressed,
  }) : super(key : key);

  final Function(int, String) onPressed;
  
  @override
  _PayTypeDialog createState() => _PayTypeDialog();
  
}

class _PayTypeDialog extends State<PayTypeDialog>{

  int value = 0;
  var list = ["未收款", "支付宝", "微信", "现金"];

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
                  list[index],
                  style: value == index ? TextStyles.textMain14 : TextStyles.textDark14,
                ),
              ),
              Offstage(
                  offstage: value != index,
                  child: Image.asset(Utils.getImgPath("order/ic_check"), width: 16.0, height: 16.0)),
              Gaps.hGap16,
            ],
          ),
        ),
        onTap: (){
          if (mounted) {
            setState(() {
              value = index;
            });
          }
        },
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: "收款方式",
      height: 285.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          getItem(0),
          getItem(1),
          getItem(2),
          getItem(3),
        ],
      ),
      onPressed: (){
        widget.onPressed(value, list[value]);
        Navigator.of(context).pop();
      },
    );
  }
}