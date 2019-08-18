
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/order/order_router.dart';
import 'package:flutter_deer/order/pay_type_dialog.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/image_utils.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/util/utils.dart';
import 'package:flutter_deer/widgets/my_card.dart';
import 'package:flutter_deer/widgets/state_layout.dart';

class OrderList extends StatefulWidget {

  const OrderList({
    Key key,
    @required this.index,
    @required this.tabIndex,
  }): super(key: key);

  final int index;
  final int tabIndex;
  
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> with AutomaticKeepAliveClientMixin<OrderList>{

  var _orderLeftButtonText = ["拒单", "拒单", "订单跟踪", "订单跟踪", "订单跟踪"];
  var _orderRightButtonText = ["接单", "开始配送", "完成", "", ""];

  /// 是否正在加载数据
  bool _isLoading = false;
  int _page = 1;
  final int _maxPage = 3;
  StateType _stateType = StateType.loading;
  int _index = 0;
  ScrollController _controller = ScrollController();
  
  @override
  void initState() {
    super.initState();
    _index = widget.index;
    _onRefresh();
  }
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NotificationListener(
      onNotification: (ScrollNotification note){
        if(note.metrics.pixels == note.metrics.maxScrollExtent){
          _loadMore();
        }
        return true;
      },
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        displacement: 120.0, /// 默认40， 多添加的80为Header高度
        child: CustomScrollView(
          /// 这里指定controller可以与外层NestedScrollView的滚动分离，避免一处滑动，5个Tab中的列表同步滑动。
          controller: _index != widget.tabIndex ? _controller : null,
          key: PageStorageKey<String>("$_index"),
          slivers: <Widget>[
            SliverOverlapInjector(
              ///SliverAppBar的expandedHeight高度,避免重叠
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              sliver: _list.isEmpty ? SliverFillRemaining(child: StateLayout(type: _stateType)) : SliverList(
                delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(top: 8.0),
                    child: index < _list.length ? (index % 5 == 0 ? _buildTimeTag() : _buildOrderItem()) : _buildMoreWidget(),
                  );
                },
                childCount: _list.length + 1),
              ),
            )
          ],
        ),
      ),
    );
  }

  List _list = [];

  Future _onRefresh() async {
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _page = 1;
        _list = List.generate(10, (i) => 'newItem：$i');
      });
    });
  }

  bool _hasMore(){
    return _page < _maxPage;
  }

  Future _loadMore() async {
    if (_isLoading) {
      return;
    }
    if (!_hasMore()){
      return;
    }
    _isLoading = true;
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _list.addAll(List.generate(10, (i) => 'newItem：$i'));
        _page ++;
        _isLoading = false;
      });
    });
  }

  Widget _buildMoreWidget(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Offstage(offstage: !_hasMore(), child: const CupertinoActivityIndicator()),
          Offstage(offstage: !_hasMore(), child: Gaps.hGap5),
          Text(!_hasMore() ? '没有了呦~' : '正在加载中...', style: TextStyle(color: const Color(0x8A000000))),
        ],
      ),
    );
  }

  Widget _buildOrderItem(){
    return MyCard(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: InkWell(
          onTap: (){
            NavigatorUtils.push(context, OrderRouter.orderInfoPage);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "15000000000（郭李）",
                      style: TextStyles.textDark14,
                    ),
                  ),
                  const Text(
                    "货到付款",
                    style: TextStyle(
                        fontSize: Dimens.font_sp12,
                        color: Colours.text_red
                    ),
                  ),
                ],
              ),
              Gaps.vGap8,
              Text(
                "西安市雁塔区 鱼化寨街道唐兴路唐兴数码3楼318",
                style: TextStyles.textNormal12,
              ),
              Gaps.vGap8,
              Gaps.line,
              Gaps.vGap8,
              RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: '清凉一度抽纸', style: TextStyles.textDark12),
                      TextSpan(text: '  x1', style: TextStyles.textGray12),
                    ],
                  )
              ),
              Gaps.vGap8,
              RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: '清凉一度抽纸', style: TextStyles.textDark12),
                      TextSpan(text: '  x2', style: TextStyles.textGray12),
                    ],
                  )
              ),
              Gaps.vGap12,
              Row(
                children: <Widget>[
                  Expanded(
                    child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(text: '¥20.00', style: TextStyles.textDark12),
                            TextSpan(text: '  共3件商品', style: TextStyles.textGray10),
                          ],
                        )
                    ),
                  ),
                  Text(
                    "2018.02.05 10:00",
                    style: TextStyles.textDark12,
                  ),
                ],
              ),
              Gaps.vGap8,
              Gaps.line,
              Gaps.vGap8,
              Theme( // 修改button默认的最小宽度与padding
                data: Theme.of(context).copyWith(
                  buttonTheme: ButtonThemeData(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      minWidth: 64.0,
                      height: 30.0,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // 距顶部距离为0
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      )
                  ),
                  textTheme: TextTheme(
                      button: TextStyle(
                        fontSize: Dimens.font_sp14,
                      )
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    FlatButton(
                      color: Colours.bg_gray,
                      child: const Text("联系客户"),
                      onPressed: (){
                        _showCallPhoneDialog("15000000000");
                      },
                    ),
                    Expanded(
                      child: Gaps.empty,
                    ),
                    FlatButton(
                      color: Colours.bg_gray,
                      child: Text(_orderLeftButtonText[_index]),
                      onPressed: (){
                        if (_index >= 2){
                          NavigatorUtils.push(context, OrderRouter.orderTrackPage);
                        }
                      },
                    ),
                    Offstage(
                      offstage: _orderRightButtonText[_index].length == 0,
                      child: Gaps.hGap10,
                    ),
                    Offstage(
                      offstage: _orderRightButtonText[_index].length == 0,
                      child: FlatButton(
                        color: Colours.app_main,
                        textColor: Colors.white,
                        onPressed: (){
                          if (_index == 2){
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return PayTypeDialog(
                                    onPressed: (index, type){
                                      Toast.show("收款类型：$type");
                                    },
                                  );
                                });
                          }
                        },
                        child: Text(_orderRightButtonText[_index]),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showCallPhoneDialog(String phone){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('提示'),
            content: Text('是否拨打：$phone ?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => NavigatorUtils.goBack(context),
                child: const Text('取消'),
              ),
              FlatButton(
                onPressed: (){
                  Utils.launchTelURL(phone);
                  NavigatorUtils.goBack(context);
                },
                textColor: Colours.text_red,
                child: const Text('拨打'),
              ),
            ],
          );
        });
  }

  Widget _buildTimeTag(){
    return MyCard(
        child: Container(
          height: 34.0,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: <Widget>[
              loadAssetImage("order/icon_calendar", width: 14.0, height: 14.0),
              Gaps.hGap10,
              Text(
                "2019年2月5日",
                style: TextStyles.textDark14,
              ),
              Expanded(child: Container()),
              Text(
                "4单",
                style: TextStyles.textDark14,
              )
            ],
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
