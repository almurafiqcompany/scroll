import 'dart:async';
import 'dart:convert';

import 'package:al_murafiq/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale? locale;
  static AppLocalizations? of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations);

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  Map<String, String>? _localizedStrings;

  Future<bool> load() async {
    final String? jsonString = await rootBundle.loadString(
        'assets/languages/${locale!.languageCode.toLowerCase()}.json');
    final Map<String, dynamic> jsonMap =
        json.decode(jsonString!) as Map<String, dynamic>;
    _localizedStrings = jsonMap.map((String key, dynamic value) =>
        MapEntry<String, String>(key, value.toString()));

    return true;
  }

  String translate(String key) => _localizedStrings![key]!;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      Constants.SUPPORTED_LOCALE.contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    final AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
