import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/models/categories.dart';
import 'package:al_murafiq/widgets/show_message_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class CategoriesBloc {
  Dio _dio = GetIt.instance.get<Dio>();
  final getAllCategoriesSubject = BehaviorSubject<List<Categories_Data>>();
  final getSortAllCategoriesSubject = BehaviorSubject<List<Categories_Data>>();
  final selectCategoriesSubject = BehaviorSubject<Categories_Data>();
  final selectedSubCategories = BehaviorSubject<SubCategories>();
  final getSortAllSubCategories = BehaviorSubject<List<SubCategories>>();
  final getSortAllSubSubCategories = BehaviorSubject<List<SubSubCategories>>();
  final selectedSubSubCategories = BehaviorSubject<SubSubCategories>();
  SharedPreferenceHelper _helper = GetIt.instance.get<SharedPreferenceHelper>();

  Future<void> fetchDataAllCategories() async {
    try {
      String lang = await _helper.getCodeLang();
      int? countryID = await _helper.getCountryId();
      final List<Categories_Data> categoriesData = [];
      final res = await _dio.get(
        '/categories/all?country_id=$countryID',
        options: Options(
          headers: {"lang": "$lang"},
        ),
      );
      print(res.data);
      if (res.statusCode == 200 && res.data['status'] == 200) {
        for (var obj in res.data['data']) {
          categoriesData.add(Categories_Data.fromJson(obj));
        }

        getAllCategoriesSubject.sink.add(categoriesData);
        getSortAllCategoriesSubject.sink.add(categoriesData);
      } else if (res.data['status'] == 500) {
        getAllCategoriesSubject.sink.addError(res.data['message']);
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      getAllCategoriesSubject.sink.addError('');
    }
  }

  sortAllCategories(String AllCategoriesName) async {
    getSortAllCategoriesSubject.add([]);
    List<Categories_Data> li = [];
    getAllCategoriesSubject.value.forEach((element) {
      if (element.name!
          .toLowerCase()
          .contains(AllCategoriesName.toLowerCase())) {
        li.add(element);
      }
    });
    print('ss ${li.toString()}');
    getSortAllCategoriesSubject.add(li);
  }

  sortSubCategories(String subCategoriesName) async {
    getSortAllSubCategories.add([]);
    List<SubCategories> li = [];
    selectCategoriesSubject.value.sub_categories!.forEach((element) {
      if (element.name!
          .toLowerCase()
          .contains(subCategoriesName.toLowerCase())) {
        li.add(element);
      }
    });
    print('ss ${li.toString()}');
    getSortAllSubCategories.add(li);
  }

  sortSubSubCategories(String subSubCategoriesName) async {
    getSortAllSubSubCategories.add([]);
    List<SubSubCategories> li = [];
    selectedSubCategories.value.sub_sub_categories!.forEach((element) {
      if (element.name!
          .toLowerCase()
          .contains(subSubCategoriesName.toLowerCase())) {
        li.add(element);
      }
    });
    print('ss ${li.toString()}');
    getSortAllSubSubCategories.add(li);
  }

  dispose() async {
    await getAllCategoriesSubject.stream.drain();
    getAllCategoriesSubject.close();
  }
}
