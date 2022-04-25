
import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/models/sub_categories.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:rxdart/rxdart.dart';
import 'package:al_murafiq/models/home_page.dart';

class HomePageBloc {
  Dio _dio = GetIt.instance.get<Dio>();
  final homeDataSubject = BehaviorSubject<HomePageData>();
  final categories = BehaviorSubject<CategoriesData>();
  SharedPreferenceHelper _helper = GetIt.instance.get<SharedPreferenceHelper>();

  RoundedLoadingButtonController loadingButtonController =
      RoundedLoadingButtonController();
  Future<void> fetchDataHome() async {
    try {
      String lang = await _helper.getCodeLang();
      int? countryID = await _helper.getCountryId();
      double? lat = await _helper.getLat();
      double? lng = await _helper.getLng();

      final Response res = await _dio.get(
        '/home?country_id=$countryID&lat=$lat&lng=$lng',
        options: Options(
          headers: {'lang': '$lang'},
        ),
      );


      print(res.data);
      if (res.statusCode == 200 && res.data['status'] == 200) {
        print('we');
        print(HomePageData.fromJson(res.data['data']));
        homeDataSubject.sink.add(HomePageData.fromJson(res.data['data']));


      } else if (res.data['status'] == 500) {
        homeDataSubject.sink.addError(res.data['message']);
      } else {
        homeDataSubject.sink.addError('');
      }
    } catch (e) {
      homeDataSubject.sink.addError('');
    }
  }

  final getAllSubCategoriesSubject = BehaviorSubject<SubCategories_Data>();
  //final selectCategoriesSubject = BehaviorSubject<Categories_Data>();
  final selectedSubCategories = BehaviorSubject<SubCategories>();
  Future<void> fetchDataAllSubCategories(int id) async {
    try {
      //final List<Categories_Data> categoriesData = [];
      String lang = await _helper.getCodeLang();
      int? countryID = await _helper.getCountryId();
      final Response res = await _dio.get('/categories/sub?category_id=$id&country_id=$countryID',
        options: Options(
          headers: {'lang': '$lang'},
        ),
      );

      if (res.statusCode == 200 && res.data['status'] == 200) {
        // for (var obj in res.data['data']) {
        //   categoriesData.add(Categories_Data.fromJson(obj));
        // }
        // categoriesData.add(Categories_Data.fromJson(obj));

        getAllSubCategoriesSubject.sink
            .add(SubCategories_Data.fromJson(res.data['data']));
      }

    else {
        getAllSubCategoriesSubject.sink.addError(res.data['message']);
      }
    } catch (e) {
      getAllSubCategoriesSubject.sink.addError('');
    }
  }

  dispose() async {
    await homeDataSubject.stream.drain();
    homeDataSubject.close();
    await getAllSubCategoriesSubject.stream.drain();
    getAllSubCategoriesSubject.close();
  }
}
