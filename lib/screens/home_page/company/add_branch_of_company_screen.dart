import 'dart:io';
import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/models/profile_edit.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/models/countries.dart';
import 'package:al_murafiq/screens/countries/countries_bloc.dart';
import 'package:al_murafiq/screens/home_page/company/add_branches_of_company_bloc.dart';
import 'package:al_murafiq/screens/home_page/company/test_map.dart';
import 'package:al_murafiq/screens/profile_edit/profile_edit_user_delegate_bloc.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_field/date_field.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:file_picker/file_picker.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:al_murafiq/utils/utils.dart';
import 'package:al_murafiq/widgets/widgets.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'package:al_murafiq/screens/home_page/categories/categories_bloc.dart';
import 'package:al_murafiq/models/categories.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_localizations/flutter_localizations.dart' as local;
import 'package:map/map.dart';
import 'package:latlng/latlng.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as lng;
import 'edit_company/map_teat.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AddBranchOfCompanyScreen extends StatefulWidget {
  dynamic lng, lat;
  final bool? beCompany;

  AddBranchOfCompanyScreen({Key? key, this.lng, this.lat, this.beCompany})
      : super(key: key);
  @override
  _AddBranchOfCompanyScreenState createState() =>
      _AddBranchOfCompanyScreenState();
}

class _AddBranchOfCompanyScreenState extends State<AddBranchOfCompanyScreen> {
  AddBranchesOfCompanyBloc _addBranchesOfCompanyBloc =
      AddBranchesOfCompanyBloc();
  File? _selectedImage;
  String _valueChangedFrom = '';
  String _valueToValidateFrom = '';
  String _valueSavedFrom = '';
  TextEditingController? _controllerFrom;
  String _valueChangedTo = '';
  String _valueToValidateTo = '';
  String _valueSavedTo = '';
  String _valueTimeTo = 'select_time'.tr;
  String _valueTimeFrom = 'select_time'.tr;
  TextEditingController? _controllerTo;
  @override
  void initState() {
    _addBranchesOfCompanyBloc.fetchDataAllCategories(1);
    _addBranchesOfCompanyBloc.fetchAllCountries(1);
    // _bloc.fetchProfileData();
    String lsHour = TimeOfDay.now().hour.toString().padLeft(2, '0');
    String lsMinute = TimeOfDay.now().minute.toString().padLeft(2, '0');
    _controllerFrom = TextEditingController(text: '$lsHour:$lsMinute');
    _controllerTo = TextEditingController(text: '$lsHour:$lsMinute');

    // TODO: implement initState
    super.initState();
  }

  File? _image;
  List<String> LIST_DAYS = <String>[
    'Saturday'.tr,
    'Sunday'.tr,
    'Monday'.tr,
    'Tuesday'.tr,
    'Wednesday'.tr,
    'Thursday'.tr,
    'Friday'.tr,
  ];

  var LIST_DAYsS = {
    'Saturday'.tr: 'Saturday',
    'Sunday'.tr: 'Sunday',
    'Monday'.tr: 'Monday',
    'Tuesday'.tr: 'Tuesday',
    'Wednesday'.tr: 'Wednesday',
    'Thursday'.tr: 'Thursday',
    'Friday'.tr: 'Friday',
  };
  final picker = ImagePicker();
  SharedPreferenceHelper _helper = GetIt.instance.get<SharedPreferenceHelper>();
  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      appBar: GradientAppbar(
        title: widget.beCompany! ? 'side_be_company'.tr : 'text_add_branch'.tr,
      ),
      body: SingleChildScrollView(
        child:
            // StreamBuilder<ProfileEditUserAndDelegate>(
            //   stream: _bloc.getProfileData.stream,
            //   builder: (context, getProfileDatasnapshot) {
            //     if(getProfileDatasnapshot.hasData){
            //      // _bloc.fetchAllCountries();
            //       _bloc.nameController.text=getProfileDatasnapshot.data.name;
            //       _bloc.emailOrPhoneController.text=getProfileDatasnapshot.data.email;
            //       _bloc.phoneController.text=getProfileDatasnapshot.data.phone;
            //       _bloc.nationalIDController.text=getProfileDatasnapshot.data.national_id;
            //
            //       // _bloc.birthDateSubject.sink.add(DateFormat('dd-MM-yyyy').format(getProfileDatasnapshot.data.birth_date));
            //       return Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 10),
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: <Widget>[
            //             SizedBox(
            //               height: 10,
            //             ),
            //             Card(
            //               elevation: 5,
            //               shape: CircleBorder(),
            //               child: Align(
            //                 alignment: Alignment.center,
            //                 child: Stack(
            //                   children: [
            //                     ClipRRect(
            //                       borderRadius:
            //                       BorderRadius.all(Radius.circular(100)),
            //                       child: _selectedImage == null
            //                           ? Image(
            //                         height: 120,
            //                         width: 120,
            //                         fit: BoxFit.cover,
            //                         image:
            //                         NetworkImage(getProfileDatasnapshot.data.avatar != null?'$ImgUrl${getProfileDatasnapshot.data.avatar}':'https://cdn.pixabay.com/photo/2017/01/03/11/33/pizza-1949183__480.jpg'),
            //                       )
            //                           : Image(
            //                         height: 120,
            //                         width: 120,
            //                         fit: BoxFit.cover,
            //                         image: FileImage(_selectedImage),
            //                       ),
            //                     ),
            //                     ClipRRect(
            //                       borderRadius:
            //                       BorderRadius.all(Radius.circular(100)),
            //                       child: GestureDetector(
            //                         onTap: () async {
            //                           // FilePickerResult result = await FilePicker.platform.pickFiles(
            //                           //     type: FileType.image);
            //                           // if (result != null) {
            //                           //   //bool res = await _bloc.updateAvatar(file);
            //                           //   // if (res) {
            //                           //   //   setState(() {
            //                           //   //     _selectedImage = file;
            //                           //   //   });
            //                           //   // }
            //                           //   setState(() {
            //                           //
            //                           //     _selectedImage = File(result.files.single.path);
            //                           //   });
            //                           // }
            //                         },
            //                         child: Container(
            //                           height: 120,
            //                           width: 120,
            //                           color: kPrimaryColor.withAlpha(100),
            //                           child: Column(
            //                             mainAxisAlignment: MainAxisAlignment.center,
            //                             children: <Widget>[
            //                               Icon(
            //                                 MdiIcons.image,
            //                                 color: Colors.white,
            //                                 size: 30,
            //                               ),
            //                               Text(
            //                                 'Change_Photo',
            //                                 style: TextStyle(color: Colors.white),
            //                               ),
            //                             ],
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //
            //
            //             Text(context.translate('full name'),
            //                 style: TextStyle(fontSize: 14, color: Colors.grey.shade600))
            //                 .addPaddingOnly(right: 8, top: 15,left: 8, bottom: 10),
            //
            //             StreamBuilder<bool>(
            //                 stream: _bloc.nameSubject.stream,
            //                 initialData: true,
            //                 builder: (context, snapshot) {
            //                   print(snapshot.data);
            //                   return TextField(
            //                     style: TextStyle(fontSize: 18),
            //                     decoration: InputDecoration(
            //                       filled: true,
            //                       fillColor: const Color(0xFFE0E7FF),
            //                       focusedBorder: OutlineInputBorder(
            //                         borderRadius:
            //                         const BorderRadius.all(Radius.circular(6)),
            //                         borderSide:
            //                         BorderSide(width: 1, color: context.accentColor),
            //                       ),
            //                       disabledBorder: const OutlineInputBorder(
            //                         borderRadius: BorderRadius.all(Radius.circular(6)),
            //                         borderSide: BorderSide(width: 1, color: Colors.black54),
            //                       ),
            //                       enabledBorder: const OutlineInputBorder(
            //                         borderRadius: BorderRadius.all(Radius.circular(6)),
            //                         borderSide:
            //                         BorderSide(width: 1, color: Color(0xFFC2C3DF)),
            //                       ),
            //                       border: const OutlineInputBorder(
            //                           borderRadius: BorderRadius.all(Radius.circular(6)),
            //                           borderSide: BorderSide(width: 1)),
            //                       errorBorder: const OutlineInputBorder(
            //                           borderRadius: BorderRadius.all(Radius.circular(6)),
            //                           borderSide: BorderSide(width: 1, color: Colors.red)),
            //                       focusedErrorBorder: OutlineInputBorder(
            //                           borderRadius:
            //                           const BorderRadius.all(Radius.circular(6)),
            //                           borderSide:
            //                           BorderSide(width: 1, color: Colors.red.shade800)),
            //                       hintText: 'murafiq',
            //                       hintStyle: const TextStyle(
            //                           fontSize: 16, color: Color(0xFF9797AD)),
            //                       errorText: snapshot.data ? null : 'name is not empty',
            //                     ),
            //                     keyboardType: TextInputType.text,
            //                     onChanged: (val) =>  _bloc.changeName(val),
            //                     controller: _bloc.nameController,
            //                   );
            //                 }),
            //             Text(context.translate('email'),
            //                 style: TextStyle(fontSize: 14, color: Colors.grey.shade600))
            //                 .addPaddingOnly(right: 8,left: 8, top: 15, bottom: 10),
            //             StreamBuilder<bool>(
            //                 stream:  _bloc.emailOrPhoneSubject.stream,
            //                 initialData: true,
            //                 builder: (context, snapshot) {
            //                   return TextField(
            //                     style: TextStyle(fontSize: 18),
            //                     decoration: InputDecoration(
            //                       filled: true,
            //                       fillColor: const Color(0xFFE0E7FF),
            //                       focusedBorder: OutlineInputBorder(
            //                         borderRadius:
            //                         const BorderRadius.all(Radius.circular(6)),
            //                         borderSide:
            //                         BorderSide(width: 1, color: context.accentColor),
            //                       ),
            //                       disabledBorder: const OutlineInputBorder(
            //                         borderRadius: BorderRadius.all(Radius.circular(6)),
            //                         borderSide: BorderSide(width: 1, color: Colors.black54),
            //                       ),
            //                       enabledBorder: const OutlineInputBorder(
            //                         borderRadius: BorderRadius.all(Radius.circular(6)),
            //                         borderSide:
            //                         BorderSide(width: 1, color: Color(0xFFC2C3DF)),
            //                       ),
            //                       border: const OutlineInputBorder(
            //                           borderRadius: BorderRadius.all(Radius.circular(6)),
            //                           borderSide: BorderSide(width: 1)),
            //                       errorBorder: const OutlineInputBorder(
            //                           borderRadius: BorderRadius.all(Radius.circular(6)),
            //                           borderSide: BorderSide(width: 1, color: Colors.red)),
            //                       focusedErrorBorder: OutlineInputBorder(
            //                           borderRadius:
            //                           const BorderRadius.all(Radius.circular(6)),
            //                           borderSide:
            //                           BorderSide(width: 1, color: Colors.red.shade800)),
            //                       hintText: 'murafiq@gmail.com',
            //                       hintStyle: const TextStyle(
            //                           fontSize: 16, color: Color(0xFF9797AD)),
            //                       errorText: snapshot.data
            //                           ? null
            //                           : context.translate('email_error'),
            //                     ),
            //                     keyboardType: TextInputType.emailAddress,
            //                     onChanged: (val) =>  _bloc.changeEmailOrPhone(val),
            //                     controller:  _bloc.emailOrPhoneController,
            //                   );
            //                 }),
            //
            //             Text(context.translate('phone'),
            //                 style: TextStyle(fontSize: 14, color: Colors.grey.shade600))
            //                 .addPaddingOnly(right: 8,left: 8, top: 15, bottom: 5),
            //             StreamBuilder<bool>(
            //                 stream:  _bloc.phoneSubject.stream,
            //                 initialData: true,
            //                 builder: (context, snapshot) {
            //                   return TextField(
            //                     style: TextStyle(fontSize: 18),
            //                     decoration: InputDecoration(
            //                       filled: true,
            //                       fillColor: const Color(0xFFE0E7FF),
            //                       focusedBorder: OutlineInputBorder(
            //                         borderRadius:
            //                         const BorderRadius.all(Radius.circular(6)),
            //                         borderSide:
            //                         BorderSide(width: 1, color: context.accentColor),
            //                       ),
            //                       disabledBorder: const OutlineInputBorder(
            //                         borderRadius: BorderRadius.all(Radius.circular(6)),
            //                         borderSide: BorderSide(width: 1, color: Colors.black54),
            //                       ),
            //                       enabledBorder: const OutlineInputBorder(
            //                         borderRadius: BorderRadius.all(Radius.circular(6)),
            //                         borderSide:
            //                         BorderSide(width: 1, color: Color(0xFFC2C3DF)),
            //                       ),
            //                       border: const OutlineInputBorder(
            //                           borderRadius: BorderRadius.all(Radius.circular(6)),
            //                           borderSide: BorderSide(width: 1)),
            //                       errorBorder: const OutlineInputBorder(
            //                           borderRadius: BorderRadius.all(Radius.circular(6)),
            //                           borderSide: BorderSide(width: 1, color: Colors.red)),
            //                       focusedErrorBorder: OutlineInputBorder(
            //                           borderRadius:
            //                           const BorderRadius.all(Radius.circular(6)),
            //                           borderSide:
            //                           BorderSide(width: 1, color: Colors.red.shade800)),
            //                       hintText: '',
            //                       hintStyle: const TextStyle(
            //                           fontSize: 16, color: Color(0xFF9797AD)),
            //                       errorText: snapshot.data ? null : 'must be 11 number',
            //                     ),
            //                     keyboardType: TextInputType.phone,
            //                     onChanged: (val) =>  _bloc.changePhone(val),
            //                     controller:  _bloc.phoneController,
            //                   );
            //                 }),
            //             Text(context.translate('number'),
            //                 style: TextStyle(fontSize: 14, color: Colors.grey.shade600))
            //                 .addPaddingOnly(right: 8,left: 8, top: 15, bottom: 5),
            //
            //             StreamBuilder<bool>(
            //                 stream: _bloc.nationalIDSubject.stream,
            //                 initialData: true,
            //                 builder: (context, snapshot) {
            //                   return TextField(
            //                     style: TextStyle(fontSize: 18),
            //                     decoration: InputDecoration(
            //                       filled: true,
            //                       fillColor: const Color(0xFFE0E7FF),
            //                       focusedBorder: OutlineInputBorder(
            //                         borderRadius:
            //                         const BorderRadius.all(Radius.circular(6)),
            //                         borderSide:
            //                         BorderSide(width: 1, color: context.accentColor),
            //                       ),
            //                       disabledBorder: const OutlineInputBorder(
            //                         borderRadius: BorderRadius.all(Radius.circular(6)),
            //                         borderSide: BorderSide(width: 1, color: Colors.black54),
            //                       ),
            //                       enabledBorder: const OutlineInputBorder(
            //                         borderRadius: BorderRadius.all(Radius.circular(6)),
            //                         borderSide:
            //                         BorderSide(width: 1, color: Color(0xFFC2C3DF)),
            //                       ),
            //                       border: const OutlineInputBorder(
            //                           borderRadius: BorderRadius.all(Radius.circular(6)),
            //                           borderSide: BorderSide(width: 1)),
            //                       errorBorder: const OutlineInputBorder(
            //                           borderRadius: BorderRadius.all(Radius.circular(6)),
            //                           borderSide: BorderSide(width: 1, color: Colors.red)),
            //                       focusedErrorBorder: OutlineInputBorder(
            //                           borderRadius:
            //                           const BorderRadius.all(Radius.circular(6)),
            //                           borderSide:
            //                           BorderSide(width: 1, color: Colors.red.shade800)),
            //                       hintText: '',
            //                       hintStyle: const TextStyle(
            //                           fontSize: 16, color: Color(0xFF9797AD)),
            //                       errorText: snapshot.data ? null : 'must be 14 number',
            //                     ),
            //                     keyboardType: TextInputType.number,
            //                     onChanged: (val) => _bloc.changeNationalID(val),
            //                     controller: _bloc.nationalIDController,
            //                   );
            //                 }),
            //             const SizedBox(
            //               height: 15,
            //             ),
            //
            //             Row(
            //               children: [
            //                 Expanded(
            //                   child: Padding(
            //                     padding: const EdgeInsets.symmetric(horizontal: 0),
            //                     child: Container(
            //                       decoration: BoxDecoration(
            //                           borderRadius: BorderRadius.circular(10),
            //                           color: Color(0xffE0E7FF)),
            //                       child: StreamBuilder<List<CountriesData>>(
            //                           stream: _bloc.allCountriesSubject.stream,
            //                           builder: (context, countriesSnapshot) {
            //                             if (countriesSnapshot.hasData) {
            //                               return StreamBuilder<CountriesData>(
            //                                   stream: _bloc.selectedCountry.stream,
            //                                   builder: (context, snapshot) {
            //                                     return Padding(
            //                                       padding: const EdgeInsets.symmetric(
            //                                           horizontal: 10, vertical: 2),
            //                                       child: DropdownButton<CountriesData>(
            //                                           dropdownColor: Colors.white,
            //                                           iconEnabledColor: Colors.grey,
            //                                           iconSize: 32,
            //                                           elevation: 3,
            //                                           icon: Icon(
            //                                               Icons.arrow_drop_down_outlined),
            //                                           items: countriesSnapshot.data
            //                                               .map((item) {
            //                                             return DropdownMenuItem<
            //                                                 CountriesData>(
            //                                                 value: item,
            //                                                 child: Row(
            //                                                   children: [
            //                                                     item.icon != null?
            //                                                     Image.network(
            //                                                       '$ImgUrl${item.icon}',
            //                                                       width: 32,
            //                                                       height: 32,
            //                                                     ):SizedBox(),
            //                                                     SizedBox(
            //                                                       width: 5,
            //                                                     ),
            //                                                     AutoSizeText(
            //                                                       item.name,
            //                                                       style: kTextStyle.copyWith(
            //                                                           fontSize: 18),
            //                                                       minFontSize: 14,
            //                                                       maxFontSize: 18,
            //                                                     ),
            //                                                   ],
            //                                                 ));
            //                                           }).toList(),
            //                                           isExpanded: true,
            //                                           hint: Text(
            //                                             'Select Countries',
            //                                             style: kTextStyle.copyWith(
            //                                                 color: Colors.black),
            //                                           ),
            //                                           style: kTextStyle.copyWith(
            //                                               color: Colors.black),
            //                                           underline: SizedBox(),
            //                                           value: snapshot.data,
            //                                           onChanged: (CountriesData item) {
            //                                             print(item.name);
            //                                             _bloc.selectedCities.sink.add(null);
            //                                             _bloc.selectedCountry.sink
            //                                                 .add(item);
            //                                             print(_bloc
            //                                                 .selectedCountry.value.name);
            //                                           }),
            //                                     );
            //                                   });
            //                             } else {
            //                               return const Padding(
            //                                 padding: EdgeInsets.all(8.0),
            //                                 child: Center(
            //                                     child: CircularProgressIndicator(
            //                                       valueColor: AlwaysStoppedAnimation<Color>(
            //                                           kAccentColor),
            //                                     )),
            //                               );
            //                             }
            //                           }),
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //             const SizedBox(
            //               height: 15,
            //             ),
            //
            //             Row(
            //               children: [
            //                 Expanded(
            //                   child: Padding(
            //                     padding: const EdgeInsets.symmetric(horizontal: 0),
            //                     child: Container(
            //                       decoration: BoxDecoration(
            //                           borderRadius: BorderRadius.circular(10),
            //                           color: Color(0xffE0E7FF)),
            //                       child: StreamBuilder<CountriesData>(
            //                           stream: _bloc.selectedCountry.stream,
            //                           builder: (context, snapshot) {
            //                             if (snapshot.hasData) {
            //                               return StreamBuilder<CitiesData>(
            //                                   stream: _bloc.selectedCities.stream,
            //                                   builder: (context, citySnapshot) {
            //                                     return Padding(
            //                                       padding: const EdgeInsets.symmetric(
            //                                           horizontal: 10, vertical: 2),
            //                                       child: DropdownButton<CitiesData>(
            //                                           dropdownColor: Colors.white,
            //                                           iconEnabledColor: Colors.grey,
            //                                           iconSize: 32,
            //                                           elevation: 3,
            //                                           icon: Icon(
            //                                               Icons.arrow_drop_down_outlined),
            //                                           items:
            //                                           snapshot.data.cities.map((item) {
            //                                             return DropdownMenuItem<CitiesData>(
            //                                                 value: item,
            //                                                 child: AutoSizeText(
            //                                                   item.name,
            //                                                   style: kTextStyle.copyWith(
            //                                                       fontSize: 18),
            //                                                   minFontSize: 14,
            //                                                   maxFontSize: 18,
            //                                                 ));
            //                                           }).toList(),
            //                                           isExpanded: true,
            //                                           hint: Text(
            //                                             'Select city',
            //                                             style: kTextStyle.copyWith(
            //                                                 color: Colors.black),
            //                                           ),
            //                                           style: kTextStyle.copyWith(
            //                                               color: Colors.black),
            //                                           underline: SizedBox(),
            //                                           value: citySnapshot.data,
            //                                           onChanged: (CitiesData item) {
            //                                             print(item.name);
            //                                             _bloc.selectedCities.sink.add(item);
            //                                             print(_bloc.selectedCities.value);
            //                                           }),
            //                                     );
            //                                   });
            //                             } else
            //                               return SizedBox();
            //                           }),
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //             const SizedBox(
            //               height: 15,
            //             ),
            //             Row(
            //               children: [
            //                 Expanded(
            //                   child: Padding(
            //                     padding: const EdgeInsets.symmetric(horizontal: 0),
            //                     child: Container(
            //                       decoration: BoxDecoration(
            //                           borderRadius: BorderRadius.circular(10),
            //                           color: Color(0xFFE0E7FF)),
            //                       child:
            //                       StreamBuilder<List<Languages>>(
            //                           stream: _bloc.allLanguageSubject.stream,
            //                           builder: (context, snapshot) {
            //                             if (snapshot.hasData) {
            //                               return StreamBuilder<Languages>(
            //                                   stream: _bloc.selectedLanguage.stream,
            //
            //                                   builder: (context, langSnapshot) {
            //                                     return Padding(
            //                                       padding: const EdgeInsets.symmetric(
            //                                           horizontal: 10, vertical: 2),
            //                                       child: DropdownButton<Languages>(
            //                                           dropdownColor: Colors.white,
            //                                           iconEnabledColor: Colors.grey,
            //                                           iconSize: 32,
            //                                           elevation: 3,
            //                                           icon: Icon(Icons
            //                                               .arrow_drop_down_outlined),
            //                                           items: snapshot.data
            //                                               .map((item) {
            //                                             return DropdownMenuItem<
            //                                                 Languages>(
            //                                                 value: item,
            //                                                 child: AutoSizeText(
            //                                                   item.name,
            //                                                   style:
            //                                                   kTextStyle.copyWith(
            //                                                       fontSize: 18),
            //                                                   minFontSize: 14,
            //                                                   maxFontSize: 18,
            //                                                 ));
            //                                           }).toList(),
            //                                           isExpanded: true,
            //                                           hint: Row(
            //                                             children: [
            //                                               Icon(Icons.language_sharp),
            //                                               Text(
            //                                                 'Select Languages',
            //                                                 style:
            //                                                 kTextStyle.copyWith(
            //                                                     color:
            //                                                     Colors.black),
            //                                               ),
            //                                             ],
            //                                           ),
            //                                           style: kTextStyle.copyWith(
            //                                               color: Colors.black),
            //                                           underline: SizedBox(),
            //                                           value:  langSnapshot.data,
            //                                           onChanged: (Languages item) {
            //                                             print(item.name);
            //                                             _bloc.selectedLanguage.sink
            //                                                 .add(item);
            //                                             print(_bloc
            //                                                 .selectedLanguage.value);
            //                                           }),
            //                                     );
            //                                   });
            //                             } else
            //                               return  Padding(
            //                                 padding: EdgeInsets.all(8.0),
            //                                 child: Center(
            //                                     child: CircularProgressIndicator(
            //                                       valueColor:
            //                                       AlwaysStoppedAnimation<Color>(
            //                                           kAccentColor),
            //                                     )),
            //                               );
            //                           }),
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //
            //             Text(context.translate('pass'),
            //                 style: TextStyle(fontSize: 14, color: Colors.grey.shade600))
            //                 .addPaddingOnly(right: 8,left: 8, top: 15, bottom: 5),
            //             StreamBuilder<bool>(
            //                 stream:  _bloc.passwordSubject.stream,
            //                 initialData: true,
            //                 builder: (context, snapshot) {
            //                   return StreamBuilder<bool>(
            //                       stream:  _bloc.obscurePasswordSubject.stream,
            //                       initialData: true,
            //                       builder: (context, obscureSnapshot) {
            //                         return TextField(
            //                           style: TextStyle(fontSize: 18),
            //                           decoration: InputDecoration(
            //                             filled: true,
            //                             fillColor: const Color(0xFFE0E7FF),
            //                             focusedBorder: OutlineInputBorder(
            //                               borderRadius:
            //                               const BorderRadius.all(Radius.circular(6)),
            //                               borderSide: BorderSide(
            //                                   width: 1, color: context.accentColor),
            //                             ),
            //                             disabledBorder: const OutlineInputBorder(
            //                               borderRadius:
            //                               BorderRadius.all(Radius.circular(6)),
            //                               borderSide:
            //                               BorderSide(width: 1, color: Colors.black54),
            //                             ),
            //                             enabledBorder: const OutlineInputBorder(
            //                               borderRadius:
            //                               BorderRadius.all(Radius.circular(6)),
            //                               borderSide: BorderSide(
            //                                   width: 1, color: Color(0xFFC2C3DF)),
            //                             ),
            //                             border: const OutlineInputBorder(
            //                                 borderRadius:
            //                                 BorderRadius.all(Radius.circular(6)),
            //                                 borderSide: BorderSide(width: 1)),
            //                             errorBorder: const OutlineInputBorder(
            //                                 borderRadius:
            //                                 BorderRadius.all(Radius.circular(6)),
            //                                 borderSide:
            //                                 BorderSide(width: 1, color: Colors.red)),
            //                             focusedErrorBorder: OutlineInputBorder(
            //                                 borderRadius:
            //                                 const BorderRadius.all(Radius.circular(6)),
            //                                 borderSide: BorderSide(
            //                                     width: 1, color: Colors.red.shade800)),
            //                             hintStyle: const TextStyle(
            //                                 fontSize: 16, color: Color(0xFF9797AD)),
            //                             errorText: snapshot.data
            //                                 ? null
            //                                 : context.translate('pass_error'),
            //                             suffixIcon: GestureDetector(
            //                                 onTap: () {
            //                                   _bloc.obscurePasswordSubject.sink.add(
            //                                       ! _bloc.obscurePasswordSubject.value);
            //                                 },
            //                                 child: Icon(obscureSnapshot.data
            //                                     ? Icons.visibility
            //                                     : Icons.visibility_off)),
            //                           ),
            //                           keyboardType: TextInputType.visiblePassword,
            //                           onChanged: (val) =>  _bloc.changePassword(val),
            //                           controller:  _bloc.passwordController,
            //                           obscureText: obscureSnapshot.data,
            //                         );
            //                       });
            //                 }),
            //             // Text(context.translate('re-pass'),
            //             //     style: TextStyle(fontSize: 14, color: Colors.grey.shade600))
            //             //     .addPaddingOnly(right: 8,left: 8, top: 15, bottom: 5),
            //             // StreamBuilder<bool>(
            //             //     //stream: widget.bloc.confirmePasswordSubject.stream,
            //             //     initialData: true,
            //             //     builder: (context, snapshot) {
            //             //       return StreamBuilder<bool>(
            //             //          // stream: widget.bloc.obscureConfirmePasswordSubject.stream,
            //             //           initialData: true,
            //             //           builder: (context, obscureCoSnapshot) {
            //             //             return TextField(
            //             //               style: TextStyle(fontSize: 18),
            //             //               decoration: InputDecoration(
            //             //                 filled: true,
            //             //                 fillColor: const Color(0xFFE0E7FF),
            //             //                 focusedBorder: OutlineInputBorder(
            //             //                   borderRadius:
            //             //                   const BorderRadius.all(Radius.circular(6)),
            //             //                   borderSide: BorderSide(
            //             //                       width: 1, color: context.accentColor),
            //             //                 ),
            //             //                 disabledBorder: const OutlineInputBorder(
            //             //                   borderRadius:
            //             //                   BorderRadius.all(Radius.circular(6)),
            //             //                   borderSide:
            //             //                   BorderSide(width: 1, color: Colors.black54),
            //             //                 ),
            //             //                 enabledBorder: const OutlineInputBorder(
            //             //                   borderRadius:
            //             //                   BorderRadius.all(Radius.circular(6)),
            //             //                   borderSide: BorderSide(
            //             //                       width: 1, color: Color(0xFFC2C3DF)),
            //             //                 ),
            //             //                 border: const OutlineInputBorder(
            //             //                     borderRadius:
            //             //                     BorderRadius.all(Radius.circular(6)),
            //             //                     borderSide: BorderSide(width: 1)),
            //             //                 errorBorder: const OutlineInputBorder(
            //             //                     borderRadius:
            //             //                     BorderRadius.all(Radius.circular(6)),
            //             //                     borderSide:
            //             //                     BorderSide(width: 1, color: Colors.red)),
            //             //                 focusedErrorBorder: OutlineInputBorder(
            //             //                     borderRadius:
            //             //                     const BorderRadius.all(Radius.circular(6)),
            //             //                     borderSide: BorderSide(
            //             //                         width: 1, color: Colors.red.shade800)),
            //             //                 hintStyle: const TextStyle(
            //             //                     fontSize: 16, color: Color(0xFF9797AD)),
            //             //                 errorText: snapshot.data
            //             //                     ? null
            //             //                     : context.translate('pass_error'),
            //             //                 suffixIcon: GestureDetector(
            //             //                     // onTap: () {
            //             //                     //   widget
            //             //                     //       .bloc.obscureConfirmePasswordSubject.sink
            //             //                     //       .add(!widget
            //             //                     //       .bloc
            //             //                     //       .obscureConfirmePasswordSubject
            //             //                     //       .value);
            //             //                     // },
            //             //                     child: Icon(obscureCoSnapshot.data
            //             //                         ? Icons.visibility
            //             //                         : Icons.visibility_off)),
            //             //               ),
            //             //               keyboardType: TextInputType.visiblePassword,
            //             //               // onChanged: (val) =>widget.bloc.changeConfirmePassword(val),
            //             //               // controller: widget.bloc.confirmePasswordController,
            //             //               obscureText: obscureCoSnapshot.data,
            //             //             );
            //             //           });
            //             //     }),
            //
            //             Text(context.translate('sex'),
            //                 style: TextStyle(fontSize: 14, color: Colors.grey.shade600))
            //                 .addPaddingOnly(right: 8,left: 8, top: 15, bottom: 5),
            //             StreamBuilder<String>(
            //                 stream:  _bloc.genderSubject.stream,
            //                 builder: (BuildContext context, snapshot) {
            //                   return DropButton(
            //                     onChanged:  _bloc.genderChanged,
            //                     values: LIST_KIND,
            //                     value:
            //                     snapshot.data != null
            //                         ?  _bloc.genderSubject.value
            //                         : LIST_KIND[0],
            //                   ).addPaddingOnly(top: 5);
            //                 }),
            //             Text(context.translate('birth'),
            //                 style: TextStyle(fontSize: 14, color: Colors.grey.shade600))
            //                 .addPaddingOnly(right: 8,left: 8, top: 15, bottom: 5),
            //             // TODO(Kareem): make these drop buttons with (kay).
            //
            //             InkWell(
            //               onTap: () =>  _bloc.birthDateChanged(context),
            //               child: StreamBuilder<DateTime>(
            //                   stream:  _bloc.birthDateSubject.stream,
            //                   initialData: DateTime.now(),
            //                   builder: (BuildContext context, snapshot) {
            //                     final DateTime date = snapshot.data ?? DateTime.now();
            //                     return TextFieldOutlineBorder(
            //                       enabled: false,
            //                       keyboardType: TextInputType.name,
            //                       textInputAction: TextInputAction.done,
            //                       hintText: '${date.year}/${date.month}/${date.day}',
            //                     ).addPaddingOnly(left: 0, right: 0);
            //                   }),
            //             ),
            //             SizedBox(
            //               height: 15,
            //             ),
            //             Padding(
            //               padding: const EdgeInsets.symmetric(vertical: 30),
            //               child: RoundedLoadingButton(
            //                 child: Text(
            //                   'Edit',
            //                   style: kTextStyle.copyWith(fontSize: 20,color: Color(0xffFFFFFF)),
            //                 ),
            //                 height: 50,
            //                 controller:  _bloc.loadingButtonController,
            //                 color: Colors.blue.shade800,
            //                 onPressed: () async {
            //                   _bloc.loadingButtonController.start();
            //                   await _bloc.confirmEditProfileUserAndDelegate(getProfileDatasnapshot.data);
            //                   _bloc.loadingButtonController.stop();
            //                 },
            //               ),
            //             ),
            //           ],
            //         ).addPaddingOnly(bottom: 28),
            //       );
            //     }else{
            //       return SizedBox(
            //           height: Get.height,
            //           child: Center(
            //               child: CircularProgressIndicator(
            //                 backgroundColor: kPrimaryColor,
            //               )));
            //     }
            //
            //   }
            // ),
            Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              StreamBuilder<File>(
                  stream: _addBranchesOfCompanyBloc.imageController.stream,
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
                                        _addBranchesOfCompanyBloc
                                            .imageController.sink
                                            .add(img);
                                      }
                                    } catch (e) {}
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
                                    _addBranchesOfCompanyBloc
                                        .imageController.sink
                                        .add(img);
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
                                    'Select Photo',
                                    style: kTextStyle,
                                    softWrap: true,
                                    maxFontSize: 20,
                                    minFontSize: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  }),

              Row(
                children: [
                  Text('text_place_name'.tr,
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade600))
                      .addPaddingOnly(right: 8, left: 8, top: 15, bottom: 5),
                  Text('*', style: TextStyle(fontSize: 14, color: Colors.red))
                      .addPaddingOnly(top: 15),
                ],
              ),
              StreamBuilder<bool>(
                  stream: _addBranchesOfCompanyBloc.namePlaceSubject.stream,
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
                          borderSide:
                              BorderSide(width: 1, color: Colors.black54),
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
                            snapshot.data! ? null : 'text_place_name_error'.tr,
                      ),
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => node.nextFocus(),
                      keyboardType: TextInputType.text,
                      onChanged: (val) =>
                          _addBranchesOfCompanyBloc.changeNamePlace(val),
                      controller: _addBranchesOfCompanyBloc.namePlaceController,
                    );
                  }),
              Row(
                children: [
                  Text('text_description'.tr,
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade600))
                      .addPaddingOnly(right: 8, left: 8, top: 15, bottom: 5),
                  Text('*', style: TextStyle(fontSize: 14, color: Colors.red))
                      .addPaddingOnly(top: 15),
                ],
              ),
              StreamBuilder<bool>(
                  stream: _addBranchesOfCompanyBloc.desSubject.stream,
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
                          borderSide:
                              BorderSide(width: 1, color: Colors.black54),
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
                            snapshot.data! ? null : 'text_description_error'.tr,
                      ),
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => node.nextFocus(),
                      keyboardType: TextInputType.text,
                      onChanged: (val) =>
                          _addBranchesOfCompanyBloc.changeDes(val),
                      controller: _addBranchesOfCompanyBloc.desController,
                      maxLines: 3,
                    );
                  }),
              Row(
                children: [
                  Text('text_address'.tr,
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade600))
                      .addPaddingOnly(right: 8, left: 8, top: 15, bottom: 5),
                  Text('*', style: TextStyle(fontSize: 14, color: Colors.red))
                      .addPaddingOnly(top: 15),
                ],
              ),
              StreamBuilder<bool>(
                  stream: _addBranchesOfCompanyBloc.addressSubject.stream,
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
                          borderSide:
                              BorderSide(width: 1, color: Colors.black54),
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
                            snapshot.data! ? null : 'text_address_error'.tr,
                      ),
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => node.nextFocus(),
                      keyboardType: TextInputType.text,
                      onChanged: (val) =>
                          _addBranchesOfCompanyBloc.changeAdress(val),
                      controller: _addBranchesOfCompanyBloc.addressController,
                    );
                  }),
              GestureDetector(
                onTap: () async {
                  // locationPicker.LocationResult result =
                  //     await locationPicker.showLocationPicker(
                  //   context,
                  //   'AIzaSyCojvOL87lFBZWjfUGiu_aS22WY0QyudSA',
                  //   initialCenter: lng.LatLng(widget.lat, widget.lng),
                  //   //automaticallyAnimateToCurrentLocation: true,
                  //   //mapStylePath: 'assets/mapStyle.json',
                  //   myLocationButtonEnabled: true,
                  //   // requiredGPS: true,
                  //   layersButtonEnabled: true,
                  //   // countries: ['AE', 'NG'],
                  //   //resultCardAlignment: Alignment.bottomCenter,
                  //   desiredAccuracy: LocationAccuracy.best,
                  // );
                  // print('result = $result');
                  // print('result = ${result.latLng.latitude}');
                  // print('result = ${result.latLng.longitude}');
                  // print('result = ${result.address}');

                  // setState(() {
                  //   // _addBranchesOfCompanyBloc.lanSubject.value=result.latLng.latitude;
                  //   // _editCompanyBloc.lngSubject.value=result.latLng.longitude;
                  //   widget.lng = result.latLng.longitude;
                  //   widget.lat = result.latLng.latitude;

                  //   _addBranchesOfCompanyBloc.addressController.text =
                  //       result.address;
                  //   _addBranchesOfCompanyBloc.longSubject.sink
                  //       .add(result.latLng.longitude);
                  //   _addBranchesOfCompanyBloc.latSubject.sink
                  //       .add(result.latLng.latitude);
                  // });
                },
                child: BuildViewMap(widget.lng, widget.lat),
              ),
              // BuildViewMap(widget.lng,widget.lat),

              Row(
                children: [
                  Text('text_phone'.tr,
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade600))
                      .addPaddingOnly(right: 8, left: 8, top: 15, bottom: 5),
                  Text('*', style: TextStyle(fontSize: 14, color: Colors.red))
                      .addPaddingOnly(top: 15),
                ],
              ),
              StreamBuilder<bool>(
                  stream: _addBranchesOfCompanyBloc.mobileSubject.stream,
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
                          borderSide:
                              BorderSide(width: 1, color: Colors.black54),
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
                        errorText: snapshot.data! ? null : 'text_phone_error'.tr,
                      ),
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => node.nextFocus(),
                      keyboardType: TextInputType.phone,
                      //onChanged: (val) => _addBranchesOfCompanyBloc.changeMobile(val),
                      controller: _addBranchesOfCompanyBloc.mobileController,
                    );
                  }),
              Text('text_phone2'.tr,
                      style:
                          TextStyle(fontSize: 14, color: Colors.grey.shade600))
                  .addPaddingOnly(right: 8, left: 8, top: 15, bottom: 5),
              StreamBuilder<bool>(
                  stream: _addBranchesOfCompanyBloc.mobile2Subject.stream,
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
                          borderSide:
                              BorderSide(width: 1, color: Colors.black54),
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
                        errorText: snapshot.data! ? null : 'text_phone_error'.tr,
                      ),
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => node.nextFocus(),
                      keyboardType: TextInputType.phone,
                      onChanged: (val) =>
                          _addBranchesOfCompanyBloc.changeMobile2(val),
                      controller: _addBranchesOfCompanyBloc.mobile2Controller,
                    );
                  }),
              Text('text_Tel'.tr,
                      style:
                          TextStyle(fontSize: 14, color: Colors.grey.shade600))
                  .addPaddingOnly(right: 8, left: 8, top: 15, bottom: 5),
              StreamBuilder<bool>(
                  stream: _addBranchesOfCompanyBloc.phoneSubject.stream,
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
                          borderSide:
                              BorderSide(width: 1, color: Colors.black54),
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
                        errorText: snapshot.data! ? null : 'text_phone_error'.tr,
                      ),
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => node.nextFocus(),
                      keyboardType: TextInputType.phone,
                      // onChanged: (val) => _addBranchesOfCompanyBloc.changePhone(val),
                      controller: _addBranchesOfCompanyBloc.phoneController,
                    );
                  }),

              // Padding(
              //   padding: const EdgeInsets.only(top: 15),
              //   child: StreamBuilder<List<SocialController>>(
              //       stream: _addBranchesOfCompanyBloc.socialSubject.stream,
              //       initialData: [SocialController()],
              //       builder: (context, snapshot) {
              //         print(
              //             'sasa${_addBranchesOfCompanyBloc.socialSubject.stream.value}');
              //         return Column(
              //           children:
              //           List.generate(snapshot.data.length, (index) {
              //             return SocialWidget(
              //               socialItems: _addBranchesOfCompanyBloc.socialItems,
              //               controller: snapshot.data[index],
              //             );
              //           }),
              //         );
              //       }),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 25),
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       GestureDetector(
              //         onTap: () {
              //           _addBranchesOfCompanyBloc.socialSubject.sink.add(
              //               _addBranchesOfCompanyBloc.socialSubject.value
              //                 ..add(SocialController()));
              //         },
              //         child: Container(
              //           decoration: const BoxDecoration(
              //               color: Colors.white,
              //               borderRadius:
              //               BorderRadius.all(Radius.circular(8.0)),
              //               boxShadow: [
              //                 BoxShadow(
              //                   spreadRadius: 5,
              //                   color: Color(0xffB7B6B6),
              //                   blurRadius: 7,
              //                   offset: Offset(0, 4),
              //                 ),
              //               ]),
              //           child: Padding(
              //             padding: const EdgeInsets.all(12.0),
              //             child: Text(
              //               'Add new social media account',
              //               style: TextStyle(
              //                   fontWeight: FontWeight.bold, fontSize: 17),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // Text('text_fax'.tr,
              //     style: TextStyle(
              //         fontSize: 14, color: Colors.grey.shade600))
              //     .addPaddingOnly(right: 8,left: 8, top: 15, bottom: 5),
              // StreamBuilder<bool>(
              //    stream: _addBranchesOfCompanyBloc.faxSubject.stream,
              //     initialData: true,
              //     builder: (context, snapshot) {
              //       print(snapshot.data);
              //       return TextField(
              //         style: TextStyle(fontSize: 18),
              //         decoration: InputDecoration(
              //           filled: true,
              //           fillColor: const Color(0xFFE0E7FF),
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
              //           snapshot.data ? null : 'text_fax_error'.tr,
              //         ),
              //         keyboardType: TextInputType.phone,
              //         onChanged: (val) =>_addBranchesOfCompanyBloc.changeFax(val),
              //         controller: _addBranchesOfCompanyBloc.faxController,
              //       );
              //     }),
              Row(
                children: [
                  Text('text_email'.tr,
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade600))
                      .addPaddingOnly(right: 8, left: 8, top: 15, bottom: 10),
                  Text('*', style: TextStyle(fontSize: 14, color: Colors.red))
                      .addPaddingOnly(top: 15),
                ],
              ),
              StreamBuilder<bool>(
                  stream: _addBranchesOfCompanyBloc.emailOrPhoneSubject.stream,
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
                          borderSide:
                              BorderSide(width: 1, color: Colors.black54),
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
                          _addBranchesOfCompanyBloc.changeEmailOrPhone(val),
                      controller:
                          _addBranchesOfCompanyBloc.emailOrPhoneController,
                    );
                  }),
              SizedBox(
                height: 15,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //
              //     StreamBuilder<File>(
              //         stream: _addBranchesOfCompanyBloc.pdfController.stream,
              //         initialData: null,
              //         builder: (context, snapshot) {
              //           if (snapshot.hasData && snapshot.data != null) {
              //             return Center(
              //               child: Container(
              //                 height: 120,
              //                 width: 120,
              //                 decoration: BoxDecoration(
              //                   border: Border.all(
              //                     color: kAccentColor.withOpacity(0.6),
              //                     width: 2,
              //                   ),
              //                   borderRadius: BorderRadius.circular(25),
              //                 ),
              //                 child: Stack(
              //                   fit: StackFit.expand,
              //                   children: [
              //                     ClipRRect(
              //                       borderRadius: BorderRadius.circular(25),
              //                       child: Image.asset(
              //                         'assets/images/pdf.png',
              //                         fit: BoxFit.fill,
              //
              //                         color: Colors.grey.withOpacity(0.7),
              //                       ),
              //                     ),
              //                     Center(
              //                       child: GestureDetector(
              //                         onTap: () async {
              //                           try {
              //                             FilePickerResult res =
              //                             await FilePicker.platform
              //                                 .pickFiles(
              //                                 type: FileType.custom,
              //                                 allowedExtensions: ['pdf']
              //                             );
              //                             File pdfFile = res != null
              //                                 ? File(res.files.single.path)
              //                                 : null;
              //                             print(pdfFile);
              //                             if (pdfFile != null) {
              //                               _addBranchesOfCompanyBloc.pdfController.sink
              //                                   .add(pdfFile);
              //                             }
              //                           } catch (e) {
              //                             print('--------');
              //                             print(e.toString());
              //                           }
              //                         },
              //                         child: Card(
              //                           elevation: 0,
              //                           margin: EdgeInsets.all(0),
              //                           shape: CircleBorder(),
              //                           color: kAccentColor.withOpacity(0.6),
              //                           child: Padding(
              //                               padding: EdgeInsets.all(8),
              //                               child: Icon(
              //                                 MdiIcons.filePdf,
              //                                 color: Colors.white,
              //                                 size: 32,
              //                               )),
              //                         ),
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             );
              //           } else {
              //             return Center(
              //               child: Container(
              //                 height: 120,
              //                 width: 120,
              //                 decoration: BoxDecoration(
              //                   border: Border.all(
              //                     color: kAccentColor.withOpacity(0.6),
              //                     width: 2,
              //                   ),
              //                   borderRadius: BorderRadius.circular(25),
              //                 ),
              //                 child: Center(
              //                   child: GestureDetector(
              //                     onTap: () async {
              //                       try {
              //                         FilePickerResult res = await FilePicker
              //                             .platform
              //                             .pickFiles(
              //                             type: FileType.custom,
              //                             allowedExtensions: ['pdf']
              //                         );
              //                         File pdfFile = res != null
              //                             ? File(res.files.single.path)
              //                             : null;
              //                         print(pdfFile);
              //                         if (pdfFile != null) {
              //                           _addBranchesOfCompanyBloc.pdfController.sink.add(pdfFile);
              //                         }
              //                       } catch (e) {
              //                         print('--------');
              //                         print(e.toString());
              //                       }
              //                     },
              //                     child: Column(
              //                       mainAxisAlignment:
              //                       MainAxisAlignment.center,
              //                       children: [
              //                         Card(
              //                           elevation: 0,
              //                           margin: EdgeInsets.all(0),
              //                           shape: CircleBorder(),
              //                           color: kAccentColor.withOpacity(0.6),
              //                           child: Padding(
              //                               padding: EdgeInsets.all(8),
              //                               child: Icon(
              //                                 MdiIcons.filePdf,
              //                                 color: Colors.white,
              //                                 size: 32,
              //                               )),
              //                         ),
              //                         SizedBox(
              //                           height: 2,
              //                         ),
              //                         AutoSizeText(
              //                           'Select Pdf',
              //                           style: kTextStyle,
              //                           softWrap: true,
              //                           maxFontSize: 20,
              //                           minFontSize: 16,
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             );
              //           }
              //         }),
              //     StreamBuilder<List<File>>(
              //         stream: _addBranchesOfCompanyBloc.imagesOfCompanyController.stream,
              //         initialData: null,
              //         builder: (context, snapshot) {
              //           if (snapshot.hasData && snapshot.data != null) {
              //             return Center(
              //               child: Container(
              //                 height: 120,
              //                 width: 120,
              //                 decoration: BoxDecoration(
              //                   border: Border.all(
              //                     color: kAccentColor.withOpacity(0.6),
              //                     width: 2,
              //                   ),
              //                   borderRadius: BorderRadius.circular(25),
              //                 ),
              //                 child: Stack(
              //                   fit: StackFit.expand,
              //                   children: [
              //                     // ClipRRect(
              //                     //   borderRadius: BorderRadius.circular(25),
              //                     //   child: Image.file(
              //                     //     snapshot.data,
              //                     //     fit: BoxFit.fitHeight,
              //                     //   ),
              //                     // ),
              //                     Center(
              //                       child: GestureDetector(
              //                         onTap: () async {
              //                           try {
              //                             FilePickerResult res =
              //                             await FilePicker.platform
              //                                 .pickFiles(
              //                               allowMultiple: true,
              //                               type: FileType.custom,
              //                               allowedExtensions: ['jpg','png','jpeg','gif'],
              //                             );
              //                             if(res != null) {
              //                               List<File> files = res.paths.map((path) => File(path)).toList();
              //                               print(files);
              //                               if (files != null) {
              //                                 _addBranchesOfCompanyBloc.imagesOfCompanyController.sink
              //                                     .add(files);
              //                               }
              //                             } else {
              //                               // User canceled the picker
              //                             }
              //
              //
              //                           } catch (e) {
              //                             print('--------');
              //                             print(e.toString());
              //                           }
              //                         },
              //                         child: Column(
              //                           mainAxisAlignment:MainAxisAlignment.center,
              //                           children: [
              //                             Card(
              //                               elevation: 0,
              //                               margin: EdgeInsets.all(0),
              //                               shape: CircleBorder(),
              //                               color: kAccentColor.withOpacity(0.6),
              //                               child: Padding(
              //                                   padding: EdgeInsets.all(8),
              //                                   child: Icon(
              //                                     MdiIcons.folderMultipleImage,
              //                                     color: Colors.white,
              //                                     size: 32,
              //                                   )),
              //                             ),
              //                             AutoSizeText(
              //                               'Selected ${snapshot.data.length}',
              //                               style: kTextStyle,
              //                               softWrap: true,
              //                               maxFontSize: 18,
              //                               minFontSize: 16,
              //                             ),
              //                           ],
              //                         ),
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             );
              //           } else {
              //             return Center(
              //               child: Container(
              //                 height: 120,
              //                 width: 120,
              //                 decoration: BoxDecoration(
              //                   border: Border.all(
              //                     color: kAccentColor.withOpacity(0.6),
              //                     width: 2,
              //                   ),
              //                   borderRadius: BorderRadius.circular(25),
              //                 ),
              //                 child: Center(
              //                   child: GestureDetector(
              //                     onTap: () async {
              //                       try {
              //                         FilePickerResult res = await FilePicker
              //                             .platform
              //                             .pickFiles(
              //                           allowMultiple: true,
              //                           type: FileType.custom,
              //                           allowedExtensions: ['jpg','png','jpeg','gif'],
              //                         );
              //                         if(res != null) {
              //                           List<File> files = res.paths.map((path) => File(path)).toList();
              //                           print(files);
              //                           if (files != null) {
              //                             _addBranchesOfCompanyBloc.imagesOfCompanyController.sink
              //                                 .add(files);
              //                           }
              //                         } else {
              //                           // User canceled the picker
              //                         }
              //
              //                         // File img = res != null
              //                         //     ? File(res.files.single.path)
              //                         //     : null;
              //                         // print(img);
              //                         // if (img != null) {
              //                         //   _addBranchesOfCompanyBloc.imagesOfCompanyController.sink.add(img);
              //                         // }
              //                       } catch (e) {
              //                         print('--------');
              //                         print(e.toString());
              //                       }
              //                     },
              //                     child: Column(
              //                       mainAxisAlignment:
              //                       MainAxisAlignment.center,
              //                       children: [
              //                         Card(
              //                           elevation: 0,
              //                           margin: EdgeInsets.all(0),
              //                           shape: CircleBorder(),
              //                           color: kAccentColor.withOpacity(0.6),
              //                           child: Padding(
              //                               padding: EdgeInsets.all(8),
              //                               child: Icon(
              //                                 MdiIcons.folderMultipleImage,
              //                                 color: Colors.white,
              //                                 size: 32,
              //                               )),
              //                         ),
              //                         SizedBox(
              //                           height: 2,
              //                         ),
              //                         AutoSizeText(
              //                           'Select Slider',
              //                           style: kTextStyle,
              //                           softWrap: true,
              //                           maxFontSize: 18,
              //                           minFontSize: 16,
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             );
              //           }
              //         }),
              //   ],
              // ),
              Row(
                children: [
                  Text('text_workdays'.tr,
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade600))
                      .addPaddingOnly(right: 8, left: 8, top: 15, bottom: 10),
                  Text('*', style: TextStyle(fontSize: 14, color: Colors.red))
                      .addPaddingOnly(top: 15),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  StreamBuilder<String>(
                    stream:
                        _addBranchesOfCompanyBloc.workDaysSubjectFrom.stream,
                    initialData: 'Saturday'.tr,
                    builder: (context, snapshot) {
                      return
                          //   DropButton(
                          //   onChanged: widget.bloc.languageChanged,
                          //   values: LIST_LANGUAGE,
                          //   value: snapshot.data ?? LIST_LANGUAGE[0],
                          // ).addPaddingOnly(top: 5);
                          Container(
                              height: 40,
                              width: Get.width / 3,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE0E7FF),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(6)),
                                border: Border.all(
                                    width: 1, color: context.accentColor),
                              ),
                              child: DropdownButton<String>(
                                iconSize: 30,
                                isExpanded: true,
                                value: snapshot.data!.tr,
                                dropdownColor: const Color(0xFFE0E7FF),
                                items: LIST_DAYS.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 4),
                                      child: Text(
                                        value,
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? val) {
                                  _addBranchesOfCompanyBloc
                                      .workDaysSubjectFrom.sink
                                      .add(LIST_DAYsS[val]!);
                                },
                              ).addPaddingOnly(right: 15));
                    },
                  ),
                  // StreamBuilder<String>(
                  //   stream: _addBranchesOfCompanyBloc.workDaysSubjectFrom.stream,
                  //   initialData: 'Saturday'.tr,
                  //   builder: (context, snapshot) {
                  //     return
                  //       //   DropButton(
                  //       //   onChanged: widget.bloc.languageChanged,
                  //       //   values: LIST_LANGUAGE,
                  //       //   value: snapshot.data ?? LIST_LANGUAGE[0],
                  //       // ).addPaddingOnly(top: 5);
                  //       Container(
                  //           height: 40,
                  //           width: Get.width/3,
                  //           alignment: Alignment.center,
                  //           decoration: BoxDecoration(
                  //             color: const Color(0xFFE0E7FF),
                  //             borderRadius:
                  //             const BorderRadius.all(Radius.circular(6)),
                  //             border:
                  //             Border.all(width: 1, color: context.accentColor),
                  //           ),
                  //           child: DropdownButton<String>(
                  //             iconSize: 30,
                  //             isExpanded: true,
                  //             value: snapshot.data,
                  //             dropdownColor: const Color(0xFFE0E7FF),
                  //             items: LIST_DAYS
                  //                 .map<DropdownMenuItem<String>>((String value) {
                  //               return DropdownMenuItem<String>(
                  //                 value: value,
                  //                 child: Padding(
                  //                   padding: const EdgeInsets.all(8.0),
                  //                   child: Text(value),
                  //                 ),
                  //               );
                  //             }).toList(),
                  //             onChanged: (String val) {
                  //
                  //               _addBranchesOfCompanyBloc.workDaysSubjectFrom.sink.add(LIST_DAYsS[val]);
                  //
                  //             },
                  //           ).addPaddingOnly(right: 15));
                  //   },
                  // ),
                  Text('to'.tr),
                  StreamBuilder<String>(
                    stream: _addBranchesOfCompanyBloc.workDaysSubjectTo.stream,
                    initialData: 'Saturday'.tr,
                    builder: (context, snapshot) {
                      return
                          //   DropButton(
                          //   onChanged: widget.bloc.languageChanged,
                          //   values: LIST_LANGUAGE,
                          //   value: snapshot.data ?? LIST_LANGUAGE[0],
                          // ).addPaddingOnly(top: 5);
                          Container(
                              height: 40,
                              width: Get.width / 3,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE0E7FF),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(6)),
                                border: Border.all(
                                    width: 1, color: context.accentColor),
                              ),
                              child: DropdownButton<String>(
                                iconSize: 30,
                                isExpanded: true,
                                value: snapshot.data!.tr,
                                dropdownColor: const Color(0xFFE0E7FF),
                                items: LIST_DAYS.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 4),
                                      child: Text(
                                        value,
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? val) {
                                  _addBranchesOfCompanyBloc
                                      .workDaysSubjectTo.sink
                                      .add(LIST_DAYsS[val]!);
                                  // _editCompanyBloc.workDaysSubjectTo.sink.add(val);
                                },
                              ).addPaddingOnly(right: 15));
                    },
                  ),
                  // StreamBuilder<String>(
                  //   stream: _addBranchesOfCompanyBloc.workDaysSubjectTo.stream,
                  //   initialData: 'Saturday'.tr,
                  //   builder: (context, snapshot) {
                  //     return
                  //       //   DropButton(
                  //       //   onChanged: widget.bloc.languageChanged,
                  //       //   values: LIST_LANGUAGE,
                  //       //   value: snapshot.data ?? LIST_LANGUAGE[0],
                  //       // ).addPaddingOnly(top: 5);
                  //       Container(
                  //           height: 40,
                  //           width: Get.width/3,
                  //           alignment: Alignment.center,
                  //           decoration: BoxDecoration(
                  //             color: const Color(0xFFE0E7FF),
                  //             borderRadius:
                  //             const BorderRadius.all(Radius.circular(6)),
                  //             border:
                  //             Border.all(width: 1, color: context.accentColor),
                  //           ),
                  //           child: DropdownButton<String>(
                  //             iconSize: 30,
                  //             isExpanded: true,
                  //             value: snapshot.data,
                  //             dropdownColor: const Color(0xFFE0E7FF),
                  //             items: LIST_DAYS
                  //                 .map<DropdownMenuItem<String>>((String value) {
                  //                 return DropdownMenuItem<String>(
                  //                 value: value,
                  //                 child: Padding(
                  //                   padding: const EdgeInsets.all(8.0),
                  //                   child: Text(value),
                  //                 ),
                  //               );
                  //             }).toList(),
                  //             onChanged: (String val) {
                  //
                  //               _addBranchesOfCompanyBloc.workDaysSubjectTo.sink.add(LIST_DAYsS[val]);
                  //
                  //             },
                  //           ).addPaddingOnly(right: 15));
                  //   },
                  // ),
                ],
              ),
              Row(
                children: [
                  Text('text_time_of_work'.tr,
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade600))
                      .addPaddingOnly(right: 8, left: 8, top: 15, bottom: 10),
                  Text('*', style: TextStyle(fontSize: 14, color: Colors.red))
                      .addPaddingOnly(top: 15),
                ],
              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     FlatButton(
              //
              //         onPressed: () {
              //           DatePicker.showTimePicker(context, showTitleActions: true,
              //               onChanged: (date) {
              //                 print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
              //               },
              //               onConfirm: (date) {
              //
              //                 setState(() {
              //                   _valueTimeFrom=DateFormat.jm().format(date);
              //                 });
              //                 // _addBranchesOfCompanyBloc.workTimeSubjectFrom.sink.add(_valueTimeFrom);
              //                 _addBranchesOfCompanyBloc.workTimeSubjectFrom.sink.add(date);
              //               }, currentTime: DateTime.now());
              //         },
              //         child: Row(
              //           children: [
              //             Icon(Icons.access_time),
              //             SizedBox(width: 15,),
              //             Text(
              //               _valueTimeFrom,
              //               style: TextStyle(color: Colors.black),
              //             ),
              //           ],
              //         )),
              //     Text('to'),
              //     FlatButton(
              //
              //         onPressed: () {
              //           DatePicker.showTimePicker(context, showTitleActions: true,
              //               onChanged: (date) {
              //                 print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
              //               },
              //               onConfirm: (date) {
              //
              //                 setState(() {
              //                   _valueTimeTo=DateFormat.jm().format(date);
              //                 });
              //                 // _addBranchesOfCompanyBloc.workTimeSubjectTo.sink.add(_valueTimeTo);
              //                 _addBranchesOfCompanyBloc.workTimeSubjectTo.sink.add(date);
              //               }, currentTime: DateTime.now());
              //         },
              //         child: Row(
              //           children: [
              //             Icon(Icons.access_time),
              //             SizedBox(width: 15,),
              //             Text(
              //               _valueTimeTo,
              //               style: TextStyle(color: Colors.black),
              //             ),
              //           ],
              //         )),
              //
              //   ],
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    color: Color(0xFFE0E7FF),
                    width: (Get.width / 3) + 20,
                    child: DateTimeFormField(
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.black45),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.access_time),
                        labelText: 'select_time'.tr,
                      ),
                      mode: DateTimeFieldPickerMode.time,
                      autovalidateMode: AutovalidateMode.always,
                      validator: (e) => (e.day) == 1
                          ? 'Please not the first day'
                          : null,
                      onDateSelected: (DateTime value) {
                        print(value);
                        _addBranchesOfCompanyBloc.workTimeSubjectFrom.sink
                            .add(DateFormat.Hms().format(value));
                      },
                    ),
                  ),
                  Text('to'.tr),
                  Container(
                    color: Color(0xFFE0E7FF),
                    width: (Get.width / 3) + 20,
                    child: DateTimeFormField(
                      // initialValue:  DateTime.now(),
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.black45),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.access_time),
                        labelText: 'select_time'.tr,
                      ),
                      mode: DateTimeFieldPickerMode.time,
                      autovalidateMode: AutovalidateMode.always,
                      validator: (e) => (e?.day ?? 0) == 1
                          ? 'Please not the first day'
                          : null,
                      onDateSelected: (DateTime value) {
                        print(value);
                        _addBranchesOfCompanyBloc.workTimeSubjectTo.sink
                            .add(DateFormat.Hms().format(value));
                      },
                    ),
                  ),
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     Container(
              //       height: 70,
              //       width: Get.width/3,
              //       child: Center(
              //         child: DateTimePicker(
              //           type: DateTimePickerType.time,
              //           controller: _controllerFrom,
              //           //initialValue: _initialValue,
              //           icon: Icon(Icons.access_time),
              //           //timeLabelText: "Time",
              //           //use24HourFormat: false,
              //           //locale: Locale('en', 'US'),
              //           onChanged: (val) {
              //             _addBranchesOfCompanyBloc.workTimeSubjectFrom.sink.add(val);
              //             print('worktime ${_addBranchesOfCompanyBloc.workTimeSubjectFrom.value}');
              //             _valueChangedFrom = val;
              //             // setState(() => _valueChangedFrom = val);
              //           },
              //           validator: (val) {
              //             _valueToValidateFrom = val;
              //             // setState(() => _valueToValidateFrom = val);
              //             return null;
              //           },
              //           onSaved: (val)  {
              //             _addBranchesOfCompanyBloc.workTimeSubjectFrom.sink.add(val);
              //             _valueSavedFrom = val;
              //             // setState(() => _valueSavedFrom = val)
              //           },
              //         ),
              //       ),),
              //     Text('to'),
              //     Container(
              //         height: 70,
              //         width: Get.width/3,
              //         child: Center(
              //           child: DateTimePicker(
              //             type: DateTimePickerType.time,
              //             controller: _controllerTo,
              //             //initialValue: _initialValue,
              //             icon: Icon(Icons.access_time),
              //             //timeLabelText: "Time",
              //             //use24HourFormat: false,
              //             //locale: Locale('en', 'US'),
              //             onChanged: (val) {
              //               _addBranchesOfCompanyBloc.workTimeSubjectTo.sink.add(val);
              //               print('worktime ${_addBranchesOfCompanyBloc.workTimeSubjectTo.value}');
              //               _valueChangedTo = val;
              //               },
              //                 // setState(() => _valueChangedTo = val),
              //             validator: (val) {
              //               _valueToValidateTo = val;
              //               // setState(() => _valueToValidateTo = val);
              //               return null;
              //             },
              //             onSaved: (val)  {
              //               _addBranchesOfCompanyBloc.workTimeSubjectTo.sink.add(val);
              //             print('worktime ${_addBranchesOfCompanyBloc.workTimeSubjectTo.value}');
              //               // setState(() => _valueSavedTo = val)
              //             },
              //           ),
              //         ),),
              //
              //   ],
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

              // Row(
              //   children: [
              //     Expanded(
              //       child: Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 0),
              //         child: Container(
              //           decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(10),
              //               color: Color(0xffE0E7FF)),
              //           child: StreamBuilder<List<CountriesData>>(
              //               stream: _addBranchesOfCompanyBloc.allCountriesSubject.stream,
              //               builder: (context, countriesSnapshot) {
              //                 if (countriesSnapshot.hasData) {
              //                   return StreamBuilder<CountriesData>(
              //                       stream: _addBranchesOfCompanyBloc.selectedCountry.stream,
              //                       builder: (context, snapshot) {
              //                         return Padding(
              //                           padding: const EdgeInsets.symmetric(
              //                               horizontal: 10, vertical: 2),
              //                           child: DropdownButton<CountriesData>(
              //                               dropdownColor: Colors.white,
              //                               iconEnabledColor: Colors.grey,
              //                               iconSize: 32,
              //                               elevation: 3,
              //                               icon: Icon(
              //                                   Icons.arrow_drop_down_outlined),
              //                               items: countriesSnapshot.data
              //                                   .map((item) {
              //                                 return DropdownMenuItem<
              //                                     CountriesData>(
              //                                     value: item,
              //                                     child: Row(
              //                                       children: [
              //                                         item.icon != null?
              //                                         Image.network(
              //                                           '$ImgUrl${item.icon}',
              //                                           width: 32,
              //                                           height: 32,
              //                                         ):SizedBox(),
              //                                         SizedBox(
              //                                           width: 5,
              //                                         ),
              //                                         AutoSizeText(
              //                                           item.name,
              //                                           style: kTextStyle.copyWith(
              //                                               fontSize: 14),
              //                                           minFontSize: 12,
              //                                           maxFontSize: 14,
              //                                         ),
              //                                       ],
              //                                     ));
              //                               }).toList(),
              //                               isExpanded: true,
              //                               hint: Text(
              //                                 'select_country'.tr,
              //                                 style: kTextStyle.copyWith(
              //                                     color: Colors.black),
              //                               ),
              //                               style: kTextStyle.copyWith(
              //                                   color: Colors.black),
              //                               underline: SizedBox(),
              //                               value: snapshot.data,
              //                               onChanged: (CountriesData item) {
              //
              //                                 _addBranchesOfCompanyBloc.selectedCities.sink.add(null);
              //                                 _addBranchesOfCompanyBloc.selectedCountry.sink
              //                                     .add(item);
              //                                 print(_addBranchesOfCompanyBloc
              //                                     .selectedCountry.value.name);
              //                               }),
              //                         );
              //                       });
              //                 } else {
              //                   return const Padding(
              //                     padding: EdgeInsets.all(8.0),
              //                     child: Center(
              //                         child: CircularProgressIndicator(
              //                           valueColor: AlwaysStoppedAnimation<Color>(
              //                               kAccentColor),
              //                         )),
              //                   );
              //                 }
              //               }),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),

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
                            stream: _addBranchesOfCompanyBloc
                                .selectedCountry.stream,
                            // initialData: _bloc
                            //     .allCountriesSubject.value[0],
                            builder: (context, snapshot) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (ctx) => Dialog(
                                                child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextField(
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                    decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      contentPadding:
                                                          EdgeInsets.all(9),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    6)),
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: context
                                                                .accentColor),
                                                      ),
                                                      disabledBorder:
                                                          const OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    6)),
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color:
                                                                Colors.black54),
                                                      ),
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    6)),
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: Color(
                                                                0xFFC2C3DF)),
                                                      ),
                                                      border: const OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          6)),
                                                          borderSide:
                                                              BorderSide(
                                                                  width: 1)),
                                                      hintText: 'Search',
                                                      hintStyle:
                                                          const TextStyle(
                                                              fontSize: 14,
                                                              color: Color(
                                                                  0xFF9797AD)),
                                                    ),
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    onChanged: (v) {
                                                      _addBranchesOfCompanyBloc
                                                          .sortCountry(v);
                                                    },
                                                  ),
                                                ),
                                                Divider(),
                                                Expanded(
                                                  child: StreamBuilder<
                                                          List<CountriesData>>(
                                                      stream: _addBranchesOfCompanyBloc
                                                          .allSortCountriesSubject
                                                          .stream,
                                                      builder: (context,
                                                          countriesSnapshot) {
                                                        if (countriesSnapshot
                                                            .hasData) {
                                                          return ListView
                                                              .separated(
                                                                  itemBuilder: (ctx,
                                                                      index) {
                                                                    final item =
                                                                        countriesSnapshot
                                                                            .data![index];
                                                                    return InkWell(
                                                                      onTap:
                                                                          () {
                                                                        _addBranchesOfCompanyBloc
                                                                            .selectedCountry
                                                                            .add(item);
                                                                        Get.back();
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            item.icon != null
                                                                                ? Image.network(
                                                                                    '$ImgUrl${item.icon}',
                                                                                    width: 32,
                                                                                    height: 32,
                                                                                  )
                                                                                : SizedBox(),
                                                                            SizedBox(
                                                                              width: 8,
                                                                            ),
                                                                            Text(item.name!),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                  separatorBuilder:
                                                                      (ctx,
                                                                          index) {
                                                                    return Divider();
                                                                  },
                                                                  shrinkWrap:
                                                                      true,
                                                                  itemCount:
                                                                      countriesSnapshot
                                                                          .data
                                                                          !.length);
                                                        } else {
                                                          return const Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Center(
                                                                child:
                                                                    CircularProgressIndicator(
                                                              valueColor:
                                                                  AlwaysStoppedAnimation<
                                                                          Color>(
                                                                      kAccentColor),
                                                            )),
                                                          );
                                                        }
                                                      }),
                                                )
                                              ],
                                            )));
                                  },
                                  child: snapshot.hasData
                                      ? Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Row(
                                            children: [
                                              snapshot.data!.icon != null
                                                  ? Image.network(
                                                      '$ImgUrl${snapshot.data!.icon}',
                                                      width: 32,
                                                      height: 32,
                                                    )
                                                  : SizedBox(),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                snapshot.data!.name!,
                                                style: kTextStyle.copyWith(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Row(
                                          children: [
                                            Icon(Icons.emoji_flags),
                                            Text(
                                              'select_country'.tr,
                                              // context.translate('select_country'),
                                              style: kTextStyle.copyWith(
                                                  color: Colors.black),
                                            ),
                                            // snapshot.data.icon != null
                                            //     ? Image.network(
                                            //         '$ImgUrl${snapshot.data.icon}',
                                            //         width: 32,
                                            //         height: 32,
                                            //       )
                                            //     : SizedBox(),
                                            // SizedBox(
                                            //   width: 8,
                                            // ),
                                            // Text(snapshot.data.name),
                                            Spacer(),
                                            Icon(Icons.arrow_drop_down_outlined)
                                          ],
                                        ),
                                ),
                              );
                            }),
                        // StreamBuilder<List<CountriesData>>(
                        //     stream: _bloc.allCountriesSubject.stream,
                        //     builder: (context, countriesSnapshot) {
                        //       if (countriesSnapshot.hasData) {
                        //         return StreamBuilder<CountriesData>(
                        //             stream: _bloc.selectedCountry.stream,
                        //             builder: (context, snapshot) {
                        //               return Padding(
                        //                 padding:
                        //                 const EdgeInsets.symmetric(
                        //                     horizontal: 10,
                        //                     vertical: 2),
                        //                 child: SearchableDropdown.single(
                        //                   menuBackgroundColor:
                        //                   Color(0xffE0E7FF),
                        //                     items: countriesSnapshot.data
                        //                         .map((item) {
                        //                       return DropdownMenuItem<
                        //                           CountriesData>(
                        //                           value: item,
                        //                           child: AutoSizeText(
                        //                             item.name,
                        //                             style: kTextStyle
                        //                                 .copyWith(
                        //                                 fontSize: 18),
                        //                             minFontSize: 14,
                        //                             maxFontSize: 18,
                        //                           ));
                        //                     }).toList(),
                        //                     isExpanded: true,
                        //                     hint: Text(
                        //                       'select_country'.tr,
                        //                       style: kTextStyle.copyWith(
                        //                           color: Colors.black),
                        //                     ),
                        //                     style: kTextStyle.copyWith(
                        //                         color: Colors.black),
                        //                     underline: SizedBox(),
                        //                     value: snapshot.data,
                        //                     onChanged:
                        //                         (CountriesData item) {
                        //                       _bloc.selectedCities.sink
                        //                           .add(null);
                        //                       _bloc.selectedCountry.sink
                        //                           .add(item);
                        //                     },
                        //                   searchHint: 'select_country'.tr,
                        //                     ),
                        //               );
                        //             });
                        //       } else {
                        //         return const Padding(
                        //           padding: EdgeInsets.all(8.0),
                        //           child: Center(
                        //               child: CircularProgressIndicator(
                        //                 valueColor:
                        //                 AlwaysStoppedAnimation<Color>(
                        //                     kAccentColor),
                        //               )),
                        //         );
                        //       }
                        //     }),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),

              // Row(
              //   children: [
              //     Expanded(
              //       child: Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 0),
              //         child: Container(
              //           decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(10),
              //               color: Color(0xffE0E7FF)),
              //           child: StreamBuilder<CountriesData>(
              //               stream: _addBranchesOfCompanyBloc.selectedCountry.stream,
              //               builder: (context, snapshot) {
              //                 if (snapshot.hasData) {
              //                   return StreamBuilder<CitiesData>(
              //                       stream: _addBranchesOfCompanyBloc.selectedCities.stream,
              //                       builder: (context, citySnapshot) {
              //                         return Padding(
              //                           padding: const EdgeInsets.symmetric(
              //                               horizontal: 10, vertical: 2),
              //                           child: DropdownButton<CitiesData>(
              //                               dropdownColor: Colors.white,
              //                               iconEnabledColor: Colors.grey,
              //                               iconSize: 32,
              //                               elevation: 3,
              //                               icon: Icon(
              //                                   Icons.arrow_drop_down_outlined),
              //                               items:
              //                               snapshot.data.cities.map((item) {
              //                                 return DropdownMenuItem<CitiesData>(
              //                                     value: item,
              //                                     child: AutoSizeText(
              //                                       item.name,
              //                                       style: kTextStyle.copyWith(
              //                                           fontSize: 14),
              //                                       minFontSize: 12,
              //                                       maxFontSize: 14,
              //                                     ));
              //                               }).toList(),
              //                               isExpanded: true,
              //                               hint: Text(
              //                                'select_city'.tr,
              //                                 style: kTextStyle.copyWith(
              //                                     color: Colors.black),
              //                               ),
              //                               style: kTextStyle.copyWith(
              //                                   color: Colors.black),
              //                               underline: SizedBox(),
              //                               value: citySnapshot.data,
              //                               onChanged: (CitiesData item) {
              //
              //                                 _addBranchesOfCompanyBloc.selectedCities.sink.add(item);
              //                                 print(_addBranchesOfCompanyBloc.selectedCities.value);
              //                               }),
              //                         );
              //                       });
              //                 } else
              //                   return SizedBox();
              //               }),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),

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
                            stream: _addBranchesOfCompanyBloc
                                .selectedCountry.stream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                _addBranchesOfCompanyBloc.allSortCitiesSubject
                                    .add(snapshot.data!.cities!);
                                return StreamBuilder<CitiesData>(
                                    stream: _addBranchesOfCompanyBloc
                                        .selectedCities.stream,
                                    // initialData: _bloc
                                    //     .allCountriesSubject.value[0],
                                    builder: (context, snapshot) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        child: InkWell(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (ctx) => Dialog(
                                                        child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: TextField(
                                                            style: TextStyle(
                                                                fontSize: 14),
                                                            decoration:
                                                                InputDecoration(
                                                              filled: true,
                                                              fillColor:
                                                                  Colors.white,
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .all(9),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    const BorderRadius
                                                                            .all(
                                                                        Radius.circular(
                                                                            6)),
                                                                borderSide: BorderSide(
                                                                    width: 1,
                                                                    color: context
                                                                        .accentColor),
                                                              ),
                                                              disabledBorder:
                                                                  const OutlineInputBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            6)),
                                                                borderSide: BorderSide(
                                                                    width: 1,
                                                                    color: Colors
                                                                        .black54),
                                                              ),
                                                              enabledBorder:
                                                                  const OutlineInputBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            6)),
                                                                borderSide: BorderSide(
                                                                    width: 1,
                                                                    color: Color(
                                                                        0xFFC2C3DF)),
                                                              ),
                                                              border: const OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              6)),
                                                                  borderSide:
                                                                      BorderSide(
                                                                          width:
                                                                              1)),
                                                              hintText:
                                                                  'Search',
                                                              hintStyle: const TextStyle(
                                                                  fontSize: 14,
                                                                  color: Color(
                                                                      0xFF9797AD)),
                                                            ),
                                                            textInputAction:
                                                                TextInputAction
                                                                    .next,
                                                            keyboardType:
                                                                TextInputType
                                                                    .text,
                                                            onChanged: (v) {
                                                              _addBranchesOfCompanyBloc
                                                                  .sortCities(
                                                                      v);
                                                            },
                                                          ),
                                                        ),
                                                        Divider(),
                                                        Expanded(
                                                          child: StreamBuilder<
                                                                  List<
                                                                      CitiesData>>(
                                                              stream: _addBranchesOfCompanyBloc
                                                                  .allSortCitiesSubject
                                                                  .stream,
                                                              builder: (context,
                                                                  citiesSnapshot) {
                                                                if (citiesSnapshot
                                                                    .hasData) {
                                                                  return ListView
                                                                      .separated(
                                                                          itemBuilder: (ctx,
                                                                              index) {
                                                                            final item =
                                                                                citiesSnapshot.data![index];
                                                                            return InkWell(
                                                                              onTap: () {
                                                                                _addBranchesOfCompanyBloc.selectedCities.add(item);
                                                                                Get.back();
                                                                              },
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Text(item.name!),
                                                                              ),
                                                                            );
                                                                          },
                                                                          separatorBuilder: (ctx,
                                                                              index) {
                                                                            return Divider();
                                                                          },
                                                                          shrinkWrap:
                                                                              true,
                                                                          itemCount: citiesSnapshot
                                                                              .data
                                                                              !.length);
                                                                } else {
                                                                  return const Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            8.0),
                                                                    child: Center(
                                                                        child: CircularProgressIndicator(
                                                                      valueColor:
                                                                          AlwaysStoppedAnimation<Color>(
                                                                              kAccentColor),
                                                                    )),
                                                                  );
                                                                }
                                                              }),
                                                        )
                                                      ],
                                                    )));
                                          },
                                          child: snapshot.hasData
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Text(
                                                    snapshot.data!.name!,
                                                    style: kTextStyle.copyWith(
                                                        color: Colors.black),
                                                  ),
                                                )
                                              : Row(
                                                  children: [
                                                    Text(
                                                      'select_city'.tr,
                                                      style:
                                                          kTextStyle.copyWith(
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                    // snapshot.data.icon != null
                                                    //     ? Image.network(
                                                    //         '$ImgUrl${snapshot.data.icon}',
                                                    //         width: 32,
                                                    //         height: 32,
                                                    //       )
                                                    //     : SizedBox(),
                                                    // SizedBox(
                                                    //   width: 8,
                                                    // ),
                                                    // Text(snapshot.data.name),
                                                    Spacer(),
                                                    Icon(Icons
                                                        .arrow_drop_down_outlined)
                                                  ],
                                                ),
                                        ),
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

              Row(
                children: [
                  Text('text_category'.tr,
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade600))
                      .addPaddingOnly(right: 8, left: 8, top: 15, bottom: 5),
                  Text('*', style: TextStyle(fontSize: 14, color: Colors.red))
                      .addPaddingOnly(top: 15),
                ],
              ),
              // Container(
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(10),
              //       color: Color(0xffE0E7FF)),
              //   child: Padding(
              //     padding:
              //         const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              //     child: DropdownButton<String>(
              //         dropdownColor: Colors.white,
              //         iconEnabledColor: Colors.grey,
              //         iconSize: 32,
              //         elevation: 3,
              //         icon: Icon(Icons.arrow_drop_down_outlined),
              //         items: ['Resturant', 'em'].map((item) {
              //           return DropdownMenuItem<String>(
              //               value: item,
              //               child: AutoSizeText(
              //                 item,
              //                 style: kTextStyle.copyWith(fontSize: 18),
              //                 minFontSize: 14,
              //                 maxFontSize: 18,
              //               ));
              //         }).toList(),
              //         isExpanded: true,
              //         hint: Text(
              //           'Select Categories',
              //           style: kTextStyle.copyWith(color: Color(0xff2E384D)),
              //         ),
              //         style: kTextStyle.copyWith(color: Color(0xff2E384D)),
              //         //underline: SizedBox(),
              //         //value: titles[0],
              //         onChanged: (String item) {
              //           print(item);
              //         }),
              //   ),
              // ),

              // Row(
              //   children: [
              //     Expanded(
              //       child: Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 0),
              //         child: Container(
              //           decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(10),
              //               color: Color(0xffE0E7FF)),
              //           child: StreamBuilder<List<Categories_Data>>(
              //               stream:
              //               _addBranchesOfCompanyBloc.getAllCategoriesSubject.stream,
              //               builder: (context, categoriesSnapshot) {
              //                 if (categoriesSnapshot.hasData) {
              //                   return StreamBuilder<Categories_Data>(
              //                       stream: _addBranchesOfCompanyBloc
              //                           .selectCategoriesSubject.stream,
              //                       builder: (context, snapshot) {
              //                         return Padding(
              //                           padding: const EdgeInsets.symmetric(
              //                               horizontal: 10, vertical: 2),
              //                           child: SearchableDropdown.single(
              //                             menuBackgroundColor: Color(0xffE0E7FF),
              //                             items: categoriesSnapshot.data
              //                                 .map((item) {
              //                               return DropdownMenuItem<
              //                                   Categories_Data>(
              //                                   value: item,
              //                                   child: AutoSizeText(
              //                                     item.name,
              //                                     style: kTextStyle.copyWith(
              //                                         fontSize: 14),
              //                                     minFontSize: 12,
              //                                     maxFontSize: 14,
              //                                   ));
              //                             }).toList(),
              //                             value: snapshot.data,
              //                             onChanged: (Categories_Data item) {
              //
              //                               _addBranchesOfCompanyBloc
              //                                   .selectedSubCategories.sink
              //                                   .add(null);
              //                               _addBranchesOfCompanyBloc
              //                                   .selectedSubSubCategories.sink
              //                                   .add(null);
              //                               _addBranchesOfCompanyBloc
              //                                   .selectCategoriesSubject.sink
              //                                   .add(item);
              //
              //                             },
              //                             hint: Text(
              //                               'select_category'.tr,
              //                               style: kTextStyle.copyWith(
              //                                   color: Colors.black),
              //                             ),
              //                             style: kTextStyle.copyWith(
              //                                 color: Colors.black),
              //                             underline: SizedBox(),
              //                             searchHint: 'select_category'.tr,
              //
              //                             isExpanded: true,
              //                           ),
              //                         );
              //                       });
              //                 } else {
              //                   return const Padding(
              //                     padding: EdgeInsets.all(8.0),
              //                     child: Center(
              //                         child: CircularProgressIndicator(
              //                           valueColor: AlwaysStoppedAnimation<Color>(
              //                               kAccentColor),
              //                         )),
              //                   );
              //                 }
              //               }),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffE0E7FF)),
                        child: StreamBuilder<Categories_Data>(
                            stream: _addBranchesOfCompanyBloc
                                .selectCategoriesSubject.stream,
                            // initialData: _bloc
                            //     .allCountriesSubject.value[0],
                            builder: (context, snapshot) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (ctx) => Dialog(
                                                child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextField(
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                    decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      contentPadding:
                                                          EdgeInsets.all(9),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    6)),
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: context
                                                                .accentColor),
                                                      ),
                                                      disabledBorder:
                                                          const OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    6)),
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color:
                                                                Colors.black54),
                                                      ),
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    6)),
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: Color(
                                                                0xFFC2C3DF)),
                                                      ),
                                                      border: const OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          6)),
                                                          borderSide:
                                                              BorderSide(
                                                                  width: 1)),
                                                      hintText: 'Search',
                                                      hintStyle:
                                                          const TextStyle(
                                                              fontSize: 14,
                                                              color: Color(
                                                                  0xFF9797AD)),
                                                    ),
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    onChanged: (v) {
                                                      _addBranchesOfCompanyBloc
                                                          .sortAllCategories(v);
                                                    },
                                                  ),
                                                ),
                                                Divider(),
                                                Expanded(
                                                  child: StreamBuilder<
                                                          List<
                                                              Categories_Data>>(
                                                      stream: _addBranchesOfCompanyBloc
                                                          .getSortAllCategoriesSubject
                                                          .stream,
                                                      builder: (context,
                                                          countriesSnapshot) {
                                                        if (countriesSnapshot
                                                            .hasData) {
                                                          return ListView
                                                              .separated(
                                                                  itemBuilder: (ctx,
                                                                      index) {
                                                                    final item =
                                                                        countriesSnapshot
                                                                            .data![index];
                                                                    return InkWell(
                                                                      onTap:
                                                                          () {
                                                                        _addBranchesOfCompanyBloc
                                                                            .selectCategoriesSubject
                                                                            .add(item);
                                                                        Get.back();
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            SizedBox(
                                                                              width: 8,
                                                                            ),
                                                                            Text(item.name!),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                  separatorBuilder:
                                                                      (ctx,
                                                                          index) {
                                                                    return Divider();
                                                                  },
                                                                  shrinkWrap:
                                                                      true,
                                                                  itemCount:
                                                                      countriesSnapshot
                                                                          .data
                                                                          !.length);
                                                        } else {
                                                          return const Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Center(
                                                                child:
                                                                    CircularProgressIndicator(
                                                              valueColor:
                                                                  AlwaysStoppedAnimation<
                                                                          Color>(
                                                                      kAccentColor),
                                                            )),
                                                          );
                                                        }
                                                      }),
                                                )
                                              ],
                                            )));
                                  },
                                  child: snapshot.hasData
                                      ? Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                snapshot.data!.name!,
                                                style: kTextStyle.copyWith(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Row(
                                          children: [
                                            Text(
                                              'select_category'.tr,
                                              // context.translate('select_country'),
                                              style: kTextStyle.copyWith(
                                                  color: Colors.black),
                                            ),
                                            // snapshot.data.icon != null
                                            //     ? Image.network(
                                            //         '$ImgUrl${snapshot.data.icon}',
                                            //         width: 32,
                                            //         height: 32,
                                            //       )
                                            //     : SizedBox(),
                                            // SizedBox(
                                            //   width: 8,
                                            // ),
                                            // Text(snapshot.data.name),
                                            Spacer(),
                                            Icon(Icons.arrow_drop_down_outlined)
                                          ],
                                        ),
                                ),
                              );
                            }),

                        // StreamBuilder<List<Categories_Data>>(
                        //     stream: _categoriesBloc
                        //         .getAllCategoriesSubject.stream,
                        //     builder: (context, categoriesSnapshot) {
                        //       if (categoriesSnapshot.hasData) {
                        //         return StreamBuilder<Categories_Data>(
                        //             stream: _categoriesBloc
                        //                 .selectCategoriesSubject.stream,
                        //             builder: (context, snapshot) {
                        //               return Padding(
                        //                 padding:
                        //                     const EdgeInsets.symmetric(
                        //                         horizontal: 10,
                        //                         vertical: 2),
                        //                 child: SearchableDropdown.single(
                        //                   menuBackgroundColor:
                        //                       Color(0xffE0E7FF),
                        //                   items: categoriesSnapshot.data
                        //                       .map((item) {
                        //                     return DropdownMenuItem<
                        //                             Categories_Data>(
                        //                         value: item,
                        //                         child: AutoSizeText(
                        //                           item.name,
                        //                           style:
                        //                               kTextStyle.copyWith(
                        //                                   fontSize: 18),
                        //                           minFontSize: 14,
                        //                           maxFontSize: 18,
                        //                         ));
                        //                   }).toList(),
                        //                   value: snapshot.data,
                        //                   onChanged:
                        //                       (Categories_Data item) {
                        //                     _categoriesBloc
                        //                         .selectedSubCategories
                        //                         .sink
                        //                         .add(null);
                        //                     _categoriesBloc
                        //                         .selectedSubSubCategories
                        //                         .sink
                        //                         .add(null);
                        //                     _categoriesBloc
                        //                         .selectCategoriesSubject
                        //                         .sink
                        //                         .add(item);
                        //                   },
                        //                   hint: Text(
                        //                     'select_category'.tr,
                        //                     style: kTextStyle.copyWith(
                        //                         color: Colors.black),
                        //                   ),
                        //                   style: kTextStyle.copyWith(
                        //                       color: Colors.black),
                        //                   underline: SizedBox(),
                        //                   searchHint:
                        //                       'select_category'.tr,
                        //                   isExpanded: true,
                        //                 ),
                        //               );
                        //             });
                        //       } else {
                        //         return const Padding(
                        //           padding: EdgeInsets.all(8.0),
                        //           child: Center(
                        //               child: CircularProgressIndicator(
                        //             valueColor:
                        //                 AlwaysStoppedAnimation<Color>(
                        //                     kAccentColor),
                        //           )),
                        //         );
                        //       }
                        //     }),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),

              // Row(
              //   children: [
              //     Expanded(
              //       child: Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 0),
              //         child: Container(
              //           decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(10),
              //               color: Color(0xffE0E7FF)),
              //           child: StreamBuilder<Categories_Data>(
              //               stream:
              //               _addBranchesOfCompanyBloc.selectCategoriesSubject.stream,
              //               builder: (context, snapshot) {
              //                 if (snapshot.hasData) {
              //                   return StreamBuilder<SubCategories>(
              //                       stream: _addBranchesOfCompanyBloc
              //                           .selectedSubCategories.stream,
              //                       builder: (context, subcategoriesSnapshot) {
              //                         return Padding(
              //                           padding: const EdgeInsets.symmetric(
              //                               horizontal: 10, vertical: 2),
              //                           child: SearchableDropdown.single(
              //                             menuBackgroundColor: Color(0xffE0E7FF),
              //                             items: snapshot.data.sub_categories
              //                                 .map((item) {
              //                               return DropdownMenuItem<
              //                                   SubCategories>(
              //                                   value: item,
              //                                   child: AutoSizeText(
              //                                     item.name,
              //                                     style: kTextStyle.copyWith(
              //                                         fontSize: 14),
              //                                     minFontSize: 12,
              //                                     maxFontSize: 14,
              //                                   ));
              //                             }).toList(),
              //                             isExpanded: true,
              //                             hint: Text(
              //                               'select_sub_category'.tr,
              //                               style: kTextStyle.copyWith(
              //                                   color: Colors.black),
              //                             ),
              //                             style: kTextStyle.copyWith(
              //                                 color: Colors.black),
              //                             underline: SizedBox(),
              //                             value: subcategoriesSnapshot.data,
              //                             onChanged: (SubCategories item) {
              //                               _addBranchesOfCompanyBloc
              //                                   .selectedSubSubCategories.sink
              //                                   .add(null);
              //                               _addBranchesOfCompanyBloc
              //                                   .selectedSubCategories.sink
              //                                   .add(item);
              //
              //                               // widget
              //                               //     .bloc.selectedSubCategories.sink
              //                               //     .add(item);
              //                               print(_addBranchesOfCompanyBloc
              //                                   .selectedSubCategories.value);
              //                             },
              //                             searchHint: 'select_sub_category'.tr,
              //                           ),
              //                         );
              //                       });
              //                 } else
              //                   return SizedBox();
              //               }),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffE0E7FF)),
                        child: StreamBuilder<Categories_Data>(
                            stream: _addBranchesOfCompanyBloc
                                .selectCategoriesSubject.stream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                _addBranchesOfCompanyBloc
                                    .getSortAllSubCategories
                                    .add(snapshot.data!.sub_categories!);
                                return StreamBuilder<SubCategories>(
                                    stream: _addBranchesOfCompanyBloc
                                        .selectedSubCategories.stream,
                                    builder: (context, snapshot) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        child: InkWell(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (ctx) => Dialog(
                                                        child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: TextField(
                                                            style: TextStyle(
                                                                fontSize: 14),
                                                            decoration:
                                                                InputDecoration(
                                                              filled: true,
                                                              fillColor:
                                                                  Colors.white,
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .all(9),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    const BorderRadius
                                                                            .all(
                                                                        Radius.circular(
                                                                            6)),
                                                                borderSide: BorderSide(
                                                                    width: 1,
                                                                    color: context
                                                                        .accentColor),
                                                              ),
                                                              disabledBorder:
                                                                  const OutlineInputBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            6)),
                                                                borderSide: BorderSide(
                                                                    width: 1,
                                                                    color: Colors
                                                                        .black54),
                                                              ),
                                                              enabledBorder:
                                                                  const OutlineInputBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            6)),
                                                                borderSide: BorderSide(
                                                                    width: 1,
                                                                    color: Color(
                                                                        0xFFC2C3DF)),
                                                              ),
                                                              border: const OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              6)),
                                                                  borderSide:
                                                                      BorderSide(
                                                                          width:
                                                                              1)),
                                                              hintText:
                                                                  'Search',
                                                              hintStyle: const TextStyle(
                                                                  fontSize: 14,
                                                                  color: Color(
                                                                      0xFF9797AD)),
                                                            ),
                                                            textInputAction:
                                                                TextInputAction
                                                                    .next,
                                                            keyboardType:
                                                                TextInputType
                                                                    .text,
                                                            onChanged: (v) {
                                                              _addBranchesOfCompanyBloc
                                                                  .sortSubCategories(
                                                                      v);
                                                            },
                                                          ),
                                                        ),
                                                        Divider(),
                                                        Expanded(
                                                          child: StreamBuilder<
                                                                  List<
                                                                      SubCategories>>(
                                                              stream: _addBranchesOfCompanyBloc
                                                                  .getSortAllSubCategories
                                                                  .stream,
                                                              builder: (context,
                                                                  subCategoriesSnapshot) {
                                                                if (subCategoriesSnapshot
                                                                    .hasData) {
                                                                  return ListView
                                                                      .separated(
                                                                          itemBuilder: (ctx,
                                                                              index) {
                                                                            final item =
                                                                                subCategoriesSnapshot.data![index];
                                                                            return InkWell(
                                                                              onTap: () {
                                                                                _addBranchesOfCompanyBloc.selectedSubCategories.add(item);
                                                                                Get.back();
                                                                              },
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Text(item.name!),
                                                                              ),
                                                                            );
                                                                          },
                                                                          separatorBuilder: (ctx,
                                                                              index) {
                                                                            return Divider();
                                                                          },
                                                                          shrinkWrap:
                                                                              true,
                                                                          itemCount: subCategoriesSnapshot
                                                                              .data
                                                                              !.length);
                                                                } else {
                                                                  return const Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            8.0),
                                                                    child: Center(
                                                                        child: CircularProgressIndicator(
                                                                      valueColor:
                                                                          AlwaysStoppedAnimation<Color>(
                                                                              kAccentColor),
                                                                    )),
                                                                  );
                                                                }
                                                              }),
                                                        )
                                                      ],
                                                    )));
                                          },
                                          child: snapshot.hasData
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Text(
                                                    snapshot.data!.name!,
                                                    style: kTextStyle.copyWith(
                                                        color: Colors.black),
                                                  ),
                                                )
                                              : Row(
                                                  children: [
                                                    Text(
                                                      'select_sub_category'.tr,
                                                      style:
                                                          kTextStyle.copyWith(
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                    // snapshot.data.icon != null
                                                    //     ? Image.network(
                                                    //         '$ImgUrl${snapshot.data.icon}',
                                                    //         width: 32,
                                                    //         height: 32,
                                                    //       )
                                                    //     : SizedBox(),
                                                    // SizedBox(
                                                    //   width: 8,
                                                    // ),
                                                    // Text(snapshot.data.name),
                                                    Spacer(),
                                                    Icon(Icons
                                                        .arrow_drop_down_outlined)
                                                  ],
                                                ),
                                        ),
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

              // Row(
              //   children: [
              //     Expanded(
              //       child: Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 0),
              //         child: Container(
              //           decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(10),
              //               color: Color(0xffE0E7FF)),
              //           child: StreamBuilder<SubCategories>(
              //               stream:
              //               _addBranchesOfCompanyBloc.selectedSubCategories.stream,
              //               builder: (context, snapshot) {
              //                 if (snapshot.hasData) {
              //                   return StreamBuilder<SubSubCategories>(
              //                       stream: _addBranchesOfCompanyBloc
              //                           .selectedSubSubCategories.stream,
              //                       builder: (context, subSubcategoriesSnapshot) {
              //                         return Padding(
              //                           padding: const EdgeInsets.symmetric(
              //                               horizontal: 10, vertical: 2),
              //                           child: SearchableDropdown.single(
              //                             menuBackgroundColor: Color(0xffE0E7FF),
              //                             items: snapshot.data.sub_sub_categories
              //                                 .map((item) {
              //                               return DropdownMenuItem<
              //                                   SubSubCategories>(
              //                                   value: item,
              //                                   child: AutoSizeText(
              //                                     item.name,
              //                                     style: kTextStyle.copyWith(
              //                                         fontSize: 14),
              //                                     minFontSize: 12,
              //                                     maxFontSize: 14,
              //                                   ));
              //                             }).toList(),
              //                             isExpanded: true,
              //                             hint: Text(
              //                               'select_sub_category'.tr,
              //                               style: kTextStyle.copyWith(
              //                                   color: Colors.black),
              //                             ),
              //                             style: kTextStyle.copyWith(
              //                                 color: Colors.black),
              //                             underline: SizedBox(),
              //                             value: subSubcategoriesSnapshot.data,
              //                             onChanged: (SubSubCategories item) {
              //                               _addBranchesOfCompanyBloc
              //                                   .selectedSubSubCategories.sink
              //                                   .add(item);
              //                               // widget
              //                               //     .bloc.selectedSubCategories.sink
              //                               //     .add(item);
              //
              //                             },
              //                             searchHint: 'select_sub_category'.tr,
              //                           ),
              //                         );
              //                       });
              //                 } else
              //                   return SizedBox();
              //               }),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),

              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffE0E7FF)),
                        child: StreamBuilder<SubCategories>(
                            stream: _addBranchesOfCompanyBloc
                                .selectedSubCategories.stream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                _addBranchesOfCompanyBloc
                                    .getSortAllSubSubCategories
                                    .add(snapshot.data!.sub_sub_categories!);
                                return StreamBuilder<SubSubCategories>(
                                    stream: _addBranchesOfCompanyBloc
                                        .selectedSubSubCategories.stream,
                                    builder: (context, snapshot) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        child: InkWell(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (ctx) => Dialog(
                                                        child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: TextField(
                                                            style: TextStyle(
                                                                fontSize: 14),
                                                            decoration:
                                                                InputDecoration(
                                                              filled: true,
                                                              fillColor:
                                                                  Colors.white,
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .all(9),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    const BorderRadius
                                                                            .all(
                                                                        Radius.circular(
                                                                            6)),
                                                                borderSide: BorderSide(
                                                                    width: 1,
                                                                    color: context
                                                                        .accentColor),
                                                              ),
                                                              disabledBorder:
                                                                  const OutlineInputBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            6)),
                                                                borderSide: BorderSide(
                                                                    width: 1,
                                                                    color: Colors
                                                                        .black54),
                                                              ),
                                                              enabledBorder:
                                                                  const OutlineInputBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            6)),
                                                                borderSide: BorderSide(
                                                                    width: 1,
                                                                    color: Color(
                                                                        0xFFC2C3DF)),
                                                              ),
                                                              border: const OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              6)),
                                                                  borderSide:
                                                                      BorderSide(
                                                                          width:
                                                                              1)),
                                                              hintText:
                                                                  'Search',
                                                              hintStyle: const TextStyle(
                                                                  fontSize: 14,
                                                                  color: Color(
                                                                      0xFF9797AD)),
                                                            ),
                                                            textInputAction:
                                                                TextInputAction
                                                                    .next,
                                                            keyboardType:
                                                                TextInputType
                                                                    .text,
                                                            onChanged: (v) {
                                                              _addBranchesOfCompanyBloc
                                                                  .sortSubSubCategories(
                                                                      v);
                                                            },
                                                          ),
                                                        ),
                                                        Divider(),
                                                        Expanded(
                                                          child: StreamBuilder<
                                                                  List<
                                                                      SubSubCategories>>(
                                                              stream: _addBranchesOfCompanyBloc
                                                                  .getSortAllSubSubCategories
                                                                  .stream,
                                                              builder: (context,
                                                                  subSubCategoriesSnapshot) {
                                                                if (subSubCategoriesSnapshot
                                                                    .hasData) {
                                                                  return ListView
                                                                      .separated(
                                                                          itemBuilder: (ctx,
                                                                              index) {
                                                                            final item =
                                                                                subSubCategoriesSnapshot.data![index];
                                                                            return InkWell(
                                                                              onTap: () {
                                                                                _addBranchesOfCompanyBloc.selectedSubSubCategories.add(item);
                                                                                Get.back();
                                                                              },
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Text(item.name!),
                                                                              ),
                                                                            );
                                                                          },
                                                                          separatorBuilder: (ctx,
                                                                              index) {
                                                                            return Divider();
                                                                          },
                                                                          shrinkWrap:
                                                                              true,
                                                                          itemCount: subSubCategoriesSnapshot
                                                                              .data!
                                                                              .length);
                                                                } else {
                                                                  return const Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            8.0),
                                                                    child: Center(
                                                                        child: CircularProgressIndicator(
                                                                      valueColor:
                                                                          AlwaysStoppedAnimation<Color>(
                                                                              kAccentColor),
                                                                    )),
                                                                  );
                                                                }
                                                              }),
                                                        )
                                                      ],
                                                    )));
                                          },
                                          child: snapshot.hasData
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Text(
                                                    snapshot.data!.name!,
                                                    style: kTextStyle.copyWith(
                                                        color: Colors.black),
                                                  ),
                                                )
                                              : Row(
                                                  children: [
                                                    Text(
                                                      'select_sub_category'.tr,
                                                      style:
                                                          kTextStyle.copyWith(
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                    // snapshot.data.icon != null
                                                    //     ? Image.network(
                                                    //         '$ImgUrl${snapshot.data.icon}',
                                                    //         width: 32,
                                                    //         height: 32,
                                                    //       )
                                                    //     : SizedBox(),
                                                    // SizedBox(
                                                    //   width: 8,
                                                    // ),
                                                    // Text(snapshot.data.name),
                                                    Spacer(),
                                                    Icon(Icons
                                                        .arrow_drop_down_outlined)
                                                  ],
                                                ),
                                        ),
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
              // Row(
              //   children: [
              //     Expanded(
              //       child: Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 0),
              //         child: Container(
              //           decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(10),
              //               color: Color(0xffE0E7FF)),
              //           child: StreamBuilder<List<Categories_Data>>(
              //               stream:
              //               _addBranchesOfCompanyBloc.getAllCategoriesSubject.stream,
              //               builder: (context, categoriesSnapshot) {
              //                 print(
              //                     'ew${_addBranchesOfCompanyBloc.getAllCategoriesSubject.value}');
              //                 if (categoriesSnapshot.hasData) {
              //                   return StreamBuilder<Categories_Data>(
              //                       stream: _addBranchesOfCompanyBloc
              //                           .selectCategoriesSubject.stream,
              //                       builder: (context, snapshot) {
              //                         return Padding(
              //                           padding: const EdgeInsets.symmetric(
              //                               horizontal: 10, vertical: 2),
              //                           child: DropdownButton<Categories_Data>(
              //                               dropdownColor: Colors.white,
              //                               iconEnabledColor: Colors.grey,
              //                               iconSize: 32,
              //                               elevation: 3,
              //                               icon: Icon(
              //                                   Icons.arrow_drop_down_outlined),
              //                               items: categoriesSnapshot.data
              //                                   .map((item) {
              //                                 return DropdownMenuItem<
              //                                     Categories_Data>(
              //                                     value: item,
              //                                     child: AutoSizeText(
              //                                       item.name,
              //                                       style: kTextStyle.copyWith(
              //                                           fontSize: 18),
              //                                       minFontSize: 14,
              //                                       maxFontSize: 18,
              //                                     ));
              //                               }).toList(),
              //                               isExpanded: true,
              //                               hint: Text(
              //                                'select_category'.tr,
              //                                 style: kTextStyle.copyWith(
              //                                     color: Colors.black),
              //                               ),
              //                               style: kTextStyle.copyWith(
              //                                   color: Colors.black),
              //                               underline: SizedBox(),
              //                               value: snapshot.data,
              //                               onChanged: (Categories_Data item) {
              //                                 print(item.name);
              //                                 _addBranchesOfCompanyBloc
              //                                     .selectedSubCategories.sink
              //                                     .add(null);
              //                                 _addBranchesOfCompanyBloc
              //                                     .selectCategoriesSubject.sink
              //                                     .add(item);
              //                                 // _addBranchesOfCompanyBloc.selectCategoriesSubject
              //                                 //     .sink
              //                                 //     .add(item);
              //                                 print(_addBranchesOfCompanyBloc
              //                                     .selectCategoriesSubject
              //                                     .value
              //                                     .name);
              //                               }),
              //                         );
              //                       });
              //                 } else {
              //                   return const Padding(
              //                     padding: EdgeInsets.all(8.0),
              //                     child: Center(
              //                         child: CircularProgressIndicator(
              //                           valueColor: AlwaysStoppedAnimation<Color>(
              //                               kAccentColor),
              //                         )),
              //                   );
              //                 }
              //               }),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 15,
              // ),
              //
              // Row(
              //   children: [
              //     Expanded(
              //       child: Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 0),
              //         child: Container(
              //           decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(10),
              //               color: Color(0xffE0E7FF)),
              //           child: StreamBuilder<Categories_Data>(
              //               stream:
              //               _addBranchesOfCompanyBloc.selectCategoriesSubject.stream,
              //               builder: (context, snapshot) {
              //                 if (snapshot.hasData) {
              //                   return StreamBuilder<SubCategories>(
              //                       stream: _addBranchesOfCompanyBloc
              //                           .selectedSubCategories.stream,
              //                       builder: (context, subcategoriesSnapshot) {
              //                         return Padding(
              //                           padding: const EdgeInsets.symmetric(
              //                               horizontal: 10, vertical: 2),
              //                           child: DropdownButton<SubCategories>(
              //                               dropdownColor: Colors.white,
              //                               iconEnabledColor: Colors.grey,
              //                               iconSize: 32,
              //                               elevation: 3,
              //                               icon: Icon(
              //                                   Icons.arrow_drop_down_outlined),
              //                               items: snapshot.data.sub_categories
              //                                   .map((item) {
              //                                 return DropdownMenuItem<
              //                                     SubCategories>(
              //                                     value: item,
              //                                     child: AutoSizeText(
              //                                       item.name,
              //                                       style: kTextStyle.copyWith(
              //                                           fontSize: 18),
              //                                       minFontSize: 14,
              //                                       maxFontSize: 18,
              //                                     ));
              //                               }).toList(),
              //                               isExpanded: true,
              //                               hint: Text(
              //                                   'select_sub_category'.tr,
              //                                 style: kTextStyle.copyWith(
              //                                     color: Colors.black),
              //                               ),
              //                               style: kTextStyle.copyWith(
              //                                   color: Colors.black),
              //                               underline: SizedBox(),
              //                               value: subcategoriesSnapshot.data,
              //                               onChanged: (SubCategories item) {
              //                                 print(item.name);
              //                                 _addBranchesOfCompanyBloc
              //                                     .selectedSubCategories.sink
              //                                     .add(item);
              //                                 // widget
              //                                 //     .bloc.selectedSubCategories.sink
              //                                 //     .add(item);
              //                                 print(_addBranchesOfCompanyBloc
              //                                     .selectedSubCategories.value);
              //                               }),
              //                         );
              //                       });
              //                 } else
              //                   return SizedBox();
              //               }),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),

              SizedBox(
                height: 15,
              ),

              if (widget.beCompany!)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: RoundedLoadingButton(
                    child: Text(
                      'side_be_company'.tr,
                      style: kTextStyle.copyWith(
                          fontSize: 20, color: Color(0xffFFFFFF)),
                    ),
                    height: 50,
                    controller:
                        _addBranchesOfCompanyBloc.loadingButtonController,
                    color: Colors.blue.shade800,
                    onPressed: () async {
                      _addBranchesOfCompanyBloc.loadingButtonController.start();
                      await _addBranchesOfCompanyBloc.confirmBeCompany(
                          lat: widget.lat, lng: widget.lng, context: context);
                      _addBranchesOfCompanyBloc.loadingButtonController.stop();
                    },
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: RoundedLoadingButton(
                    child: Text(
                      'bt_add'.tr,
                      style: kTextStyle.copyWith(
                          fontSize: 20, color: Color(0xffFFFFFF)),
                    ),
                    height: 50,
                    controller:
                        _addBranchesOfCompanyBloc.loadingButtonController,
                    color: Colors.blue.shade800,
                    onPressed: () async {
                      _addBranchesOfCompanyBloc.loadingButtonController.start();
                      // await _addBranchesOfCompanyBloc.confirmAddBranchesOfCompany(lat: widget.lat,lng: widget.lng,context: context);
                      await _addBranchesOfCompanyBloc
                          .confirmAddBranchesOfCompany(
                              lng: await _helper.getLng(),
                              lat: await _helper.getLat(),
                              context: context);
                      // await Get.to(MapTest());
                      _addBranchesOfCompanyBloc.loadingButtonController.stop();
                    },
                  ),
                ),
            ],
          ).addPaddingOnly(bottom: 28),
        ),
      ),
    );
  }

  Widget BuildViewMap(dynamic lng, dynamic lat) {
    final controller = MapController(
      location: LatLng(lat, lng),
      // location: LatLng(37.4219983, -122.084),
    );

    void _gotoDefault() {
      controller.center = LatLng(lat, lng);
    }

    void _onDoubleTap() {
      controller.zoom += 0.5;
    }

    Offset _dragStart;
    double _scaleStart = 1.0;
    void _onScaleStart(ScaleStartDetails details) {
      _dragStart = details.focalPoint;
      _scaleStart = 1.0;
    }

    void _onScaleUpdate(ScaleUpdateDetails details) {
      final scaleDiff = details.scale - _scaleStart;
      _scaleStart = details.scale;

      if (scaleDiff > 0) {
        controller.zoom += 0.02;
      } else if (scaleDiff < 0) {
        controller.zoom -= 0.02;
      } else {
        // final now = details.focalPoint;
        // final diff = now - _dragStart;
        // _dragStart = now;
        // controller.drag(diff.dx, diff.dy);
      }
    }

    return GestureDetector(
      onDoubleTap: _onDoubleTap,
      onScaleStart: _onScaleStart,
      onScaleUpdate: _onScaleUpdate,
      onScaleEnd: (details) {
        print(
            "Location: ${controller.center.latitude}, ${controller.center.longitude}");
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        child: Container(
          height: 200,
          decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  //color: Colors.amber,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                    bottomLeft: Radius.circular(15.0),
                  ),
                  child: Map(
                    controller: controller,
                    builder: (context, x, y, z) {
                      final url =
                          'https://www.google.com/maps/vt/pb=!1m4!1m3!1i$z!2i$x!3i$y!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425';

                      return CachedNetworkImage(
                        imageUrl: url,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
              Center(
                child: GestureDetector(
                    onTap: () {
                      _gotoDefault();
                    },
                    child: Icon(Icons.location_on, color: Colors.red)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SocialWidget extends StatefulWidget {
  final List<SocialItem>? socialItems;
  final SocialController? controller;

  const SocialWidget({Key? key, this.socialItems, this.controller})
      : super(key: key);

  @override
  _SocialWidgetState createState() => _SocialWidgetState();
}

class _SocialWidgetState extends State<SocialWidget> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffE0E7FF)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  child: DropDown<SocialItem>(
                    items: widget.socialItems,
                    hint: Text('Social'),
                    isExpanded: true,
                    customWidgets: widget.socialItems!.map((e) {
                      return Row(
                        children: [
                          Icon(e.icon),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              child: Text(
                            e.name!,
                            overflow: TextOverflow.ellipsis,
                          )),
                        ],
                      );
                    }).toList(),
                    onChanged: (SocialItem item) {
                      widget.controller!.socialItem = item;
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 8,
              child: TextFormField(
                style: TextStyle(fontSize: 14),
                validator: (String? val) {
                  if (val!.isEmpty && urlExp.hasMatch(val)) {
                    return 'required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFE0E7FF),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    borderSide:
                        BorderSide(width: 1, color: context.accentColor),
                  ),
                  disabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    borderSide: BorderSide(width: 1, color: Colors.black54),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    borderSide: BorderSide(width: 1, color: Color(0xFFC2C3DF)),
                  ),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      borderSide: BorderSide(width: 1)),
                  errorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      borderSide: BorderSide(width: 1, color: Colors.red)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                      borderSide:
                          BorderSide(width: 1, color: Colors.red.shade800)),
                  hintText: '',
                  hintStyle:
                      const TextStyle(fontSize: 14, color: Color(0xFF9797AD)),
                ),
                keyboardType: TextInputType.text,
                controller: widget.controller!.urlController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
