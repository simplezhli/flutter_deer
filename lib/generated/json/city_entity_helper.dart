import 'package:flutter_deer/account/models/city_entity.dart';
import 'package:azlistview/azlistview.dart';

cityEntityFromJson(CityEntity data, Map<String, dynamic> json) {
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['cityCode'] != null) {
		data.cityCode = json['cityCode'].toString();
	}
	if (json['firstCharacter'] != null) {
		data.firstCharacter = json['firstCharacter'].toString();
	}
	return data;
}

Map<String, dynamic> cityEntityToJson(CityEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['name'] = entity.name;
	data['cityCode'] = entity.cityCode;
	data['firstCharacter'] = entity.firstCharacter;
	return data;
}