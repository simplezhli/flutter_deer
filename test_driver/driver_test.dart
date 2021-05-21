
import 'account/account_test.dart' as account_test;
import 'goods/goods_test.dart' as goods_test;
import 'home/splash_page_test.dart' as splash_test;
import 'login/login_page_test.dart' as login_test;
import 'order/order_test.dart' as order_test;
import 'setting/setting_test.dart' as setting_test;
import 'shop/shop_test.dart' as shop_test;
import 'statistic/statistic_test.dart' as statistic_test;
import 'store/store_test.dart' as store_test;

/// 集成测试
/// 
/// 测试运行 flutter drive --profile --target=test_driver/driver.dart
/// 
/// 各模块统一运行，也可单独执行子模块测试
void main() {
  splash_test.main();
  login_test.main();
  store_test.main();
  order_test.main();
  goods_test.main();
  statistic_test.main();
  shop_test.main();
  account_test.main();
  setting_test.main(<String>['backHome']);
}