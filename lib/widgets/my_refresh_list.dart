
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/widgets/state_layout.dart';

class DeerListView extends StatefulWidget {

  const DeerListView({
    Key key,
    @required this.itemCount,
    @required this.itemBuilder,
    @required this.onRefresh,
    this.loadMore,
    this.hasMore : false,
    this.stateType : StateType.empty,
    this.pageSize : 10,
    this.padding,
    this.itemExtent
  }): super(key: key);

  final RefreshCallback onRefresh;
  final LoadMoreCallback loadMore;
  final int itemCount;
  final bool hasMore;
  final IndexedWidgetBuilder itemBuilder;
  final StateType stateType;
  /// 一页的数量，默认为10
  final int pageSize;
  final EdgeInsetsGeometry padding;
  final double itemExtent;
  
  @override
  _DeerListViewState createState() => _DeerListViewState();
}

typedef RefreshCallback = Future<void> Function();
typedef LoadMoreCallback = Future<void> Function();

class _DeerListViewState extends State<DeerListView> {

  /// 是否正在加载数据
  bool _isLoading = false;
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NotificationListener(
        onNotification: (ScrollNotification note){
          if (note.metrics.pixels == note.metrics.maxScrollExtent){
            _loadMore();
          }
          return true;
        },
        child: RefreshIndicator(
          onRefresh: widget.onRefresh,
          child: widget.itemCount == 0 ? StateLayout(type: widget.stateType) : ListView.builder(
            itemCount: widget.itemCount + 1,
            padding: widget.padding,
            itemExtent: widget.itemExtent,
            itemBuilder: (BuildContext context, int index){
              return index < widget.itemCount ? widget.itemBuilder(context, index) : _buildMoreWidget();
            }
          )
        ),
      ),
    );
  }

  Future _loadMore() async {
    if (widget.loadMore == null){
      return;
    }
    if (_isLoading) {
      return;
    }
    if (!widget.hasMore){
      return;
    }
    _isLoading = true;
    await widget.loadMore();
    _isLoading = false;
  }

  Widget _buildMoreWidget(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Offstage(offstage: !widget.hasMore, child: const CupertinoActivityIndicator()),
          Offstage(offstage: !widget.hasMore, child: Gaps.hGap5),
          /// 只有一页的时候，就不显示FooterView了
          Text(widget.hasMore ? '正在加载中...' : (widget.itemCount < widget.pageSize ? '' : '没有了呦~'), style: TextStyle(color: const Color(0x8A000000))),
        ],
      ),
    );
  }
}
