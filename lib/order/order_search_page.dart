

import 'package:flutter/material.dart';
import 'package:flutter_deer/mvp/base_page_state.dart';
import 'package:flutter_deer/widgets/my_refresh_list.dart';
import 'package:flutter_deer/widgets/search_bar.dart';
import 'package:flutter_deer/widgets/state_layout.dart';
import 'package:provider/provider.dart';

import 'presenter/order_search_presenter.dart';
import 'provider/search_item_provider.dart';

class OrderSearch extends StatefulWidget {
  @override
  OrderSearchState createState() => OrderSearchState();
}

class OrderSearchState extends BasePageState<OrderSearch, OrderSearchPresenter> {

  SearchItemListProvider provider = SearchItemListProvider();
  
  String _keyword;
  int _page = 1;
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchItemListProvider>(
      builder: (_) => provider,
      child: Scaffold(
        appBar: SearchBar(
          hintText: "请输入手机号或姓名查询",
          onPressed: (text){
            if (text.isEmpty){
              showToast("搜索关键字不能为空！");
              return;
            }
            FocusScope.of(context).requestFocus(FocusNode());
            _keyword = text;
            provider.setStateType(StateType.loading);
            _page = 1;
            presenter.search(_keyword, _page, true);
          },
        ),
        body: Consumer<SearchItemListProvider>(
          builder: (_, provider, __) {
            return DeerListView(
              itemCount: provider.list.length,
              stateType: provider.stateType,
              onRefresh: _onRefresh,
              loadMore: _loadMore,
              itemExtent: 50.0,
              hasMore: provider.hasMore,
              itemBuilder: (_, index){
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(provider.list[index].name),
                );
              },
            );
          }
        ),
      ),
    );
  }

  Future _onRefresh() async {
    _page = 1;
    await presenter.search(_keyword, _page, false);
  }

  Future _loadMore() async {
    _page++;
    await presenter.search(_keyword, _page, false);
  }

  @override
  OrderSearchPresenter createPresenter() {
    return OrderSearchPresenter();
  }
}
