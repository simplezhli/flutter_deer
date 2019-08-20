
import 'package:flutter/material.dart';
import 'package:flutter_deer/order/order_page.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/statistics/statistics_router.dart';
import 'package:flutter_deer/util/image_utils.dart';
import 'package:flutter_deer/util/utils.dart';
import 'package:flutter_deer/widgets/my_card.dart';
import 'package:flutter_deer/widgets/my_flexible_space_bar.dart';

class Statistics extends StatefulWidget {
  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
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
        leading: Container(),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        expandedHeight: 100.0,
        pinned: true,
        flexibleSpace: MyFlexibleSpaceBar(
          background: loadAssetImage("statistic/statistic_bg",
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
                      image: AssetImage(Utils.getImgPath("statistic/statistic_bg1")),
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
                            _buildStatisticsTab("新订单(单)", "xdd", "80"),
                            _buildStatisticsTab("待配送(单)", "dps", "80"),
                            _buildStatisticsTab("今日交易额(元)", "jrjye", "8000.00"),
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
              Text("数据走势", style: TextStyles.textBoldDark18),
              Gaps.vGap16,
              _buildStatisticsItem("订单统计", "sjzs", 1),
              Gaps.vGap8,
              _buildStatisticsItem("交易额统计", "jyetj", 2),
              Gaps.vGap8,
              _buildStatisticsItem("商品统计", "sptj", 3),
            ],
          ),
        ),
      )
    ];
  }
  
  _buildStatisticsTab(String title, String img, String content){
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          loadAssetImage("statistic/$img", width: 40.0, height: 40.0),
          Gaps.vGap4,
          Text(title, style: TextStyles.textGray12),
          Gaps.vGap8,
          Text(content, style: TextStyle(fontSize: Dimens.font_sp18, color: Colours.text_dark)),
        ],
      ),
    );
  }
  
  _buildStatisticsItem(String title, String img, int index){
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
                      loadAssetImage("statistic/icon_selected", height: 16.0, width: 16.0)
                    ],
                  ),
                ),
                Expanded(child: loadAssetImage("statistic/$img", fit: BoxFit.fill))
              ],
            ),
          ),
        )
      ),
    );
  }
}
