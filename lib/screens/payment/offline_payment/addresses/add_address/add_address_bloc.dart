import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/models/categories.dart';
import 'package:al_murafiq/models/countries.dart';
import 'package:al_murafiq/screens/home_page/nav_bar.dart';
import 'package:al_murafiq/screens/payment/check_out.dart';
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
import 'package:al_murafiq/models/payment_plans.dart';

class AddAddressBloc {
  final Dio _dio = GetIt.instance.get<Dio>();
  SharedPreferenceHelper _helper = GetIt.instance.get<SharedPreferenceHelper>();

  RoundedLoadingButtonController loadingButtonController =
      RoundedLoadingButtonController();

  validateText(TextEditingController controller) {
    return controller.text.isNotEmpty;
  }

  TextEditingController addressController = TextEditingController();
  final BehaviorSubject<bool> addressSubject = BehaviorSubject<bool>();

  changeAdress(String val) =>
      addressSubject.sink.add(validateText(addressController));

  TextEditingController specialMarkController = TextEditingController();
  final BehaviorSubject<bool> specialMarkSubject = BehaviorSubject<bool>();

  changeSpecialMark(String val) =>
      specialMarkSubject.sink.add(validateText(specialMarkController));

  TextEditingController phoneController = TextEditingController();
  final BehaviorSubject<bool> phoneSubject = BehaviorSubject<bool>();

  changePhone(String val) =>
      phoneSubject.sink.add(validateText(phoneController));

  Future<void> confirmAddAddress(
      {dynamic lat,
      dynamic lng,
      final int? company_id,
      int? pay_method_id,
      int? way_pay_id,
      BuildContext? context,
      PaymentPlans? paymentPlans}) async {
    if (validateText(addressController) && validateText(phoneController)) {
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
      final PackgDio.FormData formData = PackgDio.FormData.fromMap({
        "address_details": addressController.text,
        "phone": phoneController.text,
        "special_mark": specialMarkController.text,
        "lat": lat,
        "lng": lng,
      });

      if (selectedCountry.value != null) {
        formData.fields
            .add(MapEntry('country_id', '${selectedCountry.value.id}'));
      }
      if (selectedCities.value != null) {
        formData.fields.add(MapEntry('city_id', '${selectedCities.value.id}'));
      }

      try {
        String lang = await _helper.getCodeLang();
        String? token = await _helper.getToken();
        int? countryID = await _helper.getCountryId();

        final res = await _dio.post(
          '/addresses/store?country_id=$countryID',
          options: Options(
            headers: {
              "Authorization": "Bearer $token",
              // 'Content-Type' :"multipart/form-data",
              'lang': '$lang'
            },
          ),
          data: formData,
        );
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
          await Get.to(CheckOut(
            type_payment: 'Cash',
            way_pay_id: way_pay_id,
            pay_method_id: pay_method_id,
            company_id: company_id,
            bank_or_address_id: res.data['data']['id'],
            paymentPlans: paymentPlans,
          ));
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
      phoneSubject.sink.add(validateText(phoneController));
      addressSubject.sink.add(validateText(addressController));
    }
  }

  final allCountriesSubject = BehaviorSubject<List<CountriesData>>();
  final allLanguageSubject = BehaviorSubject<List<Languages>>();
  final allCitiesSubject = BehaviorSubject<List<CitiesData>>();
  final allDefultLanguageSubject = BehaviorSubject<String>();

  final selectedCountry = BehaviorSubject<CountriesData>();
  final selectedLanguage = BehaviorSubject<Languages>();
  final selectedCities = BehaviorSubject<CitiesData>();
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
          if (country.id == id) {
            selectedCountry.sink.add(country);
            selectedCities.sink.add(country.cities![0]);
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

  final getAllCategoriesSubject = BehaviorSubject<List<Categories_Data>>();
  final selectCategoriesSubject = BehaviorSubject<Categories_Data>();
  final selectedSubCategories = BehaviorSubject<SubCategories>();

  dispose() async {
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
    phoneController.dispose();
  }
}
