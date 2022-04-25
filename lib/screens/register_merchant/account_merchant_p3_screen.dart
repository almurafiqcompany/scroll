import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:al_murafiq/screens/register_merchant/register_merchant_bloc.dart';

import 'package:al_murafiq/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:get/get.dart';

class AccountInformationMerchantPageThreeScreen extends StatefulWidget {
  final RegisterMerchantBloc? bloc;

  const AccountInformationMerchantPageThreeScreen({Key? key, this.bloc})
      : super(key: key);

  @override
  _RegisterDealerScreenState createState() => _RegisterDealerScreenState();
}

class _RegisterDealerScreenState
    extends State<AccountInformationMerchantPageThreeScreen> {
  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Stack(
      children: [
        Scaffold(
            appBar: const GradientAppbar(),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('new_account'.tr, style: const TextStyle(fontSize: 30))
                      .addPaddingOnly(right: 44, left: 44, top: 10),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text('text_email'.tr,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade600))
                          .addPaddingOnly(
                              right: 8, left: 8, top: 15, bottom: 5),
                      Text('*',
                              style: TextStyle(fontSize: 14, color: Colors.red))
                          .addPaddingOnly(top: 15),
                    ],
                  ),
                  StreamBuilder<bool>(
                      stream: widget.bloc!.emailOrPhoneSubject.stream,
                      initialData: true,
                      builder: (context, snapshot) {
                        return TextField(
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFE0E7FF),
                            contentPadding: EdgeInsets.all(9),
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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(6)),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.red.shade800)),
                            hintText: 'hint_email'.tr,
                            hintStyle: const TextStyle(
                                fontSize: 14, color: Color(0xFF9797AD)),
                            errorText: snapshot.data! ? null : 'email_error'.tr,
                          ),
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => node.nextFocus(),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (val) =>
                              widget.bloc!.changeEmailOrPhone(val),
                          controller: widget.bloc!.emailOrPhoneController,
                        );
                      }),

                  Row(
                    children: [
                      Text('text_password'.tr,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade600))
                          .addPaddingOnly(
                              right: 8, left: 8, top: 15, bottom: 5),
                      Text('*',
                              style: TextStyle(fontSize: 14, color: Colors.red))
                          .addPaddingOnly(top: 15),
                    ],
                  ),
                  StreamBuilder<bool>(
                      stream: widget.bloc!.passwordSubject.stream,
                      initialData: true,
                      builder: (context, snapshot) {
                        return StreamBuilder<bool>(
                            stream: widget.bloc!.obscurePasswordSubject.stream,
                            initialData: true,
                            builder: (context, obscureSnapshot) {
                              return TextField(
                                style: TextStyle(fontSize: 14),
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
                                  hintStyle: const TextStyle(
                                      fontSize: 14, color: Color(0xFF9797AD)),
                                  errorText:
                                      snapshot.data! ? null : 'pass_error'.tr,
                                  suffixIcon: GestureDetector(
                                      onTap: () {
                                        widget.bloc!.obscurePasswordSubject.sink
                                            .add(!widget.bloc!
                                                .obscurePasswordSubject.value);
                                      },
                                      child: Icon(obscureSnapshot.data!
                                          ? Icons.visibility
                                          : Icons.visibility_off)),
                                ),
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => node.nextFocus(),
                                keyboardType: TextInputType.visiblePassword,
                                onChanged: (val) =>
                                    widget.bloc!.changePassword(val),
                                controller: widget.bloc!.passwordController,
                                obscureText: obscureSnapshot.data!,
                              );
                            });
                      }),
                  Row(
                    children: [
                      Text('text_confirm_pass'.tr,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade600))
                          .addPaddingOnly(
                              right: 8, left: 8, top: 15, bottom: 5),
                      Text('*',
                              style: TextStyle(fontSize: 14, color: Colors.red))
                          .addPaddingOnly(top: 15),
                    ],
                  ),
                  StreamBuilder<bool>(
                      stream: widget.bloc!.confirmePasswordSubject.stream,
                      initialData: true,
                      builder: (context, snapshot) {
                        return StreamBuilder<bool>(
                            stream: widget
                                .bloc!.obscureConfirmePasswordSubject.stream,
                            initialData: true,
                            builder: (context, obscureCoSnapshot) {
                              return TextField(
                                style: TextStyle(fontSize: 14),
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
                                  hintStyle: const TextStyle(
                                      fontSize: 14, color: Color(0xFF9797AD)),
                                  errorText:
                                      snapshot.data! ? null : 'pass_error'.tr,
                                  suffixIcon: GestureDetector(
                                      onTap: () {
                                        widget.bloc!
                                            .obscureConfirmePasswordSubject.sink
                                            .add(!widget
                                                .bloc!
                                                .obscureConfirmePasswordSubject
                                                .value);
                                      },
                                      child: Icon(obscureCoSnapshot.data!
                                          ? Icons.visibility
                                          : Icons.visibility_off)),
                                ),
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => node.nextFocus(),
                                keyboardType: TextInputType.visiblePassword,
                                onChanged: (val) =>
                                    widget.bloc!.changeConfirmePassword(val),
                                controller:
                                    widget.bloc!.confirmePasswordController,
                                obscureText: obscureCoSnapshot.data!,
                              );
                            });
                      }),
                  // Text('text_code_afflet'.tr,
                  //     style: TextStyle(
                  //         fontSize: 14, color: Colors.grey.shade600))
                  //     .addPaddingOnly(right: 8,left: 8, top: 15, bottom: 5),
                  // StreamBuilder<bool>(
                  //     stream: widget.bloc.codeAfflatorSubject.stream,
                  //     initialData: true,
                  //     builder: (context, snapshot) {
                  //       return TextField(
                  //         style: TextStyle(fontSize: 18),
                  //         decoration: InputDecoration(
                  //           filled: true,
                  //           fillColor: const Color(0xFFE0E7FF),
                  //           contentPadding: EdgeInsets.all(9),
                  //           focusedBorder: OutlineInputBorder(
                  //             borderRadius:
                  //             const BorderRadius.all(Radius.circular(6)),
                  //             borderSide: BorderSide(
                  //                 width: 1, color: context.accentColor),
                  //           ),
                  //           disabledBorder: const OutlineInputBorder(
                  //             borderRadius:
                  //             BorderRadius.all(Radius.circular(6)),
                  //             borderSide:
                  //             BorderSide(width: 1, color: Colors.black54),
                  //           ),
                  //           enabledBorder: const OutlineInputBorder(
                  //             borderRadius:
                  //             BorderRadius.all(Radius.circular(6)),
                  //             borderSide: BorderSide(
                  //                 width: 1, color: Color(0xFFC2C3DF)),
                  //           ),
                  //           border: const OutlineInputBorder(
                  //               borderRadius:
                  //               BorderRadius.all(Radius.circular(6)),
                  //               borderSide: BorderSide(width: 1)),
                  //           errorBorder: const OutlineInputBorder(
                  //               borderRadius:
                  //               BorderRadius.all(Radius.circular(6)),
                  //               borderSide:
                  //               BorderSide(width: 1, color: Colors.red)),
                  //           focusedErrorBorder: OutlineInputBorder(
                  //               borderRadius:
                  //               const BorderRadius.all(Radius.circular(6)),
                  //               borderSide: BorderSide(
                  //                   width: 1, color: Colors.red.shade800)),
                  //           hintText: '',
                  //           hintStyle: const TextStyle(
                  //               fontSize: 16, color: Color(0xFF9797AD)),
                  //           errorText:
                  //           snapshot.data ? null : 'name is not empty',
                  //         ),
                  //         textInputAction: TextInputAction.done,
                  //         onSubmitted: (_) => node.unfocus(),
                  //         keyboardType: TextInputType.text,
                  //         onChanged: (val) => widget.bloc.changeCodeAfflator(val),
                  //         controller: widget.bloc.codeAfflatorController,
                  //       );
                  //     }),
                  SizedBox(
                    height: 10,
                  ),
                  const AlreadyHaveAnAccount(
                    textColor: Colors.black,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: RoundedLoadingButton(
                      child: Text(
                        'bt_submit'.tr,
                        style: kTextStyle.copyWith(color: Colors.white),
                      ),
                      height: 50,
                      controller: widget.bloc!.loadingButtonController,
                      color: Colors.blue.shade800,
                      onPressed: () async {
                        widget.bloc!.loadingButtonController.start();
                        await widget.bloc!.confirmSignUp(context);
                        widget.bloc!.loadingButtonController.stop();
                      },
                    ),
                  )
                ],
              ).addPaddingHorizontalVertical(horizontal: 30),
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
