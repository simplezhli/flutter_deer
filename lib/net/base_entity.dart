
import 'package:flutter_deer/common/common.dart';

import '../entity_factory.dart';

class BaseEntity<T>{

  int code;
  String message;
  T data;
  List<T> listData = [];

  BaseEntity(this.code, this.message, this.data);

  BaseEntity.fromJson(Map<String, dynamic> json) {
    code = json[Constant.code];
    message = json[Constant.message];
    if (json.containsKey(Constant.data)){
      if (json[Constant.data] is List) {
        (json[Constant.data] as List).forEach((item){
          listData.add(EntityFactory.generateOBJ<T>(item));
        });
      }else {
        if (T.toString() == "String"){
          data = json[Constant.data].toString() as T;
        }else if (T.toString() == "Map<dynamic, dynamic>"){
          data = json[Constant.data] as T;
        }else {
          data = EntityFactory.generateOBJ(json[Constant.data]);
        }
      }
    }
  }
}