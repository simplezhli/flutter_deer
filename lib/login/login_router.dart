
import 'package:fluro/fluro.dart';
import 'package:flutter_deer/routers/router_init.dart';

import 'login_page.dart';
import 'register_page.dart';
import 'reset_password_page.dart';
import 'sms_login_page.dart';
import 'update_password_page.dart';


class LoginRouter implements IRouterProvider{

  static String loginPage = "/login";
  static String registerPage = "/login/register";
  static String smsLoginPage = "/login/smsLogin";
  static String resetPasswordPage = "/login/resetPassword";
  static String updatePasswordPage = "/login/updatePassword";
  
  @override
  void initRouter(Router router) {
    router.define(loginPage, handler: Handler(handlerFunc: (_, params) => Login()));
    router.define(registerPage, handler: Handler(handlerFunc: (_, params) => Register()));
    router.define(smsLoginPage, handler: Handler(handlerFunc: (_, params) => SMSLogin()));
    router.define(resetPasswordPage, handler: Handler(handlerFunc: (_, params) => ResetPassword()));
    router.define(updatePasswordPage, handler: Handler(handlerFunc: (_, params) => UpdatePasswordPage()));
  }
  
}