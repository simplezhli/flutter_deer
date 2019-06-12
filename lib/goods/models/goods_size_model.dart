
class GoodsSizeModel {

  String icon;
  String sizeName;
  int stock;
  String price;
  int minSaleNum;
  String reducePrice;
  String charges;
  String currencyPrice;

  GoodsSizeModel(this.icon, this.sizeName, this.stock, 
      this.price, this.minSaleNum, this.reducePrice,
      this.charges, this.currencyPrice);

  GoodsSizeModel.fromJsonMap(Map<String, dynamic> map):
        icon = map["icon"],
        sizeName = map["sizeName"],
        stock = map["stock"],
        price = map["price"],
        minSaleNum = map["minSaleNum"],
        reducePrice = map["reducePrice"],
        charges = map["charges"],
        currencyPrice = map["currencyPrice"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
