import 'package:flutter_deer/generated/json/base/json_convert_content.dart';
import 'package:flutter_deer/account/models/city_entity.dart';
import 'package:azlistview/azlistview.dart';


CityEntity $CityEntityFromJson(Map<String, dynamic> json) {
	final CityEntity cityEntity = CityEntity();
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		cityEntity.name = name;
	}
	final String? cityCode = jsonConvert.convert<String>(json['cityCode']);
	if (cityCode != null) {
		cityEntity.cityCode = cityCode;
	}
	final String? firstCharacter = jsonConvert.convert<String>(json['firstCharacter']);
	if (firstCharacter != null) {
		cityEntity.firstCharacter = firstCharacter;
	}
	return cityEntity;
}

Map<String, dynamic> $CityEntityToJson(CityEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['name'] = entity.name;
	data['cityCode'] = entity.cityCode;
	data['firstCharacter'] = entity.firstCharacter;
	return data;
}