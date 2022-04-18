import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/models/categories.dart';
import 'package:al_murafiq/models/countries.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:rxdart/rxdart.dart';
import 'package:al_murafiq/models/search.dart';
import 'package:get/get.dart';
import 'package:al_murafiq/widgets/show_loading_alert.dart';
import 'package:dio/dio.dart' as DioPacage;

class SearchBloc {
  Dio _dio = GetIt.instance.get<Dio>();
  final dataOfSearchSubject = BehaviorSubject<Search>();
  SharedPreferenceHelper _helper = GetIt.instance.get<SharedPreferenceHelper>();
  final BehaviorSubject<bool> searchSubject = BehaviorSubject<bool>();
  final BehaviorSubject<bool> loadSubject = BehaviorSubject<bool>.seeded(false);
  TextEditingController searchController = TextEditingController();
  RoundedLoadingButtonController loadingButtonController =
      RoundedLoadingButtonController();

  changeSearch(String val) =>
      searchSubject.sink.add(validateText(searchController));

  validateText(TextEditingController controller) {
    return controller.text.isNotEmpty;
  }

  int _pageNumber = 1;
  int _pagesCount;

  int get pageNumber => _pageNumber;

  int get pagesCount => _pagesCount;

  Future<void> pageNumberSet(int pageNumber) {
    _pageNumber = pageNumber;
    return null;
  }

  void nextPage() {
    _pageNumber++;
  }

  Future getProducts(
      {bool reset = false,
      bool goToNextPage = false,
      BuildContext context}) async {
    //showAlertDialog(context);
    loadSubject.sink.add(true);

    // if (goToNextPage) nextPage();
    if (reset) {
      _pageNumber = 1;
      dataOfSearchSubject.value = null;
    }
    if (goToNextPage && _pageNumber <= _pagesCount) {
      if (_pageNumber != _pagesCount) nextPage();
      // await getUpdateProducts(context);

    } else if (!goToNextPage) {
      // await getUpdateProducts(context);
      _pageNumber = 1;
    }
    loadSubject.sink.add(false);
  }

  final dataOfproductSubject = BehaviorSubject<List<DataOfSearch>>();

  // Future getUpdateProducts(BuildContext context) async {
  //   print('update 1');
  //   //loadSubject.sink.add(true);
  //   Search value;
  //  // value= await fetchDataSubCategories(11,context);
  //   print('update 2');
  //   print('update ${value.data.length}');
  //
  //   if (value != null) {
  //     print('number of pagenumber');
  //
  //     _pagesCount = value.last_page;
  //     _pageNumber = value.current_page;
  //     print('number of last page $_pagesCount');
  //     print('number of last page $_pageNumber');
  //     if (dataOfproductSubject.value == null)
  //       dataOfproductSubject.sink.add(value.data);
  //     else
  //       // dataOfSubCategoriesSubject.sink.add(value);
  //       dataOfproductSubject
  //         .add(dataOfproductSubject.value..addAll(value.data));
  //
  //     print(dataOfproductSubject.value.length);
  //   }
  //   //loadSubject.sink.add(false);
  //  // Get.back();
  // }

  Future<void> fetchDataSearch(
      int subCategoriesID, BuildContext context) async {
    if (validateText(searchController)) {
      try {
        String lang = await _helper.getCodeLang();
        int countryID = await _helper.getCountryId();
        double lat = await _helper.getLat();
        double lng = await _helper.getLng();

        showAlertDialog(context);
        final DioPacage.FormData formData = DioPacage.FormData.fromMap({
          "query": searchController.text,
          "country_id": '${await _helper.getCountryId()}',
          'lat': lat,
          'lng': lng,
        });
        String token = await _helper.getToken();
        final res = await _dio.post(
          '/search?country_id=$countryID&page=$pageNumber',
          options: Options(
            headers: {"Authorization": "Bearer $token", "lang": "$lang"},
          ),
          data: formData,
        );
        Get.back();
        if (res.statusCode == 200 && res.data['status'] == 200) {
          // for (var obj in res.data['data']) {
          //   homeData.add(HomePageData.fromJson(obj));
          // }

          dataOfSearchSubject.sink.add(Search.fromJson(res.data['data']));
          // dataOfproductSubject.sink.add(dataOfSearchSubject.value.data);

          // dataOfproductSubject.sink.add(dataOfSearchSubject.value.data);
          _pagesCount = Search.fromJson(res.data['data']).last_page;

          if (pageNumber == 1)
            dataOfproductSubject.sink
                .add(Search.fromJson(res.data['data']).data);
          // dataOfproductSubject.sink.add(dataOfSearchSubject.value.data);

        } else if (res.data['status'] == 400) {
          dataOfSearchSubject.sink.addError(res.data['message']);
          dataOfproductSubject.sink.addError('${res.data['message']}');
        } else {
          dataOfSearchSubject.sink.addError('');
          dataOfproductSubject.sink.addError('');
        }
        // ignore: avoid_catches_without_on_clauses
      } catch (e) {
        dataOfSearchSubject.sink.addError('');
        dataOfproductSubject.sink.addError('');
      }
    } else {
      searchSubject.sink.add(validateText(searchController));
    }
  }

  Future<bool> fetchDataCustomSearch(
      CountriesData countriesData,
      CitiesData citiesData,
      Categories_Data categories_Data,
      SubCategories subCategories,
      SubSubCategories subSubCategories,
      BuildContext context,
      bool buildLoad) async {
    try {
      buildLoad ? showAlertDialog(context) : null;

      String code = await _helper.getCode();
      double lat = await _helper.getLat();
      double lng = await _helper.getLng();
      final DioPacage.FormData formData = DioPacage.FormData.fromMap({
        "query": searchController.text != null ? searchController.text : "",
        "country_id": countriesData != null
            ? '${countriesData.id}'
            : '${await _helper.getCountryId()}',
        "city_id": citiesData != null ? '${citiesData.id}' : '',
        "sub_category_id": subCategories != null ? '${subCategories.id}' : '',
        "sub_sub_category_id":
            subSubCategories != null ? '${subSubCategories.id}' : '',
        "category_id": categories_Data != null ? '${categories_Data.id}' : '',
        "user_id": code,
        'lat': lat,
        'lng': lng,
      });

      String token = await _helper.getToken();
      String lang = await _helper.getCodeLang();

      final res = await _dio.post(
        '/search/custom?page=$pageNumber',
        options: Options(
          headers: {"Authorization": "Bearer $token", "lang": "$lang"},
        ),
        data: formData,
      );

      buildLoad ? Get.back() : null;
      print('qq ${res.data}');
      print('cod ${await _helper.getCountryId()}');
      print('sub ${subCategories != null ? '${subCategories.id}' : ''}');
      print('cat ${categories_Data != null ? '${categories_Data.id}' : ''}');
      if (res.statusCode == 200 && res.data['status'] == 200) {
        // for (var obj in res.data['data']) {بابا
        //   homeData.add(HomePageData.fromJson(obj));
        // }
        print('qqwww');
        print('qqwww ${res.data['data']}');
        dataOfSearchSubject.sink.add(Search.fromJson(res.data['data']));

        // dataOfproductSubject.sink.add(dataOfSearchSubject.value.data);
        _pagesCount = Search.fromJson(res.data['data']).last_page;

        if (pageNumber == 1)
          dataOfproductSubject.sink.add(Search.fromJson(res.data['data']).data);
        // dataOfproductSubject.sink.add(dataOfSearchSubject.value.data);

        return true;
      } else if (res.data['status'] == 400) {
        dataOfSearchSubject.sink.addError(res.data['message']);
        dataOfproductSubject.sink.addError('${res.data['message']}');
        return true;
      } else {
        dataOfSearchSubject.sink.addError('');
        dataOfproductSubject.sink.addError('');
        return false;
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      dataOfSearchSubject.sink.addError('');
      dataOfproductSubject.sink.addError('');
      return false;
    }
  }

  final dataOfSubCategoriesSubject = BehaviorSubject<Search>();

  // Future<Search> fetchDataSubCategories(int sub_category_id,BuildContext context) async {
  Future<void> fetchDataSubCategories(
      int sub_category_id, BuildContext context, bool buildLoad) async {
    try {
      buildLoad ? showAlertDialog(context) : null;
      String lang = await _helper.getCodeLang();
      int countryID = await _helper.getCountryId();
      String token = await _helper.getToken();
      double lat = await _helper.getLat();
      double lng = await _helper.getLng();
      final res = await _dio.get(
        '/companies?country_id=$countryID&category_id=$sub_category_id&lat=$lat&lng=$lng&page=$pageNumber',
        options: Options(
            headers: {'Authorization': 'Bearer $token', "lang": "$lang"}),
      );

      buildLoad ? Get.back() : null;

      if (res.statusCode == 200 && res.data['status'] == 200) {
        // for (var obj in res.data['data']) {
        //   homeData.add(HomePageData.fromJson(obj));
        // }

        dataOfSubCategoriesSubject.sink.add(Search.fromJson(res.data['data']));
        _pagesCount = Search.fromJson(res.data['data']).last_page;

        if (pageNumber == 1)
          dataOfproductSubject.sink.add(Search.fromJson(res.data['data']).data);
        // dataOfproductSubject.sink.add(dataOfSearchSubject.value.data);

        // return dataOfSubCategoriesSubject.value;
      } else {
        dataOfSubCategoriesSubject.sink.addError('');
        dataOfproductSubject.sink.addError('${res.data['message']}');
      }
    } catch (e) {
      dataOfSubCategoriesSubject.sink.addError('');
      dataOfproductSubject.sink.addError('');
    }
  }

  Future<void> fetchDataSubSubCategories(
      int sub_sub_category_id, BuildContext context, bool buildLoad) async {
    try {
      buildLoad ? showAlertDialog(context) : null;
      String lang = await _helper.getCodeLang();
      int countryID = await _helper.getCountryId();
      String token = await _helper.getToken();
      double lat = await _helper.getLat();
      double lng = await _helper.getLng();
      final res = await _dio.get(
        '/companies?country_id=$countryID&sub_sub_category_id=$sub_sub_category_id&lat=$lat&lng=$lng&page=$pageNumber',
        options: Options(
            headers: {'Authorization': 'Bearer $token', "lang": "$lang"}),
      );

      buildLoad ? Get.back() : null;

      if (res.statusCode == 200 && res.data['status'] == 200) {
        // for (var obj in res.data['data']) {
        //   homeData.add(HomePageData.fromJson(obj));
        // }

        dataOfSubCategoriesSubject.sink.add(Search.fromJson(res.data['data']));
        _pagesCount = Search.fromJson(res.data['data']).last_page;

        if (pageNumber == 1)
          dataOfproductSubject.sink.add(Search.fromJson(res.data['data']).data);
        // dataOfproductSubject.sink.add(dataOfSearchSubject.value.data);

        // return dataOfSubCategoriesSubject.value;
      } else {
        dataOfSubCategoriesSubject.sink.addError('');
        dataOfproductSubject.sink.addError('${res.data['message']}');
      }
    } catch (e) {
      dataOfSubCategoriesSubject.sink.addError('');
      dataOfproductSubject.sink.addError('');
    }
  }

  dispose() async {
    await dataOfSearchSubject.stream.drain();
    dataOfSearchSubject.close();
  }
}
