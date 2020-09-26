
import 'package:flutter/material.dart';
import 'package:flutter_deer/account/account_router.dart';
import 'package:flutter_deer/mvp/base_page.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/setting/setting_router.dart';
import 'package:flutter_deer/shop/models/user_entity.dart';
import 'package:flutter_deer/shop/iview/shop_iview.dart';
import 'package:flutter_deer/shop/presenter/shop_presenter.dart';
import 'package:flutter_deer/shop/provider/user_provider.dart';
import 'package:flutter_deer/shop/shop_router.dart';
import 'package:flutter_deer/util/image_utils.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:provider/provider.dart';

/// design/6店铺-账户/index.html#artboard0
class ShopPage extends StatefulWidget {

  const ShopPage({
    Key key,
    this.isAccessibilityTest = false,
  }) : super(key : key);

  final bool isAccessibilityTest;
  
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> with BasePageMixin<ShopPage, ShopPagePresenter>, AutomaticKeepAliveClientMixin<ShopPage> implements ShopIMvpView {
  
  final List<String> _menuTitle = ['账户流水', '资金管理', '提现账号'];
  final List<String> _menuImage = ['zhls', 'zjgl', 'txzh'];
  final List<String> _menuDarkImage = ['dark_zhls', 'dark_zjgl', 'dark_txzh'];

  UserProvider provider = UserProvider();
  
  @override
  void setUser(UserEntity user) {
    provider.setUser(user);
  }

  @override
  bool get isAccessibilityTest => widget.isAccessibilityTest;
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Color _iconColor = ThemeUtils.getIconColor(context);
    final Widget line = Container(
      height: 0.6, 
      width: double.infinity, 
      margin: const EdgeInsets.only(left: 16.0), 
      child: Gaps.line,
    );
    return ChangeNotifierProvider<UserProvider>(
      create: (_) => provider,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              tooltip: '消息',
              onPressed: () {
                NavigatorUtils.push(context, ShopRouter.messagePage);
              },
              icon: LoadAssetImage(
                'shop/message',
                key: const Key('message'),
                width: 24.0,
                height: 24.0,
                color: _iconColor,
              ),
            ),
            IconButton(
              tooltip: '设置',
              onPressed: () {
                NavigatorUtils.push(context, SettingRouter.settingPage);
              },
              icon: LoadAssetImage(
                'shop/setting',
                key: const Key('setting'),
                width: 24.0,
                height: 24.0,
                color: _iconColor,
              ),
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Gaps.vGap12,
            Consumer<UserProvider>(
              builder: (_, provider, child) {
                final Widget header = Stack(
                  children: <Widget>[
                    const SizedBox(width: double.infinity, height: 56.0),
                    const Text(
                      '官方直营店',
                      style: TextStyles.textBold24,
                    ),
                    Positioned(
                      right: 0.0,
                      child: CircleAvatar(
                        radius: 28.0,
                        backgroundColor: Colors.transparent,
                        backgroundImage: ImageUtils.getImageProvider(provider.user?.avatarUrl, holderImg: 'shop/tx'),
                      ),
                    ),
                    child,
                  ],
                );
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: MergeSemantics(
                    child: header,
                  ),
                );
              },
              child: Positioned(
                top: 38.0,
                left: 0.0,
                child: Row(
                  children: const <Widget>[
                    LoadAssetImage('shop/zybq', width: 40.0, height: 16.0,),
                    Gaps.hGap8,
                    Text('店铺账号:15000000000', style: TextStyles.textSize12)
                  ],
                ),
              ),
            ),
            Gaps.vGap24,
            line,
            Gaps.vGap24,
            const MergeSemantics(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  '账户',
                  style: TextStyles.textBold18,
                ),
              ),
            ),
            _ShopFunctionModule(
              data: _menuTitle,
              image: _menuImage,
              darkImage: _menuDarkImage,
              onItemClick: (index) {
                if (index == 0) {
                  NavigatorUtils.push(context, AccountRouter.accountRecordListPage);
                } else if (index == 1) {
                  NavigatorUtils.push(context, AccountRouter.accountPage);
                } else if (index == 2) {
                  NavigatorUtils.push(context, AccountRouter.withdrawalAccountPage);
                }
              },
            ),
            line,
            Gaps.vGap24,
            const MergeSemantics(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  '店铺',
                  style: TextStyles.textBold18,
                ),
              ),
            ),
            /// 使用Flexible防止溢出
            Flexible(
              child: _ShopFunctionModule(
                data: const ['店铺设置'],
                image: const ['dpsz'],
                darkImage: const ['dark_dpsz'],
                onItemClick: (index) {
                  NavigatorUtils.push(context, ShopRouter.shopSettingPage);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  ShopPagePresenter createPresenter() => ShopPagePresenter();
 
}

class _ShopFunctionModule extends StatelessWidget {

  const _ShopFunctionModule({
    Key key,
    this.onItemClick,
    @required this.data,
    @required this.image,
    @required this.darkImage,
  }): super(key: key);
  
  final Function(int index) onItemClick;
  final List<String> data;
  final List<String> image;
  final List<String> darkImage;
  
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 12.0),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1.18,
      ),
      itemCount: data.length,
      itemBuilder: (_, index) {
        return InkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              LoadAssetImage(context.isDark ? 'shop/${darkImage[index]}' : 'shop/${image[index]}', width: 32.0),
              Gaps.vGap4,
              Text(
                data[index],
                style: TextStyles.textSize12,
              )
            ],
          ),
          onTap: () {
            onItemClick(index);
          },
        );
      },
    );
  }
}

