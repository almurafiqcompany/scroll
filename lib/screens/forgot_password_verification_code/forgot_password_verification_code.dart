import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:al_murafiq/core/service_locator.dart';
import 'package:al_murafiq/screens/forgot_password_verification_code/forget_password_verification_bloc.dart';
import 'package:al_murafiq/utils/utils.dart';
import 'package:al_murafiq/widgets/widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ForgotPasswordVerificationCode extends StatefulWidget {
  final String? email;

  const ForgotPasswordVerificationCode({Key? key, this.email})
      : super(key: key);

  @override
  _ForgotPasswordVerificationCodeState createState() =>
      _ForgotPasswordVerificationCodeState();
}

class _ForgotPasswordVerificationCodeState
    extends State<ForgotPasswordVerificationCode> {
  ForgetPasswordVerificationBloc _bloc = ForgetPasswordVerificationBloc();

  @override
  void initState() {
    // TODO: implement initState
    _bloc.sendEmailSubject.sink.add(widget.email!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            appBar: GradientAppbar(),
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: Get.height / 3,
                      ),
                      Container(
                        height: Get.height * 0.5,
                        width: Get.width,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/keys.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    physics: iosScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            AutoSizeText(
                              'big-text2'.tr,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 22),
                              minFontSize: 20,
                              maxFontSize: 25,
                            ).addPaddingOnly(top: 40),
                            Image.asset(
                              Assets.KEY1,
                              width: 130,
                            ),
                          ],
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                color: Colors.transparent,
                                child: Text('again'.tr,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.red.shade800)),
                              ),
                            ),
                          ),
                        ),
                        Text('text_code'.tr,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey.shade600))
                            .addPaddingOnly(
                                right: 18, left: 18, top: 10, bottom: 15),

                        StreamBuilder<bool>(
                            stream: _bloc.verifiedCodeSubject.stream,
                            initialData: true,
                            builder: (context, snapshot) {
                              return TextField(
                                style: TextStyle(fontSize: 18),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color(0xFFE0E7FF),
                                  contentPadding: EdgeInsets.all(9),
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                      borderSide: BorderSide(width: 1)),
                                  errorBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.red)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(6)),
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.red.shade800)),
                                  hintText: 'hint_code'.tr,
                                  hintStyle: const TextStyle(
                                      fontSize: 16, color: Color(0xFF9797AD)),
                                  errorText:
                                      snapshot.data! ? null : 'code_error'.tr,
                                ),
                                keyboardType: TextInputType.number,
                                onChanged: (val) =>
                                    _bloc.changeverifiedCode(val),
                                controller: _bloc.verifiedCodeController,
                              );
                            }),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: RoundedLoadingButton(
                            child: Text(
                              'bt_sure'.tr,
                              style: kTextStyle.copyWith(color: Colors.white),
                            ),
                            height: 50,
                            controller: _bloc.loadingButtonController,
                            color: Colors.blue.shade800,
                            onPressed: () async {
                              _bloc.loadingButtonController.start();
                              await _bloc.sendCode(context);
                              _bloc.loadingButtonController.stop();
                            },
                          ),
                        ),
                        const SizedBox(height: 30),
                        // Center(
                        //   child: InkWell(
                        //     // onTap: () =>
                        //         // locator<ForgotPasswordVerificationCodeBloc>()
                        //         // .resendCode(context, email),
                        //     child: Text(
                        //       context.translate('again'),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ).addPaddingAll(22),
                  ),
                ],
              ),
            )),
        const Positioned(
            right: 30,
            top: 70,
            child: Image(
              image: AssetImage('assets/images/sign.png'),
            )),
      ],
    );
  }
}
