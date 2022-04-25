import 'dart:io';

import 'package:al_murafiq/components/firebase_notifications.dart';
import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/models/countries.dart';
import 'package:al_murafiq/screens/home_page/home_page.dart';
import 'package:al_murafiq/screens/home_page/nav_bar.dart';
import 'package:al_murafiq/widgets/show_message_dialog.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as PackgDio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:rxdart/rxdart.dart';
import 'package:intl/intl.dart';

class RegisterUserBloc {
  final Dio _dio = GetIt.instance.get<Dio>();
  SharedPreferenceHelper _helper = GetIt.instance.get<SharedPreferenceHelper>();
  final BehaviorSubject<int> tapBarSubject = BehaviorSubject<int>.seeded(0);
  final BehaviorSubject<String> languageSubject =
      BehaviorSubject<String>.seeded('en');

  Function(String) get languageChanged => languageSubject.sink.add;

  final BehaviorSubject<String> genderSubject =
      BehaviorSubject<String>.seeded('Male'.tr);

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
  final BehaviorSubject<bool> nameSubject = BehaviorSubject<bool>();

  TextEditingController nationalIDController = TextEditingController();
  final BehaviorSubject<bool> nationalIDSubject = BehaviorSubject<bool>();

  changeNationalID(String val) =>
      nationalIDSubject.sink.add(validateNationalID(nationalIDController));
  validateNationalID(TextEditingController controller) {
    return (phoneExp.hasMatch(controller.text) || controller.text.length >= 14);
  }

  changeName(String val) => nameSubject.sink.add(validateText(nameController));

  validateText(TextEditingController controller) {
    return controller.text.isNotEmpty;
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

  final BehaviorSubject<dynamic> longSubject =
      BehaviorSubject<dynamic>.seeded(0.0);
  final BehaviorSubject<dynamic> latSubject =
      BehaviorSubject<dynamic>.seeded(0.0);
  final avatarController = BehaviorSubject<File>();

  Future<void> confirmSignUp(BuildContext context) async {
    if (validateEmailOrPhone(emailOrPhoneController) &&
        validatePassword(passwordController) &&
        validateText(phoneController) &&
        validateText(nameController)) {
      // if (avatarController.value==null) {
      //   Get.snackbar(null, 'اختر صورة  ثم حاول مرة اخري',
      //       snackPosition: SnackPosition.BOTTOM);
      //   return false;
      // }
      if (selectedCountry.value == null || selectedCities.value == null) {
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
      }
      final PackgDio.FormData formData = PackgDio.FormData.fromMap({
        "email": emailOrPhoneController.text,
        "password": passwordController.text,
        "name": nameController.text,
        'password_confirmation': confirmePasswordController.text,
        // "default_lang": selectedLanguage.value != null?selectedLanguage.value.code:allDefultLanguageSubject.value,
        'default_lang': await _helper.getCodeLang() ?? 'ar',
        "phone": phoneController.text,
        "type": 'Customer',
        "birth_date": DateFormat('dd-MM-yyyy').format(birthDateSubject.value),
        "gender": genderSubject.value,
        'lat': await _helper.getLat(),
        'lng': await _helper.getLng(),
        'source': SourceDevice,
      });
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
      if (await FirebaseNotifications().generateFcmToken() != null) {
        formData.fields.add(MapEntry(
            'fcm_token', await FirebaseNotifications().generateFcmToken()));
      }
      if (passwordController.text == confirmePasswordController.text) {
        try {
          String lang = await _helper.getCodeLang();
          int? countryID = await _helper.getCountryId();
          final res = await _dio.post(
            '/registers/store?country_id=$countryID',
            options: Options(
              headers: {'lang': '$lang'},
            ),
            data: formData,
          );
          if (res.statusCode == 200 && res.data['status'] == 200) {
            // await _helper.setToken(res.data['token']);
            await _helper.setEmail(emailOrPhoneController.text);
            // await _helper.setName(nameController.text);
            // await _helper.setType('Customer');
            await _helper.setToken(res.data['data']['token']);
            await _helper.setType(res.data['data']['type']);
            await _helper.setName(res.data['data']['name']);
            await _helper.setCode(res.data['data']['code']);
            await _helper.setMarketer(res.data['data']['marketer_id']);
            await _helper.setAvatar(res.data['data']['avatar']);
            await _helper.setDefaultLang(allDefultLanguageSubject.value);
            // await _helper.setDefaultLang(await _helper.getDefaultLang());
            await Get.offAll(BottomNavBar());
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
              message: 'text_p_select_photo'.tr,
              show_but: true,
            );
          },
        );
      }
    } else {
      emailOrPhoneSubject.sink
          .add(validateEmailOrPhone(emailOrPhoneController));
      passwordSubject.sink.add(validatePassword(passwordController));
      confirmePasswordSubject.sink
          .add(validatePassword(confirmePasswordController));
      phoneSubject.sink.add(validateText(phoneController));
      nameSubject.sink.add(validateText(nameController));
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
      await languageSubject.stream.drain();
      await languageSubject.close();
      await genderSubject.stream.drain();
      await genderSubject.close();
      await birthDateSubject.stream.drain();
      await birthDateSubject.close();
      await nameSubject.stream.drain();
      await nameSubject.close();
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
      emailOrPhoneController.dispose();
      passwordController.dispose();
      confirmePasswordController.dispose();
      phoneController.dispose();
    }
  }

  final selectedLanguage = BehaviorSubject<Languages>();
  final allCountriesSubject = BehaviorSubject<List<CountriesData>>();
  final selectedCountry = BehaviorSubject<CountriesData>();
  final selectedCities = BehaviorSubject<CitiesData>();
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
          if (selectedCountry.value != null) {
            if (country.id == selectedCountry.value.id) {
              selectedCountry.sink.add(country);
              for (var objCity in selectedCountry.value.cities!) {
                if (objCity.id == selectedCities.value.id) {
                  selectedCities.sink.add(objCity);
                }
              }
              print('cityid ${selectedCountry.value.cities!.length}');
              // selectedCities.sink.add(country.cities[0]);
            }
          }

          countries.add(country);
        }
        for (var obj in res.data['data']['language']) {
          languages.add(Languages.fromJson(obj));
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

  Future<DateTime?> _gatDateFromPicker(BuildContext context) async {
    return await showDatePicker(
      context: context,

      //locale : Get.locale,${Get.locale}
      locale: Locale('${Get.locale}'),
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
