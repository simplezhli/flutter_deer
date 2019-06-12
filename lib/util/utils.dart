
import 'package:flutter_deer/util/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }

  static void launchTelURL(String phone) async {
    String url = 'tel:'+ phone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Toast.show('拨号失败！');
    }
  }
}
