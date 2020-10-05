import 'package:flutter/material.dart';

import 'book_entity.dart';

class BookRouteInformationParser extends RouteInformationParser<BookRoutePath> {
  @override
  Future<BookRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);

    if (uri.pathSegments.length >= 2) {
      final remaining = uri.pathSegments[1];
      return BookRoutePath.details(int.tryParse(remaining));
    } else {
      return BookRoutePath.home();
    }
  }

  @override
  RouteInformation restoreRouteInformation(BookRoutePath configuration) {
    if (configuration.isHomePage) {
      return const RouteInformation(location: '/');
    }
    if (configuration.isDetailsPage) {
      return RouteInformation(location: '/book/${configuration.id}');
    }
    return null;
  }
}
