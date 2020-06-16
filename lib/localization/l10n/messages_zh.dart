// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "forgotPasswordLink" : MessageLookupByLibrary.simpleMessage("忘记密码"),
    "inputPasswordHint" : MessageLookupByLibrary.simpleMessage("请输入密码"),
    "inputPhoneHint" : MessageLookupByLibrary.simpleMessage("请输入手机号"),
    "inputPhoneInvalid" : MessageLookupByLibrary.simpleMessage("请输入有效的手机号"),
    "inputUsernameHint" : MessageLookupByLibrary.simpleMessage("请输入账号"),
    "inputVerificationCodeHint" : MessageLookupByLibrary.simpleMessage("请输入验证码"),
    "login" : MessageLookupByLibrary.simpleMessage("登录"),
    "noAccountRegisterLink" : MessageLookupByLibrary.simpleMessage("还没账号？快去注册"),
    "openYourAccount" : MessageLookupByLibrary.simpleMessage("开启你的账号"),
    "passwordLogin" : MessageLookupByLibrary.simpleMessage("密码登录"),
    "register" : MessageLookupByLibrary.simpleMessage("注册"),
    "title" : MessageLookupByLibrary.simpleMessage("Flutter Deer"),
    "verificationButton" : MessageLookupByLibrary.simpleMessage("并没有真正发送哦，直接登录吧！"),
    "verificationCodeLogin" : MessageLookupByLibrary.simpleMessage("验证码登录"),
    "getVerificationCode" : MessageLookupByLibrary.simpleMessage("获取验证码"),
    "confirm" : MessageLookupByLibrary.simpleMessage("确认"),
    "resetLoginPassword" : MessageLookupByLibrary.simpleMessage("重置登录密码"),
    "registeredTips" : MessageLookupByLibrary.simpleMessage("提示：未注册账号的手机号，请先")
  };
}
