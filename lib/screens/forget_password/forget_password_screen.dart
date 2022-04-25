import 'package:al_murafiq/extensions/extensions.dart';
import 'package:al_murafiq/screens/forget_password/forget_password_bloc.dart';
import 'package:al_murafiq/core/service_locator.dart';
import 'package:al_murafiq/utils/utils.dart';
import 'package:al_murafiq/widgets/app_bar.dart';
import 'package:al_murafiq/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../constants.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  ForgetPasswordBloc _bloc = ForgetPasswordBloc();
  @override
  Widget build(BuildContext context) {
    //locator<ForgetPasswordBloc>().clear();
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //AppBarAllScreen(),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Flexible(
                            flex: 7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'big-text1'.tr,
                                  style: const TextStyle(fontSize: 20),
                                  maxLines: 2,
                                ).addPaddingOnly(bottom: 5),
                                Text(
                                  'message'.tr,
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 12),
                                ),
                              ],
                            ).addPaddingOnly(top: 33),
                          ),
                          Flexible(
                            flex: 4,
                            child: Image.asset(
                              Assets.KEY1,
                            ),
                          ),
                        ],
                      ),
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
                                        width: 1, color: Colors.red.shade800)),
                                hintText: 'hint_email'.tr,
                                hintStyle: const TextStyle(
                                    fontSize: 16, color: Color(0xFF9797AD)),
                                errorText:
                                    snapshot.data! ? null : 'email_error'.tr,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (val) => _bloc.changeEmailOrPhone(val),
                              controller: _bloc.emailOrPhoneController,
                            );
                          }),

                      //  CustomedButton(
                      //   text: context.translate('go'),
                      //   height: 50,
                      //   onPressed:
                      //   // snapshot.hasData
                      //   //     ? () => locator<ForgetPasswordBloc>().submit(context)
                      //   //     : null,
                      //   null
                      // ).addPaddingAll(18),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: RoundedLoadingButton(
                          child: Text(
                            'bt_send'.tr,
                            style: kTextStyle.copyWith(color: Colors.white),
                          ),
                          height: 50,
                          controller: _bloc.loadingButtonController,
                          color: Colors.blue.shade800,
                          onPressed: () async {
                            _bloc.loadingButtonController.start();
                            await _bloc.sendEmail(context);
                            _bloc.loadingButtonController.stop();
                          },
                        ),
                      ),
                    ],
                  ).addPaddingAll(18),
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
