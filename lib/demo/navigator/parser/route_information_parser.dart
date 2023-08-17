import 'package:flutter/material.dart';

import '../book_entity.dart';

class BookRouteInformationParser extends RouteInformationParser<BookRoutePath> {
  @override
  Future<BookRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = routeInformation.uri;

    if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == 'settings') {
      return BooksSettingsPath();
    } else {
      if (uri.pathSegments.length >= 2) {
        if (uri.pathSegments[0] == 'book') {
          return BooksDetailsPath(int.tryParse(uri.pathSegments[1])!);
        }
      }
      return BooksListPath();
    }
  }

  @override
  RouteInformation? restoreRouteInformation(BookRoutePath configuration) {
    if (configuration is BooksListPath) {
      return RouteInformation(uri: Uri.parse('/home'));
    }
    if (configuration is BooksSettingsPath) {
      return RouteInformation(uri: Uri.parse('/settings'));
    }
    if (configuration is BooksDetailsPath) {
      return RouteInformation(uri: Uri.parse('/book/${configuration.id}'));
    }
    return null;
  }
}
