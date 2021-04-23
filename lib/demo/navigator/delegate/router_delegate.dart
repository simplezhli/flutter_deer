import 'package:flutter/material.dart';
import 'package:flutter_deer/demo/navigator/screen/app_shell.dart';
import 'package:flutter_deer/demo/navigator/book_entity.dart';
import 'package:flutter_deer/demo/navigator/books_app_state.dart';

class BookRouterDelegate extends RouterDelegate<BookRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BookRoutePath> {

  BookRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    appState.addListener(notifyListeners);
  }

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  BooksAppState appState = BooksAppState();

  @override
  BookRoutePath get currentConfiguration {
    if (appState.selectedIndex == 1) {
      return BooksSettingsPath();
    } else {
      if (appState.selectedBook == null) {
        return BooksListPath();
      } else {
        return BooksDetailsPath(appState.getSelectedBookById());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage<dynamic>(
          child: AppShell(appState: appState),
        ),
      ],
      onPopPage: (route, dynamic result) {
        if (!route.didPop(result)) {
          return false;
        }

        if (appState.selectedBook != null) {
          appState.selectedBook = null;
        }
        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(BookRoutePath configuration) async {
    if (configuration is BooksListPath) {
      appState.selectedIndex = 0;
      appState.selectedBook = null;
    } else if (configuration is BooksSettingsPath) {
      appState.selectedIndex = 1;
    } else if (configuration is BooksDetailsPath) {
      appState.setSelectedBookById(configuration.id);
    }
  }
}