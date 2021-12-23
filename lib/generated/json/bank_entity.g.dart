import 'package:flutter_deer/generated/json/base/json_convert_content.dart';
import 'package:flutter_deer/account/models/bank_entity.dart';
import 'package:azlistview/azlistview.dart';


BankEntity $BankEntityFromJson(Map<String, dynamic> json) {
	final BankEntity bankEntity = BankEntity();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		bankEntity.id = id;
	}
	final String? bankName = jsonConvert.convert<String>(json['bankName']);
	if (bankName != null) {
		bankEntity.bankName = bankName;
	}
	final String? firstLetter = jsonConvert.convert<String>(json['firstLetter']);
	if (firstLetter != null) {
		bankEntity.firstLetter = firstLetter;
	}
	return bankEntity;
}

Map<String, dynamic> $BankEntityToJson(BankEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['bankName'] = entity.bankName;
	data['firstLetter'] = entity.firstLetter;
	return data;
}