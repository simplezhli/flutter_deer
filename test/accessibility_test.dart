import 'account/account_accessibility_test.dart' as account_test;
import 'goods/goods_accessibility_test.dart' as goods_test;
import 'login/login_accessibility_test.dart' as login_test;
import 'order/order_accessibility_test.dart' as order_test;
import 'setting/setting_accessibility_test.dart' as setting_test;
import 'shop/shop_accessibility_test.dart' as shop_test;
import 'statistics/statistic_accessibility_test.dart' as statistic_test;
import 'store/store_accessibility_test.dart' as store_test;

/// 可访问性测试
/// 1.检测页面可点击目标大小是否小于44 * 44
/// 2.检测页面可点击目标是否都有语义，例如图片可点击，但没加语义，就会报错。
/// 3.检测页面文本对比度是否满足最小值的准则，例如文字与背景对比度过低，就会报错。（部分测试）
/// 
/// 测试运行： flutter test test/accessibility_test.dart
/// 
/// 各模块统一运行，也可单独执行子模块测试
void main() {
  account_test.main();
  goods_test.main();
  login_test.main();
  order_test.main();
  setting_test.main();
  shop_test.main();
  statistic_test.main();
  store_test.main();
}
