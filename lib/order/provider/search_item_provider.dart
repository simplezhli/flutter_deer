
import 'package:flutter_deer/order/models/search_entity.dart';
import 'package:flutter_deer/provider/base_list_provider.dart';
import 'package:flutter_deer/widgets/state_layout.dart';

class SearchItemListProvider extends BaseListProvider<SearchItem>{
  
  StateType _stateType = StateType.empty;
  bool _hasMore = true;

  StateType get stateType => _stateType;
  bool get hasMore => _hasMore;
  
  void setStateType(StateType stateType){
    _stateType = stateType;
    notifyListeners();
  }

  void setHasMore(bool hasMore){
    _hasMore = hasMore;
  }
}