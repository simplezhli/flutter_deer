import 'package:fluro/fluro.dart';
import 'package:flutter_deer/routers/i_router.dart';

import 'page/account_page.dart';
import 'page/account_record_list_page.dart';
import 'page/add_withdrawal_account_page.dart';
import 'page/bank_select_page.dart';
import 'page/city_select_page.dart';
import 'page/withdrawal_account_list_page.dart';
import 'page/withdrawal_account_page.dart';
import 'page/withdrawal_page.dart';
import 'page/withdrawal_password_page.dart';
import 'page/withdrawal_record_list_page.dart';
import 'page/withdrawal_result_page.dart';


class AccountRouter implements IRouterProvider{

  static String accountPage = '/account';
  static String accountRecordListPage = '/account/recordList';
  static String addWithdrawalAccountPage = '/account/addWithdrawal';
  static String bankSelectPage = '/account/bankSelect';
  static String citySelectPage = '/account/citySelect';
  static String withdrawalAccountListPage = '/account/withdrawalAccountList';
  static String withdrawalAccountPage = '/account/withdrawalAccount';
  static String withdrawalPage = '/account/withdrawal';
  static String withdrawalPasswordPage = '/account/withdrawalPassword';
  static String withdrawalRecordListPage = '/account/withdrawalRecordList';
  static String withdrawalResultPage = '/account/withdrawalResult';
  
  @override
  void initRouter(FluroRouter router) {
    router.define(accountPage, handler: Handler(handlerFunc: (_, __) => const AccountPage()));
    router.define(accountRecordListPage, handler: Handler(handlerFunc: (_, __) => const AccountRecordListPage()));
    router.define(addWithdrawalAccountPage, handler: Handler(handlerFunc: (_, __) => const AddWithdrawalAccountPage()));
    router.define(bankSelectPage, handler: Handler(handlerFunc: (_, Map<String, List<String>> params) {
      final int type = int.parse(params['type']?.first ?? '0');
      return BankSelectPage(type: type);
    }));
    router.define(citySelectPage, handler: Handler(handlerFunc: (_, __) => const CitySelectPage()));
    router.define(withdrawalAccountListPage, handler: Handler(handlerFunc: (_, __) => const WithdrawalAccountListPage()));
    router.define(withdrawalAccountPage, handler: Handler(handlerFunc: (_, __) => const WithdrawalAccountPage()));
    router.define(withdrawalPage, handler: Handler(handlerFunc: (_, __) => const WithdrawalPage()));
    router.define(withdrawalPasswordPage, handler: Handler(handlerFunc: (_, __) => const WithdrawalPasswordPage()));
    router.define(withdrawalRecordListPage, handler: Handler(handlerFunc: (_, __) => const WithdrawalRecordListPage()));
    router.define(withdrawalResultPage, handler: Handler(handlerFunc: (_, __) => const WithdrawalResultPage()));
  }
  
}