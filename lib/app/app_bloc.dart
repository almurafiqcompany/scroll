import 'dart:async';
import 'dart:ui';

import 'package:al_murafiq/base_bloc.dart';
import 'package:al_murafiq/theme.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

enum LANGUAGES { AR, EN }

const Map<String, String>? languagesToLocale = <String, String>{
  'Arabic': 'ar',
  'English': 'EN',
};
const Map<String, String>? localeToLanguages = <String, String>{
  'ar': 'Arabic',
  'EN': 'English',
};

class AppBloc implements BaseBloc {
  static final AppState initialState = AppState(
      // TODO(Abdelrahman): remember user language.
      // const Locale('ar'),
      const Locale('EN'),
      themeDataLight,
      userLogged: false);
  final BehaviorSubject<AppState> _appController =
      BehaviorSubject<AppState>.seeded(initialState);

  Stream<AppState> get stream => _appController.stream;

  String? get language =>
      localeToLanguages![_appController.value.locale.languageCode];

  bool get userStatues => _appController.value.userLogged;

  void setLanguage(String? language) {
    _appController.add(_appController.value.copyWith(
      locale: Locale(languagesToLocale![language]!),
    ));
  }

  void toggleLanguage() {
    _appController.add(
      AppState(
        _appController.value.locale == const Locale('EN')
            ? const Locale('ar')
            : const Locale('EN'),
        _appController.value.themeData,
      ),
    );
  }

  void setThemeData(ThemeData themeData) => _appController.add(
        AppState(
          _appController.value.locale,
          themeData,
        ),
      );

  bool isDarkMood() => _appController.value.themeData == themeDataDark;

  String get themeName => _appController.value.themeData == themeDataLight
      ? 'Dark Mode 🌑'
      : 'Light Mode ☀️';

  void toggleTheme() {
    _appController.add(
      AppState(
          _appController.value.locale,
          (_appController.value.themeData == themeDataLight)
              ? themeDataDark
              : themeDataLight),
    );
  }

  @override
  void dispose() {
    _appController.drain();
    _appController.close();
  }
}

class AppState {
  AppState(this.locale, this.themeData, {this.userLogged = false});

  AppState copyWith({Locale? locale, ThemeData? themeData, bool? userLogged}) =>
      AppState(locale ?? this.locale, themeData ?? this.themeData,
          userLogged: userLogged ?? this.userLogged);
  final Locale locale;

  final ThemeData themeData;
  final bool userLogged;
}
