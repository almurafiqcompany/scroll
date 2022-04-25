import 'dart:io';
import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/models/edit_compaine.dart';
import 'package:al_murafiq/models/profile_edit.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/models/countries.dart';
import 'package:al_murafiq/screens/countries/countries_bloc.dart';
import 'package:al_murafiq/screens/home_page/company/add_branches_of_company_bloc.dart';
import 'package:al_murafiq/screens/home_page/company/edit_company/edit_company_bloc.dart';
import 'package:al_murafiq/screens/home_page/company/edit_company/map_teat.dart';
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
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:geolocator/geolocator.dart';
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

class EditCompanyScreen extends StatefulWidget {
  final int? company_id;

  const EditCompanyScreen({Key? key, this.company_id}) : super(key: key);
  // final dynamic lng,lat;
  //
  //  EditCompanyScreen({Key key, this.lng, this.lat}) : super(key: key);
  @override
  _EditCompanyScreenState createState() => _EditCompanyScreenState();
}

class _EditCompanyScreenState extends State<EditCompanyScreen> {
  EditCompanyBloc _editCompanyBloc = EditCompanyBloc();
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
    // _editCompanyBloc.fetchDataAllCategories(1);
    // _editCompanyBloc.fetchAllCountries(1);
    _editCompanyBloc.fetchProfileData(
        company_id: widget.company_id, context: context);
    // _bloc.fetchProfileData();
    final String lsHour = TimeOfDay.now().hour.toString().padLeft(2, '0');
    final String lsMinute = TimeOfDay.now().minute.toString().padLeft(2, '0');
    _controllerFrom = TextEditingController(text: '$lsHour:$lsMinute');
    _controllerTo = TextEditingController(text: '$lsHour:$lsMinute');
    setLocation();
    // TODO: implement initState
    super.initState();
  }

  SharedPreferenceHelper _helper = GetIt.instance.get<SharedPreferenceHelper>();
  // dynamic lat =await _helper.getLat();
  // dynamic lng= await _helper.getLng();

  Future<void> setLocation() async {
    try {
      _editCompanyBloc.lanSubject.value = await _helper.getLat();
      _editCompanyBloc.lngSubject.value = await _helper.getLng();
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      print('error set location');
    }
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
  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      appBar: GradientAppbar(
        title: 'side_edit_company'.tr,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<EditCompany>(
            stream: _editCompanyBloc.getProfileDataOf.stream,
            builder: (context, getProfileDatasnapshot) {
              if (getProfileDatasnapshot.hasData) {
                // _bloc.fetchAllCountries();
                //  _editCompanyBloc.namePlaceController.text=getProfileDatasnapshot.data.name_en;
                //  _editCompanyBloc.desController.text=getProfileDatasnapshot.data.desc_en;
                //  //_editCompanyBloc.addressController.text=getProfileDatasnapshot.data.address_en;
                //  _editCompanyBloc.mobileController.text=getProfileDatasnapshot.data.phone1;
                //  _editCompanyBloc.mobile2Controller.text=getProfileDatasnapshot.data.phone2;
                //  _editCompanyBloc.phoneController.text=getProfileDatasnapshot.data.tel;
                //  _editCompanyBloc.faxController.text=getProfileDatasnapshot.data.fax;
                //  _editCompanyBloc.emailOrPhoneController.text=getProfileDatasnapshot.data.email;
                //  _editCompanyBloc.workDaysSubjectFrom.value=getProfileDatasnapshot.data.week_from;
                //  _editCompanyBloc.workDaysSubjectTo.value=getProfileDatasnapshot.data.week_to;
                //  _editCompanyBloc.workTimeSubjectFrom.value=getProfileDatasnapshot.data.open_from;
                //  _editCompanyBloc.workTimeSubjectTo.value=getProfileDatasnapshot.data.open_to;
                // _editCompanyBloc.lanSubject.value=getProfileDatasnapshot.data.lat;
                // _editCompanyBloc.lngSubject.value=getProfileDatasnapshot.data.lng;
                // _controllerFrom.text=getProfileDatasnapshot.data.open_from;
                // _controllerTo.text=getProfileDatasnapshot.data.open_to;
                // _valueSavedTo=getProfileDatasnapshot.data.open_to;
                // _valueSavedFrom=getProfileDatasnapshot.data.open_from;
                print('ds ${getProfileDatasnapshot.data!.open_to}');
                // print('ds ${DateFormat("hh:mm:ss").parse(getProfileDatasnapshot.data.open_to)}');
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        height: 10,
                      ),
                      StreamBuilder<File>(
                          stream: _editCompanyBloc.imageController.stream,
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
                                              final FilePickerResult? res =
                                                  await FilePicker.platform
                                                      .pickFiles(
                                                          type: FileType.custom,
                                                          allowedExtensions: [
                                                    'jpg',
                                                    'png',
                                                    'jpeg',
                                                    'gif'
                                                  ]);
                                              final File? img = res != null
                                                  ? File(res.files.single.path!)
                                                  : null;

                                              if (img != null) {
                                                _editCompanyBloc
                                                    .imageController.sink
                                                    .add(img);
                                              }
                                              // ignore: avoid_catches_without_on_clauses
                                            } catch (e) {
                                              print(e.toString());
                                            }
                                          },
                                          child: Card(
                                            elevation: 0,
                                            margin: EdgeInsets.all(0),
                                            shape: CircleBorder(),
                                            color:
                                                kAccentColor.withOpacity(0.6),
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
                                      if (getProfileDatasnapshot.data!.image !=
                                          null)
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          child: Image.network(
                                            "$ImgUrl${getProfileDatasnapshot.data!.image}",
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      else
                                        SizedBox(),
                                      Center(
                                        child: GestureDetector(
                                          onTap: () async {
                                            try {
                                              final FilePickerResult? res =
                                                  await FilePicker.platform
                                                      .pickFiles(
                                                          type: FileType.image);
                                              final File? img = res != null
                                                  ? File(res.files.single.path!)
                                                  : null;

                                              if (img != null) {
                                                _editCompanyBloc
                                                    .imageController.sink
                                                    .add(img);
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
                                                color: kAccentColor
                                                    .withOpacity(0.6),
                                                child: Padding(
                                                    padding: EdgeInsets.all(8),
                                                    child: Icon(
                                                      MdiIcons.imagePlus,
                                                      color: Colors.white,
                                                      size: 32,
                                                    )),
                                              ),
                                              // SizedBox(
                                              //   height: 2,
                                              // ),
                                              // AutoSizeText(
                                              //   'Change Photo',
                                              //   style: kTextStyle,
                                              //   softWrap: true,
                                              //   maxFontSize: 20,
                                              //   minFontSize: 16,
                                              // ),
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

                      Row(
                        children: [
                          Text('text_place_name'.tr,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade600))
                              .addPaddingOnly(
                                  right: 8, left: 8, top: 15, bottom: 5),
                          const Text('*',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.red))
                              .addPaddingOnly(top: 15),
                        ],
                      ),
                      StreamBuilder<bool>(
                          stream: _editCompanyBloc.namePlaceSubject.stream,
                          initialData: true,
                          builder: (context, snapshot) {
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
                                        width: 1, color: Colors.red.shade800)),
                                hintText: '',
                                hintStyle: const TextStyle(
                                    fontSize: 14, color: Color(0xFF9797AD)),
                                errorText: snapshot.data!
                                    ? null
                                    : 'text_place_name_error'.tr,
                              ),
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () => node.nextFocus(),
                              keyboardType: TextInputType.text,
                              onChanged: (val) =>
                                  _editCompanyBloc.changeNamePlace(val),
                              controller: _editCompanyBloc.namePlaceController,
                            );
                          }),
                      Row(
                        children: [
                          Text('text_description'.tr,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade600))
                              .addPaddingOnly(
                                  right: 8, left: 8, top: 15, bottom: 5),
                          const Text('*',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.red))
                              .addPaddingOnly(top: 15),
                        ],
                      ),
                      StreamBuilder<bool>(
                          stream: _editCompanyBloc.desSubject.stream,
                          initialData: true,
                          builder: (context, snapshot) {
                            return TextField(
                              style: TextStyle(fontSize: 14),
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
                                hintText: '',
                                hintStyle: const TextStyle(
                                    fontSize: 14, color: Color(0xFF9797AD)),
                                errorText: snapshot.data!
                                    ? null
                                    : 'text_description_error'.tr,
                              ),
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () => node.nextFocus(),
                              keyboardType: TextInputType.text,
                              onChanged: (val) =>
                                  _editCompanyBloc.changeDes(val),
                              controller: _editCompanyBloc.desController,
                              maxLines: 3,
                            );
                          }),
                      Row(
                        children: [
                          Text('text_address'.tr,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade600))
                              .addPaddingOnly(
                                  right: 8, left: 8, top: 15, bottom: 5),
                          const Text('*',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.red))
                              .addPaddingOnly(top: 15),
                        ],
                      ),
                      StreamBuilder<bool>(
                          stream: _editCompanyBloc.addressSubject.stream,
                          initialData: true,
                          builder: (context, snapshot) {
                            //_editCompanyBloc.addressController.text=getProfileDatasnapshot.data.address_en;
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
                                        width: 1, color: Colors.red.shade800)),
                                hintText:
                                    '${getProfileDatasnapshot.data!.address_en}',
                                hintStyle: const TextStyle(
                                    fontSize: 14, color: Color(0xFF9797AD)),
                                errorText: snapshot.data!
                                    ? null
                                    : 'text_address_error'.tr,
                              ),
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () => node.nextFocus(),
                              keyboardType: TextInputType.text,
                              onChanged: (val) =>
                                  _editCompanyBloc.changeAdress(val),
                              controller: _editCompanyBloc.addressController,
                            );
                          }),
                      // BuildViewMap(widget.lng,widget.lat),
                      GestureDetector(
                          onTap: () async {
                            // final locationPicker.LocationResult result = await locationPicker.showLocationPicker(
                            //     context,
                            //     'AIzaSyCojvOL87lFBZWjfUGiu_aS22WY0QyudSA',
                            //     initialCenter: lng.LatLng(_editCompanyBloc.lanSubject.value, _editCompanyBloc.lngSubject.value),
                            //     //automaticallyAnimateToCurrentLocation: true,
                            //     //mapStylePath: 'assets/mapStyle.json',
                            //     myLocationButtonEnabled: true,
                            //     // requiredGPS: true,
                            //     layersButtonEnabled: true,
                            //     // countries: ['AE', 'NG'],
                            //     //resultCardAlignment: Alignment.bottomCenter,
                            //     desiredAccuracy: LocationAccuracy.best,
                            //   );

                            // _editCompanyBloc.lanSubject.value=result.latLng.latitude;
                            // _editCompanyBloc.lngSubject.value=result.latLng.longitude;
                            // _editCompanyBloc.addressController.text=result.address;
                            //await _editCompanyBloc.editCompanyBloc(lat: result.latLng.latitude,lng: result.latLng.longitude,company_id:widget.company_id ,context: context);

                            // setState(() {
                            //   _editCompanyBloc.lanSubject.value=result.latLng.latitude;
                            //   _editCompanyBloc.lngSubject.value=result.latLng.longitude;
                            //   _editCompanyBloc.addressController.text=null;
                            //   _editCompanyBloc.addressController.text=result.address;
                            print(
                                'test1  ${_editCompanyBloc.lanSubject.value}');
                            print(
                                'test1  ${_editCompanyBloc.lngSubject.value}');
                            print(
                                'test1  ${_editCompanyBloc.addressController.text}');
                            // });
                          },
                          child: BuildViewMap(_editCompanyBloc.lngSubject.value,
                              _editCompanyBloc.lanSubject.value)),

                      Row(
                        children: [
                          Text('text_phone'.tr,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade600))
                              .addPaddingOnly(
                                  right: 8, left: 8, top: 15, bottom: 5),
                          const Text('*',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.red))
                              .addPaddingOnly(top: 15),
                        ],
                      ),
                      StreamBuilder<bool>(
                          stream: _editCompanyBloc.mobileSubject.stream,
                          initialData: true,
                          builder: (context, snapshot) {
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
                                        width: 1, color: Colors.red.shade800)),
                                hintText: '',
                                hintStyle: const TextStyle(
                                    fontSize: 14, color: Color(0xFF9797AD)),
                                errorText: snapshot.data!
                                    ? null
                                    : 'text_phone_error'.tr,
                              ),
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () => node.nextFocus(),
                              keyboardType: TextInputType.phone,
                              onChanged: (val) =>
                                  _editCompanyBloc.changeMobile(val),
                              controller: _editCompanyBloc.mobileController,
                            );
                          }),
                      Text('text_phone2'.tr,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade600))
                          .addPaddingOnly(
                              right: 8, left: 8, top: 15, bottom: 5),
                      StreamBuilder<bool>(
                          stream: _editCompanyBloc.mobile2Subject.stream,
                          initialData: true,
                          builder: (context, snapshot) {
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
                                        width: 1, color: Colors.red.shade800)),
                                hintText: '',
                                hintStyle: const TextStyle(
                                    fontSize: 14, color: Color(0xFF9797AD)),
                                errorText: snapshot.data!
                                    ? null
                                    : 'text_phone_error'.tr,
                              ),
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () => node.nextFocus(),
                              keyboardType: TextInputType.phone,
                              onChanged: (val) =>
                                  _editCompanyBloc.changeMobile2(val),
                              controller: _editCompanyBloc.mobile2Controller,
                            );
                          }),
                      Text('text_Tel'.tr,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade600))
                          .addPaddingOnly(
                              right: 8, left: 8, top: 15, bottom: 5),
                      StreamBuilder<bool>(
                          stream: _editCompanyBloc.phoneSubject.stream,
                          initialData: true,
                          builder: (context, snapshot) {
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
                                        width: 1, color: Colors.red.shade800)),
                                hintText: '',
                                hintStyle: const TextStyle(
                                    fontSize: 14, color: Color(0xFF9797AD)),
                                errorText: snapshot.data!
                                    ? null
                                    : 'text_phone_error'.tr,
                              ),
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () => node.nextFocus(),
                              keyboardType: TextInputType.phone,
                              onChanged: (val) =>
                                  _editCompanyBloc.changePhone(val),
                              controller: _editCompanyBloc.phoneController,
                            );
                          }),

                      // Padding(
                      //   padding: const EdgeInsets.only(top: 15),
                      //   child: StreamBuilder<List<SocialController>>(
                      //       stream: _editCompanyBloc.socialSubject.stream,
                      //       initialData: [SocialController()],
                      //       builder: (context, snapshot) {
                      //         print(
                      //             'sasa${_editCompanyBloc.socialSubject.stream.value}');
                      //         return Column(
                      //           children:
                      //           List.generate(snapshot.data.length, (index) {
                      //             return SocialWidget(
                      //               socialItems: _editCompanyBloc.socialItems,
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
                      //           _editCompanyBloc.socialSubject.sink.add(
                      //               _editCompanyBloc.socialSubject.value
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
                      //     stream: _editCompanyBloc.faxSubject.stream,
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
                      //         onChanged: (val) =>_editCompanyBloc.changeFax(val),
                      //         controller: _editCompanyBloc.faxController,
                      //       );
                      //     }),
                      Row(
                        children: [
                          Text('text_email'.tr,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade600))
                              .addPaddingOnly(
                                  right: 8, left: 8, top: 15, bottom: 10),
                          const Text('*',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.red))
                              .addPaddingOnly(top: 15),
                        ],
                      ),
                      StreamBuilder<bool>(
                          stream: _editCompanyBloc.emailOrPhoneSubject.stream,
                          initialData: true,
                          builder: (context, snapshot) {
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
                                        width: 1, color: Colors.red.shade800)),
                                hintText: 'hint_email'.tr,
                                hintStyle: const TextStyle(
                                    fontSize: 14, color: Color(0xFF9797AD)),
                                errorText:
                                    snapshot.data! ? null : 'email_error'.tr,
                              ),
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () => node.nextFocus(),
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (val) =>
                                  _editCompanyBloc.changeEmailOrPhone(val),
                              controller:
                                  _editCompanyBloc.emailOrPhoneController,
                            );
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //
                      //     StreamBuilder<File>(
                      //         stream: _editCompanyBloc.pdfController.stream,
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
                      //                               _editCompanyBloc.pdfController.sink
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
                      //                           _editCompanyBloc.pdfController.sink.add(pdfFile);
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
                      //         stream: _editCompanyBloc.imagesOfCompanyController.stream,
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
                      //                                 _editCompanyBloc.imagesOfCompanyController.sink
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
                      //                             _editCompanyBloc.imagesOfCompanyController.sink
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
                      //                         //   _editCompanyBloc.imagesOfCompanyController.sink.add(img);
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
                                      fontSize: 14,
                                      color: Colors.grey.shade600))
                              .addPaddingOnly(
                                  right: 8, left: 8, top: 15, bottom: 10),
                          const Text('*',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.red))
                              .addPaddingOnly(top: 15),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          StreamBuilder<String>(
                            stream: _editCompanyBloc.workDaysSubjectFrom.stream,
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
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(6)),
                                        border: Border.all(
                                            width: 1,
                                            color: context.accentColor),
                                      ),
                                      child: DropdownButton<String>(
                                        iconSize: 30,
                                        isExpanded: true,
                                        value: snapshot.data!.tr,
                                        dropdownColor: const Color(0xFFE0E7FF),
                                        items: LIST_DAYS
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4,
                                                      vertical: 4),
                                              child: Text(
                                                value,
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (String? val) {
                                          _editCompanyBloc
                                              .workDaysSubjectFrom.sink
                                              .add(LIST_DAYsS[val]!);
                                        },
                                      ).addPaddingOnly(right: 15));
                            },
                          ),
                          Text('to'.tr),
                          StreamBuilder<String>(
                            stream: _editCompanyBloc.workDaysSubjectTo.stream,
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
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(6)),
                                        border: Border.all(
                                            width: 1,
                                            color: context.accentColor),
                                      ),
                                      child: DropdownButton<String>(
                                        iconSize: 30,
                                        isExpanded: true,
                                        value: snapshot.data!.tr,
                                        dropdownColor: const Color(0xFFE0E7FF),
                                        items: LIST_DAYS
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4,
                                                      vertical: 4),
                                              child: Text(
                                                value,
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (String? val) {
                                          _editCompanyBloc
                                              .workDaysSubjectTo.sink
                                              .add(LIST_DAYsS[val]!);
                                          // _editCompanyBloc.workDaysSubjectTo.sink.add(val);
                                        },
                                      ).addPaddingOnly(right: 15));
                            },
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Text('text_time_of_work'.tr,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade600))
                              .addPaddingOnly(
                                  right: 8, left: 8, top: 15, bottom: 10),
                          const Text('*',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.red))
                              .addPaddingOnly(top: 15),
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     FlatButton(
                      //
                      //         onPressed: () {
                      //
                      //            DatePicker.showTime12hPicker(context, showTitleActions: true,
                      //               // theme: ,
                      //               onChanged: (date) {
                      //                 print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
                      //               },
                      //               onConfirm: (date) {
                      //
                      //                 setState(() {
                      //                   // _valueTimeFrom='${date.hour}:${date.minute}:${date.second}';
                      //                   _valueTimeFrom=DateFormat.jm().format(date);
                      //                 });
                      //                 // _editCompanyBloc.workTimeSubjectFrom.sink.add(_valueTimeFrom);
                      //                 // _editCompanyBloc.workTimeSubjectFrom.sink.add(DateFormat.Hms().format(date));
                      //                 _editCompanyBloc.workTimeSubjectFrom.sink.add(date);
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
                      //     Text('to'.tr),
                      //     FlatButton(
                      //
                      //         onPressed: () {
                      //           DatePicker.showTime12hPicker(context, showTitleActions: true,
                      //
                      //               onChanged: (date) {
                      //                 print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
                      //               },
                      //               onConfirm: (date) {
                      //                 setState(() {
                      //                   // _valueTimeTo='${date.hour}:${date.minute}:${date.second}';
                      //                   _valueTimeTo=DateFormat.jm().format(date);
                      //                 });
                      //                 // _editCompanyBloc.workTimeSubjectTo.sink.add(_valueTimeTo);
                      //                 _editCompanyBloc.workTimeSubjectTo.sink.add(date);
                      //                 print('w${_editCompanyBloc.workTimeSubjectTo.value}');
                      //             }, currentTime: DateTime.now());
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
                              initialValue: DateFormat("hh:mm:ss").parse(
                                  getProfileDatasnapshot.data!.open_from),
                              decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.black45),
                                errorStyle: TextStyle(color: Colors.redAccent),
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.access_time),
                                labelText: 'select_time'.tr,
                              ),
                              mode: DateTimeFieldPickerMode.time,

                              autovalidateMode: AutovalidateMode.always,
                              //validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                              onDateSelected: (DateTime value) {
                                print(value);
                                print(DateFormat.Hms().format(value));
                                _editCompanyBloc.workTimeSubjectFrom.sink
                                    .add(DateFormat.Hms().format(value));
                              },
                            ),
                          ),
                          Text('to'.tr),
                          Container(
                            color: Color(0xFFE0E7FF),
                            width: (Get.width / 3) + 20,
                            child: DateTimeFormField(
                              initialValue: DateFormat("hh:mm:ss")
                                  .parse(getProfileDatasnapshot.data!.open_to),
                              decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.black45),
                                errorStyle: TextStyle(color: Colors.redAccent),
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.access_time),
                                labelText: 'select_time'.tr,
                              ),
                              mode: DateTimeFieldPickerMode.time,
                              autovalidateMode: AutovalidateMode.always,
                              //validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                              onDateSelected: (DateTime value) {
                                print(value);
                                _editCompanyBloc.workTimeSubjectTo.sink
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
                      //             _editCompanyBloc.workTimeSubjectFrom.sink.add(val);
                      //             print('worktime ${_editCompanyBloc.workTimeSubjectFrom.value}');
                      //             _valueChangedFrom = val;
                      //             // setState(() => _valueChangedFrom = val);
                      //           },
                      //           validator: (val) {
                      //             _valueToValidateFrom = val;
                      //             // setState(() => _valueToValidateFrom = val);
                      //             return null;
                      //           },
                      //           onSaved: (val)  {
                      //             _editCompanyBloc.workTimeSubjectFrom.sink.add(val);
                      //             _valueSavedFrom = val;
                      //             // setState(() => _valueSavedFrom = val)
                      //           },
                      //         ),
                      //       ),),
                      //     Text('to'),
                      //     Container(
                      //       height: 70,
                      //       width: Get.width/3,
                      //       child: Center(
                      //         child: DateTimePicker(
                      //           type: DateTimePickerType.time,
                      //           controller: _controllerTo,
                      //           //initialValue: _initialValue,
                      //           icon: Icon(Icons.access_time),
                      //           //timeLabelText: "Time",
                      //           //use24HourFormat: false,
                      //           //locale: Locale('en', 'US'),
                      //           onChanged: (val) {
                      //             _editCompanyBloc.workTimeSubjectTo.sink.add(val);
                      //             print('worktime ${_editCompanyBloc.workTimeSubjectTo.value}');
                      //             _valueChangedTo = val;
                      //           },
                      //           // setState(() => _valueChangedTo = val),
                      //           validator: (val) {
                      //             _valueToValidateTo = val;
                      //             // setState(() => _valueToValidateTo = val);
                      //             return null;
                      //           },
                      //           onSaved: (val)  {
                      //             _editCompanyBloc.workTimeSubjectTo.sink.add(val);
                      //             print('worktime ${_editCompanyBloc.workTimeSubjectTo.value}');
                      //             // setState(() => _valueSavedTo = val)
                      //           },
                      //         ),
                      //       ),),
                      //
                      //   ],
                      // ),
                      Row(
                        children: [
                          Text('text_country'.tr,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade600))
                              .addPaddingOnly(
                                  right: 8, left: 8, top: 15, bottom: 5),
                          const Text('*',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.red))
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
                      //               stream: _editCompanyBloc.allCountriesSubject.stream,
                      //               builder: (context, countriesSnapshot) {
                      //                 if (countriesSnapshot.hasData) {
                      //                   return StreamBuilder<CountriesData>(
                      //                       stream: _editCompanyBloc.selectedCountry.stream,
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
                      //                                 _editCompanyBloc.selectedCities.sink.add(null);
                      //                                 _editCompanyBloc.selectedCountry.sink
                      //                                     .add(item);
                      //                                 print(_editCompanyBloc
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xffE0E7FF)),
                                child: StreamBuilder<CountriesData>(
                                    stream:
                                        _editCompanyBloc.selectedCountry.stream,
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
                                                              _editCompanyBloc
                                                                  .sortCountry(
                                                                      v);
                                                            },
                                                          ),
                                                        ),
                                                        Divider(),
                                                        Expanded(
                                                          child: StreamBuilder<
                                                                  List<
                                                                      CountriesData>>(
                                                              stream: _editCompanyBloc
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
                                                                                countriesSnapshot.data![index];
                                                                            return InkWell(
                                                                              onTap: () {
                                                                                _editCompanyBloc.selectedCountry.add(item);
                                                                                Get.back();
                                                                              },
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Row(
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
                                                                          separatorBuilder: (ctx,
                                                                              index) {
                                                                            return Divider();
                                                                          },
                                                                          shrinkWrap:
                                                                              true,
                                                                          itemCount: countriesSnapshot
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
                                                  child: Row(
                                                    children: [
                                                      snapshot.data!.icon !=
                                                              null
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
                                                        style:
                                                            kTextStyle.copyWith(
                                                                color: Colors
                                                                    .black),
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
                      //               stream: _editCompanyBloc.selectedCountry.stream,
                      //               builder: (context, snapshot) {
                      //                 if (snapshot.hasData) {
                      //                   return StreamBuilder<CitiesData>(
                      //                       stream: _editCompanyBloc.selectedCities.stream,
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
                      //                                 'select_city'.tr,
                      //                                 style: kTextStyle.copyWith(
                      //                                     color: Colors.black),
                      //                               ),
                      //                               style: kTextStyle.copyWith(
                      //                                   color: Colors.black),
                      //                               underline: SizedBox(),
                      //                               value: citySnapshot.data,
                      //                               onChanged: (CitiesData item) {
                      //
                      //                                 _editCompanyBloc.selectedCities.sink.add(item);
                      //                                 print(_editCompanyBloc.selectedCities.value);
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xffE0E7FF)),
                                child: StreamBuilder<CountriesData>(
                                    stream:
                                        _editCompanyBloc.selectedCountry.stream,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        _editCompanyBloc.allSortCitiesSubject
                                            .add(snapshot.data!.cities!);
                                        return StreamBuilder<CitiesData>(
                                            stream: _editCompanyBloc
                                                .selectedCities.stream,
                                            // initialData: _bloc
                                            //     .allCountriesSubject.value[0],
                                            builder: (context, snapshot) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 8),
                                                child: InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder:
                                                            (ctx) => Dialog(
                                                                    child:
                                                                        Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          TextField(
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14),
                                                                        decoration:
                                                                            InputDecoration(
                                                                          filled:
                                                                              true,
                                                                          fillColor:
                                                                              Colors.white,
                                                                          contentPadding:
                                                                              EdgeInsets.all(9),
                                                                          focusedBorder:
                                                                              OutlineInputBorder(
                                                                            borderRadius:
                                                                                const BorderRadius.all(Radius.circular(6)),
                                                                            borderSide:
                                                                                BorderSide(width: 1, color: context.accentColor),
                                                                          ),
                                                                          disabledBorder:
                                                                              const OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(6)),
                                                                            borderSide:
                                                                                BorderSide(width: 1, color: Colors.black54),
                                                                          ),
                                                                          enabledBorder:
                                                                              const OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(6)),
                                                                            borderSide:
                                                                                BorderSide(width: 1, color: Color(0xFFC2C3DF)),
                                                                          ),
                                                                          border: const OutlineInputBorder(
                                                                              borderRadius: BorderRadius.all(Radius.circular(6)),
                                                                              borderSide: BorderSide(width: 1)),
                                                                          hintText:
                                                                              'Search',
                                                                          hintStyle: const TextStyle(
                                                                              fontSize: 14,
                                                                              color: Color(0xFF9797AD)),
                                                                        ),
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        keyboardType:
                                                                            TextInputType.text,
                                                                        onChanged:
                                                                            (v) {
                                                                          _editCompanyBloc
                                                                              .sortCities(v);
                                                                        },
                                                                      ),
                                                                    ),
                                                                    Divider(),
                                                                    Expanded(
                                                                      child: StreamBuilder<
                                                                              List<
                                                                                  CitiesData>>(
                                                                          stream: _editCompanyBloc
                                                                              .allSortCitiesSubject
                                                                              .stream,
                                                                          builder:
                                                                              (context, citiesSnapshot) {
                                                                            if (citiesSnapshot.hasData) {
                                                                              return ListView.separated(
                                                                                  itemBuilder: (ctx, index) {
                                                                                    final item = citiesSnapshot.data![index];
                                                                                    return InkWell(
                                                                                      onTap: () {
                                                                                        _editCompanyBloc.selectedCities.add(item);
                                                                                        Get.back();
                                                                                      },
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.all(8.0),
                                                                                        child: Text(item.name!),
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                  separatorBuilder: (ctx, index) {
                                                                                    return Divider();
                                                                                  },
                                                                                  shrinkWrap: true,
                                                                                  itemCount: citiesSnapshot.data!.length);
                                                                            } else {
                                                                              return const Padding(
                                                                                padding: EdgeInsets.all(8.0),
                                                                                child: Center(
                                                                                    child: CircularProgressIndicator(
                                                                                  valueColor: AlwaysStoppedAnimation<Color>(kAccentColor),
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
                                                              const EdgeInsets
                                                                  .all(2.0),
                                                          child: Text(
                                                            snapshot
                                                                .data!.name!,
                                                            style: kTextStyle
                                                                .copyWith(
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                        )
                                                      : Row(
                                                          children: [
                                                            Text(
                                                              'select_city'.tr,
                                                              style: kTextStyle
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .black),
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
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
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
                                      fontSize: 14,
                                      color: Colors.grey.shade600))
                              .addPaddingOnly(
                                  right: 8, left: 8, top: 15, bottom: 5),
                          const Text('*',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.red))
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
                      //               _editCompanyBloc.getAllCategoriesSubject.stream,
                      //               builder: (context, categoriesSnapshot) {
                      //                 if (categoriesSnapshot.hasData) {
                      //                   return StreamBuilder<Categories_Data>(
                      //                       stream: _editCompanyBloc
                      //                           .selectCategoriesSubject.stream,
                      //                       builder: (context, snapshot) {
                      //                         return Padding(
                      //                           padding: const EdgeInsets.symmetric(
                      //                               horizontal: 10, vertical: 2),
                      //                           child: SearchableDropdown.single(
                      //
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
                      //                               print(item.name);
                      //                                 _editCompanyBloc
                      //                                   .selectedSubCategories.sink
                      //                                   .add(null);
                      //
                      //                               _editCompanyBloc
                      //                                   .selectedSubSubCategories.sink
                      //                                   .add(null);
                      //
                      //                               _editCompanyBloc
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xffE0E7FF)),
                                child: StreamBuilder<Categories_Data>(
                                    stream: _editCompanyBloc
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
                                                              _editCompanyBloc
                                                                  .sortAllCategories(
                                                                      v);
                                                            },
                                                          ),
                                                        ),
                                                        Divider(),
                                                        Expanded(
                                                          child: StreamBuilder<
                                                                  List<
                                                                      Categories_Data>>(
                                                              stream: _editCompanyBloc
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
                                                                                countriesSnapshot.data![index];
                                                                            return InkWell(
                                                                              onTap: () {
                                                                                _editCompanyBloc.selectCategoriesSubject.add(item);
                                                                                Get.back();
                                                                              },
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Row(
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
                                                                          separatorBuilder: (ctx,
                                                                              index) {
                                                                            return Divider();
                                                                          },
                                                                          shrinkWrap:
                                                                              true,
                                                                          itemCount: countriesSnapshot
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
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Text(
                                                        snapshot.data!.name!,
                                                        style:
                                                            kTextStyle.copyWith(
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Row(
                                                  children: [
                                                    Text(
                                                      'select_category'.tr,
                                                      // context.translate('select_country'),
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
                      //               _editCompanyBloc.selectCategoriesSubject.stream,
                      //               builder: (context, snapshot) {
                      //                 if (snapshot.hasData) {
                      //                   return StreamBuilder<SubCategories>(
                      //                       stream: _editCompanyBloc
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
                      //                               _editCompanyBloc
                      //                                   .selectedSubSubCategories.sink
                      //                                   .add(null);
                      //                               _editCompanyBloc
                      //                                   .selectedSubCategories.sink
                      //                                   .add(item);
                      //                               // widget
                      //                               //     .bloc.selectedSubCategories.sink
                      //                               //     .add(item);
                      //                               print(_editCompanyBloc
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xffE0E7FF)),
                                child: StreamBuilder<Categories_Data>(
                                    stream: _editCompanyBloc
                                        .selectCategoriesSubject.stream,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        _editCompanyBloc.getSortAllSubCategories
                                            .add(
                                                snapshot.data!.sub_categories!);
                                        return StreamBuilder<SubCategories>(
                                            stream: _editCompanyBloc
                                                .selectedSubCategories.stream,
                                            builder: (context, snapshot) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 8),
                                                child: InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder:
                                                            (ctx) => Dialog(
                                                                    child:
                                                                        Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          TextField(
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14),
                                                                        decoration:
                                                                            InputDecoration(
                                                                          filled:
                                                                              true,
                                                                          fillColor:
                                                                              Colors.white,
                                                                          contentPadding:
                                                                              EdgeInsets.all(9),
                                                                          focusedBorder:
                                                                              OutlineInputBorder(
                                                                            borderRadius:
                                                                                const BorderRadius.all(Radius.circular(6)),
                                                                            borderSide:
                                                                                BorderSide(width: 1, color: context.accentColor),
                                                                          ),
                                                                          disabledBorder:
                                                                              const OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(6)),
                                                                            borderSide:
                                                                                BorderSide(width: 1, color: Colors.black54),
                                                                          ),
                                                                          enabledBorder:
                                                                              const OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(6)),
                                                                            borderSide:
                                                                                BorderSide(width: 1, color: Color(0xFFC2C3DF)),
                                                                          ),
                                                                          border: const OutlineInputBorder(
                                                                              borderRadius: BorderRadius.all(Radius.circular(6)),
                                                                              borderSide: BorderSide(width: 1)),
                                                                          hintText:
                                                                              'Search',
                                                                          hintStyle: const TextStyle(
                                                                              fontSize: 14,
                                                                              color: Color(0xFF9797AD)),
                                                                        ),
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        keyboardType:
                                                                            TextInputType.text,
                                                                        onChanged:
                                                                            (v) {
                                                                          _editCompanyBloc
                                                                              .sortSubCategories(v);
                                                                        },
                                                                      ),
                                                                    ),
                                                                    Divider(),
                                                                    Expanded(
                                                                      child: StreamBuilder<
                                                                              List<
                                                                                  SubCategories>>(
                                                                          stream: _editCompanyBloc
                                                                              .getSortAllSubCategories
                                                                              .stream,
                                                                          builder:
                                                                              (context, subCategoriesSnapshot) {
                                                                            if (subCategoriesSnapshot.hasData) {
                                                                              return ListView.separated(
                                                                                  itemBuilder: (ctx, index) {
                                                                                    final item = subCategoriesSnapshot.data![index];
                                                                                    return InkWell(
                                                                                      onTap: () {
                                                                                        _editCompanyBloc.selectedSubCategories.add(item);
                                                                                        Get.back();
                                                                                      },
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.all(8.0),
                                                                                        child: Text(item.name!),
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                  separatorBuilder: (ctx, index) {
                                                                                    return Divider();
                                                                                  },
                                                                                  shrinkWrap: true,
                                                                                  itemCount: subCategoriesSnapshot.data!.length);
                                                                            } else {
                                                                              return const Padding(
                                                                                padding: EdgeInsets.all(8.0),
                                                                                child: Center(
                                                                                    child: CircularProgressIndicator(
                                                                                  valueColor: AlwaysStoppedAnimation<Color>(kAccentColor),
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
                                                              const EdgeInsets
                                                                  .all(2.0),
                                                          child: Text(
                                                            snapshot
                                                                .data!.name!,
                                                            style: kTextStyle
                                                                .copyWith(
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                        )
                                                      : Row(
                                                          children: [
                                                            Text(
                                                              'select_sub_category'
                                                                  .tr,
                                                              style: kTextStyle
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .black),
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
                      //               _editCompanyBloc.selectedSubCategories.stream,
                      //               builder: (context, snapshot) {
                      //                 if (snapshot.hasData) {
                      //                   return StreamBuilder<SubSubCategories>(
                      //                       stream: _editCompanyBloc
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
                      //                               _editCompanyBloc
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xffE0E7FF)),
                                child: StreamBuilder<SubCategories>(
                                    stream: _editCompanyBloc
                                        .selectedSubCategories.stream,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        _editCompanyBloc
                                            .getSortAllSubSubCategories
                                            .add(snapshot
                                                .data!.sub_sub_categories!);
                                        return StreamBuilder<SubSubCategories>(
                                            stream: _editCompanyBloc
                                                .selectedSubSubCategories
                                                .stream,
                                            builder: (context, snapshot) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 8),
                                                child: InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder:
                                                            (ctx) => Dialog(
                                                                    child:
                                                                        Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          TextField(
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14),
                                                                        decoration:
                                                                            InputDecoration(
                                                                          filled:
                                                                              true,
                                                                          fillColor:
                                                                              Colors.white,
                                                                          contentPadding:
                                                                              EdgeInsets.all(9),
                                                                          focusedBorder:
                                                                              OutlineInputBorder(
                                                                            borderRadius:
                                                                                const BorderRadius.all(Radius.circular(6)),
                                                                            borderSide:
                                                                                BorderSide(width: 1, color: context.accentColor),
                                                                          ),
                                                                          disabledBorder:
                                                                              const OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(6)),
                                                                            borderSide:
                                                                                BorderSide(width: 1, color: Colors.black54),
                                                                          ),
                                                                          enabledBorder:
                                                                              const OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(6)),
                                                                            borderSide:
                                                                                BorderSide(width: 1, color: Color(0xFFC2C3DF)),
                                                                          ),
                                                                          border: const OutlineInputBorder(
                                                                              borderRadius: BorderRadius.all(Radius.circular(6)),
                                                                              borderSide: BorderSide(width: 1)),
                                                                          hintText:
                                                                              'Search',
                                                                          hintStyle: const TextStyle(
                                                                              fontSize: 14,
                                                                              color: Color(0xFF9797AD)),
                                                                        ),
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        keyboardType:
                                                                            TextInputType.text,
                                                                        onChanged:
                                                                            (v) {
                                                                          _editCompanyBloc
                                                                              .sortSubSubCategories(v);
                                                                        },
                                                                      ),
                                                                    ),
                                                                    Divider(),
                                                                    Expanded(
                                                                      child: StreamBuilder<
                                                                              List<
                                                                                  SubSubCategories>>(
                                                                          stream: _editCompanyBloc
                                                                              .getSortAllSubSubCategories
                                                                              .stream,
                                                                          builder:
                                                                              (context, subSubCategoriesSnapshot) {
                                                                            if (subSubCategoriesSnapshot.hasData) {
                                                                              return ListView.separated(
                                                                                  itemBuilder: (ctx, index) {
                                                                                    final item = subSubCategoriesSnapshot.data![index];
                                                                                    return InkWell(
                                                                                      onTap: () {
                                                                                        _editCompanyBloc.selectedSubSubCategories.add(item);
                                                                                        Get.back();
                                                                                      },
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.all(8.0),
                                                                                        child: Text(item.name!),
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                  separatorBuilder: (ctx, index) {
                                                                                    return Divider();
                                                                                  },
                                                                                  shrinkWrap: true,
                                                                                  itemCount: subSubCategoriesSnapshot.data!.length);
                                                                            } else {
                                                                              return const Padding(
                                                                                padding: EdgeInsets.all(8.0),
                                                                                child: Center(
                                                                                    child: CircularProgressIndicator(
                                                                                  valueColor: AlwaysStoppedAnimation<Color>(kAccentColor),
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
                                                              const EdgeInsets
                                                                  .all(2.0),
                                                          child: Text(
                                                            snapshot
                                                                .data!.name!,
                                                            style: kTextStyle
                                                                .copyWith(
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                        )
                                                      : Row(
                                                          children: [
                                                            Text(
                                                              'select_sub_category'
                                                                  .tr,
                                                              style: kTextStyle
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .black),
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
                      //               _editCompanyBloc.getAllCategoriesSubject.stream,
                      //               builder: (context, categoriesSnapshot) {
                      //                 print(
                      //                     'ew${_editCompanyBloc.getAllCategoriesSubject.value}');
                      //                 if (categoriesSnapshot.hasData) {
                      //                   return StreamBuilder<Categories_Data>(
                      //                       stream: _editCompanyBloc
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
                      //                                 'select_category'.tr,
                      //                                 style: kTextStyle.copyWith(
                      //                                     color: Colors.black),
                      //                               ),
                      //                               style: kTextStyle.copyWith(
                      //                                   color: Colors.black),
                      //                               underline: SizedBox(),
                      //                               value: snapshot.data,
                      //                               onChanged: (Categories_Data item) {
                      //                                 print(item.name);
                      //                                 _editCompanyBloc
                      //                                     .selectedSubCategories.sink
                      //                                     .add(null);
                      //                                 _editCompanyBloc
                      //                                     .selectCategoriesSubject.sink
                      //                                     .add(item);
                      //                                 // _editCompanyBloc.selectCategoriesSubject
                      //                                 //     .sink
                      //                                 //     .add(item);
                      //                                 print(_editCompanyBloc
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
                      //               _editCompanyBloc.selectCategoriesSubject.stream,
                      //               builder: (context, snapshot) {
                      //                 if (snapshot.hasData) {
                      //                   return StreamBuilder<SubCategories>(
                      //                       stream: _editCompanyBloc
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
                      //
                      //                               'select_sub_category'.tr,
                      //                                 style: kTextStyle.copyWith(
                      //                                     color: Colors.black),
                      //                               ),
                      //                               style: kTextStyle.copyWith(
                      //                                   color: Colors.black),
                      //                               underline: SizedBox(),
                      //                               value: subcategoriesSnapshot.data,
                      //                               onChanged: (SubCategories item) {
                      //                                 print(item.name);
                      //                                 _editCompanyBloc
                      //                                     .selectedSubCategories.sink
                      //                                     .add(item);
                      //                                 // widget
                      //                                 //     .bloc.selectedSubCategories.sink
                      //                                 //     .add(item);
                      //                                 print(_editCompanyBloc
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

                      const SizedBox(
                        height: 15,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: RoundedLoadingButton(
                          child: Text(
                            'bt_edit'.tr,
                            style: kTextStyle.copyWith(
                                fontSize: 18, color: Color(0xffFFFFFF)),
                          ),
                          height: 50,
                          controller: _editCompanyBloc.loadingButtonController,
                          color: Colors.blue.shade800,
                          onPressed: () async {
                            _editCompanyBloc.loadingButtonController.start();
                            // await _editCompanyBloc.editCompanyBloc(lat: getProfileDatasnapshot.data.lat,lng: getProfileDatasnapshot.data.lng,company_id:widget.company_id ,context: context);

                            await _editCompanyBloc.editCompanyBloc(
                                lat: _editCompanyBloc.lanSubject.value,
                                lng: _editCompanyBloc.lngSubject.value,
                                company_id: widget.company_id,
                                context: context);
                            // Get.to(MapTest());
                            _editCompanyBloc.loadingButtonController.stop();
                          },
                        ),
                      ),
                    ],
                  ).addPaddingOnly(bottom: 28),
                );
              } else {
                return SizedBox(
                    height: Get.height,
                    child: const Center(
                        child: CircularProgressIndicator(
                      backgroundColor: kPrimaryColor,
                    )));
              }
            }),
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
        final now = details.focalPoint;

        // final diff = now - _dragStart;
        _dragStart = now;
        //controller.drag(diff.dx, diff.dy);
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
// class SocialWidget extends StatefulWidget {
//   final List<SocialItem> socialItems;
//   final SocialController controller;
//
//   const SocialWidget({Key key, this.socialItems, this.controller})
//       : super(key: key);
//
//   @override
//   _SocialWidgetState createState() => _SocialWidgetState();
// }
//
// class _SocialWidgetState extends State<SocialWidget> {
//   final formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: formKey,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 4),
//         child: Row(
//           children: [
//             Expanded(
//               flex: 5,
//               child: Container(
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: Color(0xffE0E7FF)),
//                 child: Padding(
//                   padding:
//                   const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
//                   child: DropDown<SocialItem>(
//                     items: widget.socialItems,
//                     hint: Text('Social'),
//                     isExpanded: true,
//                     customWidgets: widget.socialItems.map((e) {
//                       return Row(
//                         children: [
//                           Icon(e.icon),
//                           SizedBox(
//                             width: 5,
//                           ),
//                           Expanded(
//                               child: Text(
//                                 e.name,
//                                 overflow: TextOverflow.ellipsis,
//                               )),
//                         ],
//                       );
//                     }).toList(),
//                     onChanged: (SocialItem item) {
//                       print(item);
//                       widget.controller.socialItem = item;
//                     },
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               width: 10,
//             ),
//             Expanded(
//               flex: 8,
//               child: TextFormField(
//                 style: TextStyle(fontSize: 18),
//                 validator: (String val) {
//                   if (val.isEmpty&&urlExp.hasMatch(val)) {
//                     return 'required';
//                   }
//                   return null;
//                 },
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: const Color(0xFFE0E7FF),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: const BorderRadius.all(Radius.circular(6)),
//                     borderSide:
//                     BorderSide(width: 1, color: context.accentColor),
//                   ),
//                   disabledBorder: const OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(6)),
//                     borderSide: BorderSide(width: 1, color: Colors.black54),
//                   ),
//                   enabledBorder: const OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(6)),
//                     borderSide: BorderSide(width: 1, color: Color(0xFFC2C3DF)),
//                   ),
//                   border: const OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(6)),
//                       borderSide: BorderSide(width: 1)),
//                   errorBorder: const OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(6)),
//                       borderSide: BorderSide(width: 1, color: Colors.red)),
//                   focusedErrorBorder: OutlineInputBorder(
//                       borderRadius: const BorderRadius.all(Radius.circular(6)),
//                       borderSide:
//                       BorderSide(width: 1, color: Colors.red.shade800)),
//                   hintText: '',
//                   hintStyle:
//                   const TextStyle(fontSize: 16, color: Color(0xFF9797AD)),
//                 ),
//                 keyboardType: TextInputType.text,
//                 controller: widget.controller.urlController,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class Days {
  const Days({this.key, this.value});

  final String? key;
  final String? value;
}
