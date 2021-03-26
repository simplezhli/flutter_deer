import 'package:flutter/material.dart';
import 'package:flutter_deer/demo/navigator/book_entity.dart';
import 'package:flutter_deer/demo/navigator/books_app_state.dart';
import 'package:flutter_deer/demo/navigator/screen/book_details_screen.dart';
import 'package:flutter_deer/demo/navigator/screen/books_list_screen.dart';
import 'package:flutter_deer/demo/navigator/screen/setting_screen.dart';

class InnerRouterDelegate extends RouterDelegate<BookRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BookRoutePath> {

  InnerRouterDelegate(this._appState);

  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  BooksAppState get appState => _appState;
  BooksAppState _appState;
  set appState(BooksAppState value) {
    if (value == _appState) {
      return;
    }
    _appState = value;
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        if (appState.selectedIndex == 0) ...[
          FadeAnimationPage(
            child: BooksListScreen(
              books: appState.books,
              onTapped: _handleBookTapped,
            ),
            key: const ValueKey('BooksListPage'),
          ),
          if (appState.selectedBook != null)
            MaterialPage<dynamic>(
              key: ValueKey(appState.selectedBook),
              child: BookDetailsScreen(book: appState.selectedBook),
            ),
        ] else
          const FadeAnimationPage(
            child: SettingsScreen(),
            key: ValueKey('SettingsPage'),
          ),
      ],
      onPopPage: (route, dynamic result) {
        appState.selectedBook = null;
        notifyListeners();
        return route.didPop(result);
      },
    );
  }

  @override
  Future<void> setNewRoutePath(BookRoutePath configuration) async {
    // This is not required for inner router delegate because it does not
    // parse route
    assert(false);
  }

  void _handleBookTapped(Book book) {
    appState.selectedBook = book;
    notifyListeners();
  }
}

class FadeAnimationPage extends Page<void> {

  const FadeAnimationPage({LocalKey key, this.child}) : super(key: key);

  final Widget child;

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder<dynamic>(
      settings: this,
      pageBuilder: (context, animation, animation2) {
        final curveTween = CurveTween(curve: Curves.easeIn);
        return FadeTransition(
          opacity: animation.drive(curveTween),
          child: child,
        );
      },
    );
  }
}
