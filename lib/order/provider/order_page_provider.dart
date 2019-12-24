import 'package:flutter/material.dart';

class OrderPageProvider extends ChangeNotifier {

  /// Tab的下标
  int _index = 0;
  int get index => _index;
  
  void refresh() {
    notifyListeners();
  }
  
  void setIndex(int index) {
    _index = index;
    notifyListeners();
  }

}