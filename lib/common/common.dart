class Constant {
  /// debug开关，上线需要关闭
  /// App运行在Release环境时，inProduction为true；当App运行在Debug和Profile环境时，inProduction为false
  static const bool inProduction  = const bool.fromEnvironment("dart.vm.product");

  static const String data = 'data';
  static const String message = 'message';
  static const String code = 'code';
  
  static const String key_guide = 'key_guide';
  static const String phone = 'phone';
  static const String access_Token = 'accessToken';
  static const String refresh_Token = 'refreshToken';

  static const List<String> orderLeftButtonText = ["拒单", "拒单", "订单跟踪", "订单跟踪", "订单跟踪"];
  static const List<String> orderRightButtonText = ["接单", "开始配送", "完成", "", ""];
}
