import 'package:flutter_deer/mvp/base_page_presenter.dart';
import 'package:flutter_deer/net/net.dart';
import 'package:flutter_deer/order/models/search_entity.dart';
import 'package:flutter_deer/order/iview/order_search_iview.dart';
import 'package:flutter_deer/widgets/state_layout.dart';


class OrderSearchPresenter extends BasePagePresenter<OrderSearchIMvpView> {

  Future search(String text, int page, bool isShowDialog) {
   
    final Map<String, String> params = <String, String>{};
    params['q'] = text;
    params['page'] = page.toString();
    params['l'] = 'Dart';
    return requestNetwork<SearchEntity>(Method.get,
      url: HttpApi.search,
      queryParameters: params,
      isShow: isShowDialog,
      onSuccess: (data) {
        if (data != null && data.items != null) {
          /// 一页30条数据，等于30条认为有下一页
          /// 具体的处理逻辑根据具体的接口情况处理，这部分可以抽离出来
          view.provider.setHasMore(data.items!.length == 30);
          if (page == 1) {
            /// 刷新
            view.provider.list.clear();
            if (data.items!.isEmpty) {
              view.provider.setStateType(StateType.order);
            } else {
              view.provider.addAll(data.items!);
            }
          } else {
            view.provider.addAll(data.items!);
          }
        } else {
          /// 加载失败
          view.provider.setHasMore(false);
          view.provider.setStateType(StateType.network);
        }
      },
      onError: (_, __) {
        /// 加载失败
        view.provider.setHasMore(false);
        view.provider.setStateType(StateType.network);
      }
    );
  }
 
}