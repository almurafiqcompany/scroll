import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/models/categories.dart';
import 'package:al_murafiq/models/countries.dart';
import 'package:al_murafiq/models/edit_compaine.dart';
import 'package:al_murafiq/widgets/show_loading_alert.dart';
import 'package:al_murafiq/widgets/show_message_dialog.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as DioPacage;
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:rxdart/rxdart.dart';
import 'package:al_murafiq/models/branch.dart';
import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:dio/dio.dart' as PackgDio;
import 'dart:io';

class EditCompanyBloc {
  final Dio _dio = GetIt.instance.get<Dio>();
  SharedPreferenceHelper _helper = GetIt.instance.get<SharedPreferenceHelper>();

  RoundedLoadingButtonController loadingButtonController =
      RoundedLoadingButtonController();

  TextEditingController namePlaceController = TextEditingController();
  final BehaviorSubject<bool> namePlaceSubject = BehaviorSubject<bool>();

  changeNamePlace(String val) =>
      namePlaceSubject.sink.add(validateText(namePlaceController));

  validateText(TextEditingController controller) {
    return controller.text.isNotEmpty;
  }

  TextEditingController addressController = TextEditingController();
  BehaviorSubject<bool> addressSubject = BehaviorSubject<bool>();

  changeAdress(String val) =>
      addressSubject.sink.add(validateText(addressController));

  TextEditingController desController = TextEditingController();
  final BehaviorSubject<bool> desSubject = BehaviorSubject<bool>();

  changeDes(String val) => desSubject.sink.add(validateText(desController));

  TextEditingController phoneController = TextEditingController();
  final BehaviorSubject<bool> phoneSubject = BehaviorSubject<bool>();

  changePhone(String val) =>
      phoneSubject.sink.add(validateText(phoneController));

  // validatePhone(TextEditingController controller) {
  //   return phoneExp.hasMatch(controller.text);
  // }
  TextEditingController mobileController = TextEditingController();
  final BehaviorSubject<bool> mobileSubject = BehaviorSubject<bool>();

  changeMobile(String val) =>
      mobileSubject.sink.add(validateText(mobileController));

  TextEditingController mobile2Controller = TextEditingController();
  final BehaviorSubject<bool> mobile2Subject = BehaviorSubject<bool>();

  changeMobile2(String val) =>
      mobile2Subject.sink.add(validateText(mobile2Controller));
  TextEditingController faxController = TextEditingController();
  final BehaviorSubject<bool> faxSubject = BehaviorSubject<bool>();

  changeFax(String val) => faxSubject.sink.add(validateText(faxController));

  final BehaviorSubject<bool> emailOrPhoneSubject = BehaviorSubject<bool>();

  TextEditingController emailOrPhoneController = TextEditingController();

  void changeEmailOrPhone(String val) => emailOrPhoneSubject.sink
      .add(validateEmailOrPhone(emailOrPhoneController));

  bool validateEmailOrPhone(TextEditingController controller) {
    // ignore: unnecessary_parenthesis
    return (emailExp.hasMatch(controller.text) ||
        phoneExp.hasMatch(controller.text));
  }

  BehaviorSubject<String> workDaysSubjectFrom =
      BehaviorSubject<String>.seeded('Saturday'.tr);
  BehaviorSubject<String> workDaysSubjectTo =
      BehaviorSubject<String>.seeded('Saturday'.tr);
  BehaviorSubject<dynamic> workTimeSubjectFrom = BehaviorSubject<dynamic>();
  BehaviorSubject<dynamic> workTimeSubjectTo = BehaviorSubject<dynamic>();
  BehaviorSubject<dynamic> lanSubject = BehaviorSubject<dynamic>();
  BehaviorSubject<dynamic> lngSubject = BehaviorSubject<dynamic>();

  final imageController = BehaviorSubject<File>();
  final imagesOfCompanyController = BehaviorSubject<List<File>>();
  final pdfController = BehaviorSubject<File>();
  List<SocialItem> socialItems = [
    SocialItem(name: 'Facebook', icon: MdiIcons.facebook),
    SocialItem(name: 'Twitter', icon: MdiIcons.twitter),
    SocialItem(name: 'Instagram', icon: MdiIcons.instagram),
  ];
  final BehaviorSubject<List<SocialController>> socialSubject =
      BehaviorSubject<List<SocialController>>.seeded([SocialController()]);

  Future<void> editCompanyBloc(
      {dynamic lat,
      dynamic lng,
      int? company_id,
      BuildContext? context}) async {
    // if (imageController.value == null) {
    //   Get.snackbar(null, 'اختر صورة  ثم حاول مرة اخري',
    //       snackPosition: SnackPosition.BOTTOM);
    //   return false;
    // }
    if (validateEmailOrPhone(emailOrPhoneController) &&
        validateText(namePlaceController) &&
        validateText(desController) &&
        validateText(addressController) &&
        validateText(mobileController)) {
      if (selectedCountry.value == null || selectedCities.value == null) {
        // Get.snackbar(null, 'اختر صورة  ثم حاول مرة اخري',
        //     snackPosition: SnackPosition.BOTTOM);
        await showModalBottomSheet<void>(
          context: context!,
          builder: (BuildContext context) {
            return ShowMessageDialog(
              type: 400,
              message: 'text_select_country_msg'.tr,
              show_but: true,
            );
          },
        );
        return;
      }
      if (selectedSubCategories.value == null ||
          selectCategoriesSubject.value == null) {
        // Get.snackbar(null, 'اختر صورة  ثم حاول مرة اخري',
        //     snackPosition: SnackPosition.BOTTOM);
        await showModalBottomSheet<void>(
          context: context!,
          builder: (BuildContext context) {
            return ShowMessageDialog(
              type: 400,
              message: 'text_select_categore_msg'.tr,
              show_but: true,
            );
          },
        );
        return;
      }
      final PackgDio.FormData formData = PackgDio.FormData.fromMap({
        //  'image': img,
        "name_en": namePlaceController.text,
        "desc_en": desController.text,
        "address_en": addressController.text,
        "phone1": mobileController.text,
        "phone2": mobile2Controller.text,
        "tel": phoneController.text,
        //"fax": faxController.text,
        "email": emailOrPhoneController.text,
        "open_from": workTimeSubjectFrom.value,
        "open_to": workTimeSubjectTo.value,
        "week_from": workDaysSubjectFrom.value,
        "week_to": workDaysSubjectTo.value,
        // 'lat': await _helper.getLat(),
        // 'lng': await _helper.getLng(),
        'lat': lanSubject.value,
        'lng': lngSubject.value,
        "id": company_id,
      });

      if (imageController.value != null) {
        var img = await PackgDio.MultipartFile.fromFileSync(
            imageController.value.path);
        formData.files.add(MapEntry('image', img));
      }
      // if (pdfController.value != null ) {
      //
      //   formData.files.add(
      //       MapEntry('pdf', PackgDio.MultipartFile.fromFileSync(pdfController.value.path))
      //   );
      // }
      // if (imagesOfCompanyController.value != null ) {
      //   final List<dynamic> srcImages = [];
      //   for (var sub in imagesOfCompanyController.value) {
      //     var arr={
      //       'source' : PackgDio.MultipartFile.fromFileSync(sub.path)
      //     };
      //     srcImages.add(arr);
      //
      //   }
      //   print('oo${srcImages}');
      //   formData.fields.add(
      //       MapEntry('slider','$srcImages')
      //   );
      // }
      if (selectedCountry.value != null) {
        formData.fields
            .add(MapEntry('country_id', '${selectedCountry.value.id}'));
      }
      if (selectedCities.value != null) {
        formData.fields.add(MapEntry('city_id', '${selectedCities.value.id}'));
      }
      if (selectCategoriesSubject.value != null) {
        formData.fields
            .add(MapEntry('cat_id', '${selectCategoriesSubject.value.id}'));
      }
      if (selectedSubCategories.value != null) {
        formData.fields
            .add(MapEntry('sub_cat_id', '${selectedSubCategories.value.id}'));
      }
      if (selectedSubSubCategories.value != null) {
        formData.fields.add(
            MapEntry('sub_sub_cat_id', '${selectedSubSubCategories.value.id}'));
      }

      try {
        String lang = await _helper.getCodeLang();
        String? token = await _helper.getToken();
        int? countryID = await _helper.getCountryId();

        final res = await _dio.post(
          '/companies/edit-branch?country_id=$countryID',
          options: Options(
            headers: {
              "Authorization": "Bearer $token",
              // 'Content-Type' :"multipart/form-data",
              'lang': '$lang'
            },
          ),
          data: formData,
        );
        print(res.data);
        if (res.statusCode == 200 && res.data['status'] == 200) {
          await showModalBottomSheet<void>(
            context: context!,
            builder: (BuildContext context) {
              return ShowMessageDialog(
                type: 200,
                message: '${res.data['message']}',
                show_but: true,
              );
            },
          );
          Get.back();
        } else if (res.data['status'] == 500) {
          await showModalBottomSheet<void>(
            context: context!,
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
        await showModalBottomSheet<void>(
          context: context!,
          builder: (BuildContext context) {
            return ShowMessageDialog(
              type: 400,
              message: 'e'.tr,
              show_but: true,
            );
          },
        );
      }
    } else {
      emailOrPhoneSubject.sink
          .add(validateEmailOrPhone(emailOrPhoneController));
      mobileSubject.sink.add(validateText(mobileController));
      desSubject.sink.add(validateText(desController));
      addressSubject.sink.add(validateText(addressController));
      namePlaceSubject.sink.add(validateText(namePlaceController));
    }
  }

  final allCountriesSubject = BehaviorSubject<List<CountriesData>>();
  final allLanguageSubject = BehaviorSubject<List<Languages>>();
  final allCitiesSubject = BehaviorSubject<List<CitiesData>>();
  final allDefultLanguageSubject = BehaviorSubject<String>();

  final selectedCountry = BehaviorSubject<CountriesData>();
  final selectedLanguage = BehaviorSubject<Languages>();
  final selectedCities = BehaviorSubject<CitiesData>();

  final getSortAllCategoriesSubject = BehaviorSubject<List<Categories_Data>>();

  final getSortAllSubCategories = BehaviorSubject<List<SubCategories>>();
  final getSortAllSubSubCategories = BehaviorSubject<List<SubSubCategories>>();

  final allSortCountriesSubject = BehaviorSubject<List<CountriesData>>();
  final allSortCitiesSubject = BehaviorSubject<List<CitiesData>>();

  Future<void> fetchAllCountries(int country_id, int city_id) async {
    try {
      String lang = await _helper.getCodeLang();
      int? countryID = await _helper.getCountryId();
      final List<CountriesData> countries = [];
      final List<Languages> languages = [];
      final res = await _dio.get(
        '/countries/all?country_id=$countryID',
        options: Options(
          headers: {'lang': '$lang'},
        ),
      );
      print(res.data);
      if (res.statusCode == 200) {
        for (var obj in res.data['data']['countries']) {
          CountriesData country = CountriesData.fromJson(obj);
          if (country.id == country_id) {
            selectedCountry.sink.add(country);
            // selectedCities.sink.add(country.cities[city_id]);
            for (var objCity in country.cities!) {
              if (objCity.id == city_id) selectedCities.sink.add(objCity);
            }
          }
          countries.add(country);
        }
        for (var obj in res.data['data']['language']) {
          languages.add(Languages.fromJson(obj));
        }

        allCountriesSubject.sink.add(countries);
        allSortCountriesSubject.add(countries);
        allLanguageSubject.sink.add(languages);
        allDefultLanguageSubject.sink.add(res.data['data']['default_lang']);
      } else {
        allCountriesSubject.sink.addError('');
      }
    } catch (e) {
      allCountriesSubject.sink.addError('');
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

  final getAllCategoriesSubject = BehaviorSubject<List<Categories_Data>>();
  BehaviorSubject<Categories_Data> selectCategoriesSubject =
      BehaviorSubject<Categories_Data>();
  BehaviorSubject<SubCategories> selectedSubCategories =
      BehaviorSubject<SubCategories>();
  BehaviorSubject<SubSubCategories> selectedSubSubCategories =
      BehaviorSubject<SubSubCategories>();

  Future<void> fetchDataAllCategories({
    int? cat_id,
    int? sub_cat_id,
  }) async {
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
      print(res.data['data']);
      if (res.statusCode == 200 && res.data['status'] == 200) {
        // for (var obj in res.data['data']) {
        //   categoriesData.add(Categories_Data.fromJson(obj));
        // }
        for (var obj in res.data['data']) {
          Categories_Data categories_data = Categories_Data.fromJson(obj);
          if (categories_data.id == cat_id) {
            selectCategoriesSubject.sink.add(categories_data);
            print('cat');
            for (var sub_obj in categories_data.sub_categories!) {
              if (sub_obj.id == sub_cat_id) {
                // selectedSubCategories.sink.add(categories_data.sub_categories[0]);
                selectedSubCategories.sink.add(sub_obj);
                if (sub_obj.sub_sub_categories!.length > 0) {
                  for (var sub_sub_obj in sub_obj.sub_sub_categories!) {
                    if (sub_sub_obj.id == sub_cat_id) {
                      selectedSubSubCategories.sink.add(sub_sub_obj);
                    }
                  }
                }
              }
            }
          }
          categoriesData.add(categories_data);
        }

        getAllCategoriesSubject.sink.add(categoriesData);
        getSortAllCategoriesSubject.sink.add(categoriesData);
      } else if (res.data['status'] == 500) {
        getAllCategoriesSubject.sink.addError(res.data['status']);
      }
    } catch (e) {
      getAllCategoriesSubject.sink.addError('');
    }
  }

  final getProfileDataOf = BehaviorSubject<EditCompany>();

  Future<void> fetchProfileData(
      {int? company_id, BuildContext? context}) async {
    try {
      String lang = await _helper.getCodeLang();
      String? token = await _helper.getToken();
      int? countryID = await _helper.getCountryId();

      final res = await _dio.get(
        '/companies/branch?id=$company_id&country_id=$countryID',
        options: Options(
          headers: {"Authorization": "Bearer $token", 'lang': '$lang'},
        ),
      );

      if (res.statusCode == 200 && res.data['status'] == 200) {
        // for (var obj in res.data['data']['countries']) {
        //   countries.add(CountriesData.fromJson(obj));
        // }
        // for (var obj in res.data['data']['language']) {
        //   languages.add(Languages.fromJson(obj));
        // }

        //
        // allCountriesSubject.sink.add(countries);
        // allLanguageSubject.sink.add(languages);
        showAlertDialog(context!);
        EditCompany profile = EditCompany.fromJson(res.data['data']);
        getProfileDataOf.sink.add(profile);
        await fetchAllCountries(profile.country_id, profile.city_id);
        await fetchDataAllCategories(
            cat_id: profile.cat_id, sub_cat_id: profile.sub_cat_id);

        addressController.text = profile.address_en!;
        lanSubject.value = profile.lat;
        lngSubject.value = profile.lng;
        namePlaceController.text = profile.name_en!;
        desController.text = profile.desc_en!;
        mobileController.text = profile.phone1;
        mobile2Controller.text = profile.phone2;
        phoneController.text = profile.tel;
        faxController.text = profile.fax;
        emailOrPhoneController.text = profile.email!;
        workDaysSubjectFrom.value = profile.week_from;
        workDaysSubjectTo.value = profile.week_to;
        workTimeSubjectFrom.value = profile.open_from;
        workTimeSubjectTo.value = profile.open_to;
        Get.back();
      } else {
        getProfileDataOf.sink.addError('');
      }
    } catch (e) {
      getProfileDataOf.sink.addError('');
    }
  }

  dispose() async {
    await emailOrPhoneSubject.stream.drain();
    await emailOrPhoneSubject.close();
    emailOrPhoneController.dispose();
    await emailOrPhoneSubject.stream.drain();
    await emailOrPhoneSubject.close();
    await phoneSubject.stream.drain();
    await phoneSubject.close();
    await allCountriesSubject.stream.drain();
    await allCountriesSubject.close();
    await allLanguageSubject.stream.drain();
    await allLanguageSubject.close();
    await allCitiesSubject.stream.drain();
    await allCitiesSubject.close();
    await selectedCountry.stream.drain();
    await selectedCountry.close();
    await selectedLanguage.stream.drain();
    await selectedLanguage.close();
    await selectedCities.stream.drain();
    await selectedCities.close();
    emailOrPhoneController.dispose();
    phoneController.dispose();
  }
}

class SocialItem {
  final String? name;
  final IconData? icon;

  SocialItem({this.name, this.icon});
}

class SocialController {
  TextEditingController? urlController;
  SocialItem? socialItem;

  SocialController({this.urlController, this.socialItem}) {
    urlController = TextEditingController();
  }
}
