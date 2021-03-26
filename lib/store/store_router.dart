
import 'package:fluro/fluro.dart';
import 'package:flutter_deer/routers/i_router.dart';

import 'page/store_audit_page.dart';
import 'page/store_audit_result_page.dart';


class StoreRouter implements IRouterProvider{

  static String auditPage = '/store/audit';
  static String auditResultPage = '/store/auditResult';
  
  @override
  void initRouter(FluroRouter router) {
    router.define(auditPage, handler: Handler(handlerFunc: (_, __) => const StoreAuditPage()));
    router.define(auditResultPage, handler: Handler(handlerFunc: (_, __) => const StoreAuditResultPage()));
  }
  
}