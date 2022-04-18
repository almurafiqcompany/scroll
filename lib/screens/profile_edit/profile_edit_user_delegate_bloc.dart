import 'dart:io';

import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/models/countries.dart';
import 'package:al_murafiq/models/profile_edit.dart';
import 'package:al_murafiq/screens/home_page/home_page.dart';
import 'package:al_murafiq/screens/home_page/nav_bar.dart';
import 'package:al_murafiq/widgets/show_loading_alert.dart';
import 'package:al_murafiq/widgets/show_message_dialog.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as PackgDio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:rxdart/rxdart.dart';
import 'package:intl/intl.dart';

class ProfileEditUserAndDelegateBloc {
  final Dio _dio = GetIt.instance.get<Dio>();
  SharedPreferenceHelper _helper = GetIt.instance.get<SharedPreferenceHelper>();

  RoundedLoadingButtonController loadingButtonController =
      RoundedLoadingButtonController();

  final BehaviorSubject<String> genderSubject =
      BehaviorSubject<String>.seeded('Male'.tr);

  Function(String) get genderChanged => genderSubject.sink.add;

  final BehaviorSubject<String> languageSubject =
      BehaviorSubject<String>.seeded('en');

  Function(String) get languageChanged => languageSubject.sink.add;

  final BehaviorSubject<DateTime> birthDateSubject =
      BehaviorSubject<DateTime>.seeded(DateTime.now());

  Future<void> birthDateChanged(BuildContext context) async {
    final DateTime dateTime = await _gatDateFromPicker(context);
    if (dateTime != null) {
      birthDateSubject.add(dateTime);
    }
  }

  TextEditingController nameController = TextEditingController();
  final BehaviorSubject<bool> nameSubject = BehaviorSubject<bool>();

  changeName(String val) => nameSubject.sink.add(validateText(nameController));

  validateText(TextEditingController controller) {
    return controller.text.isNotEmpty;
  }
  TextEditingController nationalIDController = TextEditingController();
  final BehaviorSubject<bool> nationalIDSubject = BehaviorSubject<bool>();

  changeNationalID(String val) =>
      nationalIDSubject.sink.add(validateNationalID(nationalIDController));
  validateNationalID(TextEditingController controller) {
    return (phoneExp.hasMatch(controller.text) || controller.text.length >= 14);
  }
  final BehaviorSubject<bool> emailOrPhoneSubject = BehaviorSubject<bool>();
  final BehaviorSubject<bool> passwordSubject =
      BehaviorSubject<bool>.seeded(true);

  TextEditingController emailOrPhoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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

  final imageController = BehaviorSubject<File>();
  Future<void> confirmEditProfileUserAndDelegate({BuildContext context,bool bedelegate}) async {
    if (validateEmailOrPhone(emailOrPhoneController) &&
        validateText(nameController) &&
        validateText(phoneController)) {
      final PackgDio.FormData formData = PackgDio.FormData.fromMap({
        "email": emailOrPhoneController.text,
        "name": nameController.text,
        // "default_lang": languageSubject.value,
        "phone": phoneController.text,
        // "national_id": nationalIDController.text,
        // "country_id": await _helper.getCountryId(),
        //"country_id": 1,
        // "city_id": 1,
        // "area_id": 1,
        // "zone_id": 1,
        // "type": 'Customer',
        // "birth_date": DateFormat('dd-MM-yyyy').format(birthDateSubject.value),
        // "gender": genderSubject.value,
      });
      if (imageController.value != null ) {
        var img=await PackgDio.MultipartFile.fromFileSync(imageController.value.path);
        formData.files.add(
            MapEntry('avatar', img)
        );
      }
      if (passwordController.text.isNotEmpty) {
        formData.fields.add(
          MapEntry('password', '${passwordController.text}')
        );
      }
      if (selectedLanguage.value != null ) {
        formData.fields.add(
          MapEntry('default_lang', '${selectedLanguage.value.code}')
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
      if (birthDateSubject.value != null ) {
        formData.fields.add(
          MapEntry('birth_date', DateFormat('dd-MM-yyyy').format(birthDateSubject.value))
        );
      }
      if (genderSubject.value != null ) {
        formData.fields.add(
          MapEntry('gender', genderSubject.value)
        );
      }
        try {
          String lang = await _helper.getCodeLang();
          String token = await _helper.getToken();
          int countryID = await _helper.getCountryId();
          final res = await _dio.post(
            bedelegate?'/become-affilator?country_id=$countryID':'/profiles/update?country_id=$countryID',
            options: Options(
              headers: {"Authorization": "Bearer $token",
                'lang': '$lang'},
            ),
            data: formData,
          );
          if (res.statusCode == 200 && res.data['status'] == 200) {

            if(bedelegate){

              await showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return ShowMessageDialog(type: 200,message: '${res.data['message']}',show_but: true,);
                },
              );
              await _helper.cleanData();
              await Get.offAll(BottomNavBar());
            }
            await _helper.setEmail(emailOrPhoneController.text);
            await _helper.setName(nameController.text);
            await _helper.setAvatar(res.data['data']['avatar']);
            // await _helper.setAvatar(nameController.text);
            // await _helper.setDefaultLang(await _helper.getDefaultLang());
            // await _helper.setDefaultLang(await _helper.getDefaultLang());
            if (selectedLanguage.value != null ) {
              await _helper.setDefaultLang(selectedLanguage.value.code);
          }

            await showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return ShowMessageDialog(type: 200,message: '${res.data['message']}',show_but: true,);
              },
            );
            // await Get.back();
            await Get.offAll(BottomNavBar(page: 4,));
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
      nameSubject.sink.add(validateText(nameController));
    }
  }

  final allCountriesSubject = BehaviorSubject<List<CountriesData>>();
  final allLanguageSubject = BehaviorSubject<List<Languages>>();
  final allCitiesSubject = BehaviorSubject<List<CitiesData>>();
  final allDefultLanguageSubject = BehaviorSubject<String>();

  final selectedCountry = BehaviorSubject<CountriesData>();
  final selectedLanguage = BehaviorSubject<Languages>();
  final selectedCities = BehaviorSubject<CitiesData>();
  Future<void> fetchAllCountries(int country_id,int city_id, String default_lang) async {
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
          if(country.id == country_id){
            selectedCountry.sink.add(country);
            for (var objCity in country.cities) {
              if(objCity.id ==city_id)
                 selectedCities.sink.add(objCity);
            }
          }
          countries.add(country);
        }
        for (var obj in res.data['data']['language']) {
          Languages language=Languages.fromJson(obj);
          if(language.code == default_lang){
            selectedLanguage.sink.add(language);
          }
          languages.add(language);
        }
        allCountriesSubject.sink.add(countries);
        allLanguageSubject.sink.add(languages);
        allDefultLanguageSubject.sink.add(res.data['data']['default_lang']);
      } else {
        allCountriesSubject.sink.addError('');
      }
    } catch (e) {
      allCountriesSubject.sink.addError('');
    }
  }

  final getProfileData = BehaviorSubject<ProfileEditUserAndDelegate>();
  Future<void> fetchProfileData(BuildContext context) async {
    try {
      String lang = await _helper.getCodeLang();
      String token = await _helper.getToken();
      int countryID = await _helper.getCountryId();
      final res = await _dio.get(
        '/profiles/show?country_id=$countryID',
        options: Options(
          headers: {"Authorization": "Bearer $token",
            'lang': '$lang'},
        ),
      );
      if (res.statusCode == 200 && res.data['status']==200) {
        showAlertDialog(context);
        ProfileEditUserAndDelegate profile = ProfileEditUserAndDelegate.fromJson(res.data['data']);
        getProfileData.sink.add(profile);
        await fetchAllCountries(profile.country_id,profile.city_id,profile.default_lang);
        nameController.text=profile.name;
        emailOrPhoneController.text=profile.email;
        phoneController.text=profile.phone;
        Get.back();
      } else {
        getProfileData.sink.addError('');
      }
    } catch (e) {
      getProfileData.sink.addError('');
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
    await languageSubject.stream.drain();
    await languageSubject.close();
    await genderSubject.stream.drain();
    await genderSubject.close();
    await birthDateSubject.stream.drain();
    await birthDateSubject.close();
    await nameSubject.stream.drain();
    await nameSubject.close();
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
    passwordController.dispose();
    confirmePasswordController.dispose();
    phoneController.dispose();
  }

  Future<DateTime> _gatDateFromPicker(BuildContext context) async {
    return await showDatePicker(
      locale:  Locale('${Get.locale}'),
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
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData().copyWith(
            colorScheme: const ColorScheme.light(
              primary: kAccentColor,
            ),
          ),
          child: child,
        );
      },
    );
  }
}
