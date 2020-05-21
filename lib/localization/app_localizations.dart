// Once you've added a Intl.message get run the commands below to update the generated arb and dart files
// flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/localization/l10n lib/localization/app_localizations.dart
// flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/localization/l10n --no-use-deferred-loading lib/localization/app_localizations.dart lib/localization/l10n/intl_*.arb
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'l10n/messages_all.dart';

class AppLocalizations {
  AppLocalizations(this.localeName);

  static Future<AppLocalizations> load(Locale locale) {
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      return AppLocalizations(localeName);
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  final String localeName;

  String get title {
    return Intl.message(
      'Flutter Deer',
      name: 'title',
      desc: 'Title for the application',
      locale: localeName,
    );
  }

  String get verificationCodeLogin {
    return Intl.message(
      'Verification Code Login',
      name: 'verificationCodeLogin',
      desc: 'Title for the Login page',
      locale: localeName
    );
  }

  String get passwordLogin {
    return Intl.message(
      'Password Login',
      name: 'passwordLogin',
      desc: 'Password Login',
      locale: localeName
    );
  }

  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: 'Login',
      locale: localeName,
    );
  }
  
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
