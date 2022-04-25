import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/widgets/show_message_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:rxdart/rxdart.dart';
import 'package:al_murafiq/models/countries.dart';

class ChangeLanguageBloc {
  Dio _dio = GetIt.instance.get<Dio>();
  SharedPreferenceHelper helper = GetIt.instance.get<SharedPreferenceHelper>();
  final allCountriesSubject = BehaviorSubject<List<CountriesData>>();
  final allLanguageSubject = BehaviorSubject<List<Languages>>();
  final allCitiesSubject = BehaviorSubject<List<CitiesData>>();
  final allDefultLanguageSubject = BehaviorSubject<String>();

  final selectedCountry = BehaviorSubject<CountriesData>();
  final selectedLanguage = BehaviorSubject<Languages>();
  final selectedCities = BehaviorSubject<CitiesData>();
  RoundedLoadingButtonController loadingButtonController =
      RoundedLoadingButtonController();
  Future<void> fetchAllCountries(BuildContext context) async {
    try {
      String langCode = await helper.getCodeLang();
      int? idCountry = await helper.getCountryId();

      final List<CountriesData> countries = [];
      final List<Languages> languages = [];
      final res = await _dio.get(
        '/countries/all',
        options: Options(
          headers: {'lang': '$langCode'},
        ),
      );
      if (res.statusCode == 200 && res.data['status'] == 200) {
        for (var obj in res.data['data']['countries']) {
          // countries.add(CountriesData.fromJson(obj));
          CountriesData country = CountriesData.fromJson(obj);
          if (country.id == idCountry) {
            selectedCountry.sink.add(country);
          }
          countries.add(country);
        }
        for (var obj in res.data['data']['language']) {
          // languages.add(Languages.fromJson(obj));
          Languages language = Languages.fromJson(obj);
          if (language.code == langCode) {
            selectedLanguage.sink.add(language);
          }
          languages.add(language);
        }

        allCountriesSubject.sink.add(countries);
        allLanguageSubject.sink.add(languages);
        allDefultLanguageSubject.sink.add(res.data['data']['default_lang']);
      } else if (res.data['status'] == 400) {
        allCountriesSubject.sink.addError('');

        await showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return ShowMessageDialog(
              type: 400,
              message: '${res.data['message']}',
              show_but: true,
            );
          },
        );
      } else {
        await showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return ShowMessageDialog(
              type: 400,
              message: '${res.data['message']}',
              show_but: true,
            );
          },
        );
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      allCountriesSubject.sink.addError('');

      await showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return ShowMessageDialog(
            type: 400,
            message: 'e'.tr,
            show_but: true,
          );
        },
      );
    }
  }

  dispose() async {
    await allCountriesSubject.stream.drain();
    allCountriesSubject.close();
  }
}
