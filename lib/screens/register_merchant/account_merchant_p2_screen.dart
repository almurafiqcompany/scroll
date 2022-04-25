import 'dart:io';

import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:al_murafiq/models/categories.dart';
import 'package:al_murafiq/models/countries.dart';
import 'package:al_murafiq/screens/countries/countries_bloc.dart';
import 'package:al_murafiq/screens/home_page/categories/categories_bloc.dart';
import 'package:al_murafiq/screens/register_merchant/account_merchant_screen.dart';
import 'package:al_murafiq/screens/register_merchant/register_merchant_bloc.dart';

import 'package:al_murafiq/widgets/widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:date_field/date_field.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
class AccountInformationMerchantPageTwoScreen extends StatefulWidget {
  final RegisterMerchantBloc? bloc;

  const AccountInformationMerchantPageTwoScreen({Key? key, this.bloc})
      : super(key: key);

  @override
  _RegisterDealerScreenState createState() => _RegisterDealerScreenState();
}

class _RegisterDealerScreenState
    extends State<AccountInformationMerchantPageTwoScreen> {
  CategoriesBloc _categoriesBloc = CategoriesBloc();
  CountriesBloc _bloc = CountriesBloc();
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

  List<String> LIST_DAYS= <String>[
    'Saturday'.tr,
    'Sunday'.tr,
    'Monday'.tr,
    'Tuesday'.tr,
    'Wednesday'.tr,
    'Thursday'.tr,
    'Friday'.tr,
  ];
  var LIST_DAYsS= {
    'Saturday'.tr : 'Saturday',
    'Sunday'.tr : 'Sunday',
    'Monday'.tr : 'Monday',
    'Tuesday'.tr : 'Tuesday',
    'Wednesday'.tr : 'Wednesday',
    'Thursday'.tr : 'Thursday',
    'Friday'.tr : 'Friday',
  };
  @override
  void initState() {
    // TODO: implement initState

    // _categoriesBloc.fetchDataAllCategories();
    // _bloc.fetchAllCountries();
    widget.bloc!.fetchDataAllCategories(1);
    widget.bloc!.fetchAllCountries(1);
    // widget.bloc.selectedLanguage.value=null;
    widget.bloc!.selectedSubCategories.value;
    widget.bloc!.selectCategoriesSubject.value;
    String lsHour = TimeOfDay.now().hour.toString().padLeft(2, '0');
    String lsMinute = TimeOfDay.now().minute.toString().padLeft(2, '0');
    _controllerFrom = TextEditingController(text: '$lsHour:$lsMinute');
    _controllerTo = TextEditingController(text: '$lsHour:$lsMinute');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            appBar: const GradientAppbar(),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('new_account'.tr,
                          style: const TextStyle(fontSize: 30))
                      .addPaddingOnly(right: 44, left: 44, top: 10),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Text('text_country'.tr,
                          style: TextStyle(fontSize: 14, color: Colors.grey.shade600))
                          .addPaddingOnly(right: 8,left: 8, top: 15, bottom: 5),
                      Text('*',
                          style: TextStyle(fontSize: 14, color: Colors.red))
                          .addPaddingOnly( top: 15),
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
                  //               stream: widget.bloc.allCountriesSubject.stream,
                  //               builder: (context, countriesSnapshot) {
                  //                 if (countriesSnapshot.hasData) {
                  //                   return StreamBuilder<CountriesData>(
                  //                       stream: widget.bloc.selectedCountry.stream,
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
                  //                                 widget.bloc.selectedCities.sink.add(null);
                  //                                 widget.bloc.selectedCountry.sink
                  //                                     .add(item);
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
                                stream: widget.bloc!.selectedCountry.stream,
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
                                                          EdgeInsets.all(
                                                              9),
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
                                                            BorderRadius
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
                                                            borderRadius:
                                                            BorderRadius
                                                                .all(Radius
                                                                .circular(
                                                                6)),
                                                            borderSide: BorderSide(
                                                                width: 1,
                                                                color: Color(
                                                                    0xFFC2C3DF)),
                                                          ),
                                                          border: const OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                  .circular(
                                                                  6)),
                                                              borderSide:
                                                              BorderSide(
                                                                  width:
                                                                  1)),
                                                          hintText: 'Search',
                                                          hintStyle:
                                                          const TextStyle(
                                                              fontSize:
                                                              14,
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
                                                          widget.bloc
                                                              !.sortCountry(v);
                                                        },
                                                      ),
                                                    ),
                                                    Divider(),
                                                    Expanded(
                                                      child: StreamBuilder<
                                                          List<
                                                              CountriesData>>(
                                                          stream: widget.bloc
                                                              !.allSortCountriesSubject
                                                              .stream,
                                                          builder: (context,
                                                              countriesSnapshot) {
                                                            if (countriesSnapshot
                                                                .hasData) {
                                                              return ListView
                                                                  .separated(
                                                                  itemBuilder:
                                                                      (ctx,
                                                                      index) {
                                                                    final item =
                                                                    countriesSnapshot.data![index];
                                                                    return InkWell(
                                                                      onTap:
                                                                          () {
                                                                            widget.bloc!.selectedCountry.add(item);
                                                                        Get.back();
                                                                      },
                                                                      child:
                                                                      Padding(
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
                                                                  separatorBuilder:
                                                                      (ctx,
                                                                      index) {
                                                                    return Divider();
                                                                  },
                                                                  shrinkWrap:
                                                                  true,
                                                                  itemCount: countriesSnapshot
                                                                      .data
                                                                      !.length);
                                                            } else {
                                                              return const Padding(
                                                                padding:
                                                                EdgeInsets
                                                                    .all(
                                                                    8.0),
                                                                child: Center(
                                                                    child:
                                                                    CircularProgressIndicator(
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
                                              style:
                                              kTextStyle.copyWith(
                                                  color:
                                                  Colors.black),
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
                  //               stream: widget.bloc.selectedCountry.stream,
                  //               builder: (context, snapshot) {
                  //                 if (snapshot.hasData) {
                  //                   return StreamBuilder<CitiesData>(
                  //                       stream: widget.bloc.selectedCities.stream,
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
                  //                                 widget.bloc.selectedCities.sink.add(item);
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
                                stream: widget.bloc!.selectedCountry.stream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    widget.bloc!.allSortCitiesSubject.add(snapshot.data!.cities!);
                                    return StreamBuilder<CitiesData>(
                                        stream: widget.bloc!.selectedCities.stream,
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
                                                                  EdgeInsets.all(
                                                                      9),
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
                                                                    BorderRadius
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
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .all(Radius
                                                                        .circular(
                                                                        6)),
                                                                    borderSide: BorderSide(
                                                                        width: 1,
                                                                        color: Color(
                                                                            0xFFC2C3DF)),
                                                                  ),
                                                                  border: const OutlineInputBorder(
                                                                      borderRadius: BorderRadius
                                                                          .all(Radius
                                                                          .circular(
                                                                          6)),
                                                                      borderSide:
                                                                      BorderSide(
                                                                          width:
                                                                          1)),
                                                                  hintText: 'Search',
                                                                  hintStyle:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                      14,
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
                                                                  widget.bloc
                                                                      !.sortCities(v);
                                                                },
                                                              ),
                                                            ),
                                                            Divider(),
                                                            Expanded(
                                                              child: StreamBuilder<
                                                                  List<
                                                                      CitiesData>>(
                                                                  stream: widget.bloc
                                                                      !.allSortCitiesSubject
                                                                      .stream,
                                                                  builder: (context,
                                                                      citiesSnapshot) {
                                                                    if (citiesSnapshot
                                                                        .hasData) {
                                                                      return ListView
                                                                          .separated(
                                                                          itemBuilder:
                                                                              (ctx,
                                                                              index) {
                                                                            final item =
                                                                            citiesSnapshot.data![index];
                                                                            return InkWell(
                                                                              onTap:
                                                                                  () {
                                                                                    widget.bloc!.selectedCities.add(item);
                                                                                Get.back();
                                                                              },
                                                                              child:
                                                                              Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Text(item.name!),
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
                                                                          itemCount: citiesSnapshot
                                                                              .data
                                                                              !.length);
                                                                    } else {
                                                                      return const Padding(
                                                                        padding:
                                                                        EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                        child: Center(
                                                                            child:
                                                                            CircularProgressIndicator(
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
                                                  style:
                                                  kTextStyle.copyWith(
                                                      color:
                                                      Colors.black),
                                                ),
                                              )
                                                  : Row(
                                                children: [
                                                  Text(
                                                    'select_city'.tr,
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
                  SizedBox(
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
                  //                                     context.translate('select_language'),
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
                  Row(
                    children: [
                      Text('text_category'.tr,
                          style: TextStyle(fontSize: 14, color: Colors.grey.shade600))
                          .addPaddingOnly(right: 8,left: 8, top: 15, bottom: 5),
                      Text('*',
                          style: TextStyle(fontSize: 14, color: Colors.red))
                          .addPaddingOnly( top: 15),
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
                  //               widget.bloc.getAllCategoriesSubject.stream,
                  //               builder: (context, categoriesSnapshot) {
                  //                 if (categoriesSnapshot.hasData) {
                  //                   return StreamBuilder<Categories_Data>(
                  //                       stream: widget.bloc
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
                  //                               widget.bloc
                  //                                   .selectedSubCategories.sink
                  //                                   .add(null);
                  //                               widget.bloc
                  //                                   .selectedSubSubCategories.sink
                  //                                   .add(null);
                  //                               widget.bloc
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
                                stream: widget.bloc
                                    !.selectCategoriesSubject.stream,
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
                                                          EdgeInsets.all(
                                                              9),
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
                                                            BorderRadius
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
                                                            borderRadius:
                                                            BorderRadius
                                                                .all(Radius
                                                                .circular(
                                                                6)),
                                                            borderSide: BorderSide(
                                                                width: 1,
                                                                color: Color(
                                                                    0xFFC2C3DF)),
                                                          ),
                                                          border: const OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                  .circular(
                                                                  6)),
                                                              borderSide:
                                                              BorderSide(
                                                                  width:
                                                                  1)),
                                                          hintText: 'Search',
                                                          hintStyle:
                                                          const TextStyle(
                                                              fontSize:
                                                              14,
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
                                                          widget.bloc
                                                             ! .sortAllCategories(
                                                              v);
                                                        },
                                                      ),
                                                    ),
                                                    Divider(),
                                                    Expanded(
                                                      child: StreamBuilder<
                                                          List<
                                                              Categories_Data>>(
                                                          stream: widget.bloc
                                                             ! .getSortAllCategoriesSubject
                                                              .stream,
                                                          builder: (context,
                                                              countriesSnapshot) {
                                                            if (countriesSnapshot
                                                                .hasData) {
                                                              return ListView
                                                                  .separated(
                                                                  itemBuilder:
                                                                      (ctx,
                                                                      index) {
                                                                    final item =
                                                                    countriesSnapshot.data![index];
                                                                    return InkWell(
                                                                      onTap:
                                                                          () {
                                                                            widget.bloc!.selectCategoriesSubject.add(item);
                                                                        Get.back();
                                                                      },
                                                                      child:
                                                                      Padding(
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
                                                                  separatorBuilder:
                                                                      (ctx,
                                                                      index) {
                                                                    return Divider();
                                                                  },
                                                                  shrinkWrap:
                                                                  true,
                                                                  itemCount: countriesSnapshot
                                                                      .data
                                                                    !  .length);
                                                            } else {
                                                              return const Padding(
                                                                padding:
                                                                EdgeInsets
                                                                    .all(
                                                                    8.0),
                                                                child: Center(
                                                                    child:
                                                                    CircularProgressIndicator(
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
                                                  color:
                                                  Colors.black),
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
                  //               widget.bloc.selectCategoriesSubject.stream,
                  //               builder: (context, snapshot) {
                  //                 if (snapshot.hasData) {
                  //                   return StreamBuilder<SubCategories>(
                  //                       stream: widget.bloc
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
                  //                               widget.bloc
                  //                                   .selectedSubSubCategories.sink
                  //                                   .add(null);
                  //                               widget.bloc
                  //                                   .selectedSubCategories.sink
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
                            child: StreamBuilder<Categories_Data>(
                                stream: widget.bloc
                                    !.selectCategoriesSubject.stream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    widget.bloc!.getSortAllSubCategories.add(snapshot.data!.sub_categories!);
                                    return StreamBuilder<SubCategories>(
                                        stream: widget.bloc
                                            !.selectedSubCategories.stream,
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
                                                                  EdgeInsets.all(
                                                                      9),
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
                                                                    BorderRadius
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
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .all(Radius
                                                                        .circular(
                                                                        6)),
                                                                    borderSide: BorderSide(
                                                                        width: 1,
                                                                        color: Color(
                                                                            0xFFC2C3DF)),
                                                                  ),
                                                                  border: const OutlineInputBorder(
                                                                      borderRadius: BorderRadius
                                                                          .all(Radius
                                                                          .circular(
                                                                          6)),
                                                                      borderSide:
                                                                      BorderSide(
                                                                          width:
                                                                          1)),
                                                                  hintText: 'Search',
                                                                  hintStyle:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                      14,
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
                                                                  widget.bloc
                                                                     ! .sortSubCategories(v);
                                                                },
                                                              ),
                                                            ),
                                                            Divider(),
                                                            Expanded(
                                                              child: StreamBuilder<
                                                                  List<
                                                                      SubCategories>>(
                                                                  stream: widget.bloc
                                                                      !.getSortAllSubCategories
                                                                      .stream,
                                                                  builder: (context,
                                                                      subCategoriesSnapshot) {
                                                                    if (subCategoriesSnapshot
                                                                        .hasData) {
                                                                      return ListView
                                                                          .separated(
                                                                          itemBuilder:
                                                                              (ctx,
                                                                              index) {
                                                                            final item =
                                                                            subCategoriesSnapshot.data![index];
                                                                            return InkWell(
                                                                              onTap:
                                                                                  () {
                                                                                    widget.bloc!.selectedSubCategories.add(item);
                                                                                Get.back();
                                                                              },
                                                                              child:
                                                                              Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Text(item.name!),
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
                                                                          itemCount: subCategoriesSnapshot
                                                                              .data
                                                                             ! .length);
                                                                    } else {
                                                                      return const Padding(
                                                                        padding:
                                                                        EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                        child: Center(
                                                                            child:
                                                                            CircularProgressIndicator(
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
                                                  style:
                                                  kTextStyle.copyWith(
                                                      color:
                                                      Colors.black),
                                                ),
                                              )
                                                  : Row(
                                                children: [
                                                  Text(
                                                    'select_sub_category'.tr,
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
                  //               widget.bloc.selectedSubCategories.stream,
                  //               builder: (context, snapshot) {
                  //                 if (snapshot.hasData) {
                  //                   return StreamBuilder<SubSubCategories>(
                  //                       stream: widget.bloc
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
                  //                               widget.bloc
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
                                stream: widget.bloc
                                   ! .selectedSubCategories.stream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    widget.bloc!.getSortAllSubSubCategories.add(snapshot.data!.sub_sub_categories!);
                                    return StreamBuilder<SubSubCategories>(
                                        stream: widget.bloc
                                           ! .selectedSubSubCategories.stream,
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
                                                                  EdgeInsets.all(
                                                                      9),
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
                                                                    BorderRadius
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
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .all(Radius
                                                                        .circular(
                                                                        6)),
                                                                    borderSide: BorderSide(
                                                                        width: 1,
                                                                        color: Color(
                                                                            0xFFC2C3DF)),
                                                                  ),
                                                                  border: const OutlineInputBorder(
                                                                      borderRadius: BorderRadius
                                                                          .all(Radius
                                                                          .circular(
                                                                          6)),
                                                                      borderSide:
                                                                      BorderSide(
                                                                          width:
                                                                          1)),
                                                                  hintText: 'Search',
                                                                  hintStyle:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                      14,
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
                                                                  widget.bloc
                                                                      !.sortSubSubCategories(v);
                                                                },
                                                              ),
                                                            ),
                                                            Divider(),
                                                            Expanded(
                                                              child: StreamBuilder<
                                                                  List<
                                                                      SubSubCategories>>(
                                                                  stream: widget.bloc
                                                                     ! .getSortAllSubSubCategories
                                                                      .stream,
                                                                  builder: (context,
                                                                      subSubCategoriesSnapshot) {
                                                                    if (subSubCategoriesSnapshot
                                                                        .hasData) {
                                                                      return ListView
                                                                          .separated(
                                                                          itemBuilder:
                                                                              (ctx,
                                                                              index) {
                                                                            final item =
                                                                            subSubCategoriesSnapshot.data![index];
                                                                            return InkWell(
                                                                              onTap:
                                                                                  () {
                                                                                    widget.bloc!.selectedSubSubCategories.add(item);
                                                                                Get.back();
                                                                              },
                                                                              child:
                                                                              Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Text(item.name!),
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
                                                                          itemCount: subSubCategoriesSnapshot
                                                                              .data
                                                                             ! .length);
                                                                    } else {
                                                                      return const Padding(
                                                                        padding:
                                                                        EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                        child: Center(
                                                                            child:
                                                                            CircularProgressIndicator(
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
                                                  style:
                                                  kTextStyle.copyWith(
                                                      color:
                                                      Colors.black),
                                                ),
                                              )
                                                  : Row(
                                                children: [
                                                  Text(
                                                    'select_sub_category'.tr,
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
                  //               widget.bloc.getAllCategoriesSubject.stream,
                  //               builder: (context, categoriesSnapshot) {
                  //                 print(
                  //                     'ew${widget.bloc.getAllCategoriesSubject.value}');
                  //                 if (categoriesSnapshot.hasData) {
                  //                   return StreamBuilder<Categories_Data>(
                  //                       stream: widget.bloc
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
                  //                                 widget.bloc
                  //                                     .selectedSubCategories.sink
                  //                                     .add(null);
                  //                                 widget.bloc
                  //                                     .selectCategoriesSubject.sink
                  //                                     .add(item);
                  //                                 // widget.bloc.selectCategoriesSubject
                  //                                 //     .sink
                  //                                 //     .add(item);
                  //                                 print(widget.bloc
                  //                                     .selectCategoriesSubject
                  //                                     .value
                  //                                     .name);
                  //                               }
                  //                               ),
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
                  //               widget.bloc.selectCategoriesSubject.stream,
                  //               builder: (context, snapshot) {
                  //                 if (snapshot.hasData) {
                  //                   return StreamBuilder<SubCategories>(
                  //                       stream: widget.bloc
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
                  //                                 'select_sub_category'.tr,
                  //                                 style: kTextStyle.copyWith(
                  //                                     color: Colors.black),
                  //                               ),
                  //                               style: kTextStyle.copyWith(
                  //                                   color: Colors.black),
                  //                               underline: SizedBox(),
                  //                               value: subcategoriesSnapshot.data,
                  //                               onChanged: (SubCategories item) {
                  //                                 print(item.name);
                  //                                 widget.bloc
                  //                                     .selectedSubCategories.sink
                  //                                     .add(item);
                  //                                 // widget
                  //                                 //     .bloc.selectedSubCategories.sink
                  //                                 //     .add(item);
                  //                                 print(widget.bloc
                  //                                     .selectedSubCategories.value);
                  //                               }
                  //                               ),
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
                      Text('text_workdays'.tr,
                          style: TextStyle(fontSize: 14, color: Colors.grey.shade600))
                          .addPaddingOnly(right: 8,left: 8, top: 15, bottom: 10),
                      Text('*',
                          style: TextStyle(fontSize: 14, color: Colors.red))
                          .addPaddingOnly( top: 15),
                    ],
                  ),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     StreamBuilder<String>(
                  //       stream: widget.bloc.workDaysSubjectFrom.stream,
                  //       initialData: 'Saturday'.tr,
                  //       builder: (context, snapshot) {
                  //
                  //         return
                  //           //   DropButton(
                  //           //   onChanged: widget.bloc.languageChanged,
                  //           //   values: LIST_LANGUAGE,
                  //           //   value: snapshot.data ?? LIST_LANGUAGE[0],
                  //           // ).addPaddingOnly(top: 5);
                  //           Container(
                  //               height: 40,
                  //               width: Get.width/3,
                  //               alignment: Alignment.center,
                  //               decoration: BoxDecoration(
                  //                 color: const Color(0xFFE0E7FF),
                  //                 borderRadius:
                  //                 const BorderRadius.all(Radius.circular(6)),
                  //                 border:
                  //                 Border.all(width: 1, color: context.accentColor),
                  //               ),
                  //               child: DropdownButton<String>(
                  //                 iconSize: 30,
                  //                 isExpanded: true,
                  //                 value: snapshot.data,
                  //                 dropdownColor: const Color(0xFFE0E7FF),
                  //                 items: LIST_DAYS
                  //                     .map<DropdownMenuItem<String>>((String value) {
                  //                   return DropdownMenuItem<String>(
                  //                     value: value,
                  //                     child: Padding(
                  //                       padding: const EdgeInsets.all(8.0),
                  //                       child: Text(value),
                  //                     ),
                  //                   );
                  //                 }).toList(),
                  //                 onChanged: (String val) {
                  //
                  //                   widget.bloc.workDaysSubjectFrom.sink.add(LIST_DAYsS[val]);
                  //                 },
                  //               ).addPaddingOnly(right: 15));
                  //       },
                  //     ),
                  //     Text('to'),
                  //     StreamBuilder<String>(
                  //       stream: widget.bloc.workDaysSubjectTo.stream,
                  //       initialData: 'Saturday'.tr,
                  //       builder: (context, snapshot) {
                  //         return
                  //           //   DropButton(
                  //           //   onChanged: widget.bloc.languageChanged,
                  //           //   values: LIST_LANGUAGE,
                  //           //   value: snapshot.data ?? LIST_LANGUAGE[0],
                  //           // ).addPaddingOnly(top: 5);
                  //           Container(
                  //               height: 40,
                  //               width: Get.width/3,
                  //               alignment: Alignment.center,
                  //               decoration: BoxDecoration(
                  //                 color: const Color(0xFFE0E7FF),
                  //                 borderRadius:
                  //                 const BorderRadius.all(Radius.circular(6)),
                  //                 border:
                  //                 Border.all(width: 1, color: context.accentColor),
                  //               ),
                  //               child: DropdownButton<String>(
                  //                 iconSize: 30,
                  //                 isExpanded: true,
                  //                 value: snapshot.data,
                  //                 dropdownColor: const Color(0xFFE0E7FF),
                  //                 items: LIST_DAYS
                  //                     .map<DropdownMenuItem<String>>((String value) {
                  //                   return DropdownMenuItem<String>(
                  //                     value: value,
                  //                     child: Padding(
                  //                       padding: const EdgeInsets.all(8.0),
                  //                       child: Text(value),
                  //                     ),
                  //                   );
                  //                 }).toList(),
                  //                 onChanged: (String val) {
                  //
                  //                   widget.bloc.workDaysSubjectTo.sink.add(LIST_DAYsS[val]);
                  //
                  //                 },
                  //               ).addPaddingOnly(right: 15));
                  //       },
                  //     ),
                  //   ],
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      StreamBuilder<String>(
                        stream: widget.bloc!.workDaysSubjectFrom.stream,
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
                                width: Get.width/3,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE0E7FF),
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(6)),
                                  border:
                                  Border.all(width: 1, color: context.accentColor),
                                ),
                                child: DropdownButton<String>(
                                  iconSize: 30,
                                  isExpanded: true,

                                  value: snapshot.data!.tr,
                                  dropdownColor: const Color(0xFFE0E7FF),
                                  items: LIST_DAYS
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 4),
                                        child: Text(value,style: TextStyle(fontSize: 14),),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? val) {

                                    widget.bloc!.workDaysSubjectFrom.sink.add(LIST_DAYsS[val]!);
                                  },
                                ).addPaddingOnly(right: 15));
                        },
                      ),
                      Text('to'.tr),
                      StreamBuilder<String>(
                        stream: widget.bloc!.workDaysSubjectTo.stream,
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
                                width: Get.width/3,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE0E7FF),
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(6)),
                                  border:
                                  Border.all(width: 1, color: context.accentColor),
                                ),
                                child: DropdownButton<String>(
                                  iconSize: 30,
                                  isExpanded: true,
                                  value: snapshot.data!.tr,
                                  dropdownColor: const Color(0xFFE0E7FF),
                                  items: LIST_DAYS
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,

                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 4),
                                        child: Text(value,style: TextStyle(fontSize: 14),),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? val) {

                                    widget.bloc!.workDaysSubjectTo.sink.add(LIST_DAYsS[val]!);
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
                          style: TextStyle(fontSize: 14, color: Colors.grey.shade600))
                          .addPaddingOnly(right: 8,left: 8, top: 15, bottom: 10),
                      Text('*',
                          style: TextStyle(fontSize: 14, color: Colors.red))
                          .addPaddingOnly( top: 15),
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
                  //                 setState(() {
                  //                   _valueTimeFrom=DateFormat.jm().format(date);
                  //                 });
                  //                 // widget.bloc.workTimeSubjectFrom.sink.add(_valueTimeFrom);
                  //                 widget.bloc.workTimeSubjectFrom.sink.add(date);
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
                  //                 setState(() {
                  //                   _valueTimeTo=DateFormat.jm().format(date);
                  //                 });
                  //                 // widget.bloc.workTimeSubjectTo.sink.add(_valueTimeTo);
                  //                 widget.bloc.workTimeSubjectTo.sink.add(date);
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
                        width: (Get.width/3)+20,
                        child: DateTimeFormField(
                          decoration:  InputDecoration(
                            hintStyle: TextStyle(color: Colors.black45),
                            errorStyle: TextStyle(color: Colors.redAccent),
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.access_time),
                            labelText: 'select_time'.tr,
                          ),
                          mode: DateTimeFieldPickerMode.time,

                          autovalidateMode: AutovalidateMode.always,
                          validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                          onDateSelected: (DateTime value) {
                            print(value);
                            widget.bloc!.workTimeSubjectFrom.sink.add(DateFormat.Hms().format(value));
                          },
                        ),
                      ),
                      Text('to'.tr),
                      Container(
                        color: Color(0xFFE0E7FF),
                        width: (Get.width/3)+20,
                        child: DateTimeFormField(
                          // initialValue:  DateTime.now(),


                          decoration:  InputDecoration(
                            hintStyle: TextStyle(color: Colors.black45),
                            errorStyle: TextStyle(color: Colors.redAccent),
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.access_time),

                            labelText: 'select_time'.tr,
                          ),
                          mode: DateTimeFieldPickerMode.time,
                          autovalidateMode: AutovalidateMode.always,
                          validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                          onDateSelected: (DateTime value) {
                            print(value);
                            widget.bloc!.workTimeSubjectTo.sink.add(DateFormat.Hms().format(value));
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
                  //             widget.bloc.workTimeSubjectFrom.sink.add(val);
                  //             print('worktime ${widget.bloc.workTimeSubjectFrom.value}');
                  //             _valueChangedFrom = val;
                  //             // setState(() => _valueChangedFrom = val);
                  //           },
                  //           validator: (val) {
                  //             _valueToValidateFrom = val;
                  //             // setState(() => _valueToValidateFrom = val);
                  //             return null;
                  //           },
                  //           onSaved: (val)  {
                  //             widget.bloc.workTimeSubjectFrom.sink.add(val);
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
                  //             widget.bloc.workTimeSubjectTo.sink.add(val);
                  //             print('worktime ${widget.bloc.workTimeSubjectTo.value}');
                  //             _valueChangedTo = val;
                  //           },
                  //           // setState(() => _valueChangedTo = val),
                  //           validator: (val) {
                  //             _valueToValidateTo = val;
                  //             // setState(() => _valueToValidateTo = val);
                  //             return null;
                  //           },
                  //           onSaved: (val)  {
                  //             widget.bloc.workTimeSubjectTo.sink.add(val);
                  //             print('worktime ${widget.bloc.workTimeSubjectTo.value}');
                  //             // setState(() => _valueSavedTo = val)
                  //           },
                  //         ),
                  //       ),),
                  //
                  //   ],
                  // ),

                  SizedBox(
                    height: 15,
                  ),
                  //
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 15),
                  //   child: StreamBuilder<List<SocialController>>(
                  //       stream: widget.bloc.socialSubject.stream,
                  //       initialData: [SocialController()],
                  //       builder: (context, snapshot) {
                  //         print(
                  //             'sasa${widget.bloc.socialSubject.stream.value}');
                  //         return Column(
                  //           children:
                  //               List.generate(snapshot.data.length, (index) {
                  //             return SocialWidget(
                  //               socialItems: widget.bloc.socialItems,
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
                  //           widget.bloc.socialSubject.sink.add(
                  //               widget.bloc.socialSubject.value
                  //                 ..add(SocialController()));
                  //         },
                  //         child: Container(
                  //           decoration: const BoxDecoration(
                  //               color: Colors.white,
                  //               borderRadius:
                  //                   BorderRadius.all(Radius.circular(8.0)),
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
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: Center(
                      child: FlatButton(
                          height: 55,
                          minWidth: Get.width - 110,
                          child: Text('bt_continue'.tr,
                              style: kTextStyle.copyWith(
                                  color: Colors.white, fontSize: 22)),
                          color: Colors.blue.shade800,
                          textColor: Color(0xffFFFFFF),
                          onPressed: () async {
                            // await Get.to(AccountInformationDealerPageThreeScreen(bloc: widget.bloc,));
                            await widget.bloc
                                !.accountDealerPageTwo(context, widget.bloc!);
                          },
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0))),
                    ),
                  ),
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
