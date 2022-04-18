import 'dart:io';

import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:al_murafiq/screens/register_merchant/register_merchant_bloc.dart';
import 'package:al_murafiq/utils/utils.dart';
import 'package:al_murafiq/widgets/already_have_an_account.dart';
import 'package:al_murafiq/widgets/drop_button.dart';
import 'package:al_murafiq/widgets/social_btn.dart';
import 'package:al_murafiq/widgets/textfield_outline_border.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:get/get.dart';
class PersonalInformationMerchantScreen extends StatefulWidget {
  final RegisterMerchantBloc bloc;

  const PersonalInformationMerchantScreen({Key key, this.bloc}) : super(key: key);

  @override
  _PersonalInformationMerchantScreenState createState() =>
      _PersonalInformationMerchantScreenState();
}

class _PersonalInformationMerchantScreenState
    extends State<PersonalInformationMerchantScreen> {
  List<String> LIST_KIND = <String>[
    'Male'.tr,
    'Female'.tr,
  ];
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: iosScrollPhysics(),
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            StreamBuilder<File>(
                stream: widget.bloc.avatarController.stream,
                initialData: null,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return Center(
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: kAccentColor.withOpacity(0.6),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.file(
                                snapshot.data,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            Center(
                              child: GestureDetector(
                                onTap: () async {
                                  try {
                                    FilePickerResult res =
                                    await FilePicker.platform
                                        .pickFiles(
                                        type: FileType.custom,
                                        allowedExtensions: ['jpg','png','jpeg','gif']
                                    );
                                    File img = res != null
                                        ? File(res.files.single.path)
                                        : null;
                                    if (img != null) {
                                      widget.bloc.avatarController.sink
                                          .add(img);
                                    }
                                  } catch (e) {

                                    print(e.toString());
                                  }
                                },
                                child: Card(
                                  elevation: 0,
                                  margin: EdgeInsets.all(0),
                                  shape: CircleBorder(),
                                  color: kAccentColor.withOpacity(0.6),
                                  child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Icon(
                                        MdiIcons.imagePlus,
                                        color: Colors.white,
                                        size: 32,
                                      )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: kAccentColor.withOpacity(0.6),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: GestureDetector(
                            onTap: () async {
                              try {
                                FilePickerResult res = await FilePicker
                                    .platform
                                    .pickFiles(type: FileType.image);
                                File img = res != null
                                    ? File(res.files.single.path)
                                    : null;

                                if (img != null) {
                                  widget.bloc.avatarController.sink.add(img);
                                }
                              } catch (e) {

                                print(e.toString());
                              }
                            },
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Card(
                                  elevation: 0,
                                  margin: EdgeInsets.all(0),
                                  shape: CircleBorder(),
                                  color: kAccentColor.withOpacity(0.6),
                                  child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Icon(
                                        MdiIcons.imagePlus,
                                        color: Colors.white,
                                        size: 32,
                                      )),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                AutoSizeText(
                                  'profile_photo'.tr,
                                  style: kTextStyle,
                                  softWrap: true,
                                  maxFontSize: 16,
                                  minFontSize: 14,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                }),
            // Text(context.translate('language'),
            //         style: TextStyle(fontSize: 16, color: Colors.grey.shade600))
            //     .addPaddingOnly(right: 15, top: 25, bottom: 8),
            //
            // StreamBuilder<String>(
            //   stream: widget.bloc.languageSubject.stream,
            //   initialData: 'en',
            //   builder: (context, snapshot) {
            //     print(snapshot.data);
            //     return
            //         //   DropButton(
            //         //   onChanged: widget.bloc.languageChanged,
            //         //   values: LIST_LANGUAGE,
            //         //   value: snapshot.data ?? LIST_LANGUAGE[0],
            //         // ).addPaddingOnly(top: 5);
            //         Container(
            //             height: 50,
            //             alignment: Alignment.center,
            //             width: double.infinity,
            //             decoration: BoxDecoration(
            //               color: const Color(0xFFE0E7FF),
            //               borderRadius:
            //                   const BorderRadius.all(Radius.circular(6)),
            //               border:
            //                   Border.all(width: 1, color: context.accentColor),
            //             ),
            //             child: DropdownButton<String>(
            //               iconSize: 30,
            //               isExpanded: true,
            //               value: snapshot.data,
            //               dropdownColor: const Color(0xFFE0E7FF),
            //               items: LIST_LANGUAGE
            //                   .map<DropdownMenuItem<String>>((String value) {
            //                 return DropdownMenuItem<String>(
            //                   value: value,
            //                   child: Padding(
            //                     padding: const EdgeInsets.all(8.0),
            //                     child: Text(value),
            //                   ),
            //                 );
            //               }).toList(),
            //               onChanged: (String val) {
            //                 //onChanged(val);
            //                 widget.bloc.languageSubject.sink.add(val);
            //                 print(val);
            //               },
            //             ).addPaddingOnly(right: 15));
            //   },
            // ),

            Text('text_full_name'.tr,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600))
                .addPaddingOnly(right: 15, top: 20, bottom: 10),

            StreamBuilder<bool>(
                stream: widget.bloc.nameSubject.stream,
                initialData: true,
                builder: (context, snapshot) {
                  return TextField(
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFE0E7FF),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6)),
                        borderSide:
                            BorderSide(width: 1, color: context.accentColor),
                      ),
                      disabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        borderSide: BorderSide(width: 1, color: Colors.black54),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        borderSide:
                            BorderSide(width: 1, color: Color(0xFFC2C3DF)),
                      ),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          borderSide: BorderSide(width: 1)),
                      errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          borderSide: BorderSide(width: 1, color: Colors.red)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6)),
                          borderSide:
                              BorderSide(width: 1, color: Colors.red.shade800)),
                      hintText:'hint_name'.tr,
                      hintStyle: const TextStyle(
                          fontSize: 14, color: Color(0xFF9797AD)),
                      errorText: snapshot.data ? null : 'text_full_name_error'.tr,
                    ),
                    keyboardType: TextInputType.text,
                    onChanged: (val) => widget.bloc.changeName(val),
                    controller: widget.bloc.nameController,
                  );
                }),
            Text('text_email'.tr,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600))
                .addPaddingOnly(right: 15, top: 25, bottom: 10),
            StreamBuilder<bool>(
                stream: widget.bloc.emailOrPhoneSubject.stream,
                initialData: true,
                builder: (context, snapshot) {
                  return TextField(
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFE0E7FF),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(6)),
                        borderSide:
                        BorderSide(width: 1, color: context.accentColor),
                      ),
                      disabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        borderSide: BorderSide(width: 1, color: Colors.black54),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        borderSide:
                        BorderSide(width: 1, color: Color(0xFFC2C3DF)),
                      ),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          borderSide: BorderSide(width: 1)),
                      errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          borderSide: BorderSide(width: 1, color: Colors.red)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(6)),
                          borderSide:
                          BorderSide(width: 1, color: Colors.red.shade800)),
                      hintText:'hint_email'.tr,
                      hintStyle: const TextStyle(
                          fontSize: 14, color: Color(0xFF9797AD)),
                      errorText: snapshot.data
                          ? null
                          : 'email_error'.tr,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (val) => widget.bloc.changeEmailOrPhone(val),
                    controller: widget.bloc.emailOrPhoneController,
                  );
                }),
            Text('text_phone'.tr,
                style: TextStyle(
                    fontSize: 14, color: Colors.grey.shade600))
                .addPaddingOnly(right: 15, top: 25, bottom: 5),
            StreamBuilder<bool>(
                stream: widget.bloc.userPhoneSubject.stream,
                initialData: true,
                builder: (context, snapshot) {
                  return TextField(
                    style: TextStyle(fontSize: 14),
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
                          borderRadius:
                          const BorderRadius.all(Radius.circular(6)),
                          borderSide: BorderSide(
                              width: 1, color: Colors.red.shade800)),
                      hintText: '',
                      hintStyle: const TextStyle(
                          fontSize: 14, color: Color(0xFF9797AD)),
                      errorText:
                      snapshot.data ? null : 'text_phone_error'.tr,
                    ),
                    keyboardType: TextInputType.phone,
                    onChanged: (val) => widget.bloc.changeUserPhone(val),
                    controller: widget.bloc.userPhoneController,
                  );
                }),
            // Text('number'.tr,
            //         style: TextStyle(fontSize: 14, color: Colors.grey.shade600))
            //     .addPaddingOnly(right: 15, top: 20, bottom: 5),
            //
            // StreamBuilder<bool>(
            //     stream: widget.bloc.nationalIDSubject.stream,
            //     initialData: true,
            //     builder: (context, snapshot) {
            //       return TextField(
            //         style: TextStyle(fontSize: 18),
            //         decoration: InputDecoration(
            //           filled: true,
            //           fillColor: const Color(0xFFE0E7FF),
            //           focusedBorder: OutlineInputBorder(
            //             borderRadius:
            //                 const BorderRadius.all(Radius.circular(6)),
            //             borderSide:
            //                 BorderSide(width: 1, color: context.accentColor),
            //           ),
            //           disabledBorder: const OutlineInputBorder(
            //             borderRadius: BorderRadius.all(Radius.circular(6)),
            //             borderSide: BorderSide(width: 1, color: Colors.black54),
            //           ),
            //           enabledBorder: const OutlineInputBorder(
            //             borderRadius: BorderRadius.all(Radius.circular(6)),
            //             borderSide:
            //                 BorderSide(width: 1, color: Color(0xFFC2C3DF)),
            //           ),
            //           border: const OutlineInputBorder(
            //               borderRadius: BorderRadius.all(Radius.circular(6)),
            //               borderSide: BorderSide(width: 1)),
            //           errorBorder: const OutlineInputBorder(
            //               borderRadius: BorderRadius.all(Radius.circular(6)),
            //               borderSide: BorderSide(width: 1, color: Colors.red)),
            //           focusedErrorBorder: OutlineInputBorder(
            //               borderRadius:
            //                   const BorderRadius.all(Radius.circular(6)),
            //               borderSide:
            //                   BorderSide(width: 1, color: Colors.red.shade800)),
            //           hintText: '',
            //           hintStyle: const TextStyle(
            //               fontSize: 16, color: Color(0xFF9797AD)),
            //           errorText: snapshot.data ? null : 'number_error'.tr,
            //         ),
            //         keyboardType: TextInputType.number,
            //         onChanged: (val) => widget.bloc.changeNationalID(val),
            //         controller: widget.bloc.nationalIDController,
            //       );
            //     }),


            ////////////////////////////////
            // Text('text_gender'.tr,
            //         style: TextStyle(fontSize: 14, color: Colors.grey.shade600))
            //     .addPaddingOnly(right: 15, top: 20),
            // StreamBuilder<String>(
            //     stream: widget.bloc.genderSubject.stream,
            //     builder: (BuildContext context, snapshot) {
            //       return DropButton(
            //         onChanged: widget.bloc.genderChanged,
            //         values: LIST_KIND,
            //         value: snapshot.data != null
            //             ? widget.bloc.genderSubject.value
            //             : LIST_KIND[0],
            //       ).addPaddingOnly(top: 5);
            //     }),
            // Text('text_birthDate'.tr,
            //         style: TextStyle(fontSize: 14, color: Colors.grey.shade600))
            //     .addPaddingOnly(right: 15, top: 20, bottom: 5),
            // InkWell(
            //   onTap: () => widget.bloc.birthDateChanged(context),
            //   child: StreamBuilder<DateTime>(
            //       stream: widget.bloc.birthDateSubject.stream,
            //       initialData: DateTime.now(),
            //       builder: (BuildContext context, snapshot) {
            //         final DateTime date = snapshot.data ?? DateTime.now();
            //         return TextFieldOutlineBorder(
            //           enabled: false,
            //           keyboardType: TextInputType.name,
            //           textInputAction: TextInputAction.done,
            //           hintText: '${date.year}/${date.month}/${date.day}',
            //         ).addPaddingOnly(left: 8, right: 8);
            //       }),
            // ),
            ////////////////////////////////



            // CustomedButton(
            //   text: context.translate('cont'),
            //   height: 55,
            //   onPressed: locator<RegisterUserDelegateBloc>().continueBtn,
            // ).addPaddingOnly(top: 30, left: 20, right: 20),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 30),
            //   child: RoundedLoadingButton(
            //     child: Text(
            //       context.translate('cont'),
            //       style: kTextStyle.copyWith(color: Colors.white),
            //     ),
            //     height: 50,
            //     controller: widget.bloc.loadingButtonController,
            //     color: Colors.blue.shade800,
            //     onPressed: () async {
            //       widget.bloc.loadingButtonController.start();
            //       print(widget.bloc.tapBarSubject.value);
            //       widget.bloc.tapBarSubject.sink.add(1);
            //       print(widget.bloc.tapBarSubject.value);
            //
            //       widget.bloc.loadingButtonController.stop();
            //     },
            //   ),
            // ),
            // SocialButton(
            //     onPress: (){
            //
            //     },
            //         decorationColor: const Color(0xFF0D61B8),
            //         text: 'face login'.tr,
            //         iconColor: Colors.white,
            //         icon: FontAwesomeIcons.facebookF,
            //         textColor: Colors.white)
            //     .addPaddingHorizontalVertical(vertical: 20, horizontal: 20),
            // SocialButton(
            //     onPress: (){
            //
            //     },
            //         decorationColor: Colors.white,
            //         text: 'google login'.tr,
            //         iconColor: Colors.black,
            //         icon: FontAwesomeIcons.google,
            //         fontWeight: FontWeight.w100,
            //         border: Border.all(color: Colors.grey, width: 2),
            //         textColor: Colors.black)
            //     .addPaddingHorizontalVertical(horizontal: 20),
            SizedBox(
              height: 10,
            ),

            const AlreadyHaveAnAccount(
              textColor: Colors.black,
            )
          ],
        ).addPaddingOnly(bottom: 28),
      ],
    );
  }
}
