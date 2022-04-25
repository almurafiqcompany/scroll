import 'dart:io';

import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:al_murafiq/screens/register_merchant/register_merchant_bloc.dart';
import 'package:al_murafiq/utils/utils.dart';
import 'package:al_murafiq/widgets/widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:get_it/get_it.dart';
import 'package:map/map.dart';
import 'package:latlng/latlng.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:al_murafiq/models/countries.dart';
import 'package:al_murafiq/screens/countries/countries_bloc.dart';
import 'package:al_murafiq/screens/home_page/categories/categories_bloc.dart';
import 'package:al_murafiq/models/categories.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as lng;

class AccountInformationMerchantScreen extends StatefulWidget {
  final RegisterMerchantBloc? bloc;

  const AccountInformationMerchantScreen({Key? key, this.bloc})
      : super(key: key);

  @override
  _AccountInformationMerchantScreenState createState() =>
      _AccountInformationMerchantScreenState();
}

class _AccountInformationMerchantScreenState
    extends State<AccountInformationMerchantScreen> {
  CategoriesBloc _categoriesBloc = CategoriesBloc();
  CountriesBloc _bloc = CountriesBloc();

  @override
  void initState() {
    // TODO: implement initState
    _categoriesBloc.fetchDataAllCategories();
    _bloc.fetchAllCountries(context);
    setLocation();
    super.initState();
  }

  SharedPreferenceHelper _helper = GetIt.instance.get<SharedPreferenceHelper>();
  // dynamic lat =await _helper.getLat();
  // dynamic lng= await _helper.getLng();

  Future<void> setLocation() async {
    try {
      widget.bloc!.latSubject.value = await _helper.getLat() ?? 0.0;
      widget.bloc!.longSubject.value = await _helper.getLng() ?? 0.0;
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      print('error set location');
    }
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return ListView(
      physics: iosScrollPhysics(),
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 4,
            ),
            StreamBuilder<File>(
                stream: widget.bloc!.imageCompanyController.stream,
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
                                      widget.bloc!.imageCompanyController.sink
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
                                  widget.bloc!.imageCompanyController.sink
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
                                // SizedBox(
                                //   height: 2,
                                // ),
                                // AutoSizeText(
                                //   'Company_photo'.tr,
                                //   style: kTextStyle,
                                //   softWrap: true,
                                //   maxFontSize: 16,
                                //   minFontSize: 14,
                                // ),
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
                stream: widget.bloc!.nameCompanyLang1Subject.stream,
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
                      errorText:
                          snapshot.data! ? null : 'text_place_name_error'.tr,
                    ),
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => node.nextFocus(),
                    keyboardType: TextInputType.text,
                    onChanged: (val) =>
                        widget.bloc!.changeNameCompanylang1(val),
                    controller: widget.bloc!.nameCompanyLang1Controller,
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
                stream: widget.bloc!.desLang1Subject.stream,
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
                      errorText:
                          snapshot.data! ? null : 'text_description_error'.tr,
                    ),
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => node.nextFocus(),
                    keyboardType: TextInputType.text,
                    onChanged: (val) => widget.bloc!.changeDesLang1(val),
                    controller: widget.bloc!.desLang1Controller,
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
                stream: widget.bloc!.addressSubject.stream,
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
                      errorText:
                          snapshot.data! ? null : 'text_address_error'.tr,
                    ),
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => node.nextFocus(),
                    keyboardType: TextInputType.text,
                    onChanged: (val) => widget.bloc!.changeAddress(val),
                    controller: widget.bloc!.addressController,
                  );
                }),
            GestureDetector(
              onTap: () async {
                // locationPicker.LocationResult result = await locationPicker.showLocationPicker(
                //   context,
                //   'AIzaSyCojvOL87lFBZWjfUGiu_aS22WY0QyudSA',
                //   initialCenter: lng.LatLng(widget.bloc.latSubject.value, widget.bloc.longSubject.value),
                //   //automaticallyAnimateToCurrentLocation: true,
                //   //mapStylePath: 'assets/mapStyle.json',
                //   myLocationButtonEnabled: true,
                //   // requiredGPS: true,
                //   layersButtonEnabled: true,
                //   // countries: ['AE', 'NG'],
                //   //resultCardAlignment: Alignment.bottomCenter,
                //   desiredAccuracy: LocationAccuracy.best,
                // );

                // setState(() {
                //   // _editCompanyBloc.lanSubject.value=result.latLng.latitude;
                //   // _editCompanyBloc.lngSubject.value=result.latLng.longitude;
                //   widget.bloc.longSubject.value =result.latLng.longitude;
                //   widget.bloc.latSubject.value =result.latLng.latitude;
                //   widget.bloc.addressController.text=result.address;
                // });
              },
              child: BuildViewMap(widget.bloc!.longSubject.value,
                  widget.bloc!.latSubject.value),
            ),
            // BuildViewMap(widget.bloc.longSubject.value,widget.bloc.latSubject.value),

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
                stream: widget.bloc!.phoneSubject.stream,
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
                      errorText: snapshot.data! ? null : 'text_phone_error'.tr,
                    ),
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => node.nextFocus(),
                    keyboardType: TextInputType.phone,
                    onChanged: (val) => widget.bloc!.changePhone(val),
                    controller: widget.bloc!.phoneController,
                  );
                }),
            Text('text_phone2'.tr,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600))
                .addPaddingOnly(right: 8, left: 8, top: 15, bottom: 5),
            StreamBuilder<bool>(
                stream: widget.bloc!.mobile2Subject.stream,
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
                      errorText: snapshot.data! ? null : 'text_phone_error'.tr,
                    ),
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => node.nextFocus(),
                    keyboardType: TextInputType.phone,
                    onChanged: (val) => widget.bloc!.changeMobile2(val),
                    controller: widget.bloc!.mobile2Controller,
                  );
                }),
            Text('text_Tel'.tr,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600))
                .addPaddingOnly(right: 8, left: 8, top: 15, bottom: 5),
            StreamBuilder<bool>(
                stream: widget.bloc!.mobileSubject.stream,
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
                      errorText: snapshot.data! ? null : 'text_phone_error'.tr,
                    ),
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => node.unfocus(),
                    keyboardType: TextInputType.phone,
                    onChanged: (val) => widget.bloc!.changeMobile(val),
                    controller: widget.bloc!.mobileController,
                  );
                }),
            // Text('text_fax'.tr,
            //     style: TextStyle(
            //         fontSize: 14, color: Colors.grey.shade600))
            //     .addPaddingOnly(right: 15, top: 25, bottom: 5),
            // StreamBuilder<bool>(
            //    stream: widget.bloc.faxSubject.stream,
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
            //         onChanged: (val) => widget.bloc.changeFax(val),
            //          controller: widget.bloc.faxController,
            //       );
            //     }),

            SizedBox(
              height: 15,
            ),
            const AlreadyHaveAnAccount(
              textColor: Colors.black,
            )
          ],
        ).addPaddingOnly(bottom: 28),
      ],
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

      // if (scaleDiff > 0) {
      //   controller.zoom += 0.02;
      // } else if (scaleDiff < 0) {
      //   controller.zoom -= 0.02;
      // } else {
      //   final now = details.focalPoint;
      //   final diff = now - _dragStart;
      //   _dragStart = now;
      //   controller.drag(diff.dx, diff.dy);
      // }
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

  SocialWidget({Key? key, this.socialItems, this.controller}) : super(key: key);

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
                    hint: Text('text_social'.tr),
                    isExpanded: true,
                    customWidgets: widget.socialItems!.map((e) {
                      return Row(
                        children: [
                          Icon(e.icon),
                          SizedBox(
                            width: 5,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                e.name!,
                                overflow: TextOverflow.ellipsis,
                              )),
                            ],
                          ),
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
                  if (val!.isEmpty) {
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
