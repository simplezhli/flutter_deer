

import 'package:flutter/material.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/widgets/my_refresh_list.dart';
import 'package:flutter_deer/widgets/state_layout.dart';

import '../goods_router.dart';
import 'goods_delete_bottom_sheet.dart';
import 'goods_item.dart';

class GoodsList extends StatefulWidget {
  
  const GoodsList({
    Key key,
    @required this.index
  }): super(key: key);
  
  final int index;
  
  @override
  _GoodsListState createState() => _GoodsListState();
}

class _GoodsListState extends State<GoodsList> with AutomaticKeepAliveClientMixin<GoodsList>, SingleTickerProviderStateMixin {
  
  int _selectIndex = -1;
  Animation<double> _animation;
  AnimationController _controller;
  List _list = [];

  @override
  void initState() {
    super.initState();
    // 初始化动画控制
    _controller = new AnimationController(duration: const Duration(milliseconds: 450), vsync: this);
    // 动画曲线
    CurvedAnimation _curvedAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeOutSine);
    _animation = new Tween(begin: 0.0, end: 1.1).animate(_curvedAnimation);

    //Item数量
    _maxPage = widget.index == 0 ? 1 : (widget.index == 1 ? 2 : 3);

    _onRefresh();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  List<String> _imgList = [
    "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3130502839,1206722360&fm=26&gp=0.jpg",
    "https://xxx", // 故意使用一张错误链接
    "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1762976310,1236462418&fm=26&gp=0.jpg",
    "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3659255919,3211745976&fm=26&gp=0.jpg",
    "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2085939314,235211629&fm=26&gp=0.jpg",
    "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2441563887,1184810091&fm=26&gp=0.jpg"
  ];

  Future _onRefresh() async {
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _page = 1;
        _list = List.generate(widget.index == 0 ? 3 : 10, (i) => 'newItem：$i');
      });
    });
  }

  Future _loadMore() async {
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _list.addAll(List.generate(10, (i) => 'newItem：$i'));
        _page ++;
      });
    });
  }

  int _page = 1;
  int _maxPage;
  StateType _stateType = StateType.loading;
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DeerListView(
      itemCount: _list.length,
      stateType: _stateType,
      onRefresh: _onRefresh,
      loadMore: _loadMore,
      hasMore: _page < _maxPage,
      itemBuilder: (_, index){
        return GoodsItem(
          index: index,
          selectIndex: _selectIndex,
          img: _imgList[index % 6],
          animation: _animation,
          onTapMenu: (){
            // 开始执行动画
            _controller.forward(from: 0.0);
            setState(() {
              _selectIndex = index;
            });
          },
          onTapMenuClose: (){
            _controller.reverse(from: 1.1);
            _selectIndex = -1;
          },
          onTapEdit: (){
            setState(() {
              _selectIndex = -1;
            });
            NavigatorUtils.push(context, '${GoodsRouter.goodsEditPage}?isAdd=false');
          },
          onTapOperation: (){
            Toast.show("下架");
          },
          onTapDelete: (){
            _controller.reverse(from: 1.1);
            _selectIndex = -1;
            _showDeleteBottomSheet(index);
          },
        );
      }
    );
  }

  @override
  bool get wantKeepAlive => true;

  _showDeleteBottomSheet(int index){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return GoodsDeleteBottomSheet(
          onTapDelete: (){
            setState(() {
              _list.removeAt(index);
              if (_list.isEmpty){
                _stateType = StateType.goods;
              }
            });
          },
        );
      },
    );
  }
}
