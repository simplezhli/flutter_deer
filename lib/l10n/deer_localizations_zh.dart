// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'deer_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class DeerLocalizationsZh extends DeerLocalizations {
  DeerLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get title => 'Flutter Deer';

  @override
  String get verificationCodeLogin => '验证码登录';

  @override
  String get passwordLogin => '密码登录';

  @override
  String get login => '登录';

  @override
  String get forgotPasswordLink => '忘记密码';

  @override
  String get inputPasswordHint => '请输入密码';

  @override
  String get inputUsernameHint => '请输入账号';

  @override
  String get noAccountRegisterLink => '还没账号？快去注册';

  @override
  String get register => '注册';

  @override
  String get openYourAccount => '开启你的账号';

  @override
  String get inputPhoneHint => '请输入手机号';

  @override
  String get inputVerificationCodeHint => '请输入验证码';

  @override
  String get inputPhoneInvalid => '请输入有效的手机号';

  @override
  String get verificationButton => '并没有真正发送哦，直接登录吧！';

  @override
  String get getVerificationCode => '获取验证码';

  @override
  String get confirm => '确认';

  @override
  String get resetLoginPassword => '重置登录密码';

  @override
  String get registeredTips => '提示：未注册账号的手机号，请先';
}
