import 'package:flutter_deer/mvp/mvps.dart';
import 'package:flutter_deer/order/models/search_entity.dart';
import 'package:flutter_deer/order/provider/base_list_provider.dart';

abstract class OrderSearchIMvpView implements IMvpView {

  BaseListProvider<SearchItems> get provider;
}

