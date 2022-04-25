import 'package:get/get.dart' as gett;
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:al_murafiq/screens/home_page/nav_bar.dart';
import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LogoutBloc {
  Dio _dio = GetIt.instance.get<Dio>();

  SharedPreferenceHelper _helper = GetIt.instance.get<SharedPreferenceHelper>();

  Future<void> logOut() async {
    try {
      String? token = await _helper.getToken();

      String lang = await _helper.getCodeLang();
      int? countryID = await _helper.getCountryId();

      final Response res = await _dio.post(
        '/logout?country_id=$countryID',
        options: Options(
          headers: {"Authorization": "Bearer $token", 'lang': '$lang'},
        ),
      );

      if (res.statusCode == 200 && res.data['status'] == 200) {
        // await _helper.cleanData();
        await _helper.setToken(null!);
        await _helper.setAvatar(null!);
        await _helper.setCode(null!);
        await _helper.setType(null!);
        await _helper.setActive(-1);

        // try{
        //
        //   final facebookLogin = FacebookLogin();
        //   facebookLogin.logOut();
        //   print('logout facebook');
        // }catch(e){}

        try {
          GoogleSignIn _googleSignIn = GoogleSignIn(
            scopes: [
              'email',
            ],
          );
          await _googleSignIn.signOut();
          print('logout google');
        } catch (e) {}

        await gett.Get.offAll(BottomNavBar());
      } else {
        gett.Get.snackbar(null!, '${res.data['message']}',
            snackPosition: gett.SnackPosition.BOTTOM);
      }
    } catch (e) {
      gett.Get.snackbar(null!, 'e'.tr,
          snackPosition: gett.SnackPosition.BOTTOM);
    }
  }
}
