import 'package:flutter/material.dart';
import 'package:flutter_deer/demo/navigator/route_information_parser.dart';
import 'package:flutter_deer/demo/navigator/router_delegate.dart';

/// https://gist.github.com/johnpryan/5ce79aee5b5f83cfababa97c9cf0a204
class BooksApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BooksAppState();
}

class _BooksAppState extends State<BooksApp> {
  final BookRouterDelegate _routerDelegate = BookRouterDelegate();
  final BookRouteInformationParser _routeInformationParser = BookRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Books App',
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
    );
  }
}
