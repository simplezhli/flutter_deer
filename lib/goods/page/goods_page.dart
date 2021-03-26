
import 'package:flutter/material.dart';
import 'package:flutter_deer/goods/page/goods_list_page.dart';
import 'package:flutter_deer/goods/provider/goods_page_provider.dart';
import 'package:flutter_deer/goods/widgets/goods_sort_menu.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/toast_utils.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:flutter_deer/widgets/popup_window.dart';
import 'package:provider/provider.dart';

import '../goods_router.dart';


/// design/4商品/index.html
class GoodsPage extends StatefulWidget {

  const GoodsPage({Key key}) : super(key: key);

  @override
  _GoodsPageState createState() => _GoodsPageState();
}

class _GoodsPageState extends State<GoodsPage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {

  final List<String> _sortList = ['全部商品', '个人护理', '饮料', '沐浴洗护', '厨房用具', '休闲食品', '生鲜水果', '酒水', '家庭清洁'];
  TabController _tabController;
  final PageController _pageController = PageController(initialPage: 0);

  final GlobalKey _addKey = GlobalKey();
  final GlobalKey _bodyKey = GlobalKey();
  final GlobalKey _buttonKey = GlobalKey();

  GoodsPageProvider provider = GoodsPageProvider();
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Color _iconColor = ThemeUtils.getIconColor(context);
    return ChangeNotifierProvider<GoodsPageProvider>(
      create: (_) => provider,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              tooltip: '搜索商品',
              onPressed: () => NavigatorUtils.push(context, GoodsRouter.goodsSearchPage),
              icon: LoadAssetImage(
                'goods/search',
                key: const Key('search'),
                width: 24.0,
                height: 24.0,
                color: _iconColor,
              ),
            ),
            IconButton(
              tooltip: '添加商品',
              key: _addKey,
              onPressed: _showAddMenu,
              icon: LoadAssetImage(
                'goods/add',
                key: const Key('add'),
                width: 24.0,
                height: 24.0,
                color: _iconColor,
              ),
            )
          ],
        ),
        body: Column(
          key: _bodyKey,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Semantics(
              container: true,
              label: '选择商品类型',
              child: GestureDetector(
                key: _buttonKey,
                /// 使用Selector避免同provider数据变化导致此处不必要的刷新
                child: Selector<GoodsPageProvider, int>(
                  selector: (_, provider) => provider.sortIndex,
                  /// 精准判断刷新条件（provider 4.0新属性）
//                  shouldRebuild: (previous, next) => previous != next,
                  builder: (_, sortIndex, __) {
                    // 只会触发sortIndex变化的刷新
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Gaps.hGap16,
                        Text(
                          _sortList[sortIndex],
                          style: TextStyles.textBold24,
                        ),
                        Gaps.hGap8,
                        LoadAssetImage('goods/expand', width: 16.0, height: 16.0, color: _iconColor,)
                      ],
                    );
                  },
                ),
                onTap: () => _showSortMenu(),
              ),
            ),
            Gaps.vGap24,
            Container(
              // 隐藏点击效果
              padding: const EdgeInsets.only(left: 16.0),
              color: context.backgroundColor,
              child: TabBar(
                onTap: (index) {
                  if (!mounted) {
                    return;
                  }
                  _pageController.jumpToPage(index);
                },
                isScrollable: true,
                controller: _tabController,
                labelStyle: TextStyles.textBold18,
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding: const EdgeInsets.only(left: 0.0),
                unselectedLabelColor: context.isDark ? Colours.text_gray : Colours.text,
                labelColor: Theme.of(context).primaryColor,
                indicatorPadding: const EdgeInsets.only(right: 98.0 - 36.0),
                tabs: const <Widget>[
                  _TabView('在售', 0),
                  _TabView('待售', 1),
                  _TabView('下架', 2),
                ],
              ),
            ),
            Gaps.line,
            Expanded(
              child: PageView.builder(
                key: const Key('pageView'),
                itemCount: 3,
                onPageChanged: _onPageChange,
                controller: _pageController,
                itemBuilder: (_, int index) => GoodsListPage(index: index)
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onPageChange(int index) {
    _tabController.animateTo(index);
    provider.setIndex(index);
  }

  /// design/4商品/index.html#artboard3
  void _showSortMenu() {
    // 获取点击控件的坐标
    final RenderBox button = _buttonKey.currentContext.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    // 获得控件左下方的坐标
    final Offset a =  button.localToGlobal(Offset(0.0, button.size.height + 12.0), ancestor: overlay);
    // 获得控件右下方的坐标
    final Offset b =  button.localToGlobal(button.size.bottomLeft(const Offset(0, 12.0)), ancestor: overlay);
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(a, b),
      Offset.zero & overlay.size,
    );
    final RenderBox body = _bodyKey.currentContext.findRenderObject() as RenderBox;

    showPopupWindow<void>(
      context: context,
      fullWidth: true,
      position: position,
      elevation: 0.0,
      child: GoodsSortMenu(
        data: _sortList,
        height: body.size.height - button.size.height,
        sortIndex: provider.sortIndex,
        onSelected: (index, name) {
          provider.setSortIndex(index);
          Toast.show('选择分类: $name');
          NavigatorUtils.goBack(context);
        },
      ),
    );
  }

  /// design/4商品/index.html#artboard4
  void _showAddMenu() {
    final RenderBox button = _addKey.currentContext.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final a =  button.localToGlobal(Offset(button.size.width - 8.0, button.size.height - 12.0), ancestor: overlay);
    final b =  button.localToGlobal(button.size.bottomLeft(const Offset(0, - 12.0)), ancestor: overlay);
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(a, b),
      Offset.zero & overlay.size,
    );
    final Color backgroundColor = context.backgroundColor;
    final Color _iconColor = ThemeUtils.getIconColor(context);
    showPopupWindow<void>(
      context: context,
      fullWidth: false,
      isShowBg: true,
      position: position,
      elevation: 0.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: LoadAssetImage('goods/jt', width: 8.0, height: 4.0,
              color: ThemeUtils.getDarkColor(context, Colours.dark_bg_color),
            ),
          ),
          SizedBox(
            width: 120.0,
            height: 40.0,
            child: TextButton.icon(
              onPressed: () {
                NavigatorUtils.push(context, '${GoodsRouter.goodsEditPage}?isAdd=true&isScan=true', replace: true);
              },
              icon: LoadAssetImage('goods/scanning', width: 16.0, height: 16.0, color: _iconColor,),
              label: const Text('扫码添加'),
              style: TextButton.styleFrom(
                primary: Theme.of(context).textTheme.bodyText2.color,
                onSurface: Theme.of(context).textTheme.bodyText2.color.withOpacity(0.12),
                backgroundColor: backgroundColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
                ),
              ),
            ),
          ),
          Container(width: 120.0, height: 0.6, color: Colours.line),
          SizedBox(
            width: 120.0,
            height: 40.0,
            child: TextButton.icon(
              onPressed: () {
                NavigatorUtils.push(context, '${GoodsRouter.goodsEditPage}?isAdd=true', replace: true);
              },
              icon: LoadAssetImage('goods/add2', width: 16.0, height: 16.0, color: _iconColor,),
              label: const Text('添加商品'),
              style: TextButton.styleFrom(
                primary: Theme.of(context).textTheme.bodyText2.color,
                onSurface: Theme.of(context).textTheme.bodyText2.color.withOpacity(0.12),
                backgroundColor: backgroundColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8.0), bottomRight: Radius.circular(8.0)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _TabView extends StatelessWidget {
  
  const _TabView(this.tabName, this.index);
  
  final String tabName;
  final int index;
  
  @override
  Widget build(BuildContext context) {
    return Tab(
      child: SizedBox(
        width: 98.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(tabName),
            Consumer<GoodsPageProvider>(
              builder: (_, provider, child) {
                return Visibility(
                  visible: !(provider.goodsCountList[index] == 0 || provider.index != index),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 1.0),
                    child: Text(' (${provider.goodsCountList[index]}件)',
                      style: const TextStyle(fontSize: Dimens.font_sp12),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
