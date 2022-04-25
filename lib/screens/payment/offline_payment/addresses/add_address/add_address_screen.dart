import 'dart:io';
import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/models/countries.dart';
import 'package:al_murafiq/screens/payment/offline_payment/addresses/add_address/add_address_bloc.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:al_murafiq/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:get/get.dart';
import 'package:map/map.dart';
import 'package:latlng/latlng.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as lng;
import 'package:al_murafiq/models/payment_plans.dart';

class AddAddressScreen extends StatefulWidget {
  dynamic lat, lng;
  final int? company_id;
  final int? pay_method_id;
  final int? way_pay_id;
  final PaymentPlans? paymentPlans;

  AddAddressScreen(
      {Key? key,
      this.lat,
      this.lng,
      this.company_id,
      this.pay_method_id,
      this.way_pay_id,
      this.paymentPlans})
      : super(key: key);

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  AddAddressBloc _addAddressBloc = AddAddressBloc();

  @override
  void initState() {
    _addAddressBloc.fetchAllCountries(1);

    // TODO: implement initState
    super.initState();
  }

  File? _image;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      appBar: GradientAppbar(
        title: 'text_add_address'.tr,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
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
                  stream: _addAddressBloc.addressSubject.stream,
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
                      onChanged: (val) => _addAddressBloc.changeAdress(val),
                      controller: _addAddressBloc.addressController,
                    );
                  }),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () async {
                  // locationPicker.LocationResult result = await locationPicker.showLocationPicker(
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
                  // setState(() {
                  //   // _editCompanyBloc.lanSubject.value=result.latLng.latitude;
                  //   // _editCompanyBloc.lngSubject.value=result.latLng.longitude;
                  //   widget.lng=result.latLng.longitude;
                  //   widget.lat=result.latLng.latitude;
                  //   _addAddressBloc.addressController.text=result.address;
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
                  stream: _addAddressBloc.phoneSubject.stream,
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
                            snapshot.data! ? null : 'text_phone_error'.tr,
                      ),
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => node.nextFocus(),
                      keyboardType: TextInputType.phone,
                      onChanged: (val) => _addAddressBloc.changePhone(val),
                      controller: _addAddressBloc.phoneController,
                    );
                  }),
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
                            stream: _addAddressBloc.allCountriesSubject.stream,
                            builder: (context, countriesSnapshot) {
                              if (countriesSnapshot.hasData) {
                                return StreamBuilder<CountriesData>(
                                    stream:
                                        _addAddressBloc.selectedCountry.stream,
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
                                                        SizedBox(),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      AutoSizeText(
                                                        item.name,
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
                                              _addAddressBloc
                                                  .selectedCities.sink
                                                  .add(null!);
                                              _addAddressBloc
                                                  .selectedCountry.sink
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
                            stream: _addAddressBloc.selectedCountry.stream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return StreamBuilder<CitiesData>(
                                    stream:
                                        _addAddressBloc.selectedCities.stream,
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
                                              return DropdownMenuItem<
                                                      CitiesData>(
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
                                            onChanged: (CitiesData? item) {
                                              _addAddressBloc
                                                  .selectedCities.sink
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
                height: 15,
              ),
              Text('text_special_mark'.tr,
                      style:
                          TextStyle(fontSize: 14, color: Colors.grey.shade600))
                  .addPaddingOnly(right: 8, left: 8, top: 15, bottom: 5),
              StreamBuilder<bool>(
                  stream: _addAddressBloc.specialMarkSubject.stream,
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
                        errorText: snapshot.data!
                            ? null
                            : 'text_special_mark_error'.tr,
                      ),
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => node.unfocus(),
                      keyboardType: TextInputType.text,
                      onChanged: (val) =>
                          _addAddressBloc.changeSpecialMark(val),
                      controller: _addAddressBloc.specialMarkController,
                      maxLines: 3,
                    );
                  }),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: RoundedLoadingButton(
                  child: Text(
                    'bt_add'.tr,
                    style: kTextStyle.copyWith(
                        fontSize: 20, color: Color(0xffFFFFFF)),
                  ),
                  height: 50,
                  controller: _addAddressBloc.loadingButtonController,
                  color: Colors.blue.shade800,
                  onPressed: () async {
                    _addAddressBloc.loadingButtonController.start();
                    await _addAddressBloc.confirmAddAddress(
                        lat: widget.lat,
                        lng: widget.lng,
                        way_pay_id: widget.way_pay_id,
                        pay_method_id: widget.pay_method_id,
                        company_id: widget.company_id,
                        context: context,
                        paymentPlans: widget.paymentPlans);
                    _addAddressBloc.loadingButtonController.stop();
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
