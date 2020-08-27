import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer/common/common.dart';
import 'package:flutter_deer/net/dio_utils.dart';
import 'package:flutter_deer/net/intercept.dart';
import 'package:flutter_deer/provider/theme_provider.dart';
import 'package:flutter_deer/routers/not_found_page.dart';
import 'package:flutter_deer/routers/routers.dart';
import 'package:flutter_deer/util/device_utils.dart';
import 'package:flutter_deer/util/log_utils.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter_deer/home/splash_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_deer/localization/app_localizations.dart';
import 'package:sp_util/sp_util.dart';

Future<void> main() async {
//  debugProfileBuildsEnabled = true;
//  debugPaintLayerBordersEnabled = true;
//  debugProfilePaintsEnabled = true;
//  debugRepaintRainbowEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  /// sp初始化
  await SpUtil.getInstance();
  runApp(MyApp());
  // 透明状态栏
  if (Device.isAndroid) {
    final SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  
  final Widget home;
  final ThemeData theme;
  
  MyApp({this.home, this.theme}) {
    Log.init();
    initDio();
    Routes.initRoutes();
  }
  
  void initDio() {
    final List<Interceptor> interceptors = [];
    /// 统一添加身份验证请求头
    interceptors.add(AuthInterceptor());
    /// 刷新Token
    interceptors.add(TokenInterceptor());
    /// 打印Log(生产模式去除)
    if (!Constant.inProduction) {
      interceptors.add(LoggingInterceptor());
    }
    /// 适配数据(根据自己的数据结构，可自行选择添加)
    interceptors.add(AdapterInterceptor());
    setInitDio(
      baseUrl: 'https://api.github.com/',
      interceptors: interceptors,
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: ChangeNotifierProvider<ThemeProvider>(
        create: (_) => ThemeProvider(),
        child: Consumer<ThemeProvider>(
          builder: (_, provider, __) {
            return MaterialApp(
              title: 'Flutter Deer',
//              showPerformanceOverlay: true, //显示性能标签
//              debugShowCheckedModeBanner: false, // 去除右上角debug的标签
//              checkerboardRasterCacheImages: true,
//              showSemanticsDebugger: true, // 显示语义视图
//              checkerboardOffscreenLayers: true, // 检查离屏渲染
              theme: theme ?? provider.getTheme(),
              darkTheme: provider.getTheme(isDarkMode: true),
              themeMode: provider.getThemeMode(),
              home: home ?? SplashPage(),
              onGenerateRoute: Routes.router.generator,
              localizationsDelegates: const [
                AppLocalizationsDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const <Locale>[
                Locale('zh', 'CN'),
                Locale('en', 'US')
              ],
              builder: (context, child) {
                /// 保证文字大小不受手机系统设置影响 https://www.kikt.top/posts/flutter/layout/dynamic-text/
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: child,
                );
              },
              /// 因为使用了fluro，这里设置主要针对Web
              onUnknownRoute: (_) {
                return MaterialPageRoute(
                  builder: (BuildContext context) => NotFoundPage(),
                );
              },
            );
          },
        ),
      ),
      /// Toast 配置
      backgroundColor: Colors.black54,
      textPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      radius: 20.0,
      position: ToastPosition.bottom
    );
  }
}
