import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:al_murafiq/models/countries.dart';
import 'package:al_murafiq/screens/countries/countries_bloc.dart';
import 'package:al_murafiq/screens/home_page/nav_bar.dart';
import 'package:al_murafiq/utils/utils.dart';
import 'package:al_murafiq/widgets/show_check_login_dialog.dart';
import 'package:al_murafiq/widgets/show_loading_dialog.dart';
import 'package:al_murafiq/widgets/show_message_dialog.dart';
import 'package:al_murafiq/widgets/widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:al_murafiq/core/shared_pref_helper.dart';

class CountriesScreen extends StatefulWidget {
  @override
  _CountriesScreenState createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  CountriesBloc _bloc = CountriesBloc();
  SharedPreferenceHelper helper = GetIt.instance.get<SharedPreferenceHelper>();

  @override
  void initState() {
    _bloc.fetchAllCountries(context);
    // print('eeee');
    // getLocation();
    super.initState();
  }

  Future<void> getLocation() async {
    try {
      print('getttt location');
      // Position position = await Geolocator.getCurrentPosition(
      //     desiredAccuracy: LocationAccuracy.low);
      // print('get location');
      // print(position);
      // await helper.setLng(position.longitude);
      // await helper.setLat(position.latitude);
      // await helper.setLng(0.0);
      // await helper.setLat(0.0);
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      print('error get location');
      print('error get location $e');
      await helper.setLng(0.0);
      await helper.setLat(0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _bloc.fetchAllCountries(context);
          return Future.delayed(Duration(milliseconds: 400));
        },
        child: Stack(children: <Widget>[
          const BGLinearGradient(),
          SingleChildScrollView(
              physics: iosScrollPhysics(),
              child: Container(
                width: Get.width,
                height: Get.height,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        height: 50,
                      ),
                      Image.asset(
                        Assets.APP_LOGO,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                              // context.translate('select_country'),
                              'select_country'.tr,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 19))
                          .addPaddingOnly(top: 50),
                      Text('p_choose_country'.tr,
                              // context.translate('p_choose_country'),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15))
                          .addPaddingOnly(top: 5, bottom: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white),
                                child: StreamBuilder<CountriesData>(
                                    stream: _bloc.selectedCountry.stream,
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
                                                              _bloc.sortCountry(
                                                                  v);
                                                            },
                                                          ),
                                                        ),
                                                        Divider(),
                                                        Expanded(
                                                          child: StreamBuilder<
                                                                  List<
                                                                      CountriesData>>(
                                                              stream: _bloc
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
                                                                                _bloc.selectedCountry.add(item);
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
                                //     stream: _bloc.allSortCountriesSubject.stream,
                                //     builder: (context, allCountry) {
                                //       if (allCountry.hasData) {
                                //         return StreamBuilder<CountriesData>(
                                //             stream: _bloc.selectedCountry.stream,
                                //             // initialData: _bloc
                                //             //     .allCountriesSubject.value[0],
                                //             builder: (context, snapshot) {
                                //               return Padding(
                                //                 padding:
                                //                     const EdgeInsets.symmetric(
                                //                         horizontal: 16,
                                //                         vertical: 8),
                                //                 child: InkWell(
                                //                   onTap: () {
                                //                     showDialog(
                                //                         context: context,
                                //                         builder: (ctx) => Dialog(
                                //                                 child: Column(
                                //                               children: [
                                //                                 Padding(
                                //                                   padding:
                                //                                       const EdgeInsets
                                //                                               .all(
                                //                                           8.0),
                                //                                   child:
                                //                                       TextField(
                                //                                     style: TextStyle(
                                //                                         fontSize:
                                //                                             14),
                                //                                     decoration:
                                //                                         InputDecoration(
                                //                                       filled:
                                //                                           true,
                                //                                       fillColor:
                                //                                           Colors
                                //                                               .white,
                                //                                       contentPadding:
                                //                                           EdgeInsets
                                //                                               .all(9),
                                //                                       focusedBorder:
                                //                                           OutlineInputBorder(
                                //                                         borderRadius: const BorderRadius
                                //                                                 .all(
                                //                                             Radius.circular(
                                //                                                 6)),
                                //                                         borderSide: BorderSide(
                                //                                             width:
                                //                                                 1,
                                //                                             color:
                                //                                                 context.accentColor),
                                //                                       ),
                                //                                       disabledBorder:
                                //                                           const OutlineInputBorder(
                                //                                         borderRadius:
                                //                                             BorderRadius.all(
                                //                                                 Radius.circular(6)),
                                //                                         borderSide: BorderSide(
                                //                                             width:
                                //                                                 1,
                                //                                             color:
                                //                                                 Colors.black54),
                                //                                       ),
                                //                                       enabledBorder:
                                //                                           const OutlineInputBorder(
                                //                                         borderRadius:
                                //                                             BorderRadius.all(
                                //                                                 Radius.circular(6)),
                                //                                         borderSide: BorderSide(
                                //                                             width:
                                //                                                 1,
                                //                                             color:
                                //                                                 Color(0xFFC2C3DF)),
                                //                                       ),
                                //                                       border: const OutlineInputBorder(
                                //                                           borderRadius:
                                //                                               BorderRadius.all(Radius.circular(
                                //                                                   6)),
                                //                                           borderSide:
                                //                                               BorderSide(width: 1)),
                                //                                       hintText:
                                //                                           'Search',
                                //                                       hintStyle: const TextStyle(
                                //                                           fontSize:
                                //                                               14,
                                //                                           color: Color(
                                //                                               0xFF9797AD)),
                                //                                     ),
                                //                                     textInputAction:
                                //                                         TextInputAction
                                //                                             .next,
                                //                                     keyboardType:
                                //                                         TextInputType
                                //                                             .text,
                                //                                     onChanged:
                                //                                         (v) {
                                //                                       _bloc
                                //                                           .sortCountry(
                                //                                               v);
                                //                                     },
                                //                                   ),
                                //                                 ),
                                //                                 Divider(),
                                //                                 Expanded(
                                //                                   child: StreamBuilder<
                                //                                           List<
                                //                                               CountriesData>>(
                                //                                       stream: _bloc
                                //                                           .allSortCountriesSubject
                                //                                           .stream,
                                //                                       builder:
                                //                                           (context,
                                //                                               countriesSnapshot) {
                                //                                         if (countriesSnapshot
                                //                                             .hasData) {
                                //                                           return ListView.separated(
                                //                                               itemBuilder: (ctx, index) {
                                //                                                 final item = countriesSnapshot.data[index];
                                //                                                 return InkWell(
                                //                                                   onTap: () {
                                //                                                     _bloc.selectedCountry.add(item);
                                //                                                     Get.back();
                                //                                                   },
                                //                                                   child: Padding(
                                //                                                     padding: const EdgeInsets.all(8.0),
                                //                                                     child: Row(
                                //                                                       children: [
                                //                                                         item.icon != null
                                //                                                             ? Image.network(
                                //                                                                 '$ImgUrl${item.icon}',
                                //                                                                 width: 32,
                                //                                                                 height: 32,
                                //                                                               )
                                //                                                             : SizedBox(),
                                //                                                         SizedBox(
                                //                                                           width: 8,
                                //                                                         ),
                                //                                                         Text(item.name),
                                //                                                       ],
                                //                                                     ),
                                //                                                   ),
                                //                                                 );
                                //                                               },
                                //                                               separatorBuilder: (ctx, index) {
                                //                                                 return Divider();
                                //                                               },
                                //                                               shrinkWrap: true,
                                //                                               itemCount: countriesSnapshot.data.length);
                                //                                         } else {
                                //                                           return const Padding(
                                //                                             padding:
                                //                                                 EdgeInsets.all(8.0),
                                //                                             child: Center(
                                //                                                 child: CircularProgressIndicator(
                                //                                               valueColor:
                                //                                                   AlwaysStoppedAnimation<Color>(kAccentColor),
                                //                                             )),
                                //                                           );
                                //                                         }
                                //                                       }),
                                //                                 )
                                //                               ],
                                //                             )));
                                //                   },
                                //                   child: snapshot.hasData?
                                //                   Row(
                                //                     children: [
                                //
                                //                       snapshot.data.icon != null
                                //                           ? Image.network(
                                //                               '$ImgUrl${snapshot.data.icon}',
                                //                               width: 32,
                                //                               height: 32,
                                //                             )
                                //                           : SizedBox(),
                                //                       SizedBox(
                                //                         width: 8,
                                //                       ),
                                //                       Text(snapshot.data.name),
                                //
                                //                     ],
                                //                   ):
                                //                   Row(
                                //                     children: [
                                //
                                //                       Icon(Icons.emoji_flags),
                                //                       Text(
                                //                         'select_country'.tr,
                                //                         // context.translate('select_country'),
                                //                         style:
                                //                         kTextStyle.copyWith(
                                //                             color: Colors
                                //                                 .black),
                                //                       ),
                                //                       // snapshot.data.icon != null
                                //                       //     ? Image.network(
                                //                       //         '$ImgUrl${snapshot.data.icon}',
                                //                       //         width: 32,
                                //                       //         height: 32,
                                //                       //       )
                                //                       //     : SizedBox(),
                                //                       // SizedBox(
                                //                       //   width: 8,
                                //                       // ),
                                //                       // Text(snapshot.data.name),
                                //                       Spacer(),
                                //                       Icon(Icons
                                //                           .arrow_drop_down_outlined)
                                //                     ],
                                //                   ),
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

                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: Padding(
                      //         padding: const EdgeInsets.symmetric(horizontal: 25),
                      //         child: Container(
                      //           decoration: BoxDecoration(
                      //               borderRadius: BorderRadius.circular(20),
                      //               color: Colors.white),
                      //           child: StreamBuilder<List<CountriesData>>(
                      //               stream: _bloc.allCountriesSubject.stream,
                      //               builder: (context, countriesSnapshot) {
                      //                 if (countriesSnapshot.hasData) {
                      //                   return StreamBuilder<CountriesData>(
                      //                       stream: _bloc.selectedCountry.stream,
                      //                       builder: (context, snapshot) {
                      //                         return Padding(
                      //                           padding:
                      //                               const EdgeInsets.symmetric(
                      //                                   horizontal: 10,
                      //                                   vertical: 2),
                      //                           child: SearchableDropdown.single(
                      //                               menuBackgroundColor:
                      //                                   Color(0xffE0E7FF),
                      //                               items: countriesSnapshot.data
                      //                                   .map((item) {
                      //                                 return DropdownMenuItem<
                      //                                         CountriesData>(
                      //                                     value: item,
                      //                                     child: Row(
                      //                                       children: [
                      //                                         item.icon != null
                      //                                             ? Image.network(
                      //                                                 '$ImgUrl${item.icon}',
                      //                                                 width: 32,
                      //                                                 height: 32,
                      //                                               )
                      //                                             : SizedBox(),
                      //                                         SizedBox(
                      //                                           width: 5,
                      //                                         ),
                      //                                         AutoSizeText(
                      //                                           item.name,
                      //                                           style: kTextStyle
                      //                                               .copyWith(
                      //                                                   fontSize:
                      //                                                       17),
                      //                                           minFontSize: 14,
                      //                                           maxFontSize: 18,
                      //                                         ),
                      //                                       ],
                      //                                     ));
                      //                               }).toList(),
                      //                               isExpanded: true,
                      //                               hint: Row(
                      //                                 children: [
                      //                                   Icon(Icons.emoji_flags),
                      //                                   Text(
                      //                                     'select_country'.tr,
                      //                                     // context.translate('select_country'),
                      //                                     style:
                      //                                         kTextStyle.copyWith(
                      //                                             color: Colors
                      //                                                 .black),
                      //                                   ),
                      //                                 ],
                      //                               ),
                      //                               style: kTextStyle.copyWith(
                      //                                   color: Colors.black),
                      //                               underline: SizedBox(),
                      //                               searchHint:
                      //                                   'select_country'.tr,
                      //                               value: snapshot.data,
                      //                               onChanged:
                      //                                   (CountriesData item) {
                      //                                 // _bloc.selectedLanguage.sink.add(null);
                      //                                 _bloc.selectedCountry.sink
                      //                                     .add(item);
                      //                                 print(_bloc.selectedCountry
                      //                                     .value.name);
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
                        height: 25,
                      ),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: Padding(
                      //         padding: const EdgeInsets.symmetric(horizontal: 25),
                      //         child: Container(
                      //           decoration: BoxDecoration(
                      //               borderRadius: BorderRadius.circular(20),
                      //               color: Colors.white),
                      //           child: StreamBuilder<List<Languages>>(
                      //               stream: _bloc.allLanguageSubject.stream,
                      //               builder: (context, snapshot) {
                      //                 if (snapshot.hasData) {
                      //                   return StreamBuilder<Languages>(
                      //                       stream: _bloc.selectedLanguage.stream,
                      //                       builder: (context, langSnapshot) {
                      //                         return Padding(
                      //                           padding:
                      //                               const EdgeInsets.symmetric(
                      //                                   horizontal: 10,
                      //                                   vertical: 2),
                      //                           child: DropdownButton<Languages>(
                      //                               dropdownColor: Colors.white,
                      //                               iconEnabledColor: Colors.grey,
                      //                               iconSize: 32,
                      //                               elevation: 3,
                      //                               icon: Icon(Icons
                      //                                   .arrow_drop_down_outlined),
                      //                               items:
                      //                                   snapshot.data.map((item) {
                      //                                 return DropdownMenuItem<
                      //                                         Languages>(
                      //                                     value: item,
                      //                                     child: AutoSizeText(
                      //                                       item.name,
                      //                                       style: kTextStyle
                      //                                           .copyWith(
                      //                                               fontSize: 17),
                      //                                       minFontSize: 14,
                      //                                       maxFontSize: 18,
                      //                                     ));
                      //                               }).toList(),
                      //                               isExpanded: true,
                      //                               hint: Row(
                      //                                 children: [
                      //                                   Icon(
                      //                                       Icons.language_sharp),
                      //                                   Text(
                      //                                     'select_language'.tr,
                      //                                     // context.translate('select_language'),
                      //                                     style:
                      //                                         kTextStyle.copyWith(
                      //                                             color: Colors
                      //                                                 .black),
                      //                                   ),
                      //                                 ],
                      //                               ),
                      //                               style: kTextStyle.copyWith(
                      //                                   color: Colors.black),
                      //                               underline: SizedBox(),
                      //                               value: langSnapshot.data,
                      //                               onChanged: (Languages item) {
                      //                                 _bloc.selectedLanguage.sink
                      //                                     .add(item);
                      //                                 print(_bloc.selectedLanguage
                      //                                     .value);
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white),
                                child: StreamBuilder<Languages>(
                                    stream: _bloc.selectedLanguage.stream,
                                    // initialData: _bloc
                                    //     .allCountriesSubject.value[0],
                                    builder: (context, snapshot) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 10),
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
                                                              _bloc
                                                                  .sortLanguage(
                                                                      v);
                                                            },
                                                          ),
                                                        ),
                                                        Divider(),
                                                        Expanded(
                                                          child: StreamBuilder<
                                                                  List<
                                                                      Languages>>(
                                                              stream: _bloc
                                                                  .allSortLanguageSubject
                                                                  .stream,
                                                              builder: (context,
                                                                  languagesSnapshot) {
                                                                if (languagesSnapshot
                                                                    .hasData) {
                                                                  return ListView
                                                                      .separated(
                                                                          itemBuilder: (ctx,
                                                                              index) {
                                                                            final item =
                                                                                languagesSnapshot.data![index];
                                                                            return InkWell(
                                                                              onTap: () {
                                                                                _bloc.selectedLanguage.add(item);
                                                                                Get.back();
                                                                              },
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Row(
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      width: 8,
                                                                                    ),
                                                                                    Text(
                                                                                      item.name!,
                                                                                    ),
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
                                                                          itemCount: languagesSnapshot
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
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
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
                                                    Icon(Icons.language_sharp),
                                                    Text(
                                                      'select_language'.tr,
                                                      // context.translate('select_language'),
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
                                //     stream: _bloc.allSortCountriesSubject.stream,
                                //     builder: (context, allCountry) {
                                //       if (allCountry.hasData) {
                                //         return StreamBuilder<CountriesData>(
                                //             stream: _bloc.selectedCountry.stream,
                                //             // initialData: _bloc
                                //             //     .allCountriesSubject.value[0],
                                //             builder: (context, snapshot) {
                                //               return Padding(
                                //                 padding:
                                //                     const EdgeInsets.symmetric(
                                //                         horizontal: 16,
                                //                         vertical: 8),
                                //                 child: InkWell(
                                //                   onTap: () {
                                //                     showDialog(
                                //                         context: context,
                                //                         builder: (ctx) => Dialog(
                                //                                 child: Column(
                                //                               children: [
                                //                                 Padding(
                                //                                   padding:
                                //                                       const EdgeInsets
                                //                                               .all(
                                //                                           8.0),
                                //                                   child:
                                //                                       TextField(
                                //                                     style: TextStyle(
                                //                                         fontSize:
                                //                                             14),
                                //                                     decoration:
                                //                                         InputDecoration(
                                //                                       filled:
                                //                                           true,
                                //                                       fillColor:
                                //                                           Colors
                                //                                               .white,
                                //                                       contentPadding:
                                //                                           EdgeInsets
                                //                                               .all(9),
                                //                                       focusedBorder:
                                //                                           OutlineInputBorder(
                                //                                         borderRadius: const BorderRadius
                                //                                                 .all(
                                //                                             Radius.circular(
                                //                                                 6)),
                                //                                         borderSide: BorderSide(
                                //                                             width:
                                //                                                 1,
                                //                                             color:
                                //                                                 context.accentColor),
                                //                                       ),
                                //                                       disabledBorder:
                                //                                           const OutlineInputBorder(
                                //                                         borderRadius:
                                //                                             BorderRadius.all(
                                //                                                 Radius.circular(6)),
                                //                                         borderSide: BorderSide(
                                //                                             width:
                                //                                                 1,
                                //                                             color:
                                //                                                 Colors.black54),
                                //                                       ),
                                //                                       enabledBorder:
                                //                                           const OutlineInputBorder(
                                //                                         borderRadius:
                                //                                             BorderRadius.all(
                                //                                                 Radius.circular(6)),
                                //                                         borderSide: BorderSide(
                                //                                             width:
                                //                                                 1,
                                //                                             color:
                                //                                                 Color(0xFFC2C3DF)),
                                //                                       ),
                                //                                       border: const OutlineInputBorder(
                                //                                           borderRadius:
                                //                                               BorderRadius.all(Radius.circular(
                                //                                                   6)),
                                //                                           borderSide:
                                //                                               BorderSide(width: 1)),
                                //                                       hintText:
                                //                                           'Search',
                                //                                       hintStyle: const TextStyle(
                                //                                           fontSize:
                                //                                               14,
                                //                                           color: Color(
                                //                                               0xFF9797AD)),
                                //                                     ),
                                //                                     textInputAction:
                                //                                         TextInputAction
                                //                                             .next,
                                //                                     keyboardType:
                                //                                         TextInputType
                                //                                             .text,
                                //                                     onChanged:
                                //                                         (v) {
                                //                                       _bloc
                                //                                           .sortCountry(
                                //                                               v);
                                //                                     },
                                //                                   ),
                                //                                 ),
                                //                                 Divider(),
                                //                                 Expanded(
                                //                                   child: StreamBuilder<
                                //                                           List<
                                //                                               CountriesData>>(
                                //                                       stream: _bloc
                                //                                           .allSortCountriesSubject
                                //                                           .stream,
                                //                                       builder:
                                //                                           (context,
                                //                                               countriesSnapshot) {
                                //                                         if (countriesSnapshot
                                //                                             .hasData) {
                                //                                           return ListView.separated(
                                //                                               itemBuilder: (ctx, index) {
                                //                                                 final item = countriesSnapshot.data[index];
                                //                                                 return InkWell(
                                //                                                   onTap: () {
                                //                                                     _bloc.selectedCountry.add(item);
                                //                                                     Get.back();
                                //                                                   },
                                //                                                   child: Padding(
                                //                                                     padding: const EdgeInsets.all(8.0),
                                //                                                     child: Row(
                                //                                                       children: [
                                //                                                         item.icon != null
                                //                                                             ? Image.network(
                                //                                                                 '$ImgUrl${item.icon}',
                                //                                                                 width: 32,
                                //                                                                 height: 32,
                                //                                                               )
                                //                                                             : SizedBox(),
                                //                                                         SizedBox(
                                //                                                           width: 8,
                                //                                                         ),
                                //                                                         Text(item.name),
                                //                                                       ],
                                //                                                     ),
                                //                                                   ),
                                //                                                 );
                                //                                               },
                                //                                               separatorBuilder: (ctx, index) {
                                //                                                 return Divider();
                                //                                               },
                                //                                               shrinkWrap: true,
                                //                                               itemCount: countriesSnapshot.data.length);
                                //                                         } else {
                                //                                           return const Padding(
                                //                                             padding:
                                //                                                 EdgeInsets.all(8.0),
                                //                                             child: Center(
                                //                                                 child: CircularProgressIndicator(
                                //                                               valueColor:
                                //                                                   AlwaysStoppedAnimation<Color>(kAccentColor),
                                //                                             )),
                                //                                           );
                                //                                         }
                                //                                       }),
                                //                                 )
                                //                               ],
                                //                             )));
                                //                   },
                                //                   child: snapshot.hasData?
                                //                   Row(
                                //                     children: [
                                //
                                //                       snapshot.data.icon != null
                                //                           ? Image.network(
                                //                               '$ImgUrl${snapshot.data.icon}',
                                //                               width: 32,
                                //                               height: 32,
                                //                             )
                                //                           : SizedBox(),
                                //                       SizedBox(
                                //                         width: 8,
                                //                       ),
                                //                       Text(snapshot.data.name),
                                //
                                //                     ],
                                //                   ):
                                //                   Row(
                                //                     children: [
                                //
                                //                       Icon(Icons.emoji_flags),
                                //                       Text(
                                //                         'select_country'.tr,
                                //                         // context.translate('select_country'),
                                //                         style:
                                //                         kTextStyle.copyWith(
                                //                             color: Colors
                                //                                 .black),
                                //                       ),
                                //                       // snapshot.data.icon != null
                                //                       //     ? Image.network(
                                //                       //         '$ImgUrl${snapshot.data.icon}',
                                //                       //         width: 32,
                                //                       //         height: 32,
                                //                       //       )
                                //                       //     : SizedBox(),
                                //                       // SizedBox(
                                //                       //   width: 8,
                                //                       // ),
                                //                       // Text(snapshot.data.name),
                                //                       Spacer(),
                                //                       Icon(Icons
                                //                           .arrow_drop_down_outlined)
                                //                     ],
                                //                   ),
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
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: Padding(
                      //         padding: const EdgeInsets.symmetric(horizontal: 25),
                      //         child: Container(
                      //           decoration: BoxDecoration(
                      //               borderRadius: BorderRadius.circular(20),
                      //               color: Colors.white),
                      //           child: StreamBuilder<List<Languages>>(
                      //               stream: _bloc.allLanguageSubject.stream,
                      //               builder: (context, snapshot) {
                      //                 if (snapshot.hasData) {
                      //                   return StreamBuilder<Languages>(
                      //                       stream: _bloc.selectedLanguage.stream,
                      //                       builder: (context, langSnapshot) {
                      //                         return Padding(
                      //                           padding:
                      //                               const EdgeInsets.symmetric(
                      //                                   horizontal: 10,
                      //                                   vertical: 2),
                      //                           child: SearchableDropdown.single(
                      //                             menuBackgroundColor:
                      //                                 Color(0xffE0E7FF),
                      //                             items:
                      //                                 snapshot.data.map((item) {
                      //                               return DropdownMenuItem<
                      //                                       Languages>(
                      //                                   value: item,
                      //                                   child: AutoSizeText(
                      //                                     item.name,
                      //                                     style:
                      //                                         kTextStyle.copyWith(
                      //                                             fontSize: 17),
                      //                                     minFontSize: 14,
                      //                                     maxFontSize: 18,
                      //                                   ));
                      //                             }).toList(),
                      //                             isExpanded: true,
                      //                             hint: Row(
                      //                               children: [
                      //                                 Icon(Icons.language_sharp),
                      //                                 Text(
                      //                                   'select_language'.tr,
                      //                                   // context.translate('select_language'),
                      //                                   style:
                      //                                       kTextStyle.copyWith(
                      //                                           color:
                      //                                               Colors.black),
                      //                                 ),
                      //                               ],
                      //                             ),
                      //                             style: kTextStyle.copyWith(
                      //                                 color: Colors.black),
                      //                             underline: SizedBox(),
                      //                             value: langSnapshot.data,
                      //                             onChanged: (Languages item) {
                      //                               _bloc.selectedLanguage.sink
                      //                                   .add(item);
                      //                               print(_bloc
                      //                                   .selectedLanguage.value);
                      //                             },
                      //                             searchHint:
                      //                                 'select_language'.tr,
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

                      /////////////////////////////////////////////////////////

                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: Padding(
                      //         padding: const EdgeInsets.symmetric(horizontal: 25),
                      //         child: Container(
                      //           decoration: BoxDecoration(
                      //               borderRadius: BorderRadius.circular(20),
                      //               color: Colors.white),
                      //           child: StreamBuilder<CountriesData>(
                      //               stream: _bloc.selectedCountry.stream,
                      //               builder: (context, snapshot) {
                      //                 if (snapshot.hasData) {
                      //                   return StreamBuilder<Languages>(
                      //                       stream: _bloc.selectedLanguage.stream,
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
                      //                               items: snapshot.data.languages
                      //                                   .map((item) {
                      //                                 return DropdownMenuItem<
                      //                                         Languages>(
                      //                                     value: item,
                      //                                     child: AutoSizeText(
                      //                                       item.name,
                      //                                       style:
                      //                                           kTextStyle.copyWith(
                      //                                               fontSize: 18),
                      //                                       minFontSize: 14,
                      //                                       maxFontSize: 18,
                      //                                     ));
                      //                               }).toList(),
                      //                               isExpanded: true,
                      //                               hint: Row(
                      //                                 children: [
                      //                                   Icon(Icons.language_sharp),
                      //                                   Text(
                      //                                     'Select Languages',
                      //                                     style:
                      //                                         kTextStyle.copyWith(
                      //                                             color:
                      //                                                 Colors.black),
                      //                                   ),
                      //                                 ],
                      //                               ),
                      //                               style: kTextStyle.copyWith(
                      //                                   color: Colors.black),
                      //                               underline: SizedBox(),
                      //                               value:  langSnapshot.data,
                      //                               onChanged: (Languages item) {
                      //                                 print(item.name);
                      //                                 _bloc.selectedLanguage.sink
                      //                                     .add(item);
                      //                                 print(_bloc
                      //                                     .selectedLanguage.value);
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
                        height: 80,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: RoundedLoadingButton(
                          child: Text(
                            'bt_done'.tr,
                            // context.translate('bt_done'),
                            style: kTextStyle.copyWith(
                                fontSize: 20, color: Color(0xffFFFFFF)),
                          ),
                          height: 50,
                          controller: _bloc.loadingButtonController,
                          color: Colors.blue.shade800,
                          onPressed: () async {
                            _bloc.loadingButtonController.start();
                            if (_bloc.selectedCountry.value != null &&
                                _bloc.selectedLanguage.value != null) {
                              await Get.snackbar(
                                '',
                                'before sh',
                                //'${await _bloc.helper.getCountryId()} ${await _bloc.helper.getLangId()} ${await _bloc.helper.getCodeLang()} ${await _bloc.helper.getDefaultLang()} ',
                                icon: GestureDetector(
                                    onTap: () => Get.back(),
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.black,
                                    )),
                                colorText: Colors.black,
                                backgroundColor: Colors.red.withOpacity(0.8),
                                duration: Duration(seconds: 60),
                                snackPosition: SnackPosition.BOTTOM,
                              );
                              // await _bloc.helper.setCountryId(1);
                              int? idCountry = _bloc.selectedCountry.value.id;
                              // await _bloc.helper.setCountryId(_bloc.selectedCountry.value.id);
                              await helper.setCountryId(idCountry!);
                              // await _bloc.helper.setLangId(1);
                              // int idLanguage=_bloc.selectedLanguage.value.id;
                              // await _bloc.helper.setLangId(_bloc.selectedLanguage.value.id);
                              // await helper.setLangId(idLanguage);
                              // await _bloc.helper.setCodeLang('en');
                              String? codeLang =
                                  _bloc.selectedLanguage.value.code;
                              // await _bloc.helper.setCodeLang(_bloc.selectedLanguage.value.code);
                              await helper.setCodeLang(codeLang!);
                              // String codeLangDef=_bloc.allDefultLanguageSubject.value ?? 'ar';

                              // await _bloc.helper.setDefaultLang(_bloc.allDefultLanguageSubject.value ?? 'ar');
                              // await helper.setDefaultLang(codeLangDef);

                              Get.updateLocale(Locale(codeLang));
                              await Get.offAll(BottomNavBar());
                              // Get.updateLocale(Locale(_bloc.selectedLanguage.value.code));
                              //  print('wee${_bloc.selectedCountry.value.id}');

                              _bloc.loadingButtonController.stop();
                            } else {
                              Get.snackbar(
                                '',
                                'message_warring_select_country_splash'.tr,
                                // context.translate('message_warring_select_country_splash'),
                                icon: GestureDetector(
                                    onTap: () => Get.back(),
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.black,
                                    )),
                                colorText: Colors.black,
                                backgroundColor: Colors.red.withOpacity(0.8),
                                duration: Duration(seconds: 60),
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            }
                            _bloc.loadingButtonController.stop();
                          },
                        ),
                      ),
                      // Align(
                      //   alignment: Alignment.bottomCenter,
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(vertical: 25),
                      //     child: FlatButton(
                      //
                      //       height: 60,
                      //       minWidth: Get.width-100,
                      //       child: Text(context.translate('bt_done'), style: kTextStyle.copyWith(fontSize: 25)),
                      //       color: Colors.blue.shade800,
                      //       textColor: Color(0xffFFFFFF),
                      //       onPressed: () async {
                      //         if(_bloc.selectedCountry.value != null&&_bloc.selectedLanguage.value!= null){
                      //           await _bloc.helper.setCountryId(_bloc.selectedCountry.value.id);
                      //           await _bloc.helper.setLangId(_bloc.selectedLanguage.value.id);
                      //           await _bloc.helper.setCodeLang(_bloc.selectedLanguage.value.code);
                      //           await _bloc.helper.setDefaultLang(_bloc.selectedCountry.value.default_lang);
                      //           print('wee${_bloc.selectedCountry.value.id}');
                      //           print(await _bloc.helper.getCountryId());
                      //           print(await _bloc.helper.getCodeLang());
                      //           // _bloc.loadingButtonController.start();
                      //            Get.off(BottomNavBar());
                      //
                      //
                      //           //_bloc.loadingButtonController.stop();
                      //         }
                      //       },
                      //       shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              )),
        ]),
      ),
    );
  }
}
