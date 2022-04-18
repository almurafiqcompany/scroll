import 'dart:io';

import 'package:al_murafiq/widgets/show_loading_alert.dart';
import 'package:al_murafiq/widgets/show_message_dialog.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as DioPacage;
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:rxdart/rxdart.dart';
import 'package:al_murafiq/models/profile_compaine.dart';
import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:dio/dio.dart' as PackgDio;

class ProfileCompanyBloc {
  Dio _dio = GetIt.instance.get<Dio>();
  SharedPreferenceHelper _helper = GetIt.instance.get<SharedPreferenceHelper>();
  final dataOfProfileCompanySubject = BehaviorSubject<ProfileCompany>();
  final dataOfPhotosSubject = BehaviorSubject<List<Files>>();
  final showCommentSubject = BehaviorSubject<bool>.seeded(false);
  final fileController = BehaviorSubject<File>();
  final imgController = BehaviorSubject<File>();
  RoundedLoadingButtonController loadingButtonController =
      RoundedLoadingButtonController();
  Future<void> fetchDataProfileCompany(int companyId, bool flagBranch,int ad_id,BuildContext context) async {
    try {
      String lang = await _helper.getCodeLang();
      String token = await _helper.getToken();
      String code = await _helper.getCode();
      final res = await _dio.get(
        flagBranch
            ? '/companies/show-profile?id=$companyId&user_id=$code'
            : '/companies/show?id=$companyId&ad_id=$ad_id&user_id=$code',
        options: Options(
          // ignore: unnecessary_string_interpolations
          headers: {'Authorization': 'Bearer $token', 'lang': '$lang'},
        ),
      );
      print('code $code ');
      print('code ${res.data} ');
      if (res.statusCode == 200 && res.data['status'] == 200) {
        dataOfProfileCompanySubject.sink
            .add(ProfileCompany.fromJson(res.data['data']));
        final List<Files> files = [];
        for (var file in res.data['data']['files']) {
          files.add(Files.fromJson(file));
        }
        dataOfPhotosSubject.sink.add(files);
        if (res.data['data']['closed_reason'] != null) {
          await showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return ShowMessageDialog(
                type: 400,
                message: '${res.data['data']['closed_reason']}',
                show_but: true,
              );
            },
          );
        }

      } else if (res.data['status'] == 500) {
        dataOfProfileCompanySubject.sink.addError(res.data['message']);
      } else if (res.data['status'] == 400) {
        dataOfProfileCompanySubject.sink.addError(res.data['message']);
      }
    } catch (e) {
      dataOfProfileCompanySubject.sink.addError('');
    }
  }

  final favCompanySubject = BehaviorSubject<int>();
  final favCompanyLoadingSubject = BehaviorSubject<bool>();
  final disFavCompanyLoadingSubject = BehaviorSubject<bool>();
  Future<void> favCompany(int companyId, BuildContext context) async {
    try {
      showAlertDialog(context);

      String lang = await _helper.getCodeLang();
      int countryID = await _helper.getCountryId();
      String token = await _helper.getToken();
      final res = await _dio.post('/wishlists/store?country_id=$countryID',
          options: Options(
            headers: {'Authorization': 'Bearer $token'
              , 'lang': '$lang'},
          ),
          data: {'company_id': companyId});
       Get.back();
      if (res.statusCode == 200 && res.data['status'] == 200) {

        favCompanyLoadingSubject.sink.add(true);
        favCompanySubject.sink.add(1);
        // await showModalBottomSheet<void>(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return ShowMessageDialog(
        //       type: 200,
        //       message: '${res.data['message']}',
        //       show_but: true,
        //     );
        //   },
        // );
      } else if (res.data['status'] == 500) {
        // Get.snackbar(
        //   null,
        //   '${res.data['message']}',
        //   icon: GestureDetector(
        //       onTap: () => Get.back(),
        //       child: Icon(
        //         Icons.close,
        //         color: Colors.black,
        //       )),
        //   colorText: Colors.black,
        //   backgroundColor: Colors.red.withOpacity(0.8),
        //   duration: Duration(seconds: 60),
        //   snackPosition: SnackPosition.BOTTOM,
        // );
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
      Get.back();
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
  }

  Future<bool> likeComment(int commentId, BuildContext context) async {
    try {


      showAlertDialog(context);

      final PackgDio.FormData formData = PackgDio.FormData.fromMap({
        'review_id': commentId,
      });
      String lang = await _helper.getCodeLang();
      int countryID = await _helper.getCountryId();
      String token = await _helper.getToken();
      final res = await _dio.post('/reviews/like?country_id=$countryID',
          options: Options(
            headers: {'Authorization': 'Bearer $token', 'lang': '$lang'},
          ),
          data: formData);
      Get.back();
      if (res.statusCode == 200 && res.data['status'] == 200) {

        // await showModalBottomSheet<void>(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return ShowMessageDialog(
        //       type: 200,
        //       message: '${res.data['message']}',
        //       show_but: true,
        //     );
        //   },
        // );
        return true;
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
      }
      return false;
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      Get.back();
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
      return false;
    }
  }

  Future<bool> dislikeComment(int commentId, BuildContext context) async {
    try {


      showAlertDialog(context);
      final PackgDio.FormData formData = PackgDio.FormData.fromMap({
        'review_id': commentId,
        'reson': reportController.text,
      });
      String lang = await _helper.getCodeLang();
      int countryID = await _helper.getCountryId();
      String token = await _helper.getToken();
      final res = await _dio.post('/reviews/dislike?country_id=$countryID',
          options: Options(
            headers: {'Authorization': 'Bearer $token', 'lang': '$lang'},
          ),
          data: formData);

      Get.back();
      if (res.statusCode == 200 && res.data['status'] == 200) {
        // await showModalBottomSheet<void>(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return ShowMessageDialog(
        //       type: 200,
        //       message: '${res.data['message']}',
        //       show_but: true,
        //     );
        //   },
        // );
        return true;
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
      }
      return false;
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      Get.back();
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
      return false;
    }
  }

  final loadImgSubject = BehaviorSubject<bool>();
  final loadFileSubject = BehaviorSubject<bool>();
  Future<void> uploadFile(
      {int companyId, String type, BuildContext context}) async {
    try {

      showAlertDialog(context);
      String lang = await _helper.getCodeLang();
      int countryID = await _helper.getCountryId();
      String token = await _helper.getToken();
      final DioPacage.FormData formData = DioPacage.FormData.fromMap({
        'source': type == 'pdf'
            ? DioPacage.MultipartFile.fromFileSync(fileController.value.path)
            : DioPacage.MultipartFile.fromFileSync(imgController.value.path),
        'type': '$type',
        'id': companyId,
      });
      final res = await _dio.post('/files/store?country_id=$countryID&',
          options: Options(
            headers: {'Authorization': 'Bearer $token', 'lang': '$lang'},
          ),
          data: formData);

      Get.back();
      if (res.statusCode == 200 && res.data['status'] == 200) {

        type == 'pdf'
            ? loadFileSubject.sink.add(true)
            : loadImgSubject.sink.add(true);

        await showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return ShowMessageDialog(
              type: 200,
              message: '${res.data['message']}',
              show_but: true,
            );
          },
        );
      } else if (res.data['status'] == 500) {
        type == 'pdf'
            ? loadFileSubject.sink.add(false)
            : loadImgSubject.sink.add(false);

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

      type == 'pdf'
          ? loadFileSubject.sink.add(false)
          : loadImgSubject.sink.add(false);
      Get.back();
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
  }

  Future<void> imageDestroyOfCompany(
      {int file_id, int company_id, BuildContext context}) async {
    try {

      showAlertDialog(context);
      String token = await _helper.getToken();
      String lang = await _helper.getCodeLang();
      int countryID = await _helper.getCountryId();
      final res = await _dio.delete(
        '/files/destroy?id=$company_id&file_id=$file_id&country_id=$countryID',
        options: DioPacage.Options(
          headers: {'Authorization': 'Bearer $token', 'lang': '$lang'},
        ),
      );

      Get.back();
      if (res.statusCode == 200 && res.data['status'] == 200) {
        dataOfPhotosSubject.sink.add(
            dataOfPhotosSubject.value..removeWhere((ele) => ele.id == file_id));
        await showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return ShowMessageDialog(
              type: 200,
              message: '${res.data['message']}',
              show_but: true,
            );
          },
        );
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
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {

      Get.back();
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
  }

  Future<void> favDesCompany(int companyId, BuildContext context) async {
    try {

      showAlertDialog(context);

      String token = await _helper.getToken();
      String lang = await _helper.getCodeLang();
      final res = await _dio.delete(
        '/wishlists/destroy?company_id=$companyId',
        options: Options(
          headers: {'Authorization': 'Bearer $token', 'lang': '$lang'},
        ),
      );

      Get.back();
      if (res.statusCode == 200 && res.data['status'] == 200) {
        disFavCompanyLoadingSubject.sink.add(true);
        favCompanySubject.sink.add(0);
        // await showModalBottomSheet<void>(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return ShowMessageDialog(
        //       type: 200,
        //       message: '${res.data['message']}',
        //       show_but: true,
        //     );
        //   },
        // );
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
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      Get.back();
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
  }

  final commentSubject = BehaviorSubject<bool>();
  final reportSubject = BehaviorSubject<bool>();
  final rateSubject = BehaviorSubject<dynamic>.seeded(0.0);
  TextEditingController commentController = TextEditingController();
  TextEditingController reportController = TextEditingController();
  changeReport(String val) =>
      reportSubject.sink.add(validateText(reportController));

  changeComment(String val) =>
      commentSubject.sink.add(validateText(commentController));
  validateText(TextEditingController controller) {
    return controller.text.isNotEmpty;
  }
  //_bloc.rateSubject
  Future<bool> commentToCompany(int companyId, BuildContext context) async {
    // if (validateText(commentController)) {
    print('rate ${rateSubject.value}');
    if (rateSubject.value >0) {
      try {
        showAlertDialog(context);
        String token = await _helper.getToken();
        final DioPacage.FormData formData = DioPacage.FormData.fromMap({
          'company_id': companyId,
          'rate': rateSubject.value,
          'comment': commentController.text
        });

        String lang = await _helper.getCodeLang();
        int countryID = await _helper.getCountryId();
        final res = await _dio.post('/reviews/store?company_id=$companyId&country_id=$countryID',
            options: Options(
              headers: {'Authorization': 'Bearer $token', 'lang': '$lang'},
            ),
            data: formData);
        Get.back();
        if (res.statusCode == 200 && res.data['status'] == 200) {
          // for (var obj in res.data['data']) {
          //   homeData.add(HomePageData.fromJson(obj));
          // }


          // await showModalBottomSheet<void>(
          //   context: context,
          //   builder: (BuildContext context) {
          //     return ShowMessageDialog(
          //       type: 200,
          //       message: '${res.data['message']}',
          //       show_but: true,
          //     );
          //   },
          // );
          rateSubject.sink.add(0);
          commentController.text=null;
          showCommentSubject.sink.add(true);
          return true;
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
          return false;
        } else {

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

          return false;
        }
        // ignore: avoid_catches_without_on_clauses
      } catch (e) {

        Get.back();
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
        return false;
      }
    }
    else {
      //Get.snackbar(null, 'enter comment', snackPosition: SnackPosition.BOTTOM);
      await showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return ShowMessageDialog(
            type: 400,
            message: 'enter_rate'.tr,
            show_but: true,
          );
        },
      );
      return false;
    }
  }

  dispose() async {
    await dataOfProfileCompanySubject.stream.drain();
    dataOfProfileCompanySubject.close();
  }
}
