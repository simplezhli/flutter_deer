
class GoodsSizeModel {

  GoodsSizeModel(this.icon, this.sizeName, this.stock, 
      this.price, this.minSaleNum, this.reducePrice,
      this.charges, this.currencyPrice);

  GoodsSizeModel.fromJsonMap(Map<String, dynamic> map):
        icon = map['icon'] as String,
        sizeName = map['sizeName'] as String,
        stock = map['stock'] as int,
        price = map['price'] as String,
        minSaleNum = map['minSaleNum'] as int,
        reducePrice = map['reducePrice'] as String,
        charges = map['charges'] as String,
        currencyPrice = map['currencyPrice'] as String;

  String icon;
  String sizeName;
  int stock;
  String price;
  int minSaleNum;
  String reducePrice;
  String charges;
  String currencyPrice;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['icon'] = icon;
    data['sizeName'] = sizeName;
    data['stock'] = stock;
    data['price'] = price;
    data['minSaleNum'] = minSaleNum;
    data['reducePrice'] = reducePrice;
    data['charges'] = charges;
    data['xPrice'] = currencyPrice;
    return data;
  }
}
