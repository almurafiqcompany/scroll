// import 'dart:async';

// import 'package:al_murafiq/components/firebase_notifications.dart';
// import 'package:al_murafiq/constants.dart';
// import 'package:al_murafiq/core/shared_pref_helper.dart';
// import 'package:al_murafiq/screens/home_page/nav_bar.dart';
// import 'package:al_murafiq/widgets/show_loading_alert.dart';
// import 'package:al_murafiq/widgets/show_message_dialog.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_login_facebook/flutter_login_facebook.dart';
// import 'package:get/get.dart';
// import 'package:get_it/get_it.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:rounded_loading_button/rounded_loading_button.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert' as JSON;
// import 'package:dio/dio.dart' as PackgDio;

//  import 'package:sign_in_with_apple/sign_in_with_apple.dart';

// class SocialLoginBlocc {

//   Map? userProfile;
//   final facebookLogin = FacebookLogin();
//   Dio _dio = GetIt.instance.get<Dio>();
//   SharedPreferenceHelper _helper = GetIt.instance.get<SharedPreferenceHelper>();

//   RoundedLoadingButtonController loadingButtonController =
//       RoundedLoadingButtonController();


//   GoogleSignIn _googleSignIn = GoogleSignIn(
//     scopes: [
//       'email',
//     ],
//   );

//   Future<void> googleSignIn(BuildContext context) async {

//     try {
//       var response = await _googleSignIn.signIn();
//        String fcm_token =await FirebaseNotifications().generateFcmToken();

//       print('profile ${response}');
//       final PackgDio.FormData formData = PackgDio.FormData.fromMap({
//         'email': response!.email,
//         'name': response.displayName,
//         'social_avatar': response.photoUrl,
//         'provider_id': response.id,
//         'provider': 'google',
//         'fcm_token': fcm_token,
//         'source': SourceDevice,
//       });
//       // var loginResponse = await locator<ApiService>().socialMediaLogin(map);
//       await confirmSocialLogin(formData: formData,context: context);

//       // return true;
//     } catch (error) {

//       print("google response is ${error}");
//     }

//   }

//   logoutFB(){
//     facebookLogin.logOut();
//     print('logg out');
//   }

//   loginWithFB(BuildContext context) async {
//     // final facebookLogin = FacebookLogin();
//     final result = await facebookLogin.logIn();

//     print('result ${result.status}');

//     switch (result.status) {
//       case FacebookLoginStatus.loggedIn:
//         final token = result.accessToken.token;
//         final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
//         final profile = JSON.jsonDecode(graphResponse.body);
//         String fcm_token =await FirebaseNotifications().generateFcmToken();

//         userProfile = profile;

//         // setState(() {
//         //   _isLoggedIn = true;
//         // });
//         print('profile ${userProfile}');
//         final PackgDio.FormData formData = PackgDio.FormData.fromMap({
//           'email': profile['email'],
//           'name': profile['name'],
//           'social_avatar': profile['picture']['data']['url'],
//           'provider_id': profile['id'],
//           'provider': 'facebook',
//           'fcm_token': fcm_token,
//           'source': SourceDevice,
//         });
//         print('profile ${profile['email'] }');
//         print('profile ${profile['name']}');
//         print('profile ${profile['id']}');
//         print('profile ${profile['picture']['data']['url']}');
//         await confirmSocialLogin(formData: formData,context: context);
//         break;

//       case FacebookLoginStatus.cancelledByUser:
//       // setState(() => _isLoggedIn = false );
//         break;
//       case FacebookLoginStatus.error:
//       //setState(() => _isLoggedIn = false );
//         break;
//     }
//   }

//   Future<void> signInWithApple(BuildContext context) async {


//      try {
//         final response = await SignInWithApple.getAppleIDCredential(
//           scopes: [
//             AppleIDAuthorizationScopes.email,
//             AppleIDAuthorizationScopes.fullName,
//           ],
//         );
//         String fcm_token =await FirebaseNotifications().generateFcmToken();

//         print('profile ${response}');
//         final PackgDio.FormData formData = PackgDio.FormData.fromMap({
//           'email': response.email,
//           'name': response.givenName,
//           'social_avatar': "https://presaveio.s3.amazonaws.com/uploads/NoImage/no_img.png",
//           'provider_id': response.authorizationCode,
//           'provider': 'apple',
//           'fcm_token': fcm_token,
//           'source': SourceDevice,
//         });
//         // var loginResponse = await locator<ApiService>().socialMediaLogin(map);
//         await confirmSocialLogin(formData: formData,context: context);

//         // return true;
//       } catch (error) {


//       }
//     }

//   Future<void> confirmSocialLogin({PackgDio.FormData formData,BuildContext context}) async {
//       try {
//         showAlertDialog(context);
//         String lang = await _helper.getCodeLang();
//         int countryID = await _helper.getCountryId();
//         final res = await _dio.post(
//           '/social-login?country_id=$countryID',
//           options: Options(
//             headers: {'lang': '$lang'},
//           ),
//           data: formData,
//         );
//         Get.back();
//         print('res ${res.data}');
//       if (res.statusCode == 200 && res.data['status'] == 200) {
//           await _helper.setToken(res.data['data']['token']);
//           await _helper.setType(res.data['data']['type']);
//           await _helper.setName(res.data['data']['name']);
//           await _helper.setCode(res.data['data']['code']);
//           await _helper.setMarketer(res.data['data']['marketer_id']);
//           await _helper.setAvatar(res.data['data']['avatar']);
//           // Get.snackbar(null, 'Success', snackPosition: SnackPosition.BOTTOM);

//           await Get.offAll(BottomNavBar());
//         } else if (res.data['status'] == 500) {

//           await showModalBottomSheet<void>(
//             context: context,
//             builder: (BuildContext context) {
//               return ShowMessageDialog(type: 400,message: '${res.data['message']}',show_but: true,);
//             },
//           );
//         }else if (res.data['status'] == 400) {

//           await showModalBottomSheet<void>(
//             context: context,
//             builder: (BuildContext context) {
//               return ShowMessageDialog(type: 400,message: '${res.data['message']}',show_but: true,);
//             },
//           );
//         }else if (res.data['status'] == 300) {
//           await showModalBottomSheet<void>(
//             context: context,
//             builder: (BuildContext context) {
//               return ShowMessageDialog(type: 400,message: '${res.data['message']}',show_but: true,);
//             },
//           );
//         }
//       // ignore: avoid_catches_without_on_clauses
//       } catch (e) {
//         await showModalBottomSheet<void>(
//           context: context,
//           builder: (BuildContext context) {
//             return ShowMessageDialog(type: 400,message: 'e'.tr,show_but: true,);
//           },
//         );
//       }



//   }

// }
