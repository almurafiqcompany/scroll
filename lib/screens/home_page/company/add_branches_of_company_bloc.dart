import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/models/categories.dart';
import 'package:al_murafiq/models/countries.dart';
import 'package:al_murafiq/screens/home_page/nav_bar.dart';
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

class AddBranchesOfCompanyBloc {
  final Dio _dio = GetIt.instance.get<Dio>();
  SharedPreferenceHelper _helper = GetIt.instance.get<SharedPreferenceHelper>();

  RoundedLoadingButtonController loadingButtonController =
  RoundedLoadingButtonController();


  TextEditingController namePlaceController = TextEditingController();
  final BehaviorSubject<bool> namePlaceSubject = BehaviorSubject<bool>();

  changeNamePlace(String val) => namePlaceSubject.sink.add(validateText(namePlaceController));

  validateText(TextEditingController controller) {
    return controller.text.isNotEmpty;
  }
  TextEditingController addressController = TextEditingController();
  final BehaviorSubject<bool> addressSubject = BehaviorSubject<bool>();

  changeAdress(String val) => addressSubject.sink.add(validateText(addressController));

    TextEditingController desController = TextEditingController();
  final BehaviorSubject<bool> desSubject = BehaviorSubject<bool>();

  changeDes(String val) => desSubject.sink.add(validateText(desController));

  TextEditingController phoneController = TextEditingController();
  final BehaviorSubject<bool> phoneSubject = BehaviorSubject<bool>();

  changePhone(String val) =>
      phoneSubject.sink.add(validateText(phoneController));


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

  changeFax(String val) =>
      faxSubject.sink.add(validateText(faxController));

  final BehaviorSubject<bool> emailOrPhoneSubject = BehaviorSubject<bool>();


  TextEditingController emailOrPhoneController = TextEditingController();


  final BehaviorSubject<dynamic> longSubject =
  BehaviorSubject<dynamic>.seeded(0.0);//lng:await _helper.getLng(),lat: await _helper.getLat()

  final BehaviorSubject<dynamic> latSubject =
  BehaviorSubject<dynamic>.seeded(0.0);
  void changeEmailOrPhone(String val) => emailOrPhoneSubject.sink
      .add(validateEmailOrPhone(emailOrPhoneController));




  bool validateEmailOrPhone(TextEditingController controller) {
    // ignore: unnecessary_parenthesis
    return (emailExp.hasMatch(controller.text) ||
        phoneExp.hasMatch(controller.text));
  }

  final BehaviorSubject<String> workDaysSubjectFrom =
  BehaviorSubject<String>.seeded('Saturday'.tr);
  final BehaviorSubject<String> workDaysSubjectTo =
  BehaviorSubject<String>.seeded('Saturday'.tr);
  final BehaviorSubject<dynamic> workTimeSubjectFrom =
  BehaviorSubject<dynamic>();
  final BehaviorSubject<dynamic> workTimeSubjectTo =
  BehaviorSubject<dynamic>();

  final imageController = BehaviorSubject<File>();
  final imagesOfCompanyController = BehaviorSubject<List<File>>();
  final pdfController = BehaviorSubject<File>();

  final BehaviorSubject<List<SocialController>> socialSubject =
  BehaviorSubject<List<SocialController>>.seeded([SocialController()]);

  Future<void> confirmAddBranchesOfCompany({dynamic lat,dynamic lng,BuildContext context}) async {
    print('signup111');

    print(emailOrPhoneController.text);

    print(phoneController.text);
    if (imageController.value == null) {

      await showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return ShowMessageDialog(type: 400,message: 'text_p_select_photo'.tr,show_but: true,);
        },
      );
      return false;
    }
    if (validateEmailOrPhone(emailOrPhoneController) &&
        validateText(namePlaceController) &&
        validateText(desController) &&
        validateText(addressController) &&
        validateText(mobileController))
    {
      print('signup222');
      print('signup222 ${workTimeSubjectFrom.value}');
      print('signup222 ${workTimeSubjectTo.value}');
      print('signup222 ${workDaysSubjectFrom.value}');
      print('signup222 ${workDaysSubjectTo.value}');
      if ( selectedCountry.value == null || selectedCities.value == null) {
        // Get.snackbar(null, 'اختر صورة  ثم حاول مرة اخري',
        //     snackPosition: SnackPosition.BOTTOM);
        await showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return ShowMessageDialog(type: 400,message: 'text_select_country_msg'.tr,show_but: true,);
          },
        );
        return false;
      }
      if ( selectedSubCategories.value == null || selectCategoriesSubject.value == null) {
        // Get.snackbar(null, 'اختر صورة  ثم حاول مرة اخري',
        //     snackPosition: SnackPosition.BOTTOM);
        await showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return ShowMessageDialog(type: 400,message: 'text_select_categore_msg'.tr,show_but: true,);
          },
        );
        return false;
      }

      if ( workTimeSubjectFrom.value == null || workTimeSubjectTo.value == null) {
        // Get.snackbar(null, 'اختر صورة  ثم حاول مرة اخري',
        //     snackPosition: SnackPosition.BOTTOM);
        await showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return ShowMessageDialog(type: 400,message: 'text_select_time_msg'.tr,show_but: true,);
          },
        );
        return false;
      }

      final PackgDio.FormData formData = PackgDio.FormData.fromMap({
        //  'image': img,
        'name_en': namePlaceController.text,
        'desc_en': desController.text,
        'address_en': addressController.text,
        'phone1': mobileController.text,
        'phone2': mobile2Controller.text,
        'tel': phoneController.text,
        //"fax": faxController.text,
        'email': emailOrPhoneController.text,
        'open_from': workTimeSubjectFrom.value,
        'open_to': workTimeSubjectTo.value,
        'week_from': workDaysSubjectFrom.value,
        'week_to': workDaysSubjectTo.value,
        'lat': latSubject.value==0.0?lat:latSubject.value,
        'lng': longSubject.value==0.0?lng:longSubject.value,

      });

      if (imageController.value != null ) {
        var img=await PackgDio.MultipartFile.fromFileSync(imageController.value.path);
        formData.files.add(
            MapEntry('image', img)
        );
      }
      if (pdfController.value != null ) {

        formData.files.add(
            MapEntry('pdf', PackgDio.MultipartFile.fromFileSync(pdfController.value.path))
        );
      }
      if (imagesOfCompanyController.value != null ) {
        final List<dynamic> srcImages = [];
        for (var sub in imagesOfCompanyController.value) {
          var arr={
            'source' : PackgDio.MultipartFile.fromFileSync(sub.path)
          };
          srcImages.add(arr);

        }
        print('oo${srcImages}');
        formData.fields.add(
            MapEntry('slider','$srcImages')
        );
      }
      if (selectedCountry.value != null ) {
        formData.fields.add(
            MapEntry('country_id', '${selectedCountry.value.id}')
        );
      }
      if (selectedCities.value != null ) {
        formData.fields.add(
            MapEntry('city_id', '${selectedCities.value.id}')
        );
      }
      if (selectCategoriesSubject.value != null ) {
        formData.fields.add(
            MapEntry('cat_id', '${selectCategoriesSubject.value.id}')
        );
      }
      if (selectedSubCategories.value != null ) {
        formData.fields.add(
            MapEntry('sub_cat_id', '${selectedSubCategories.value.id}')
        );
      }
      if (selectedSubSubCategories.value != null ) {
        formData.fields.add(
            MapEntry('sub_sub_cat_id', '${selectedSubSubCategories.value.id}')
        );
      }

      try {
        String lang = await _helper.getCodeLang();
        String token = await _helper.getToken();
        int countryID = await _helper.getCountryId();

        final res = await _dio.post(
          '/companies/new-branch?country_id=$countryID',
          options: Options(
            headers: {'Authorization': 'Bearer $token',
              // 'Content-Type' :"multipart/form-data",
              'lang': '$lang'},

          ),
          data: formData,
        );

        if (res.statusCode == 200 && res.data['status'] == 200) {




          await showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return ShowMessageDialog(type: 200,message: '${res.data['message']}',show_but: true,);
            },
          );
          await Get.back();
        } else if (res.data['status'] == 500) {

          await showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return ShowMessageDialog(type: 400,message: '${res.data['message']}',show_but: true,);
            },
          );
        }
        // ignore: avoid_catches_without_on_clauses
      } catch (e) {

        await showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return ShowMessageDialog(type: 400,message: 'e'.tr,show_but: true,);
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
  Future<void> confirmBeCompany({dynamic lat,dynamic lng,BuildContext context}) async {

    if (imageController.value == null) {
      await showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return ShowMessageDialog(type: 400,message: 'text_p_select_photo'.tr,show_but: true,);
        },
      );
      return false;
    }
    if (validateEmailOrPhone(emailOrPhoneController) &&
        validateText(namePlaceController) &&
        validateText(desController) &&
        validateText(addressController) &&
        validateText(phoneController))
    {

      final PackgDio.FormData formData = PackgDio.FormData.fromMap({
        //  'image': img,
        "name_en": namePlaceController.text,
        "desc_en": desController.text,
        "address_en": addressController.text,
        "phone1": phoneController.text,
        "phone2": mobileController.text,
        "tel": mobile2Controller.text,
        "fax": faxController.text,
        "email": emailOrPhoneController.text,
        "open_from": workTimeSubjectFrom.value,
        "open_to": workTimeSubjectTo.value,
        "week_from": workDaysSubjectFrom.value,
        "week_to": workDaysSubjectTo.value,
        "lat": lat,
        "lng": lng,

      });

      if (imageController.value != null ) {
        var img=await PackgDio.MultipartFile.fromFileSync(imageController.value.path);
        formData.files.add(
            MapEntry('image', img)
        );
      }
      if (pdfController.value != null ) {

        formData.files.add(
            MapEntry('pdf', PackgDio.MultipartFile.fromFileSync(pdfController.value.path))
        );
      }
      if (imagesOfCompanyController.value != null ) {
        final List<dynamic> srcImages = [];
        for (var sub in imagesOfCompanyController.value) {
          var arr={
            'source' : PackgDio.MultipartFile.fromFileSync(sub.path)
          };
          srcImages.add(arr);

        }

        formData.fields.add(
            MapEntry('slider','$srcImages')
        );
      }
      if (selectedCountry.value != null ) {
        formData.fields.add(
            MapEntry('country_id', '${selectedCountry.value.id}')
        );
      }
      if (selectedCities.value != null ) {
        formData.fields.add(
            MapEntry('city_id', '${selectedCities.value.id}')
        );
      }
      if (selectCategoriesSubject.value != null ) {
        formData.fields.add(
            MapEntry('cat_id', '${selectCategoriesSubject.value.id}')
        );
      }
      if (selectedSubCategories.value != null ) {
        formData.fields.add(
            MapEntry('sub_cat_id', '${selectedSubCategories.value.id}')
        );
      }
      if (selectedSubSubCategories.value != null ) {
        formData.fields.add(
            MapEntry('sub_sub_cat_id', '${selectedSubSubCategories.value.id}')
        );
      }

      try {
        String lang = await _helper.getCodeLang();
        String token = await _helper.getToken();
        int countryID = await _helper.getCountryId();

        final res = await _dio.post(
          '/become-company?country_id=$countryID',
          options: Options(
            headers: {"Authorization": "Bearer $token",
              // 'Content-Type' :"multipart/form-data",
              'lang': '$lang'},

          ),
          data: formData,
        );

        if (res.statusCode == 200 && res.data['status'] == 200) {
          await _helper.cleanData();

          await Get.offAll(BottomNavBar());

          await showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return ShowMessageDialog(type: 200,message: '${res.data['message']}',show_but: true,);
            },
          );
        } else if (res.data['status'] == 500) {

          await showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return ShowMessageDialog(type: 400,message: '${res.data['message']}',show_but: true,);
            },
          );
        }
        // ignore: avoid_catches_without_on_clauses
      } catch (e) {
        await showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return ShowMessageDialog(type: 400,message: 'e'.tr,show_but: true,);
          },
        );
      }

    } else {
      emailOrPhoneSubject.sink
          .add(validateEmailOrPhone(emailOrPhoneController));
      phoneSubject.sink.add(validateText(phoneController));
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


  Future<void> fetchAllCountries(int id) async {
    try {
      String lang = await _helper.getCodeLang();
      int countryID = await _helper.getCountryId();
      final List<CountriesData> countries = [];
      final List<Languages> languages = [];
      final res = await _dio.get(
        '/countries/all?country_id=$countryID',
        options: Options(
          headers: {'lang': '$lang'},
        ),
      );
      if (res.statusCode == 200) {
        for (var obj in res.data['data']['countries']) {
          CountriesData country = CountriesData.fromJson(obj);
          if(country.id == id){
            selectedCountry.sink.add(country);
            selectedCities.sink.add(country.cities[0]);
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

  sortCountry(String countryName) async{
    allSortCountriesSubject.add([]);
    List<CountriesData> li = [];
    await allCountriesSubject.value.forEach((element) {
      if(element.name.toLowerCase().contains(countryName.toLowerCase())){
        li.add(element);
      }
    });
    print('ss ${li.toString()}');
    allSortCountriesSubject.add(li);
  }

  sortCities(String cityName) async{
    allSortCitiesSubject.add([]);
    List<CitiesData> li = [];
    await selectedCountry.value.cities.forEach((element) {
      if(element.name.toLowerCase().contains(cityName.toLowerCase())){
        li.add(element);
      }
    });
    print('ss ${li.toString()}');
    allSortCitiesSubject.add(li);
  }

  sortAllCategories(String AllCategoriesName) async{
    getSortAllCategoriesSubject.add([]);
    List<Categories_Data> li = [];
    await getAllCategoriesSubject.value.forEach((element) {
      if(element.name.toLowerCase().contains(AllCategoriesName.toLowerCase())){
        li.add(element);
      }
    });
    print('ss ${li.toString()}');
    getSortAllCategoriesSubject.add(li);
  }
  sortSubCategories(String subCategoriesName) async{
    getSortAllSubCategories.add([]);
    List<SubCategories> li = [];
    await selectCategoriesSubject.value.sub_categories.forEach((element) {
      if(element.name.toLowerCase().contains(subCategoriesName.toLowerCase())){
        li.add(element);
      }
    });
    print('ss ${li.toString()}');
    getSortAllSubCategories.add(li);
  }

  sortSubSubCategories(String subSubCategoriesName) async{
    getSortAllSubSubCategories.add([]);
    List<SubSubCategories> li = [];
    await selectedSubCategories.value.sub_sub_categories.forEach((element) {
      if(element.name.toLowerCase().contains(subSubCategoriesName.toLowerCase())){
        li.add(element);
      }
    });
    print('ss ${li.toString()}');
    getSortAllSubSubCategories.add(li);
  }

  final getAllCategoriesSubject = BehaviorSubject<List<Categories_Data>>();
  final selectCategoriesSubject = BehaviorSubject<Categories_Data>();
  final selectedSubCategories = BehaviorSubject<SubCategories>();
  final selectedSubSubCategories = BehaviorSubject<SubSubCategories>();
  Future<void> fetchDataAllCategories(int id) async {
    try {
      String lang = await _helper.getCodeLang();
      int countryID = await _helper.getCountryId();
      final List<Categories_Data> categoriesData = [];
      final  res = await _dio.get(
        '/categories/all?country_id=$countryID',
        options: Options(
          headers: {"lang": "$lang"},
        ),
      );

      if (res.statusCode == 200 && res.data['status'] == 200) {
        // for (var obj in res.data['data']) {
        //   categoriesData.add(Categories_Data.fromJson(obj));
        // }
        for (var obj in res.data['data']) {
          Categories_Data categories_data =Categories_Data.fromJson(obj);
          if(categories_data.id == id){
            selectCategoriesSubject.sink.add(categories_data);
            selectedSubCategories.sink.add(categories_data.sub_categories[0]);
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
  // final getProfileData = BehaviorSubject<ProfileEditUserAndDelegate>();
  // Future<void> fetchProfileData() async {
  //   try {
  //     String lang = await _helper.getCodeLang();
  //     String token = await _helper.getToken();
  //     int countryID = await _helper.getCountryId();
  //     print("start requset");
  //     final res = await _dio.get(
  //       '/profiles/show?country_id=$countryID',
  //       options: Options(
  //         headers: {"Authorization": "Bearer $token",
  //           'lang': '$lang'},
  //       ),
  //     );
  //     print(res.data);
  //     if (res.statusCode == 200 && res.data['status']==200) {
  //       // for (var obj in res.data['data']['countries']) {
  //       //   countries.add(CountriesData.fromJson(obj));
  //       // }
  //       // for (var obj in res.data['data']['language']) {
  //       //   languages.add(Languages.fromJson(obj));
  //       // }
  //
  //       //
  //       // allCountriesSubject.sink.add(countries);
  //       // allLanguageSubject.sink.add(languages);
  //       ProfileEditUserAndDelegate profile = ProfileEditUserAndDelegate.fromJson(res.data['data']);
  //       getProfileData.sink.add(profile);
  //       await fetchAllCountries(profile.country_id);
  //       print('done request');
  //     } else {
  //       getProfileData.sink.addError('');
  //     }
  //   } catch (e) {
  //     getProfileData.sink.addError('');
  //   }
  // }
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
  final String name;
  final IconData icon;

  SocialItem({this.name, this.icon});
}

class SocialController {
  TextEditingController urlController;
  SocialItem socialItem;

  SocialController({this.urlController, this.socialItem}) {
    urlController = TextEditingController();
  }
}