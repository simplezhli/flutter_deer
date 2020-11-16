
class WithdrawalAccountModel {

  WithdrawalAccountModel(this.name, this.typeName, this.type, this.code);

  WithdrawalAccountModel.fromJsonMap(Map<String, dynamic> map):
        name = map['name'] as String,
        typeName = map['typeName'] as String,
        type = map['type'] as int,
        code = map['code'] as String;

  String name;
  String typeName;
  int type;
  String code;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['typeName'] = typeName;
    data['type'] = type;
    data['code'] = code;
    return data;
  }
}
