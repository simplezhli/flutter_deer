
import 'package:flutter_deer/common/common.dart';
import 'package:flutter_deer/generated/json/base/json_convert_content.dart';

class BaseEntity<T> {

  int code;
  String message;
  T data;
  List<T> listData = [];

  BaseEntity(this.code, this.message, this.data);

  BaseEntity.fromJson(Map<String, dynamic> json) {
    code = json[Constant.code] as int;
    message = json[Constant.message] as String;
    if (json.containsKey(Constant.data)) {
      if (json[Constant.data] is List) {
        json[Constant.data].forEach((Object item) {
          listData.add(_generateOBJ<T>(item));
        });
      } else {
        data = _generateOBJ(json[Constant.data]);
      }
    }
  }

  S _generateOBJ<S>(Object json) {
    if (S.toString() == 'String') {
      return json.toString() as S;
    } else if (T.toString() == 'Map<dynamic, dynamic>') {
      return json as S;
    } else {
      return JsonConvert.fromJsonAsT<S>(json);
    }
  }
}