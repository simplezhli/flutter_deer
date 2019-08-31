
import 'package:flutter/material.dart';
import 'package:flutter_deer/order/page/order_page.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/statistics/statistics_router.dart';
import 'package:flutter_deer/util/image_utils.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:flutter_deer/widgets/my_card.dart';
import 'package:flutter_deer/widgets/my_flexible_space_bar.dart';

class StatisticsPage extends StatefulWidget {
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: _sliverBuilder(),
      ),
    );
  }

  List<Widget> _sliverBuilder() {
    return <Widget>[
      SliverAppBar(
        leading: Gaps.empty,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        expandedHeight: 100.0,
        pinned: true,
        flexibleSpace: MyFlexibleSpaceBar(
          background: const LoadAssetImage("statistic/statistic_bg",
            width: double.infinity,
            height: 115.0,
            fit: BoxFit.fill,
          ),
          centerTitle: true,
          titlePadding: const EdgeInsetsDirectional.only(start: 16.0, bottom: 14.0),
          collapseMode: CollapseMode.pin,
          title: const Text('统计'),
        ),
      ),
      SliverPersistentHeader(
        pinned: true,
        delegate: SliverAppBarDelegate(
            DecoratedBox(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(ImageUtils.getImgPath("statistic/statistic_bg1")),
                      fit: BoxFit.fill
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: <Widget>[
                    MyCard(
                      child: Container(
                        alignment: Alignment.center,
                        height: 120.0,
                        child: Row(
                          children: <Widget>[
                            const _StatisticsTab("新订单(单)", "xdd", "80"),
                            const _StatisticsTab("待配送(单)", "dps", "80"),
                            const _StatisticsTab("今日交易额(元)", "jrjye", "8000.00"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            , 120.0
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Gaps.vGap16,
              Gaps.vGap16,
              const Text("数据走势", style: TextStyles.textBoldDark18),
              Gaps.vGap16,
              const _StatisticsItem("订单统计", "sjzs", 1),
              Gaps.vGap8,
              const _StatisticsItem("交易额统计", "jyetj", 2),
              Gaps.vGap8,
              const _StatisticsItem("商品统计", "sptj", 3),
            ],
          ),
        ),
      )
    ];
  }
  
}

class _StatisticsItem extends StatelessWidget {

  const _StatisticsItem(this.title, this.img, this.index);

  final String title;
  final String img;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.14,
      child: MyCard(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            child: InkWell(
              onTap: (){
                if (index == 1 || index == 2){
                  NavigatorUtils.push(context, '${StatisticsRouter.orderStatisticsPage}?index=$index');
                }else{
                  NavigatorUtils.push(context, StatisticsRouter.goodsStatisticsPage);
                }
              },
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(title, style: TextStyles.textBoldDark14),
                        const LoadAssetImage("statistic/icon_selected", height: 16.0, width: 16.0)
                      ],
                    ),
                  ),
                  Expanded(child: LoadAssetImage("statistic/$img", fit: BoxFit.fill))
                ],
              ),
            ),
          )
      ),
    );
  }
}

class _StatisticsTab extends StatelessWidget {

  const _StatisticsTab(this.title, this.img, this.content);

  final String title;
  final String img;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          LoadAssetImage("statistic/$img", width: 40.0, height: 40.0),
          Gaps.vGap4,
          Text(title, style: TextStyles.textGray12),
          Gaps.vGap8,
          Text(content, style: const TextStyle(fontSize: Dimens.font_sp18, color: Colours.text_dark)),
        ],
      ),
    );
  }
}