
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/input_formatter/number_text_input_formatter.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/toast_utils.dart';
import 'package:flutter_deer/widgets/base_dialog.dart';

/// design/7店铺-店铺配置/index.html#artboard1
class RangePriceInputDialog extends StatefulWidget {

  const RangePriceInputDialog({
    Key key,
    this.title,
    this.onPressed,
  }) : super(key : key);

  final String title;
  final Function(String, String) onPressed;
  
  @override
  _RangePriceInputDialog createState() => _RangePriceInputDialog();
  
}

class _RangePriceInputDialog extends State<RangePriceInputDialog> {

  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller1 = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    _controller1.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: widget.title,
      child: Container(
        height: 34.0,
        margin: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
        decoration: BoxDecoration(
          color: ThemeUtils.getDialogTextFieldColor(context),
          borderRadius: BorderRadius.circular(2.0),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: _buildTextField(_controller),
            ),
            Container(
              alignment: Alignment.center,
              child: const Text('至'),
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              color: context.dialogBackgroundColor,
              height: double.infinity
            ),
            Expanded(
              child: _buildTextField(_controller1),
            ),
          ],
        ),
      ),
      onPressed: () {
        if (_controller.text.isEmpty || _controller1.text.isEmpty) {
          Toast.show('请输入${widget.title}');
          return;
        }
        if (double.parse(_controller.text) >= double.parse(_controller1.text)) {
          Toast.show('最小金额不能大于最大金额!');
          return;
        }
        NavigatorUtils.goBack(context);
        widget.onPressed(_controller.text, _controller1.text);
      },
    );
  }

  Widget _buildTextField(TextEditingController controller) {
    return TextField(
      autofocus: true,
      //style: TextStyles.textDark14,
      controller: controller,
      maxLines: 1,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      // 金额限制数字格式
      inputFormatters: [UsNumberTextInputFormatter()],
      decoration: const InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
        border: InputBorder.none,
        //hintStyle: TextStyles.textGray14,
      ),
    );
  }
}