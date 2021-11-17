import 'package:flutter/material.dart';
import 'package:flutter_deer/goods/goods_router.dart';
import 'package:flutter_deer/goods/page/goods_list_page.dart';
import 'package:flutter_deer/goods/provider/goods_page_provider.dart';
import 'package:flutter_deer/goods/widgets/goods_add_menu.dart';
import 'package:flutter_deer/goods/widgets/goods_sort_menu.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/toast_utils.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:flutter_deer/widgets/popup_window.dart';
import 'package:provider/provider.dart';


/// design/4商品/index.html
class GoodsPage extends StatefulWidget {

  const GoodsPage({Key? key}) : super(key: key);

  @override
  _GoodsPageState createState() => _GoodsPageState();
}

class _GoodsPageState extends State<GoodsPage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {

  final List<String> _sortList = ['全部商品', '个人护理', '饮料', '沐浴洗护', '厨房用具', '休闲食品', '生鲜水果', '酒水', '家庭清洁'];
  TabController? _tabController;
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
    _tabController?.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Color? _iconColor = ThemeUtils.getIconColor(context);
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
                labelPadding: EdgeInsets.zero,
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
    _tabController?.animateTo(index);
    provider.setIndex(index);
  }

  /// design/4商品/index.html#artboard3
  void _showSortMenu() {
    // 获取点击控件的坐标
    final RenderBox button = _buttonKey.currentContext!.findRenderObject()! as RenderBox;
    final RenderBox body = _bodyKey.currentContext!.findRenderObject()! as RenderBox;

    showPopupWindow<void>(
      context: context,
      offset: const Offset(0.0, 12.0),
      anchor: button,
      child: GoodsSortMenu(
        data: _sortList,
        height: body.size.height - button.size.height,
        sortIndex: provider.sortIndex,
        onSelected: (index, name) {
          provider.setSortIndex(index);
          Toast.show('选择分类: $name');
        },
      ),
    );
  }

  /// design/4商品/index.html#artboard4
  void _showAddMenu() {
    final RenderBox button = _addKey.currentContext!.findRenderObject()! as RenderBox;

    showPopupWindow<void>(
      context: context,
      isShowBg: true,
      offset: Offset(button.size.width - 8.0, -12.0),
      anchor: button,
      child: const GoodsAddMenu(),
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
