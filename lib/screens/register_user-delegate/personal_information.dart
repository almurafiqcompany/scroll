import 'dart:io';

import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:al_murafiq/models/countries.dart';
import 'package:al_murafiq/screens/register_user-delegate/register_user_bloc.dart';
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

class PersonalInformation extends StatefulWidget {
  final RegisterUserBloc? bloc;

  const PersonalInformation({Key? key, this.bloc}) : super(key: key);

  @override
  _PersonalInformationState createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  @override
  void initState() {
    // TODO: implement initState
    widget.bloc!.fetchAllCountries(1);
    // widget.bloc.selectedLanguage.sink.add(null);
    // widget.bloc.selectedCountry.sink.add(null);
    // widget.bloc.selectedCities.sink.add(null);
    super.initState();
  }

  List<String> LIST_KIND = <String>[
    'Male'.tr,
    'Female'.tr,
  ];
  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return ListView(
      physics: iosScrollPhysics(),
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            StreamBuilder<File>(
                stream: widget.bloc!.avatarController.stream,
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
                                snapshot.data!,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            Center(
                              child: GestureDetector(
                                onTap: () async {
                                  try {
                                    FilePickerResult? res =
                                        await FilePicker.platform.pickFiles(
                                            type: FileType.custom,
                                            allowedExtensions: [
                                          'jpg',
                                          'png',
                                          'jpeg',
                                          'gif'
                                        ]);
                                    File? img = res != null
                                        ? File(res.files.single.path!)
                                        : null;

                                    if (img != null) {
                                      widget.bloc!.avatarController.sink
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
                                FilePickerResult? res = await FilePicker
                                    .platform
                                    .pickFiles(type: FileType.image);
                                File? img = res != null
                                    ? File(res.files.single.path!)
                                    : null;
                                if (img != null) {
                                  widget.bloc!.avatarController.sink.add(img);
                                }
                              } catch (e) {
                                print(e.toString());
                              }
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                  'bt_profile_photo'.tr,
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

            Row(
              children: [
                Text('text_country'.tr,
                        style: TextStyle(
                            fontSize: 14, color: Colors.grey.shade600))
                    .addPaddingOnly(right: 8, left: 8, top: 15, bottom: 5),
                Text('*', style: TextStyle(fontSize: 14, color: Colors.red))
                    .addPaddingOnly(top: 15),
              ],
            ),

            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffE0E7FF)),
                      child: StreamBuilder<List<CountriesData>>(
                          stream: widget.bloc!.allCountriesSubject.stream,
                          builder: (context, countriesSnapshot) {
                            if (countriesSnapshot.hasData) {
                              return StreamBuilder<CountriesData>(
                                  stream: widget.bloc!.selectedCountry.stream,
                                  builder: (context, snapshot) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 2),
                                      child: DropdownButton<CountriesData>(
                                          dropdownColor: Colors.white,
                                          iconEnabledColor: Colors.grey,
                                          iconSize: 32,
                                          elevation: 3,
                                          icon: const Icon(
                                              Icons.arrow_drop_down_outlined),
                                          items: countriesSnapshot.data!
                                              .map((item) {
                                            return DropdownMenuItem<
                                                    CountriesData>(
                                                value: item,
                                                child: Row(
                                                  children: [
                                                    if (item.icon != null)
                                                      Image.network(
                                                        '$ImgUrl${item.icon}',
                                                        width: 32,
                                                        height: 32,
                                                      )
                                                    else
                                                      const SizedBox(
                                                        width: 32,
                                                      ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    AutoSizeText(
                                                      item.name!,
                                                      style:
                                                          kTextStyle.copyWith(
                                                              fontSize: 14),
                                                      minFontSize: 12,
                                                      maxFontSize: 14,
                                                    ),
                                                  ],
                                                ));
                                          }).toList(),
                                          isExpanded: true,
                                          hint: Text(
                                            'select_country'.tr,
                                            style: kTextStyle.copyWith(
                                                color: Colors.black),
                                          ),
                                          style: kTextStyle.copyWith(
                                              color: Colors.black),
                                          underline: SizedBox(),
                                          value: snapshot.data,
                                          onChanged: (CountriesData? item) {
                                            widget.bloc!.selectedCities.sink
                                                .add(null!);
                                            widget.bloc!.selectedCountry.sink
                                                .add(item!);
                                          }),
                                    );
                                  });
                            } else {
                              return const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                    child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      kAccentColor),
                                )),
                              );
                            }
                          }),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),

            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffE0E7FF)),
                      child: StreamBuilder<CountriesData>(
                          stream: widget.bloc!.selectedCountry.stream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return StreamBuilder<CitiesData>(
                                  stream: widget.bloc!.selectedCities.stream,
                                  builder: (context, citySnapshot) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 2),
                                      child: DropdownButton<CitiesData>(
                                          dropdownColor: Colors.white,
                                          iconEnabledColor: Colors.grey,
                                          iconSize: 32,
                                          elevation: 3,
                                          icon: Icon(
                                              Icons.arrow_drop_down_outlined),
                                          items: snapshot.data!.cities!
                                              .map((item) {
                                            return DropdownMenuItem<CitiesData>(
                                                value: item,
                                                child: AutoSizeText(
                                                  item.name!,
                                                  style: kTextStyle.copyWith(
                                                      fontSize: 14),
                                                  minFontSize: 12,
                                                  maxFontSize: 14,
                                                ));
                                          }).toList(),
                                          isExpanded: true,
                                          hint: Text(
                                            'select_city'.tr,
                                            style: kTextStyle.copyWith(
                                                color: Colors.black),
                                          ),
                                          style: kTextStyle.copyWith(
                                              color: Colors.black),
                                          underline: SizedBox(),
                                          value: citySnapshot.data,
                                          onChanged: (CitiesData? item) {
                                            widget.bloc!.selectedCities.sink
                                                .add(item!);
                                          }),
                                    );
                                  });
                            } else
                              return SizedBox();
                          }),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),

            Row(
              children: [
                Text('text_full_name'.tr,
                        style: TextStyle(
                            fontSize: 14, color: Colors.grey.shade600))
                    .addPaddingOnly(right: 8, left: 8, top: 15, bottom: 5),
                Text('*', style: TextStyle(fontSize: 14, color: Colors.red))
                    .addPaddingOnly(top: 15),
              ],
            ),

            StreamBuilder<bool>(
                stream: widget.bloc!.nameSubject.stream,
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
                      hintText: 'murafiq'.tr,
                      hintStyle: const TextStyle(
                          fontSize: 14, color: Color(0xFF9797AD)),
                      errorText:
                          snapshot.data! ? null : 'text_full_name_error'.tr,
                    ),
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => node.nextFocus(),
                    keyboardType: TextInputType.text,
                    onChanged: (val) => widget.bloc!.changeName(val),
                    controller: widget.bloc!.nameController,
                  );
                }),
            // Text(context.translate('text_defalut_languages'),
            //     style: TextStyle(fontSize: 14, color: Colors.grey.shade600))
            //     .addPaddingOnly(right: 8,left: 8, top: 15, bottom: 5),
            // Row(
            //   children: [
            //     Expanded(
            //       child: Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 0),
            //         child: Container(
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(10),
            //               color: Color(0xFFE0E7FF)),
            //           child:
            //           StreamBuilder<List<Languages>>(
            //               stream: widget.bloc.allLanguageSubject.stream,
            //               builder: (context, snapshot) {
            //                 if (snapshot.hasData) {
            //                   return StreamBuilder<Languages>(
            //                       stream: widget.bloc.selectedLanguage.stream,
            //
            //                       builder: (context, langSnapshot) {
            //                         return Padding(
            //                           padding: const EdgeInsets.symmetric(
            //                               horizontal: 10, vertical: 2),
            //                           child: DropdownButton<Languages>(
            //                               dropdownColor: Colors.white,
            //                               iconEnabledColor: Colors.grey,
            //                               iconSize: 32,
            //                               elevation: 3,
            //                               icon: Icon(Icons
            //                                   .arrow_drop_down_outlined),
            //                               items: snapshot.data
            //                                   .map((item) {
            //                                 return DropdownMenuItem<
            //                                     Languages>(
            //                                     value: item,
            //                                     child: AutoSizeText(
            //                                       item.name,
            //                                       style:
            //                                       kTextStyle.copyWith(
            //                                           fontSize: 18),
            //                                       minFontSize: 14,
            //                                       maxFontSize: 18,
            //                                     ));
            //                               }).toList(),
            //                               isExpanded: true,
            //                               hint: Row(
            //                                 children: [
            //                                   Icon(Icons.language_sharp),
            //                                   Text(
            //                                       context.translate('select_language'),
            //                                     style:
            //                                     kTextStyle.copyWith(
            //                                         color:
            //                                         Colors.black),
            //                                   ),
            //                                 ],
            //                               ),
            //                               style: kTextStyle.copyWith(
            //                                   color: Colors.black),
            //                               underline: SizedBox(),
            //                               value:  langSnapshot.data,
            //                               onChanged: (Languages item) {
            //                                 print(item.name);
            //                                 widget.bloc.selectedLanguage.sink
            //                                     .add(item);
            //                                 print(widget.bloc
            //                                     .selectedLanguage.value);
            //                               }),
            //                         );
            //                       });
            //                 } else
            //                   return  Padding(
            //                     padding: EdgeInsets.all(8.0),
            //                     child: Center(
            //                         child: CircularProgressIndicator(
            //                           valueColor:
            //                           AlwaysStoppedAnimation<Color>(
            //                               kAccentColor),
            //                         )),
            //                   );
            //               }),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // Text('text_gender'.tr,
            //         style: TextStyle(fontSize: 14, color: Colors.grey.shade600))
            //     .addPaddingOnly(right: 8,left: 8, top: 15, bottom: 5),
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
            //     .addPaddingOnly(right: 8,left: 8, top: 15, bottom: 5),
            // // TODO(Kareem): make these drop buttons with (kay).
            //
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
            //         ).addPaddingOnly(left: 0, right: 0);
            //       }),
            // ),

            // Text('number'.tr,
            //     style: TextStyle(fontSize: 14, color: Colors.grey.shade600))
            //     .addPaddingOnly(right: 8,left: 8, top: 15, bottom: 5),
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
            //             const BorderRadius.all(Radius.circular(6)),
            //             borderSide:
            //             BorderSide(width: 1, color: context.accentColor),
            //           ),
            //           disabledBorder: const OutlineInputBorder(
            //             borderRadius: BorderRadius.all(Radius.circular(6)),
            //             borderSide: BorderSide(width: 1, color: Colors.black54),
            //           ),
            //           enabledBorder: const OutlineInputBorder(
            //             borderRadius: BorderRadius.all(Radius.circular(6)),
            //             borderSide:
            //             BorderSide(width: 1, color: Color(0xFFC2C3DF)),
            //           ),
            //           border: const OutlineInputBorder(
            //               borderRadius: BorderRadius.all(Radius.circular(6)),
            //               borderSide: BorderSide(width: 1)),
            //           errorBorder: const OutlineInputBorder(
            //               borderRadius: BorderRadius.all(Radius.circular(6)),
            //               borderSide: BorderSide(width: 1, color: Colors.red)),
            //           focusedErrorBorder: OutlineInputBorder(
            //               borderRadius:
            //               const BorderRadius.all(Radius.circular(6)),
            //               borderSide:
            //               BorderSide(width: 1, color: Colors.red.shade800)),
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
