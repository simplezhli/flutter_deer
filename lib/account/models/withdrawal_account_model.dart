
class WithdrawalAccountModel {

  String name;
  String typeName;
  int type;
  String code;

  WithdrawalAccountModel(this.name, this.typeName, this.type, this.code);

  WithdrawalAccountModel.fromJsonMap(Map<String, dynamic> map):
        name = map['name'],
        typeName = map['typeName'],
        type = map['type'],
        code = map['code'];
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['typeName'] = typeName;
    data['type'] = type;
    data['code'] = code;
    return data;
  }
}
