import 'dart:io';

import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:al_murafiq/screens/forget_password/forget_password_screen.dart';
import 'package:al_murafiq/screens/login/login_bloc.dart';
import 'package:al_murafiq/screens/login/social_login_bloc.dart';
import 'package:al_murafiq/utils/utils.dart';
import 'package:al_murafiq/widgets/widgets.dart';

import '../../constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc _bloc = LoginBloc();
  SocialLoginBlocc _socialLoginBlocc=SocialLoginBlocc();
  @override
  void initState() {
    super.initState();
    getEmailCach();
  }

  SharedPreferenceHelper _helper = GetIt.instance.get<SharedPreferenceHelper>();
  Future<void> getEmailCach() async {
    try {
    _bloc.emailOrPhoneController.text=await _helper.getEmail() !=null?await _helper.getEmail():null;
    // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      print('error $e');

    }
  }
  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Stack(
      children: [
        Scaffold(
            appBar: const GradientAppbar(),
            body:
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('login'.tr,
                          style: const TextStyle(fontSize: 30)),
                      Image.asset(Assets.LOGO).setCenter(),
                      Text('text_email'.tr,
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey.shade800))
                          .addPaddingHorizontalVertical(
                              horizontal: 10, vertical: 5),
                      StreamBuilder<bool>(
                          stream: _bloc.emailOrPhoneSubject.stream,
                          initialData: true,
                          builder: (context, snapshot) {
                            return TextField(
                              style: TextStyle(fontSize: 15),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color(0xFFE0E7FF),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(6)),
                                  borderSide: BorderSide(
                                      width: 1, color: context.accentColor),
                                ),
                                disabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.black54),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                  borderSide: BorderSide(
                                      width: 1, color: Color(0xFFC2C3DF)),
                                ),
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                    borderSide: BorderSide(width: 1)),
                                errorBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                    borderSide:
                                        BorderSide(width: 1, color: Colors.red)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(6)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.red.shade800)),
                                hintText: 'hint_email'.tr,
                                hintStyle: const TextStyle(
                                    fontSize: 15, color: Color(0xFF9797AD)),
                                errorText: snapshot.data
                                    ? null
                                    : 'email_error'.tr,
                              ),
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () => node.nextFocus(),
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (val) => _bloc.changeEmailOrPhone(val),
                              controller: _bloc.emailOrPhoneController,
                            );
                          }),
                      Text('text_password'.tr,
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey.shade800))
                          .addPaddingHorizontalVertical(
                              horizontal: 10, vertical: 5),
                      // TextFieldOutlineBorder(
                      //         hintText: '',
                      //         controller: _bloc.passwordController,
                      //         onChanged: (val) => _bloc.changePassword(val),
                      //         obscure: _bloc.obscure,
                      //         obscureChanged: _bloc.obscureChanged,
                      //         //error: snapshot.error as String,
                      //         keyboardType: TextInputType.visiblePassword,
                      //         textInputAction: TextInputAction.done)
                      //     .addPaddingHorizontalVertical(vertical: 10),
                      StreamBuilder<bool>(
                          stream: _bloc.passwordSubject.stream,
                          initialData: true,
                          builder: (context, snapshot) {
                            return StreamBuilder<bool>(
                                stream: _bloc.obscurePasswordSubject.stream,
                                initialData: true,
                                builder: (context, obscureSnapshot) {
                                  return TextField(
                                    style: TextStyle(fontSize: 15),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: const Color(0xFFE0E7FF),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(6)),
                                        borderSide: BorderSide(
                                            width: 1, color: context.accentColor),
                                      ),
                                      disabledBorder: const OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(6)),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.black54),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(6)),
                                        borderSide: BorderSide(
                                            width: 1, color: Color(0xFFC2C3DF)),
                                      ),
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6)),
                                          borderSide: BorderSide(width: 1)),
                                      errorBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6)),
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.red)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(6)),
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Colors.red.shade800)),
                                      hintStyle: const TextStyle(
                                          fontSize: 15, color: Color(0xFF9797AD)),
                                      errorText: snapshot.data
                                          ? null
                                          : 'pass_error'.tr,
                                      suffixIcon: GestureDetector(
                                          onTap: () {
                                            _bloc.obscurePasswordSubject.sink.add(
                                                !_bloc.obscurePasswordSubject
                                                    .value);
                                          },
                                          child: Icon(obscureSnapshot.data
                                              ? Icons.visibility
                                              : Icons.visibility_off)),
                                    ),
                                    textInputAction: TextInputAction.done,
                                    onSubmitted: (_) => node.unfocus(),
                                    keyboardType: TextInputType.visiblePassword,
                                    onChanged: (val) => _bloc.changePassword(val),
                                    controller: _bloc.passwordController,
                                    obscureText: obscureSnapshot.data,
                                  );
                                });
                          }),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: InkWell(
                      //     //onTap: () { Get.to(ForgetPassswordScreen());}
                      //     //     Navigator.pushNamed(
                      //     //     context, PageRouteName.FORGET_PASSWORD),
                      //     // child: Text(context.translate('forgot_password?'),
                      //     //     style: TextStyle(
                      //     //         fontSize: 15, color: Colors.grey.shade800)),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(ForgetPasswordScreen());
                          },
                          child: Container(
                            child: Text('forgot_password?'.tr,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey.shade800)),
                          ),
                        ),
                      ),

                      // CustomedButton(
                      //         text: context.translate('sagel'),
                      //         height: 50,
                      //         onPressed: () async {
                      //           _bloc.loadingButtonController.start();
                      //           await _bloc.confirmLogin(context);
                      //           _bloc.loadingButtonController.stop();
                      //         }
                      //
                      //         )
                      //     .addPaddingHorizontalVertical(vertical: 30, horizontal: 20),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: RoundedLoadingButton(
                          child: Text(
                            'login'.tr,
                            style: kTextStyle.copyWith(color: Colors.white),
                          ),
                          height: 50,
                          controller: _bloc.loadingButtonController,
                          color: Colors.blue.shade800,
                          onPressed: () async {
                            _bloc.loadingButtonController.start();
                            await _bloc.confirmLogin(context);
                            _bloc.loadingButtonController.stop();
                          },
                        ),
                      ),
                      SocialButton(
                        onPress: (){
                          _socialLoginBlocc.googleSignIn(context);
                        },
                          decorationColor: Colors.white,
                          text: 'google login'.tr,
                          iconColor: Colors.black,
                          icon: FontAwesomeIcons.google,
                          fontWeight: FontWeight.w100,
                          border: Border.all(color: Colors.grey, width: 2),
                          textColor: Colors.black)
                          .addPaddingHorizontalVertical(horizontal: 15),

                      SizedBox(height: 15,),
                      SocialButton(
                          onPress: (){
                            _socialLoginBlocc.loginWithFB(context);
                            // _socialLoginBlocc.logoutFB();
                          },
                          decorationColor: const Color(0xFF0D61B8),
                          text: 'face login'.tr,
                          iconColor: Colors.white,
                          icon: FontAwesomeIcons.facebookF,
                          textColor: Colors.white)
                          .addPaddingHorizontalVertical(horizontal: 15),

                      SizedBox(height: 15,),

                      if (Platform.isIOS)
                      SocialButton(
                          onPress: (){
                            _socialLoginBlocc.signInWithApple(context);
                          },
                          decorationColor: Colors.grey.shade800,
                          text: 'Sign in with Apple'.tr,
                          iconColor: Colors.white,
                          icon: FontAwesomeIcons.apple,
                          textColor: Colors.white)
                          .addPaddingHorizontalVertical(horizontal: 15),

                    ],
                  ).addPaddingAll(18),
                ),

            ),
        const Positioned(
            right: 30,
            top: 50,
            child: Image(
              image: AssetImage('assets/images/sign.png'),
            )),
      ],
    );
  }
}
