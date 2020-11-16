
class FreightConfigModel {

  FreightConfigModel(this.min, this.max, this.type,
      this.isAdd, this.price);

  FreightConfigModel.fromJsonMap(Map<String, dynamic> map):
        min = map['min'] as String,
        max = map['max'] as String,
        type = map['type'] as int,
        isAdd = map['isAdd'] as bool,
        price = map['price'] as String;

  String min;
  String max;
  int type;
  bool isAdd;
  String price;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['min'] = min;
    data['max'] = max;
    data['type'] = type;
    data['isAdd'] = isAdd;
    data['price'] = price;
    return data;
  }
}
