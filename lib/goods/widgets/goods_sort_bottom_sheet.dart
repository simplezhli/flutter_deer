
import 'package:flutter/material.dart';
import 'package:flutter_deer/goods/provider/goods_sort_provider.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/screen_utils.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:provider/provider.dart';


/// design/4商品/index.html#artboard20
class GoodsSortBottomSheet extends StatefulWidget {

  const GoodsSortBottomSheet({
    Key key,
    @required this.provider,
    @required this.onSelected,
  }): super(key: key);

  final Function(String, String) onSelected;
  /// 临时状态
  final GoodsSortProvider provider;
  
  @override
  GoodsSortBottomSheetState createState() => GoodsSortBottomSheetState();
}

class GoodsSortBottomSheetState extends State<GoodsSortBottomSheet> with SingleTickerProviderStateMixin {
  
  TabController _tabController;
  final ScrollController _controller = ScrollController();
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.provider.initData();
      _tabController.animateTo(widget.provider.index, duration: const Duration(microseconds: 0));
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        height: context.height * 11.0 / 16.0,
        /// 为保留状态，选择ChangeNotifierProvider.value，销毁自己手动处理（见 goods_edit_page.dart ：dispose()）
        child: ChangeNotifierProvider<GoodsSortProvider>.value(
          value: widget.provider,
          child: Consumer<GoodsSortProvider>(
            builder: (_, provider, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  child,
                  Gaps.line,
                  Container(
                    // 隐藏点击效果
                    color: context.dialogBackgroundColor,
                    child: TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      onTap: (index) {
                        if (provider.myTabs[index].text.isEmpty) {
                          // 拦截点击事件
                          _tabController.animateTo(provider.index);
                          return;
                        }
                        provider.setList(index);
                        provider.setIndex(index);
                        _controller.animateTo(
                          provider.positions[provider.index] * 48.0,
                          duration: const Duration(milliseconds: 10),
                          curve: Curves.ease,
                        );
                      },
                      indicatorSize: TabBarIndicatorSize.label,
                      unselectedLabelColor: context.isDark ? Colours.text_gray : Colours.text,
                      labelColor: Theme.of(context).primaryColor,
                      tabs: provider.myTabs,
                    ),
                  ),
                  Gaps.line,
                  Expanded(
                    child: ListView.builder(
                      controller: _controller,
                      itemExtent: 48.0,
                      itemBuilder: (_, index) {
                        return _buildItem(provider, index);
                      },
                      itemCount: provider.mList.length,
                    ),
                  )
                ],
              );
            },
            child: Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: const Text(
                    '商品分类',
                    style: TextStyles.textBold16,
                  ),
                ),
                Positioned(
                  child: InkWell(
                    onTap: () => NavigatorUtils.goBack(context),
                    child: const SizedBox(
                      height: 16.0,
                      width: 16.0,
                      child: LoadAssetImage('goods/icon_dialog_close'),
                    ),
                  ),
                  right: 16.0,
                  top: 16.0,
                  bottom: 16.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(GoodsSortProvider provider, int index) {
    final bool flag = provider.mList[index]['name'] == provider.myTabs[provider.index].text;
    return InkWell(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.centerLeft,
        child: Row(
          children: <Widget>[
            Text(
              provider.mList[index]['name'] as String,
              style: flag ? TextStyle(
                fontSize: Dimens.font_sp14,
                color: Theme.of(context).primaryColor,
              ) : null,),
            Gaps.hGap8,
            Visibility(
              visible: flag,
              child: const LoadAssetImage('goods/xz', height: 16.0, width: 16.0),
            )
          ],
        ),
      ),
      onTap: () {
        provider.myTabs[provider.index] = Tab(text: provider.mList[index]['name'] as String);
        provider.positions[provider.index] = index;

        provider.indexIncrement();
        provider.setListAndChangeTab();
        if (provider.index > 2) {
          provider.setIndex(2);
          widget.onSelected(provider.mList[index]['id'] as String, provider.mList[index]['name'] as String);
          NavigatorUtils.goBack(context);
        }
        _controller.animateTo(0.0, duration: const Duration(milliseconds: 100), curve: Curves.ease);
        _tabController.animateTo(provider.index);
      },
    );
  }
}
