import 'package:flutter_deer/account/models/bank_entity.dart';
import 'package:azlistview/azlistview.dart';

bankEntityFromJson(BankEntity data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['bankName'] != null) {
		data.bankName = json['bankName'].toString();
	}
	if (json['firstLetter'] != null) {
		data.firstLetter = json['firstLetter'].toString();
	}
	return data;
}

Map<String, dynamic> bankEntityToJson(BankEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['bankName'] = entity.bankName;
	data['firstLetter'] = entity.firstLetter;
	return data;
}