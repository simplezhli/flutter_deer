
import 'dart:io';

import 'package:flutter/services.dart';

/// https://github.com/flutter/flutter/issues/25511
/// 主要针对TextInput有设置maxLength且在iOS平台使用原生输入法输入中文时崩溃问题。
/// 使用方法：
/// TextField(
///   inputFormatters: [FixIOSTextInputFormatter()],
/// )
/// 使用后问题是输入的拼音不展示。
///
/// 1.22已修复：https://github.com/flutter/flutter/pull/63754
@Deprecated('1.22已修复')
class FixIOSTextInputFormatter extends TextInputFormatter {

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

    if (Platform.isIOS) {
      // ios Composing变化也执行format，因为在拼音阶段没有执行LengthLimitingTextInputFormatter，从拼音到汉字需要重新执行
      if (newValue != null && newValue.composing != null && newValue.composing.isValid) {
        // ios拼音阶段不执行长度限制的format
        return null;
      }
    }
    return TextEditingValue(
      text: newValue.text,
      selection: TextSelection.collapsed(offset: newValue.selection.end),
    );
  }

}