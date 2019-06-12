import 'package:azlistview/azlistview.dart';

class CityModel extends ISuspensionBean{

  String name;
  String cityCode;
  String firstCharacter;

  CityModel(this.name, this.cityCode, this.firstCharacter);

  CityModel.fromJsonMap(Map<String, dynamic> map):
        name = map["name"],
        cityCode = map["cityCode"],
        firstCharacter = map["firstCharacter"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['cityCode'] = cityCode;
    data['firstCharacter'] = firstCharacter;
    return data;
  }

  @override
  String getSuspensionTag() {
    return firstCharacter;
  }
}
