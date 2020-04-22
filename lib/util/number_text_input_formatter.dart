
import 'package:flutter/services.dart';

/// 只允许输入小数
class UsNumberTextInputFormatter extends TextInputFormatter {
  
  static const _kDefaultDouble = 0.001;
  
  static double strToFloat(String str, [double defaultValue = _kDefaultDouble]) {
    try {
      return double.parse(str);
    } catch (e) {
      return defaultValue;
    }
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String value = newValue.text;
    int selectionIndex = newValue.selection.end;
    if (value == '.') {
      value = '0.';
      selectionIndex++;
    } else if (value != '' && value != _kDefaultDouble.toString() && strToFloat(value, _kDefaultDouble) == _kDefaultDouble) {
      value = oldValue.text;
      selectionIndex = oldValue.selection.end;
    }
    return TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}