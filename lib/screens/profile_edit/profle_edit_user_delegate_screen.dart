import 'dart:io';
import 'package:al_murafiq/models/profile_edit.dart';
import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/models/countries.dart';
import 'package:al_murafiq/screens/profile_edit/profile_edit_user_delegate_bloc.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:al_murafiq/widgets/widgets.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
class ProfileEditUserDelegateScreen extends StatefulWidget {
  final bool bedelegate;

   ProfileEditUserDelegateScreen({Key key, this.bedelegate}) : super(key: key);
  @override
  _ProfileEditUserDelegateScreenState createState() => _ProfileEditUserDelegateScreenState();
}

class _ProfileEditUserDelegateScreenState extends State<ProfileEditUserDelegateScreen> {
  ProfileEditUserAndDelegateBloc _bloc = ProfileEditUserAndDelegateBloc();
  File _selectedImage;
  @override
  void initState() {

    _bloc.fetchProfileData(context);
    // TODO: implement initState
    super.initState();
  }

  List<String> LIST_KIND = <String>[
    'Male'.tr,
    'Female'.tr,
  ];
  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      appBar:  GradientAppbar(
        title: widget.bedelegate?'side_be_delegate'.tr:'side_edit_profile'.tr,

      ),
      body: SingleChildScrollView(
        child:  StreamBuilder<ProfileEditUserAndDelegate>(
          stream: _bloc.getProfileData.stream,
          builder: (context, getProfileDatasnapshot) {
            if(getProfileDatasnapshot.hasData){
             // _bloc.fetchAllCountries();
             //  _bloc.nameController.text=getProfileDatasnapshot.data.name;
             //  _bloc.emailOrPhoneController.text=getProfileDatasnapshot.data.email;
             //  _bloc.phoneController.text=getProfileDatasnapshot.data.phone;

              // _bloc.birthDateSubject.sink.add(DateFormat('dd-MM-yyyy').format(getProfileDatasnapshot.data.birth_date));
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),

                    StreamBuilder<File>(
                        stream: _bloc.imageController.stream,
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
                                              _bloc.imageController.sink
                                                  .add(img);
                                            }
                                          } catch (e) {

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
                                child: Stack(
                                  children: [
                                    if (getProfileDatasnapshot.data.avatar != null)
                                      ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: Image.network(
                                        '$ImgUrl${getProfileDatasnapshot.data.avatar}',
                                        fit: BoxFit.fill,
                                       // width: 120,
                                      ),
                                    ) else SizedBox(),
                                    Center(
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
                                              _bloc.imageController.sink.add(img);
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

                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        }),
                    // AutoSizeText(
                    //   context.translate('bt_change_photo'),
                    //   style: kTextStyle,
                    //   softWrap: true,
                    //   maxFontSize: 20,
                    //   minFontSize: 16,
                    // ),
                    Row(
                      children: [
                        Text('text_full_name'.tr,
                            style: TextStyle(fontSize: 14, color: Colors.grey.shade600))
                            .addPaddingOnly(right: 8, top: 15,left: 8, bottom: 10),
                        const Text('*',
                            style: TextStyle(fontSize: 14, color: Colors.red))
                            .addPaddingOnly( top: 15),
                      ],
                    ),

                    StreamBuilder<bool>(
                        stream: _bloc.nameSubject.stream,
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
                              hintText: 'hint_name'.tr,
                              hintStyle: const TextStyle(
                                  fontSize: 14, color: Color(0xFF9797AD)),
                              errorText: snapshot.data ? null : 'text_full_name_error'.tr,
                            ),
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => node.nextFocus(),
                            keyboardType: TextInputType.text,
                            onChanged: (val) =>  _bloc.changeName(val),
                            controller: _bloc.nameController,
                          );
                        }),
                    Row(
                      children: [
                        Text('text_email'.tr,
                            style: TextStyle(fontSize: 14, color: Colors.grey.shade600))
                            .addPaddingOnly(right: 8,left: 8, top: 15, bottom: 10),
                        const Text('*',
                            style: TextStyle(fontSize: 14, color: Colors.red))
                            .addPaddingOnly( top: 15),
                      ],
                    ),
                    StreamBuilder<bool>(
                        stream:  _bloc.emailOrPhoneSubject.stream,
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
                              hintText: 'hint_email'.tr,
                              hintStyle: const TextStyle(
                                  fontSize: 14, color: Color(0xFF9797AD)),
                              errorText: snapshot.data
                                  ? null
                                  : 'email_error'.tr,
                            ),
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => node.nextFocus(),
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (val) =>  _bloc.changeEmailOrPhone(val),
                            controller:  _bloc.emailOrPhoneController,
                          );
                        }),

                    Row(
                      children: [
                        Text('text_phone'.tr,
                            style: TextStyle(fontSize: 14, color: Colors.grey.shade600))
                            .addPaddingOnly(right: 8,left: 8, top: 15, bottom: 5),
                        Text('*',
                            style: TextStyle(fontSize: 14, color: Colors.red))
                            .addPaddingOnly( top: 15),
                      ],
                    ),
                    StreamBuilder<bool>(
                        stream:  _bloc.phoneSubject.stream,
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
                              hintText: '',
                              hintStyle: const TextStyle(
                                  fontSize: 14, color: Color(0xFF9797AD)),
                              errorText: snapshot.data ? null :'text_phone_error'.tr,
                            ),
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => node.nextFocus(),
                            keyboardType: TextInputType.phone,
                            onChanged: (val) =>  _bloc.changePhone(val),
                            controller:  _bloc.phoneController,
                          );
                        }),
                    // Text('number'.tr,
                    //     style: TextStyle(fontSize: 14, color: Colors.grey.shade600))
                    //     .addPaddingOnly(right: 8,left: 8, top: 15, bottom: 5),
                    //
                    // StreamBuilder<bool>(
                    //     stream: _bloc.nationalIDSubject.stream,
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
                    //         onChanged: (val) => _bloc.changeNationalID(val),
                    //         controller: _bloc.nationalIDController,
                    //       );
                    //     }),
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
                              child: StreamBuilder<List<CountriesData>>(
                                  stream: _bloc.allCountriesSubject.stream,
                                  builder: (context, countriesSnapshot) {
                                    if (countriesSnapshot.hasData) {
                                      return StreamBuilder<CountriesData>(
                                          stream: _bloc.selectedCountry.stream,
                                          builder: (context, snapshot) {
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 2),
                                              child: DropdownButton<CountriesData>(
                                                  dropdownColor: Colors.white,
                                                  iconEnabledColor: Colors.grey,
                                                  iconSize: 32,
                                                  elevation: 3,
                                                  icon: Icon(
                                                      Icons.arrow_drop_down_outlined),
                                                  items: countriesSnapshot.data
                                                      .map((item) {
                                                    return DropdownMenuItem<
                                                        CountriesData>(
                                                        value: item,
                                                        child: Row(
                                                          children: [
                                                            item.icon != null?
                                                            Image.network(
                                                              '$ImgUrl${item.icon}',
                                                              width: 32,
                                                              height: 32,
                                                            ):SizedBox(),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            AutoSizeText(
                                                              item.name,
                                                              style: kTextStyle.copyWith(
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
                                                  onChanged: (CountriesData item) {

                                                    _bloc.selectedCities.sink.add(null);
                                                    _bloc.selectedCountry.sink
                                                        .add(item);
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
                                  stream: _bloc.selectedCountry.stream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return StreamBuilder<CitiesData>(
                                          stream: _bloc.selectedCities.stream,
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
                                                  items:
                                                  snapshot.data.cities.map((item) {
                                                    return DropdownMenuItem<CitiesData>(
                                                        value: item,
                                                        child: AutoSizeText(
                                                          item.name,
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
                                                  onChanged: (CitiesData item) {
                                                    _bloc.selectedCities.sink.add(item);

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
                                  color: Color(0xFFE0E7FF)),
                              child:
                              StreamBuilder<List<Languages>>(
                                  stream: _bloc.allLanguageSubject.stream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return StreamBuilder<Languages>(
                                          stream: _bloc.selectedLanguage.stream,

                                          builder: (context, langSnapshot) {
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 2),
                                              child: DropdownButton<Languages>(
                                                  dropdownColor: Colors.white,
                                                  iconEnabledColor: Colors.grey,
                                                  iconSize: 32,
                                                  elevation: 3,
                                                  icon: Icon(Icons
                                                      .arrow_drop_down_outlined),
                                                  items: snapshot.data
                                                      .map((item) {
                                                    return DropdownMenuItem<
                                                        Languages>(
                                                        value: item,
                                                        child: AutoSizeText(
                                                          item.name,
                                                          style:
                                                          kTextStyle.copyWith(
                                                              fontSize: 14),
                                                          minFontSize: 12,
                                                          maxFontSize: 14,
                                                        ));
                                                  }).toList(),
                                                  isExpanded: true,
                                                  hint: Row(
                                                    children: [
                                                      Icon(Icons.language_sharp),
                                                      Text(
                                                        'select_language'.tr,
                                                        style:
                                                        kTextStyle.copyWith(
                                                            color:
                                                            Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                  style: kTextStyle.copyWith(
                                                      color: Colors.black),
                                                  underline: SizedBox(),
                                                  value:  langSnapshot.data,
                                                  onChanged: (Languages item) {
                                                    _bloc.selectedLanguage.sink
                                                        .add(item);
                                                  }),
                                            );
                                          });
                                    } else
                                      return  Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Center(
                                            child: CircularProgressIndicator(
                                              valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  kAccentColor),
                                            )),
                                      );
                                  }),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Text('text_password'.tr,
                            style: TextStyle(fontSize: 14, color: Colors.grey.shade600))
                            .addPaddingOnly(right: 8,left: 8, top: 15, bottom: 5),
                        Text('*',
                            style: TextStyle(fontSize: 14, color: Colors.red))
                            .addPaddingOnly( top: 15),
                      ],
                    ),
                    StreamBuilder<bool>(
                        stream:  _bloc.passwordSubject.stream,
                        initialData: true,
                        builder: (context, snapshot) {
                          return StreamBuilder<bool>(
                              stream:  _bloc.obscurePasswordSubject.stream,
                              initialData: true,
                              builder: (context, obscureSnapshot) {
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
                                    hintStyle: const TextStyle(
                                        fontSize: 14, color: Color(0xFF9797AD)),
                                    errorText: snapshot.data
                                        ? null
                                        : 'pass_error'.tr,
                                    suffixIcon: GestureDetector(
                                        onTap: () {
                                          _bloc.obscurePasswordSubject.sink.add(
                                              ! _bloc.obscurePasswordSubject.value);
                                        },
                                        child: Icon(obscureSnapshot.data
                                            ? Icons.visibility
                                            : Icons.visibility_off)),
                                  ),
                                  textInputAction: TextInputAction.done,
                                  onSubmitted: (_) => node.unfocus(),
                                  keyboardType: TextInputType.visiblePassword,
                                  onChanged: (val) =>  _bloc.changePassword(val),
                                  controller:  _bloc.passwordController,
                                  obscureText: obscureSnapshot.data,
                                );
                              });
                        }),
                    // Text(context.translate('re-pass'),
                    //     style: TextStyle(fontSize: 14, color: Colors.grey.shade600))
                    //     .addPaddingOnly(right: 8,left: 8, top: 15, bottom: 5),
                    // StreamBuilder<bool>(
                    //     //stream: widget.bloc.confirmePasswordSubject.stream,
                    //     initialData: true,
                    //     builder: (context, snapshot) {
                    //       return StreamBuilder<bool>(
                    //          // stream: widget.bloc.obscureConfirmePasswordSubject.stream,
                    //           initialData: true,
                    //           builder: (context, obscureCoSnapshot) {
                    //             return TextField(
                    //               style: TextStyle(fontSize: 18),
                    //               decoration: InputDecoration(
                    //                 filled: true,
                    //                 fillColor: const Color(0xFFE0E7FF),
                    //                 focusedBorder: OutlineInputBorder(
                    //                   borderRadius:
                    //                   const BorderRadius.all(Radius.circular(6)),
                    //                   borderSide: BorderSide(
                    //                       width: 1, color: context.accentColor),
                    //                 ),
                    //                 disabledBorder: const OutlineInputBorder(
                    //                   borderRadius:
                    //                   BorderRadius.all(Radius.circular(6)),
                    //                   borderSide:
                    //                   BorderSide(width: 1, color: Colors.black54),
                    //                 ),
                    //                 enabledBorder: const OutlineInputBorder(
                    //                   borderRadius:
                    //                   BorderRadius.all(Radius.circular(6)),
                    //                   borderSide: BorderSide(
                    //                       width: 1, color: Color(0xFFC2C3DF)),
                    //                 ),
                    //                 border: const OutlineInputBorder(
                    //                     borderRadius:
                    //                     BorderRadius.all(Radius.circular(6)),
                    //                     borderSide: BorderSide(width: 1)),
                    //                 errorBorder: const OutlineInputBorder(
                    //                     borderRadius:
                    //                     BorderRadius.all(Radius.circular(6)),
                    //                     borderSide:
                    //                     BorderSide(width: 1, color: Colors.red)),
                    //                 focusedErrorBorder: OutlineInputBorder(
                    //                     borderRadius:
                    //                     const BorderRadius.all(Radius.circular(6)),
                    //                     borderSide: BorderSide(
                    //                         width: 1, color: Colors.red.shade800)),
                    //                 hintStyle: const TextStyle(
                    //                     fontSize: 16, color: Color(0xFF9797AD)),
                    //                 errorText: snapshot.data
                    //                     ? null
                    //                     : context.translate('pass_error'),
                    //                 suffixIcon: GestureDetector(
                    //                     // onTap: () {
                    //                     //   widget
                    //                     //       .bloc.obscureConfirmePasswordSubject.sink
                    //                     //       .add(!widget
                    //                     //       .bloc
                    //                     //       .obscureConfirmePasswordSubject
                    //                     //       .value);
                    //                     // },
                    //                     child: Icon(obscureCoSnapshot.data
                    //                         ? Icons.visibility
                    //                         : Icons.visibility_off)),
                    //               ),
                    //               keyboardType: TextInputType.visiblePassword,
                    //               // onChanged: (val) =>widget.bloc.changeConfirmePassword(val),
                    //               // controller: widget.bloc.confirmePasswordController,
                    //               obscureText: obscureCoSnapshot.data,
                    //             );
                    //           });
                    //     }),

                    // Text('text_gender'.tr,
                    //     style: TextStyle(fontSize: 14, color: Colors.grey.shade600))
                    //     .addPaddingOnly(right: 8,left: 8, top: 15, bottom: 5),
                    // StreamBuilder<String>(
                    //     stream:  _bloc.genderSubject.stream,
                    //     builder: (BuildContext context, snapshot) {
                    //       return DropButton(
                    //         onChanged:  _bloc.genderChanged,
                    //         values: LIST_KIND,
                    //         value:
                    //         snapshot.data != null
                    //             ?  _bloc.genderSubject.value
                    //             : LIST_KIND[0],
                    //       ).addPaddingOnly(top: 5);
                    //     }),
                    // Text('text_birthDate'.tr,
                    //     style: TextStyle(fontSize: 14, color: Colors.grey.shade600))
                    //     .addPaddingOnly(right: 8,left: 8, top: 15, bottom: 5),
                    // // TODO(Kareem): make these drop buttons with (kay).
                    //
                    // InkWell(
                    //   onTap: () =>  _bloc.birthDateChanged(context),
                    //   child: StreamBuilder<DateTime>(
                    //       stream:  _bloc.birthDateSubject.stream,
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
                    SizedBox(
                      height: 15,
                    ),
                    if (widget.bedelegate) Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: RoundedLoadingButton(
                        child: Text(
                          'bt_be_delegat'.tr,
                          style: kTextStyle.copyWith(fontSize: 20,color: Color(0xffFFFFFF)),
                        ),
                        height: 50,
                        controller:  _bloc.loadingButtonController,
                        color: Colors.blue.shade800,
                        onPressed: () async {
                          _bloc.loadingButtonController.start();
                          await _bloc.confirmEditProfileUserAndDelegate(context: context,bedelegate: true);
                          _bloc.loadingButtonController.stop();
                        },
                      ),
                    ) else Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: RoundedLoadingButton(
                        child: Text(
                          'bt_edit'.tr,
                          style: kTextStyle.copyWith(fontSize: 20,color: Color(0xffFFFFFF)),
                        ),
                        height: 50,
                        controller:  _bloc.loadingButtonController,
                        color: Colors.blue.shade800,
                        onPressed: () async {
                          _bloc.loadingButtonController.start();
                          await _bloc.confirmEditProfileUserAndDelegate(context: context,bedelegate: false);
                          _bloc.loadingButtonController.stop();
                        },
                      ),
                    ),
                  ],
                ).addPaddingOnly(bottom: 28),
              );
            }else{
              return SizedBox(
                  height: Get.height,
                  child: Center(
                      child: CircularProgressIndicator(
                        backgroundColor: kPrimaryColor,
                      )));
            }

          }
        ),
      ),
    );
  }
}
