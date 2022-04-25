import 'dart:io';

import 'package:al_murafiq/components/firebase_notifications.dart';
import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/screens/home_page/nav_bar.dart';
import 'package:al_murafiq/screens/payment/payment_plans/pay_plans_screen.dart';
import 'package:al_murafiq/screens/register_merchant/account_merchant_p2_screen.dart';
import 'package:al_murafiq/screens/register_merchant/account_merchant_p3_screen.dart';
import 'package:al_murafiq/widgets/show_message_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:rxdart/rxdart.dart';
import 'package:dio/dio.dart' as PackgDio;
import 'package:al_murafiq/models/categories.dart';
import 'package:al_murafiq/models/countries.dart';

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

class RegisterMerchantBloc {
  // List<SocialItem> socialItems = [
  //   SocialItem(name: 'Facebook', icon: MdiIcons.facebook),
  //   SocialItem(name: 'Twitter', icon: MdiIcons.twitter),
  //   SocialItem(name: 'Instagram', icon: MdiIcons.instagram),
  // ];
  final BehaviorSubject<List<SocialController>> socialSubject =
      BehaviorSubject<List<SocialController>>.seeded([SocialController()]);

  final Dio _dio = GetIt.instance.get<Dio>();
  SharedPreferenceHelper _helper = GetIt.instance.get<SharedPreferenceHelper>();
  final BehaviorSubject<int> tapBarSubject = BehaviorSubject<int>.seeded(0);
  final BehaviorSubject<dynamic> longSubject = BehaviorSubject<dynamic>.seeded(
      0.0); //lng:await _helper.getLng(),lat: await _helper.getLat()

  final BehaviorSubject<dynamic> latSubject =
      BehaviorSubject<dynamic>.seeded(0.0);
  final BehaviorSubject<String> languageSubject = BehaviorSubject<String>();

  Function(String) get languageChanged => languageSubject.sink.add;

  final BehaviorSubject<String> genderSubject =
      BehaviorSubject<String>.seeded('Male'.tr);
  final BehaviorSubject<String> kindCompanySubject = BehaviorSubject<String>();

  Function(String) get genderChanged => genderSubject.sink.add;

  RoundedLoadingButtonController loadingButtonController =
      RoundedLoadingButtonController();

  final BehaviorSubject<DateTime> birthDateSubject =
      BehaviorSubject<DateTime>.seeded(DateTime.now());

  Future<void> birthDateChanged(BuildContext context) async {
    final DateTime? dateTime = await _gatDateFromPicker(context);
    if (dateTime != null) {
      birthDateSubject.add(dateTime);
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController nationalIDController = TextEditingController();
  TextEditingController nameCompanyLang1Controller = TextEditingController();
  TextEditingController nameCompanyLang2Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  // TextEditingController codeAfflatorController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController desLang1Controller = TextEditingController();
  TextEditingController desLang2Controller = TextEditingController();

  final BehaviorSubject<bool> nameSubject = BehaviorSubject<bool>();
  final BehaviorSubject<bool> nameCompanyLang1Subject = BehaviorSubject<bool>();
  final BehaviorSubject<bool> nameCompanyLang2Subject = BehaviorSubject<bool>();
  final BehaviorSubject<bool> nationalIDSubject = BehaviorSubject<bool>();
  final BehaviorSubject<bool> citySubject = BehaviorSubject<bool>();
  // final BehaviorSubject<bool> codeAfflatorSubject = BehaviorSubject<bool>();
  final BehaviorSubject<bool> addressSubject = BehaviorSubject<bool>();
  final BehaviorSubject<bool> desLang1Subject = BehaviorSubject<bool>();
  final BehaviorSubject<bool> desLang2Subject = BehaviorSubject<bool>();

  changeName(String val) => nameSubject.sink.add(validateText(nameController));

  changeCity(String val) => citySubject.sink.add(validateText(cityController));
  // changeCodeAfflator(String val) => codeAfflatorSubject.sink.add(validateText(codeAfflatorController));
  changeAddress(String val) =>
      addressSubject.sink.add(validateText(addressController));

  changeDesLang1(String val) =>
      desLang1Subject.sink.add(validateText(desLang1Controller));

  changeDesLang2(String val) =>
      desLang2Subject.sink.add(validateText(desLang2Controller));

  changeNameCompanylang1(String val) => nameCompanyLang1Subject.sink
      .add(validateText(nameCompanyLang1Controller));

  changeNameCompanylang2(String val) => nameCompanyLang2Subject.sink
      .add(validateText(nameCompanyLang2Controller));

  changeNationalID(String val) =>
      nationalIDSubject.sink.add(validateNationalID(nationalIDController));

  validateText(TextEditingController controller) {
    return controller.text.isNotEmpty;
  }

  validateNationalID(TextEditingController controller) {
    return (phoneExp.hasMatch(controller.text) || controller.text.length >= 14);
  }

  TextEditingController emailOrPhoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final BehaviorSubject<bool> emailOrPhoneSubject = BehaviorSubject<bool>();
  final BehaviorSubject<bool> passwordSubject =
      BehaviorSubject<bool>.seeded(true);
  final BehaviorSubject<bool> obscurePasswordSubject =
      BehaviorSubject<bool>.seeded(true);

  void changeEmailOrPhone(String val) => emailOrPhoneSubject.sink
      .add(validateEmailOrPhone(emailOrPhoneController));

  changePassword(String val) =>
      passwordSubject.sink.add(validatePassword(passwordController));

  bool validateEmailOrPhone(TextEditingController controller) {
    // ignore: unnecessary_parenthesis
    return (emailExp.hasMatch(controller.text) ||
        phoneExp.hasMatch(controller.text));
  }

  validatePassword(TextEditingController controller) {
    return controller.text.length >= 8;
  }

  final BehaviorSubject<bool> confirmePasswordSubject =
      BehaviorSubject<bool>.seeded(true);

  final BehaviorSubject<bool> obscureConfirmePasswordSubject =
      BehaviorSubject<bool>.seeded(true);
  TextEditingController confirmePasswordController = TextEditingController();

  changeConfirmePassword(String val) => confirmePasswordSubject.sink
      .add(validatePassword(confirmePasswordController));

  TextEditingController phoneController = TextEditingController();
  final BehaviorSubject<bool> phoneSubject = BehaviorSubject<bool>();

  changePhone(String val) =>
      phoneSubject.sink.add(validateText(phoneController));

  // validatePhone(TextEditingController controller) {
  //   return phoneExp.hasMatch(controller.text);
  // }
  TextEditingController userPhoneController = TextEditingController();
  final BehaviorSubject<bool> userPhoneSubject = BehaviorSubject<bool>();

  changeUserPhone(String val) =>
      userPhoneSubject.sink.add(validateText(userPhoneController));

  validateUserPhone(TextEditingController controller) {
    return phoneExp.hasMatch(controller.text);
  }

  final selectCategoriesSubject = BehaviorSubject<Categories_Data>();
  final selectedSubCategories = BehaviorSubject<SubCategories>();
  final selectedSubSubCategories = BehaviorSubject<SubSubCategories>();
  final selectedCountry = BehaviorSubject<CountriesData>();
  final allSortCitiesSubject = BehaviorSubject<List<CitiesData>>();
  final selectedCities = BehaviorSubject<CitiesData>();

  final BehaviorSubject<String> workDaysSubjectFrom =
      BehaviorSubject<String>.seeded('Saturday'.tr);
  final BehaviorSubject<String> workDaysSubjectTo =
      BehaviorSubject<String>.seeded('Saturday'.tr);
  final BehaviorSubject<dynamic> workTimeSubjectFrom =
      BehaviorSubject<dynamic>();
  final BehaviorSubject<dynamic> workTimeSubjectTo = BehaviorSubject<dynamic>();
  final getAllCategoriesSubject = BehaviorSubject<List<Categories_Data>>();
  final getSortAllCategoriesSubject = BehaviorSubject<List<Categories_Data>>();

  final getSortAllSubCategories = BehaviorSubject<List<SubCategories>>();
  final getSortAllSubSubCategories = BehaviorSubject<List<SubSubCategories>>();

  Future<void> fetchDataAllCategories(int id) async {
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
      if (res.statusCode == 200 && res.data['status'] == 200) {
        // for (var obj in res.data['data']) {
        //   categoriesData.add(Categories_Data.fromJson(obj));
        // }
        for (var obj in res.data['data']) {
          Categories_Data categories_data = Categories_Data.fromJson(obj);
          if (categories_data.id == id) {
            selectCategoriesSubject.sink.add(categories_data);
            selectedSubCategories.sink.add(categories_data.sub_categories![0]);
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

  final selectedLanguage = BehaviorSubject<Languages>();
  final allCountriesSubject = BehaviorSubject<List<CountriesData>>();
  final allSortCountriesSubject = BehaviorSubject<List<CountriesData>>();

  final allLanguageSubject = BehaviorSubject<List<Languages>>();
  final allCitiesSubject = BehaviorSubject<List<CitiesData>>();
  final allDefultLanguageSubject = BehaviorSubject<String>();
  Future<void> fetchAllCountries(int id) async {
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

      if (res.statusCode == 200) {
        for (var obj in res.data['data']['countries']) {
          CountriesData country = CountriesData.fromJson(obj);
          // if(country.id == id){
          //   selectedCountry.sink.add(country);
          //   selectedCities.sink.add(country.cities[0]);
          // }
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

  final imageCompanyController = BehaviorSubject<File>();
  final avatarController = BehaviorSubject<File>();
  TextEditingController faxController = TextEditingController();
  final BehaviorSubject<bool> faxSubject = BehaviorSubject<bool>();

  TextEditingController mobileController = TextEditingController();
  final BehaviorSubject<bool> mobileSubject = BehaviorSubject<bool>();

  changeMobile(String val) =>
      mobileSubject.sink.add(validateText(mobileController));

  TextEditingController mobile2Controller = TextEditingController();
  final BehaviorSubject<bool> mobile2Subject = BehaviorSubject<bool>();

  changeMobile2(String val) =>
      mobile2Subject.sink.add(validateText(mobile2Controller));
  changeFax(String val) => faxSubject.sink.add(validateText(faxController));
  Future<void> confirmSignUp(BuildContext context) async {
    if (validatePassword(confirmePasswordController) &&
        validatePassword(passwordController)) {
      final PackgDio.FormData formData = PackgDio.FormData.fromMap({
        'password': passwordController.text,
        //"name": nameController.text,
        'password_confirmation': confirmePasswordController.text,
        // "default_lang": selectedLanguage.value != null?selectedLanguage.value.code:allDefultLanguageSubject.value,
        'default_lang': await _helper.getCodeLang() ?? 'ar',
        // "national_id": nationalIDController.text,
        'type': 'Company',
        //"phone": userPhoneController.text,
        //"birth_date": DateFormat('dd-MM-yyyy').format(birthDateSubject.value),
        //"gender": genderSubject.value,
        'name_en': nameCompanyLang1Controller.text,
        'desc_en': desLang1Controller.text,
        'address_en': addressController.text,
        'phone1': phoneController.text,
        'phone2': mobile2Controller.text,
        'tel': mobileController.text,
        //"fax": faxController.text,
        'email': emailOrPhoneController.text,
        'open_from': workTimeSubjectFrom.value,
        'open_to': workTimeSubjectTo.value,
        'week_from': workDaysSubjectFrom.value,
        'week_to': workDaysSubjectTo.value,
        'lat': latSubject.value,
        'lng': longSubject.value,
        'source': SourceDevice,
      });

      // if (codeAfflatorController.text.isNotEmpty) {
      //   formData.fields.add(
      //       MapEntry('affilate_code', '${codeAfflatorController.text}')
      //   );
      // }

      if (imageCompanyController.value != null) {
        var img = await PackgDio.MultipartFile.fromFileSync(
            imageCompanyController.value.path);
        formData.files.add(MapEntry('image', img));
      }
      if (avatarController.value != null) {
        var img = await PackgDio.MultipartFile.fromFileSync(
            avatarController.value.path);
        formData.files.add(MapEntry('avatar', img));
      }

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
      if (await FirebaseNotifications().generateFcmToken() != null) {
        formData.fields.add(MapEntry(
            'fcm_token', await FirebaseNotifications().generateFcmToken()));
      }

      if (passwordController.text == confirmePasswordController.text) {
        try {
          String lang = await _helper.getCodeLang();
          int? countryID = await _helper.getCountryId();
          print('do rregester');
          print('do ${formData}');
          final res = await _dio.post(
            '/registers/store-company?country_id=$countryID',
            options: Options(
              headers: {'lang': '$lang'},
            ),
            data: formData,
          );
          print('do ${res.data}');
          if (res.statusCode == 200 && res.data['status'] == 200) {
            // await _helper.setToken(res.data['token']);
            await _helper.setEmail(emailOrPhoneController.text);
            // await _helper.setName(nameController.text);
            // await _helper.setType('Company');
            await _helper.setToken(res.data['data']['token']);
            await _helper.setType(res.data['data']['type']);
            await _helper.setName(res.data['data']['name']);
            await _helper.setCode(res.data['data']['code']);
            await _helper.setMarketer(res.data['data']['marketer_id']);
            await _helper.setAvatar(res.data['data']['avatar']);
            await _helper.setActive(res.data['data']['active']);
            await _helper
                .setActivationMessage(res.data['data']['activation_message']);
            // await _helper.setFirst(res.data['data']['first']);activation_message
            await _helper.setDefaultLang(allDefultLanguageSubject.value);
            //
            // await _helper.setName(res.data['data']['name']);
            // await _helper.setCode(res.data['data']['code']);
            // await _helper.setAvatar(res.data['data']['avatar']);
            // await _helper.setDefaultLang(await _helper.getDefaultLang());

            await Get.to(PayPlansScreen(
              company_id: res.data['data']['company_id'],
              typeAdsOrPlan: 0,
            ));
            // await Get.snackbar(
            //   null,
            //   '${res.data['message']}',
            //   icon: GestureDetector(
            //       onTap: () => Get.back(),
            //       child: Icon(
            //         Icons.check_circle,
            //         color: Colors.black,
            //       )),
            //   colorText: Colors.black,
            //   backgroundColor: Colors.green.withOpacity(0.9),
            //   snackPosition: SnackPosition.BOTTOM,
            // );

            // await Get.offAll(BottomNavBar());

          } else if (res.data['status'] == 500) {
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
          } else if (res.data['status'] == 300) {
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
      } else {
        await showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return ShowMessageDialog(
              type: 400,
              message: 'text_pass_not_similer'.tr,
              show_but: true,
            );
          },
        );
      }
    } else {
      passwordSubject.sink.add(validatePassword(passwordController));
      confirmePasswordSubject.sink
          .add(validatePassword(confirmePasswordController));
    }
  }

  Future<void> accountDealerPageOne(
      BuildContext context, RegisterMerchantBloc bloc) async {
    if (validateText(nameCompanyLang1Controller) &&
        validateText(desLang1Controller) &&
        validateText(addressController) &&
        validateText(phoneController)) {
      await Get.to(AccountInformationMerchantPageTwoScreen(
        bloc: bloc,
      ));
    } else {
      nameCompanyLang1Subject.sink
          .add(validateText(nameCompanyLang1Controller));
      desLang1Subject.sink.add(validateText(desLang1Controller));
      addressSubject.sink.add(validateText(addressController));
      phoneSubject.sink.add(validateText(phoneController));
    }
  }

  Future<void> accountDealerPageTwo(
      BuildContext context, RegisterMerchantBloc bloc) async {
    if (selectedCountry.value == null || selectedCities.value == null) {
      // Get.snackbar(null, 'اختر صورة  ثم حاول مرة اخري',
      //     snackPosition: SnackPosition.BOTTOM);
      await showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return ShowMessageDialog(
            type: 400,
            message: 'text_select_country_msg'.tr,
            show_but: true,
          );
        },
      );
      return;
    } else if (selectedSubCategories.value == null ||
        selectCategoriesSubject.value == null) {
      // Get.snackbar(null, 'اختر صورة  ثم حاول مرة اخري',
      //     snackPosition: SnackPosition.BOTTOM);
      await showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return ShowMessageDialog(
            type: 400,
            message: 'text_select_categore_msg'.tr,
            show_but: true,
          );
        },
      );
      return;
    } else if (workTimeSubjectFrom.value == null ||
        workTimeSubjectTo.value == null) {
      // Get.snackbar(null, 'اختر صورة  ثم حاول مرة اخري',
      //     snackPosition: SnackPosition.BOTTOM);
      await showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return ShowMessageDialog(
            type: 400,
            message: 'text_select_time_msg'.tr,
            show_but: true,
          );
        },
      );
      return;
    } else {
      await Get.to(AccountInformationMerchantPageThreeScreen(
        bloc: bloc,
      ));
    }
  }

  dispose() async {
    await emailOrPhoneSubject.stream.drain();
    await emailOrPhoneSubject.close();
    await passwordSubject.stream.drain();
    await passwordSubject.close();
    await obscurePasswordSubject.stream.drain();
    await obscurePasswordSubject.close();
    emailOrPhoneController.dispose();
    passwordController.dispose();
    await tapBarSubject.stream.drain();
    await tapBarSubject.close();
    await longSubject.stream.drain();
    await longSubject.close();
    await latSubject.stream.drain();
    await latSubject.close();
    await languageSubject.stream.drain();
    await languageSubject.close();
    await genderSubject.stream.drain();
    await genderSubject.close();
    await kindCompanySubject.stream.drain();
    await kindCompanySubject.close();
    await birthDateSubject.stream.drain();
    await birthDateSubject.close();
    await nameSubject.stream.drain();
    await nameSubject.close();
    await nameCompanyLang1Subject.stream.drain();
    await nameCompanyLang1Subject.close();
    await desLang1Subject.stream.drain();
    await desLang1Subject.close();
    await desLang2Subject.stream.drain();
    await desLang2Subject.close();
    await nameCompanyLang2Subject.stream.drain();
    await nameCompanyLang2Subject.close();
    await nationalIDSubject.stream.drain();
    await nationalIDSubject.close();
    await emailOrPhoneSubject.stream.drain();
    await emailOrPhoneSubject.close();
    await passwordSubject.stream.drain();
    await passwordSubject.close();
    await obscurePasswordSubject.stream.drain();
    await obscurePasswordSubject.close();
    await confirmePasswordSubject.stream.drain();
    await confirmePasswordSubject.close();
    await phoneSubject.stream.drain();
    await phoneSubject.close();
    await socialSubject.stream.drain();
    await socialSubject.close();
    emailOrPhoneController.dispose();
    passwordController.dispose();
    confirmePasswordController.dispose();
    phoneController.dispose();
  }

  Future<DateTime?> _gatDateFromPicker(BuildContext context) async {
    return await showDatePicker(
      locale: Locale('${Get.locale}'),
      context: context,
      initialDate: DateTime.now().subtract(
        const Duration(days: 1),
      ),
      firstDate: DateTime.now().subtract(
        const Duration(days: 45000),
      ),
      lastDate: DateTime.now().subtract(
        const Duration(days: 1),
      ),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData().copyWith(
            colorScheme: const ColorScheme.light(
              primary: kAccentColor,
            ),
          ),
          child: child!,
        );
      },
    );
  }
}
