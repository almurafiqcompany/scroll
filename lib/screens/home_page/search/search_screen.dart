import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/screens/home_page/all_resturants/resturants_screen.dart';
import 'package:al_murafiq/screens/home_page/categories/categories_bloc.dart';
import 'package:al_murafiq/screens/home_page/search/search_bloc.dart';
import 'package:al_murafiq/screens/notification/notification_screen.dart';
import 'package:al_murafiq/widgets/show_check_login_dialog.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:al_murafiq/models/countries.dart';
import 'package:al_murafiq/screens/countries/countries_bloc.dart';
import 'package:al_murafiq/models/categories.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:get_it/get_it.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class SearchScreen extends StatefulWidget {
  final String query;

  const SearchScreen({Key key, this.query}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // final imageList = [
  //   'https://cdn.pixabay.com/photo/2017/01/03/11/33/pizza-1949183__480.jpg',
  //   'https://cdn.pixabay.com/photo/2017/02/03/03/54/burger-2034433__480.jpg',
  // ];

  CountriesBloc _bloc = CountriesBloc();
  CategoriesBloc _categoriesBloc = CategoriesBloc();
  SearchBloc _blocSearch = SearchBloc();

  @override
  void initState() {
    _bloc.fetchAllCountries(context);
    _categoriesBloc.fetchDataAllCategories();
    _blocSearch.searchController.text = widget.query;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        title: AutoSizeText(
          'al_murafiq'.tr,
          maxFontSize: 20,
          minFontSize: 16,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        actions: [
          StreamBuilder<String>(
              stream: Stream.fromFuture(getIsLogIn()),
              builder: (context, snapshotToken) {
                if (snapshotToken.hasData) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(NotificationScreen());
                    },
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          child: const Icon(
                            Icons.notifications,
                            size: 30,
                          ),
                        ),
                        StreamBuilder<int>(
                            stream: Stream.fromFuture(getNumberOfNotfiction()),
                            builder: (context, snapshotNumNotif) {
                              if (snapshotNumNotif.hasData &&
                                  snapshotNumNotif.data != 0) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 2),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 3, vertical: 0),
                                      child: Text(
                                        '${snapshotNumNotif.data}',
                                        style: TextStyle(fontSize: 12),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                child: Container(),
                              );
                            }),
                      ],
                    ),
                  );
                } else {
                  return GestureDetector(
                    onTap: () async {
                      await showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return ShowCheckLoginDialog();
                        },
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(
                        Icons.notifications,
                        size: 30,
                      ),
                    ),
                  );
                }
              }),
        ],
        elevation: 0,
        flexibleSpace: Column(
          children: <Widget>[
            Flexible(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xFF03317C),
                      Color(0xFF05B3D6),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.maxFinite,
              height: 6,
              color: Colors.lime,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            StreamBuilder<bool>(
                stream: _blocSearch.searchSubject.stream,
                initialData: true,
                builder: (context, snapshot) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Card(
                      elevation: 4,
                      //color: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      shadowColor: Colors.grey.shade300,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          onChanged: (val) => _blocSearch.changeSearch(val),
                          controller: _blocSearch.searchController,
                          style: kTextStyle.copyWith(fontSize: 18),
                          decoration: InputDecoration(
                            // prefixIcon: Padding(
                            //   padding: EdgeInsets.only(
                            //     left: 5,
                            //     right: 16,
                            //     top: 0,
                            //     bottom: 0,
                            //   ),
                            //   child: GestureDetector(
                            //     onTap: () {
                            //       // _blocSearch.searchController.text.isEmpty
                            //       //     ? null
                            //       //     : Get.to(ResturantsScreen(
                            //       //   bloc: _blocSearch,
                            //       //   subCategoriesID: 1,
                            //       //   targert: true,
                            //       // ));
                            //     },
                            //     child: Icon(
                            //       Icons.search,
                            //       size: 35,
                            //     ),
                            //   ),
                            // ),
                            hintText: 'search'.tr,
                            // errorText:
                            //     snapshot.data ? null : context.translate('search_error'),
                            contentPadding: EdgeInsets.only(
                              left: 16,
                              right: 16,
                              top: 10,
                              bottom: 10,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: Get.height * 0.8,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  //gradient: kAdsHomeGradient,
                  color: Colors.white,
                  // image: DecorationImage(
                  //   image: AssetImage('assets/images/file.png'),
                  //   fit: BoxFit.scaleDown,
                  //   // colorFilter: new ColorFilter.mode(
                  //   //     Colors.black.withOpacity(0.8), BlendMode.dstATop),
                  // )
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: Padding(
                    //         padding: const EdgeInsets.symmetric(horizontal: 25),
                    //         child: Container(
                    //           decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(5),
                    //               border: Border.all(
                    //                 color: Colors.black.withOpacity(0.4),
                    //                 width: 0.5,
                    //               ),
                    //               color: Color(0xffE0E7FF).withOpacity(0.3)),
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
                    //                           child: DropdownButton<
                    //                                   CountriesData>(
                    //                               dropdownColor: Colors.white,
                    //                               iconEnabledColor: Colors.grey,
                    //                               iconSize: 32,
                    //                               elevation: 3,
                    //                               icon: Icon(Icons
                    //                                   .arrow_drop_down_outlined),
                    //                               items: countriesSnapshot.data
                    //                                   .map((item) {
                    //                                 return DropdownMenuItem<
                    //                                         CountriesData>(
                    //                                     value: item,
                    //                                     child: AutoSizeText(
                    //                                       item.name,
                    //                                       style: kTextStyle
                    //                                           .copyWith(
                    //                                               fontSize: 18),
                    //                                       minFontSize: 14,
                    //                                       maxFontSize: 18,
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
                    //                               onChanged:
                    //                                   (CountriesData item) {
                    //                                 _bloc.selectedCities.sink
                    //                                     .add(null);
                    //                                 _bloc.selectedCountry.sink
                    //                                     .add(item);
                    //                               }),
                    //                         );
                    //                       });
                    //                 } else {
                    //                   return const Padding(
                    //                     padding: EdgeInsets.all(8.0),
                    //                     child: Center(
                    //                         child: CircularProgressIndicator(
                    //                       valueColor:
                    //                           AlwaysStoppedAnimation<Color>(
                    //                               kAccentColor),
                    //                     )),
                    //                   );
                    //                 }
                    //               }),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    ///country dropdown
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.black.withOpacity(0.4),
                                    width: 0.5,
                                  ),
                                  color: Color(0xffE0E7FF).withOpacity(0.3)),
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
                                                            _bloc
                                                                .sortCountry(v);
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
                                                                        itemBuilder:
                                                                            (ctx,
                                                                                index) {
                                                                          final item =
                                                                              countriesSnapshot.data[index];
                                                                          return InkWell(
                                                                            onTap:
                                                                                () {
                                                                              _bloc.selectedCountry.add(item);
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
                                                                                  Text(item.name),
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
                                                                            .length);
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
                                                    snapshot.data.icon != null
                                                        ? Image.network(
                                                            '$ImgUrl${snapshot.data.icon}',
                                                            width: 32,
                                                            height: 32,
                                                          )
                                                        : SizedBox(),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(
                                                      snapshot.data.name,
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
                    //         padding: const EdgeInsets.symmetric(horizontal: 25),
                    //         child: Container(
                    //           decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(5),
                    //               border: Border.all(
                    //                 color: Colors.black.withOpacity(0.4),
                    //                 width: 0.5,
                    //               ),
                    //               color: Color(0xffE0E7FF).withOpacity(0.3)),
                    //           child: StreamBuilder<CountriesData>(
                    //               stream: _bloc.selectedCountry.stream,
                    //               builder: (context, snapshot) {
                    //                 if (snapshot.hasData) {
                    //                   return StreamBuilder<CitiesData>(
                    //                       stream: _bloc.selectedCities.stream,
                    //                       builder: (context, citySnapshot) {
                    //                         return Padding(
                    //                           padding:
                    //                               const EdgeInsets.symmetric(
                    //                                   horizontal: 10,
                    //                                   vertical: 2),
                    //                           child: DropdownButton<CitiesData>(
                    //                               dropdownColor: Colors.white,
                    //                               iconEnabledColor: Colors.grey,
                    //                               iconSize: 32,
                    //                               elevation: 3,
                    //                               icon: Icon(Icons
                    //                                   .arrow_drop_down_outlined),
                    //                               items: snapshot.data.cities
                    //                                   .map((item) {
                    //                                 return DropdownMenuItem<
                    //                                         CitiesData>(
                    //                                     value: item,
                    //                                     child: AutoSizeText(
                    //                                       item.name,
                    //                                       style: kTextStyle
                    //                                           .copyWith(
                    //                                               fontSize: 18),
                    //                                       minFontSize: 14,
                    //                                       maxFontSize: 18,
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
                    //                                 _bloc.selectedCities.sink
                    //                                     .add(item);
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
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: Padding(
                    //         padding: const EdgeInsets.symmetric(horizontal: 25),
                    //         child: Container(
                    //           decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(5),
                    //               border: Border.all(
                    //                 color: Colors.black.withOpacity(0.4),
                    //                 width: 0.5,
                    //               ),
                    //               color: Color(0xffE0E7FF).withOpacity(0.3)),
                    //           child: StreamBuilder<CountriesData>(
                    //               stream: _bloc.selectedCountry.stream,
                    //               builder: (context, snapshot) {
                    //                 if (snapshot.hasData) {
                    //                   _bloc.allSortCitiesSubject.add(snapshot.data.cities);
                    //                   return StreamBuilder<CitiesData>(
                    //                       stream: _bloc.selectedCities.stream,
                    //                       builder: (context, citySnapshot) {
                    //                         return Padding(
                    //                           padding:
                    //                               const EdgeInsets.symmetric(
                    //                                   horizontal: 10,
                    //                                   vertical: 2),
                    //                           child: SearchableDropdown.single(
                    //                             menuBackgroundColor:
                    //                                 Color(0xffE0E7FF),
                    //                             items: snapshot.data.cities
                    //                                 .map((item) {
                    //                               return DropdownMenuItem<
                    //                                       CitiesData>(
                    //                                   value: item,
                    //                                   child: AutoSizeText(
                    //                                     item.name,
                    //                                     style:
                    //                                         kTextStyle.copyWith(
                    //                                             fontSize: 18),
                    //                                     minFontSize: 14,
                    //                                     maxFontSize: 18,
                    //                                   ));
                    //                             }).toList(),
                    //                             isExpanded: true,
                    //                             hint: Text(
                    //                               'select_city'.tr,
                    //                               style: kTextStyle.copyWith(
                    //                                   color: Colors.black),
                    //                             ),
                    //                             style: kTextStyle.copyWith(
                    //                                 color: Colors.black),
                    //                             underline: SizedBox(),
                    //                             value: citySnapshot.data,
                    //                             onChanged: (CitiesData item) {
                    //                               _bloc.selectedCities.sink
                    //                                   .add(item);
                    //                             },
                    //                             searchHint: 'select_city'.tr,
                    //                           ),
                    //                         );
                    //                       });
                    //                 } else {
                    //                   return const Padding(
                    //                     padding: EdgeInsets.all(8.0),
                    //                     child: Center(
                    //                         child: CircularProgressIndicator(
                    //                       valueColor:
                    //                           AlwaysStoppedAnimation<Color>(
                    //                               kAccentColor),
                    //                     )),
                    //                   );
                    //                 }
                    //               }),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),

                    ////////////////

                    ///city dropdown
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.black.withOpacity(0.4),
                                    width: 0.5,
                                  ),
                                  color: Color(0xffE0E7FF).withOpacity(0.3)),
                              child: StreamBuilder<CountriesData>(
                                  stream: _bloc.selectedCountry.stream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      _bloc.allSortCitiesSubject.add(snapshot.data.cities);
                                      return StreamBuilder<CitiesData>(
                                          stream: _bloc.selectedCities.stream,
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
                                                                    _bloc
                                                                        .sortCities(v);
                                                                  },
                                                                ),
                                                              ),
                                                              Divider(),
                                                              Expanded(
                                                                child: StreamBuilder<
                                                                    List<
                                                                        CitiesData>>(
                                                                    stream: _bloc
                                                                        .allSortCitiesSubject
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
                                                                              citiesSnapshot.data[index];
                                                                              return InkWell(
                                                                                onTap:
                                                                                    () {
                                                                                  _bloc.selectedCities.add(item);
                                                                                  Get.back();
                                                                                },
                                                                                child:
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: Text(item.name),
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
                                                                                .length);
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
                                                    snapshot.data.name,
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
                                      // return const Padding(
                                      //   padding: EdgeInsets.all(8.0),
                                      //   child: Center(
                                      //       child: CircularProgressIndicator(
                                      //         valueColor:
                                      //         AlwaysStoppedAnimation<Color>(
                                      //             kAccentColor),
                                      //       )),
                                      // );

                                      return SizedBox();
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
                    ///category dropdown
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.black.withOpacity(0.4),
                                    width: 0.5,
                                  ),
                                  color: Color(0xffE0E7FF).withOpacity(0.3)),
                              child: StreamBuilder<Categories_Data>(
                                  stream: _categoriesBloc
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
                                                            _categoriesBloc
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
                                                            stream: _categoriesBloc
                                                                .getSortAllCategoriesSubject
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
                                                                              countriesSnapshot.data[index];
                                                                          return InkWell(
                                                                            onTap:
                                                                                () {
                                                                              _categoriesBloc.selectCategoriesSubject.add(item);
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
                                                                                  Text(item.name),
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
                                                                            .length);
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
                                                      snapshot.data.name,
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
///////////////////////////////////
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 25),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(5),
//                                   border: Border.all(
//                                     color: Colors.black.withOpacity(0.4),
//                                     width: 0.5,
//                                   ),
//                                   color: Color(0xffE0E7FF).withOpacity(0.3)),
//                               child: StreamBuilder<Categories_Data>(
//                                   stream: _categoriesBloc
//                                       .selectCategoriesSubject.stream,
//                                   builder: (context, snapshot) {
//                                     if (snapshot.hasData) {
//                                       return StreamBuilder<SubCategories>(
//                                           stream: _categoriesBloc
//                                               .selectedSubCategories.stream,
//                                           builder:
//                                               (context, subcategoriesSnapshot) {
//                                             return Padding(
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                       horizontal: 10,
//                                                       vertical: 2),
//                                               child: SearchableDropdown.single(
//                                                 menuBackgroundColor:
//                                                     Color(0xffE0E7FF),
//                                                 items: snapshot
//                                                     .data.sub_categories
//                                                     .map((item) {
//                                                   return DropdownMenuItem<
//                                                           SubCategories>(
//                                                       value: item,
//                                                       child: AutoSizeText(
//                                                         item.name,
//                                                         style:
//                                                             kTextStyle.copyWith(
//                                                                 fontSize: 18),
//                                                         minFontSize: 14,
//                                                         maxFontSize: 18,
//                                                       ));
//                                                 }).toList(),
//                                                 isExpanded: true,
//                                                 hint: Text(
//                                                   'select_sub_category'.tr,
//                                                   style: kTextStyle.copyWith(
//                                                       color: Colors.black),
//                                                 ),
//                                                 style: kTextStyle.copyWith(
//                                                     color: Colors.black),
//                                                 underline: SizedBox(),
//                                                 value:
//                                                     subcategoriesSnapshot.data,
//                                                 onChanged:
//                                                     (SubCategories item) {
//                                                   _categoriesBloc
//                                                       .selectedSubSubCategories
//                                                       .sink
//                                                       .add(null);
//                                                   _categoriesBloc
//                                                       .selectedSubCategories
//                                                       .sink
//                                                       .add(item);
//                                                   // widget
//                                                   //     .bloc.selectedSubCategories.sink
//                                                   //     .add(item);
//                                                 },
//                                                 searchHint:
//                                                     'select_sub_category'.tr,
//                                               ),
//                                             );
//                                           });
//                                     } else
//                                       return SizedBox();
//                                   }),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),

                    ////////////////////

                    ///subcategory dropdown
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.black.withOpacity(0.4),
                                    width: 0.5,
                                  ),
                                  color: Color(0xffE0E7FF).withOpacity(0.3)),
                              child: StreamBuilder<Categories_Data>(
                                  stream: _categoriesBloc
                                      .selectCategoriesSubject.stream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      _categoriesBloc.getSortAllSubCategories.add(snapshot.data.sub_categories);
                                      return StreamBuilder<SubCategories>(
                                          stream: _categoriesBloc
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
                                                                    _categoriesBloc
                                                                        .sortSubCategories(v);
                                                                  },
                                                                ),
                                                              ),
                                                              Divider(),
                                                              Expanded(
                                                                child: StreamBuilder<
                                                                    List<
                                                                        SubCategories>>(
                                                                    stream: _categoriesBloc
                                                                        .getSortAllSubCategories
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
                                                                              subCategoriesSnapshot.data[index];
                                                                              return InkWell(
                                                                                onTap:
                                                                                    () {
                                                                                      _categoriesBloc.selectedSubCategories.add(item);
                                                                                  Get.back();
                                                                                },
                                                                                child:
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: Text(item.name),
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
                                                                                .length);
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
                                                    snapshot.data.name,
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
                    //         padding: const EdgeInsets.symmetric(horizontal: 25),
                    //         child: Container(
                    //           decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(5),
                    //               border: Border.all(
                    //                 color: Colors.black.withOpacity(0.4),
                    //                 width: 0.5,
                    //               ),
                    //               color: Color(0xffE0E7FF).withOpacity(0.3)),
                    //           child: StreamBuilder<SubCategories>(
                    //               stream: _categoriesBloc
                    //                   .selectedSubCategories.stream,
                    //               builder: (context, snapshot) {
                    //                 if (snapshot.hasData) {
                    //                   return StreamBuilder<SubSubCategories>(
                    //                       stream: _categoriesBloc
                    //                           .selectedSubSubCategories.stream,
                    //                       builder: (context,
                    //                           subSubcategoriesSnapshot) {
                    //                         return Padding(
                    //                           padding:
                    //                               const EdgeInsets.symmetric(
                    //                                   horizontal: 10,
                    //                                   vertical: 2),
                    //                           child: SearchableDropdown.single(
                    //                             menuBackgroundColor:
                    //                                 Color(0xffE0E7FF),
                    //                             items: snapshot
                    //                                 .data.sub_sub_categories
                    //                                 .map((item) {
                    //                               return DropdownMenuItem<
                    //                                       SubSubCategories>(
                    //                                   value: item,
                    //                                   child: AutoSizeText(
                    //                                     item.name,
                    //                                     style:
                    //                                         kTextStyle.copyWith(
                    //                                             fontSize: 14),
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
                    //                             value: subSubcategoriesSnapshot
                    //                                 .data,
                    //                             onChanged:
                    //                                 (SubSubCategories item) {
                    //                               _categoriesBloc
                    //                                   .selectedSubSubCategories
                    //                                   .sink
                    //                                   .add(item);
                    //                               // widget
                    //                               //     .bloc.selectedSubCategories.sink
                    //                               //     .add(item);
                    //                             },
                    //                             searchHint:
                    //                                 'select_sub_category'.tr,
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
                    ///subsubcategory dropdown
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.black.withOpacity(0.4),
                                    width: 0.5,
                                  ),
                                  color: Color(0xffE0E7FF).withOpacity(0.3)),
                              child: StreamBuilder<SubCategories>(
                                  stream: _categoriesBloc
                                      .selectedSubCategories.stream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      _categoriesBloc.getSortAllSubSubCategories.add(snapshot.data.sub_sub_categories);
                                      return StreamBuilder<SubSubCategories>(
                                          stream: _categoriesBloc
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
                                                                    _categoriesBloc
                                                                        .sortSubSubCategories(v);
                                                                  },
                                                                ),
                                                              ),
                                                              Divider(),
                                                              Expanded(
                                                                child: StreamBuilder<
                                                                    List<
                                                                        SubSubCategories>>(
                                                                    stream: _categoriesBloc
                                                                        .getSortAllSubSubCategories
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
                                                                              subSubCategoriesSnapshot.data[index];
                                                                              return InkWell(
                                                                                onTap:
                                                                                    () {
                                                                                  _categoriesBloc.selectedSubSubCategories.add(item);
                                                                                  Get.back();
                                                                                },
                                                                                child:
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: Text(item.name),
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
                                                                                .length);
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
                                                    snapshot.data.name,
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
                    //         padding: const EdgeInsets.symmetric(horizontal: 25),
                    //         child: Container(
                    //           decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(5),
                    //               border: Border.all(
                    //                 color: Colors.black.withOpacity(0.4),
                    //                 width: 0.5,
                    //               ),
                    //               color: Color(0xffE0E7FF).withOpacity(0.3)),
                    //           child: StreamBuilder<List<Categories_Data>>(
                    //               stream: _categoriesBloc
                    //                   .getAllCategoriesSubject.stream,
                    //               builder: (context, categoriesSnapshot) {
                    //                 print(
                    //                     'ew${_categoriesBloc.getAllCategoriesSubject.value}');
                    //                 if (categoriesSnapshot.hasData) {
                    //                   return StreamBuilder<Categories_Data>(
                    //                       stream: _categoriesBloc
                    //                           .selectCategoriesSubject.stream,
                    //                       builder: (context, snapshot) {
                    //                         return Padding(
                    //                           padding:
                    //                               const EdgeInsets.symmetric(
                    //                                   horizontal: 10,
                    //                                   vertical: 2),
                    //                           child: DropdownButton<
                    //                                   Categories_Data>(
                    //                               dropdownColor: Colors.white,
                    //                               iconEnabledColor: Colors.grey,
                    //                               iconSize: 32,
                    //                               elevation: 3,
                    //                               icon: Icon(Icons
                    //                                   .arrow_drop_down_outlined),
                    //                               items: categoriesSnapshot.data
                    //                                   .map((item) {
                    //                                 return DropdownMenuItem<
                    //                                         Categories_Data>(
                    //                                     value: item,
                    //                                     child: AutoSizeText(
                    //                                       item.name,
                    //                                       style: kTextStyle
                    //                                           .copyWith(
                    //                                               fontSize: 18),
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
                    //                               onChanged:
                    //                                   (Categories_Data item) {
                    //                                 print(item.name);
                    //                                 _categoriesBloc
                    //                                     .selectedSubCategories
                    //                                     .sink
                    //                                     .add(null);
                    //                                 _categoriesBloc
                    //                                     .selectCategoriesSubject
                    //                                     .sink
                    //                                     .add(item);
                    //                                 print(_categoriesBloc
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
                    //                       valueColor:
                    //                           AlwaysStoppedAnimation<Color>(
                    //                               kAccentColor),
                    //                     )),
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
                    //         padding: const EdgeInsets.symmetric(horizontal: 25),
                    //         child: Container(
                    //           decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(5),
                    //               border: Border.all(
                    //                 color: Colors.black.withOpacity(0.4),
                    //                 width: 0.5,
                    //               ),
                    //               color: Color(0xffE0E7FF).withOpacity(0.3)),
                    //           child: StreamBuilder<Categories_Data>(
                    //               stream: _categoriesBloc
                    //                   .selectCategoriesSubject.stream,
                    //               builder: (context, snapshot) {
                    //                 if (snapshot.hasData) {
                    //                   return StreamBuilder<SubCategories>(
                    //                       stream: _categoriesBloc
                    //                           .selectedSubCategories.stream,
                    //                       builder:
                    //                           (context, subcategoriesSnapshot) {
                    //                         return Padding(
                    //                           padding:
                    //                               const EdgeInsets.symmetric(
                    //                                   horizontal: 10,
                    //                                   vertical: 2),
                    //                           child: DropdownButton<
                    //                                   SubCategories>(
                    //                               dropdownColor: Colors.white,
                    //                               iconEnabledColor: Colors.grey,
                    //                               iconSize: 32,
                    //                               elevation: 3,
                    //                               icon: Icon(Icons
                    //                                   .arrow_drop_down_outlined),
                    //                               items: snapshot
                    //                                   .data.sub_categories
                    //                                   .map((item) {
                    //                                 return DropdownMenuItem<
                    //                                         SubCategories>(
                    //                                     value: item,
                    //                                     child: AutoSizeText(
                    //                                       item.name,
                    //                                       style: kTextStyle
                    //                                           .copyWith(
                    //                                               fontSize: 18),
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
                    //                               value: subcategoriesSnapshot
                    //                                   .data,
                    //                               onChanged:
                    //                                   (SubCategories item) {
                    //                                 print(item.name);
                    //                                 _categoriesBloc
                    //                                     .selectedSubCategories
                    //                                     .sink
                    //                                     .add(item);
                    //                                 print(_categoriesBloc
                    //                                     .selectedSubCategories
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
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: Padding(
                    //         padding: const EdgeInsets.symmetric(horizontal: 25),
                    //         child: Container(
                    //           decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(5),
                    //               border: Border.all(
                    //                 color: Colors.black.withOpacity(0.4),
                    //                 width: 0.5,
                    //               ),
                    //               color: Color(0xffE0E7FF).withOpacity(0.3)),
                    //           child: StreamBuilder<List<Languages>>(
                    //               stream: _bloc.allLanguageSubject.stream,
                    //               builder: (context, snapshot) {
                    //                 if (snapshot.hasData) {
                    //                   return StreamBuilder<Languages>(
                    //                       stream: _bloc.selectedLanguage.stream,
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
                    //                               hint: Text(
                    //                                 'select_language'.tr,
                    //                                 // context.translate('select_language'),
                    //                                 style:
                    //                                 kTextStyle.copyWith(
                    //                                     color:
                    //                                     Colors.black),
                    //                               ),
                    //                               style: kTextStyle.copyWith(
                    //                                   color: Colors.black),
                    //                               underline: SizedBox(),
                    //                               value:  langSnapshot.data,
                    //                               onChanged: (Languages item) {
                    //                                 _bloc.selectedLanguage.sink
                    //                                     .add(item);
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

                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 25),
                    //   child: FlatButton(
                    //
                    //       height: 55,
                    //       minWidth: Get.width-150,
                    //       child: Text('Search', style: kTextStyle.copyWith(fontSize: 22)),
                    //       color: Colors.blue.shade800,
                    //       textColor: Color(0xffFFFFFF),
                    //       onPressed: ()  async {
                    //        bool falg=await _blocSearch.fetchDataCustomSearch(
                    //             _bloc.selectedCountry.value,
                    //             _bloc.selectedCities.value,
                    //           _categoriesBloc.selectCategoriesSubject.value,
                    //           _categoriesBloc.selectedSubCategories.value
                    //         );
                    //        if(falg){
                    //          await Get.to(ResturantsScreen(
                    //            bloc: _blocSearch,
                    //            blocCountry: _bloc,
                    //            blocCategories:_categoriesBloc,
                    //            subCategoriesID: 1,
                    //            targert: 0,
                    //          ));
                    //        }
                    //
                    //       },
                    //       shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0))
                    //   ),
                    // ),

                    StreamBuilder<String>(
                        stream: Stream.fromFuture(getIsLogIn()),
                        builder: (context, snapshotToken) {
                          if (snapshotToken.hasData) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 30),
                              child: RoundedLoadingButton(
                                child: Text(
                                  'search'.tr,
                                  style: kTextStyle.copyWith(
                                      fontSize: 20, color: Colors.white),
                                ),
                                height: 50,
                                controller: _blocSearch.loadingButtonController,
                                color: Colors.blue.shade800,
                                onPressed: () async {
                                  _blocSearch.loadingButtonController.start();
                                  _blocSearch.dataOfSearchSubject.sink
                                      .add(null);
                                  bool falg =
                                      await _blocSearch.fetchDataCustomSearch(
                                          _bloc.selectedCountry.value,
                                          _bloc.selectedCities.value,
                                          _categoriesBloc
                                              .selectCategoriesSubject.value,
                                          _categoriesBloc
                                              .selectedSubCategories.value,
                                          _categoriesBloc
                                              .selectedSubSubCategories.value,
                                          context,
                                          false);
                                  if (falg) {
                                    await Get.to(ResturantsScreen(
                                      bloc: _blocSearch,
                                      blocCountry: _bloc,
                                      blocCategories: _categoriesBloc,
                                      subCategoriesID: _categoriesBloc
                                                  .selectedSubCategories
                                                  .value ==
                                              null
                                          ? 1
                                          : _categoriesBloc
                                              .selectedSubCategories.value.id,
                                      //1
                                      targert: 0,
                                    ));
                                  }
                                  _blocSearch.loadingButtonController.stop();
                                },
                              ),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 30),
                              child: RoundedLoadingButton(
                                child: Text(
                                  'search'.tr,
                                  style: kTextStyle.copyWith(fontSize: 20),
                                ),
                                height: 50,
                                controller: _blocSearch.loadingButtonController,
                                color: Colors.blue.shade800,
                                onPressed: () async {
                                  _blocSearch.loadingButtonController.start();
                                  await showModalBottomSheet<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ShowCheckLoginDialog();
                                    },
                                  );
                                  _blocSearch.loadingButtonController.stop();
                                },
                              ),
                            );
                          }
                        }),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  SharedPreferenceHelper helper = GetIt.instance.get<SharedPreferenceHelper>();

  Future<String> getIsLogIn() async {
    return await helper.getToken();
  }

  Future<int> getNumberOfNotfiction() async {
    return await helper.getNumberOfNotfiction();
  }
}
