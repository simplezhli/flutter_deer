
class FreightConfigModel {

  String min;
  String max;
  int type;
  bool isAdd;
  String price;

  FreightConfigModel(this.min, this.max, this.type, 
      this.isAdd, this.price);

  FreightConfigModel.fromJsonMap(Map<String, dynamic> map):
        min = map['min'],
        max = map['max'],
        type = map['type'],
        isAdd = map['isAdd'],
        price = map['price'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['min'] = min;
    data['max'] = max;
    data['type'] = type;
    data['isAdd'] = isAdd;
    data['price'] = price;
    return data;
  }
}
