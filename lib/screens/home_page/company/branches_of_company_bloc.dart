import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as DioPacage;
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:al_murafiq/models/branch.dart';
import 'package:al_murafiq/core/shared_pref_helper.dart';

class BranchesOfCompanyBloc {
  Dio _dio = GetIt.instance.get<Dio>();
  SharedPreferenceHelper _helper = GetIt.instance.get<SharedPreferenceHelper>();
  final dataOfBranchCompanySubject = BehaviorSubject<CompanyOfBranches>();
  Future<void> fetchDataOfBranchCompany() async {
    try {
      String lang = await _helper.getCodeLang();

      String? token = await _helper.getToken();
      int? countryID = await _helper.getCountryId();
      final res = await _dio.get(
        '/companies/branches?country_id=$countryID&type=0',
        options: Options(
          // ignore: unnecessary_string_interpolations
          headers: {'Authorization': 'Bearer $token', 'lang': '$lang'},
        ),
      );

      if (res.statusCode == 200 && res.data['status'] == 200) {
        dataOfBranchCompanySubject.sink
            .add(CompanyOfBranches.fromJson(res.data['data']));

      } else if (res.data['status'] == 500) {
        dataOfBranchCompanySubject.sink.addError(res.data['message']);
      }
    } catch (e) {
      dataOfBranchCompanySubject.sink.addError('');
    }
  }



  dispose() async {
    await dataOfBranchCompanySubject.stream.drain();
    dataOfBranchCompanySubject.close();
  }
}
