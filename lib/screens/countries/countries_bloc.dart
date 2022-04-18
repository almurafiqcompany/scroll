import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/widgets/show_message_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:rxdart/rxdart.dart';
import 'package:al_murafiq/models/countries.dart';

class CountriesBloc {
  Dio _dio = GetIt.instance.get<Dio>();

  final allCountriesSubject = BehaviorSubject<List<CountriesData>>();
  final allSortCountriesSubject = BehaviorSubject<List<CountriesData>>();
  final allLanguageSubject = BehaviorSubject<List<Languages>>();
  final allSortLanguageSubject = BehaviorSubject<List<Languages>>();
  final allCitiesSubject = BehaviorSubject<List<CitiesData>>();
  final allSortCitiesSubject = BehaviorSubject<List<CitiesData>>();
  final allDefultLanguageSubject = BehaviorSubject<String>();

  final selectedCountry = BehaviorSubject<CountriesData>();
  final selectedLanguage = BehaviorSubject<Languages>();
  final selectedCities = BehaviorSubject<CitiesData>();
  RoundedLoadingButtonController loadingButtonController =
      RoundedLoadingButtonController();
  SharedPreferenceHelper _helper = GetIt.instance.get<SharedPreferenceHelper>();
  Future<void> fetchAllCountries(BuildContext context) async {
    try {
      String lang = await _helper.getCodeLang();
      print('start reqest');
      print('lang $lang');
      final List<CountriesData> countries = [];
      final List<Languages> languages = [];
      final res = await _dio.get(
        '/countries/all',
        options: Options(
          headers: {'lang': '$lang'},
        ),
      );
      print(res.data);
      if (res.statusCode == 200 && res.data['status'] == 200) {
        for (var obj in res.data['data']['countries']) {
          countries.add(CountriesData.fromJson(obj));
        }
        for (var obj in res.data['data']['language']) {
          languages.add(Languages.fromJson(obj));
        }

        allCountriesSubject.sink.add(countries);
        allSortCountriesSubject.add(countries);
        allLanguageSubject.sink.add(languages);
        allSortLanguageSubject.sink.add(languages);
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

  sortCountry(String countryName) async {
    allSortCountriesSubject.add([]);
    List<CountriesData> li = [];
    allCountriesSubject.value.forEach((element) {
      if (element.name!.toLowerCase().contains(countryName.toLowerCase())) {
        li.add(element);
      }
    });
    print('ss ${li.toString()}');
    allSortCountriesSubject.add(li);
  }

  sortLanguage(String LanguageName) async {
    allSortLanguageSubject.add([]);
    List<Languages> li = [];
    allLanguageSubject.value.forEach((element) {
      if (element.name!.toLowerCase().contains(LanguageName.toLowerCase())) {
        li.add(element);
      }
    });
    print('ss ${li.toString()}');
    allSortLanguageSubject.add(li);
  }

  sortCities(String cityName) async {
    allSortCitiesSubject.add([]);
    List<CitiesData> li = [];
    selectedCountry.value.cities!.forEach((element) {
      if (element.name!.toLowerCase().contains(cityName.toLowerCase())) {
        li.add(element);
      }
    });
    print('ss ${li.toString()}');
    allSortCitiesSubject.add(li);
  }

  dispose() async {
    await allCountriesSubject.stream.drain();
    allCountriesSubject.close();
  }
}
