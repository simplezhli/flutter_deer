import 'package:flutter_deer/generated/json/base/json_field.dart';
import 'package:flutter_deer/generated/json/user_entity.g.dart';

@JsonSerializable()
class UserEntity {

	UserEntity();

	factory UserEntity.fromJson(Map<String, dynamic> json) => $UserEntityFromJson(json);

	Map<String, dynamic> toJson() => $UserEntityToJson(this);

	@JSONField(name: 'avatar_url')
	String? avatarUrl;
	String? name;
	int? id;
	String? blog;
}
