
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/image_utils.dart';
import 'package:flutter_deer/util/toast.dart';
import 'package:flutter_deer/widgets/popup_window.dart';

import 'goods_list.dart';
import 'goods_router.dart';

class Goods extends StatefulWidget {
  @override
  _GoodsState createState() => _GoodsState();
}

class _GoodsState extends State<Goods> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin{

  List<String> _sortList = ["全部商品", "个人护理", "饮料", "沐浴洗护", "厨房用具", "休闲食品", "生鲜水果", "酒水", "家庭清洁"];
  TabController _tabController;
  PageController _pageController = PageController(initialPage: 0);
  var _isPageCanChanged = true;
  var _index = 0;
  var _sortIndex = 0;
  
  GlobalKey _addKey = GlobalKey();
  GlobalKey _bodyKey = GlobalKey();
  GlobalKey _buttonKey = GlobalKey();
  
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            onPressed: (){
              NavigatorUtils.push(context, GoodsRouter.goodsSearchPage);
            },
            icon: loadAssetImage(
              "goods/search",
              width: 24.0,
              height: 24.0,
            ),
          ),
          IconButton(
            key: _addKey,
            onPressed: (){
              _showAddMenu();
            },
            icon: loadAssetImage(
              "goods/add",
              width: 24.0,
              height: 24.0,
            ),
          )
        ],
      ),
      body: Column(
        key: _bodyKey,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            key: _buttonKey,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                  child: Text(
                    _sortList[_sortIndex],
                    style: TextStyles.textBoldDark24,
                  ),
                ),
                loadAssetImage("goods/expand", width: 16.0, height: 16.0)
              ],
            ),
            onTap: (){
              _showSortMenu();
            },
          ),
          Gaps.vGap16,
          Gaps.vGap8,
          Container(
            color: Colors.white,
            child: TabBar(
              onTap: (index){
                if (!mounted){
                  return;
                }
                _pageController.jumpToPage(index);
              },
              isScrollable: true,
              controller: _tabController,
              labelStyle: TextStyles.textBoldDark18,
              indicatorSize: TabBarIndicatorSize.label,
              labelPadding: const EdgeInsets.only(left: 16.0),
              unselectedLabelColor: Colours.text_dark,
              labelColor: Colours.app_main,
              indicatorPadding: const EdgeInsets.only(left: 12.0, right: 36.0),
              tabs: <Widget>[
                Tab(
                  child: Container(
                    width: 78.0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("在售"),
                        Offstage(offstage: _index != 0, child: Padding(
                          padding: const EdgeInsets.only(top: 1.0),
                          child: Text(" (3件)", style: TextStyle(fontSize: Dimens.font_sp12)),
                        )),
                      ],
                    ),
                  )
                ),
                Tab(
                    child: Container(
                      width: 78.0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("待售"),
                          Offstage(offstage: _index != 1, child: Padding(
                            padding: const EdgeInsets.only(top: 1.0),
                            child: Text(" (15件)", style: TextStyle(fontSize: Dimens.font_sp12)),
                          )),
                        ],
                      ),
                    )
                ),
                Tab(
                    child: Container(
                      width: 78.0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("下架"),
                          Offstage(offstage: _index != 2, child: Padding(
                            padding: const EdgeInsets.only(top: 1.0),
                            child: Text(" (26件)", style: TextStyle(fontSize: Dimens.font_sp12)),
                          )),
                        ],
                      ),
                    )
                ),
              ],
            ),
          ),
          Gaps.line,
          Expanded(
            child: PageView.builder(
              itemCount: 3,
              onPageChanged: (index) {
                if (_isPageCanChanged) {//由于pageview切换是会回调这个方法,又会触发切换tabbar的操作,所以定义一个flag,控制pageview的回调
                  _onPageChange(index);
                }
              },
              controller: _pageController,
              itemBuilder: (BuildContext context, int index) {
                return GoodsList(index: index);
              },
            ),
          )
        ],
      ),
    );
  }

  _onPageChange(int index, {PageController p, TabController t}) async {
    
    if (p != null) {//判断是哪一个切换
      _isPageCanChanged = false;
      await _pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.ease);//等待pageview切换完毕,再释放pageivew监听
      _isPageCanChanged = true;
    } else {
      _tabController.animateTo(index);//切换Tabbar
    }
    setState(() {
      _index = index;
    });
  }
  
  _showSortMenu(){
    // 获取点击控件的坐标
    final RenderBox button = _buttonKey.currentContext.findRenderObject();
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    // 获得控件左下方的坐标
    var a =  button.localToGlobal(Offset(0.0, button.size.height + 12.0), ancestor: overlay);
    // 获得控件右下方的坐标
    var b =  button.localToGlobal(button.size.bottomLeft(Offset(0, 12.0)), ancestor: overlay);
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(a, b),
      Offset.zero & overlay.size,
    );
    final RenderBox body = _bodyKey.currentContext.findRenderObject();
    showPopupWindow(
      context: context,
      fullWidth: true,
      position: position,
      elevation: 0.0,
      child: GestureDetector(
        onTap: (){
          NavigatorUtils.goBack(context);
        },
        child: Container(
          color: Color(0x99000000),
          height: body.size.height - button.size.height - 12.0,
          child: ListView.builder(
            physics: ClampingScrollPhysics(),
            itemCount: _sortList.length + 1,
            itemBuilder: (_, index){
              return index == _sortList.length ? Container(
                color: Colors.white,
                height: 12.0,
              ) : Material(
                color: Colors.white,
                child: InkWell(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          _sortList[index],
                          style: index == _sortIndex ? TextStyles.textMain14 : TextStyles.textDark14,
                        ),
                        Text(
                          "($index)",
                          style: index == _sortIndex ? TextStyles.textMain14 : TextStyles.textDark14,
                        ),
                      ],
                    ),
                  ),
                  onTap: (){
                    setState(() {
                      _sortIndex = index;
                    });
                    Toast.show("选择分类: ${_sortList[index]}");
                    NavigatorUtils.goBack(context);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  _showAddMenu(){
    final RenderBox button = _addKey.currentContext.findRenderObject();
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    var a =  button.localToGlobal(Offset(button.size.width - 8.0, button.size.height - 12.0), ancestor: overlay);
    var b =  button.localToGlobal(button.size.bottomLeft(Offset(0, - 12.0)), ancestor: overlay);
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(a, b),
      Offset.zero & overlay.size,
    );
    showPopupWindow(
      context: context,
      fullWidth: false,
      isShowBg: true,
      position: position,
      elevation: 0.0,
      child: GestureDetector(
        onTap: (){
          NavigatorUtils.goBack(context);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: loadAssetImage("goods/jt", width: 8.0, height: 4.0,),
            ),
            Container(
              width: 120.0,
              height: 40.0,
              child: FlatButton.icon(
                onPressed: (){
                  NavigatorUtils.push(context, '${GoodsRouter.goodsEditPage}?isAdd=true&isScan=true', replace: true);
                },
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
                ),  
                icon: loadAssetImage("goods/scanning", width: 16.0, height: 16.0,), 
                label: const Text("扫码添加", style: TextStyles.textDark14,)
              ),
            ),
            Container(width: 120.0, height: 0.6, color: Colours.line),
            Container(
              width: 120.0,
              height: 40.0,
              child: FlatButton.icon(
                color: Colors.white,
                onPressed: (){
                  NavigatorUtils.push(context, '${GoodsRouter.goodsEditPage}?isAdd=true', replace: true);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8.0), bottomRight: Radius.circular(8.0)),
                ),
                icon: loadAssetImage("goods/add2", width: 16.0, height: 16.0,),
                label: const Text("添加商品", style: TextStyles.textDark14)
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
