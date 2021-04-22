
import 'package:azlistview/azlistview.dart';
import 'package:flutter_deer/generated/json/base/json_convert_content.dart';

class CityEntity with JsonConvert<CityEntity>, ISuspensionBean {
	late String name;
	late String cityCode;
	late String firstCharacter;

	@override
	String getSuspensionTag() {
		return firstCharacter;
	}
}
