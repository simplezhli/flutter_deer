
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/input_formatter/number_text_input_formatter.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/toast_utils.dart';
import 'package:flutter_deer/widgets/base_dialog.dart';


/// design/7店铺-店铺配置/index.html#artboard3
class PriceInputDialog extends StatefulWidget {

  const PriceInputDialog({
    Key key,
    this.title,
    this.inputMaxPrice = 100000,
    this.onPressed,
  }) : super(key : key);

  final String title;
  final double inputMaxPrice;
  final Function(String) onPressed;
  
  @override
  _PriceInputDialog createState() => _PriceInputDialog();
  
}

class _PriceInputDialog extends State<PriceInputDialog> {

  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: widget.title,
      child: Container(
        height: 34.0,
        alignment: Alignment.center,
        margin: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
        decoration: BoxDecoration(
          color: ThemeUtils.getDialogTextFieldColor(context),
          borderRadius: BorderRadius.circular(2.0),
        ),
        child: TextField(
          key: const Key('price_input'),
          autofocus: true,
          controller: _controller,
          maxLines: 1,
          //style: TextStyles.textDark14,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          // 金额限制数字格式
          inputFormatters: [UsNumberTextInputFormatter(max: widget.inputMaxPrice)],
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            border: InputBorder.none,
            hintText: '输入${widget.title}',
            //hintStyle: TextStyles.textGrayC14,
          ),
        ),
      ),
      onPressed: () {
        if (_controller.text.isEmpty) {
          Toast.show('请输入${widget.title}');         
          return;
        }
        NavigatorUtils.goBack(context);
        widget.onPressed(_controller.text);
      },
    );
  }
}