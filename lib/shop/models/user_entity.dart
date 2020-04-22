import 'package:flutter_deer/generated/json/base/json_convert_content.dart';
import 'package:flutter_deer/generated/json/base/json_filed.dart';

class UserEntity with JsonConvert<UserEntity> {
	@JSONField(name: 'avatar_url')
	String avatarUrl;
	String name;
	int id;
	String blog;
}
