import 'package:al_murafiq/app/app_bloc.dart';
import 'package:al_murafiq/app/app_localizations.dart';
import 'package:flutter/material.dart';

extension Localizations on BuildContext {
  AppLocalizations? appLocalizations() {
    return AppLocalizations.of(this);
  }

  String translate(String key) {
    return appLocalizations()!.translate(key);
  }

  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  Color get primaryColor => Theme.of(this).primaryColor;

  Color get accentColor => Theme.of(this).accentColor;
}
