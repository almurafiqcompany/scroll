import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/models/sub_categories.dart';
import 'package:al_murafiq/screens/home_page/all_resturants/resturants_screen.dart';
import 'package:al_murafiq/screens/home_page/company/resturant_page_screen.dart';
import 'package:al_murafiq/screens/home_page/home_page_bloc.dart';
import 'package:al_murafiq/screens/home_page/search/search_bloc.dart';
import 'package:al_murafiq/screens/notification/notification_screen.dart';
import 'package:al_murafiq/screens/home_page/sub_categores/sub_sub_categorie_scteen.dart';
import 'package:al_murafiq/widgets/show_check_login_dialog.dart';
import 'package:al_murafiq/widgets/show_message_emty_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:get/get.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:get_it/get_it.dart';
import 'package:al_murafiq/models/categories.dart' as adsCate;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SubCategorieHomeScreen extends StatefulWidget {
  final String? name_Categories;
  final int? id;
  final HomePageBloc? bloc;

  const SubCategorieHomeScreen(
      {Key? key, this.name_Categories, this.id, this.bloc})
      : super(key: key);

  @override
  _SubCategorieScreenState createState() => _SubCategorieScreenState();
}

class _SubCategorieScreenState extends State<SubCategorieHomeScreen> {
  // HomePageBloc _bloc = HomePageBloc();

  @override
  void initState() {
    // TODO: implement initState
    // _bloc.fetchDataAllSubCategories(widget.id);
    super.initState();
  }

  final double itemHeight = Get.height * 0.12;
  final double itemWidth = (Get.width / 2) - 15;
  SearchBloc _blocSearch = SearchBloc();

  //SubCategoriesBloc _subCategoriesBloc=SubCategoriesBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_blocSearch.searchController.text != null
            ? _blocSearch.searchController.text
            : ''),
        actions: [
          StreamBuilder<String?>(
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
                        StreamBuilder<int?>(
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
                    child: Row(
                      children: [
                        Expanded(
                          child: Card(
                            elevation: 6,
                            //color: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            shadowColor: Colors.grey,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                onChanged: (val) =>
                                    _blocSearch.changeSearch(val),
                                controller: _blocSearch.searchController,
                                style: kTextStyle.copyWith(fontSize: 20),
                                decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(
                                      left: 5,
                                      right: 16,
                                      top: 0,
                                      bottom: 0,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        _blocSearch
                                                .searchController.text.isEmpty
                                            ? null
                                            : Get.to(
                                                ResturantsScreen(
                                                  bloc: _blocSearch,
                                                  subCategoriesID: 1,
                                                  targert: 2,
                                                ),
                                              );
                                      },
                                      child: Icon(
                                        Icons.search,
                                        size: 35,
                                      ),
                                    ),
                                  ),
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
                        ),
                        FlatButton(
                          onPressed: () {
                            _blocSearch.searchController.text.isEmpty
                                ? null
                                : Get.to(ResturantsScreen(
                                    bloc: _blocSearch,
                                    subCategoriesID: 1,
                                    targert: 2,
                                  ));
                          },
                          color: Colors.blue,
                          padding:
                              EdgeInsets.symmetric(horizontal: 7, vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: Text(
                            'search'.tr,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
            const SizedBox(
              height: 10,
            ),
            StreamBuilder<SubCategories_Data>(
                stream: widget.bloc!.getAllSubCategoriesSubject.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.ads!.length > 0) {
                      if (snapshot.data!.ads!.isNotEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 1,
                                    color: Color(0xffe6e6e4),
                                    blurRadius: 1,
                                    offset: Offset(0, 2),
                                  ),
                                ]),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: Get.height * 0.31,
                                      width: Get.width - 20,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Swiper(
                                          // pagination:  SwiperPagination(margin: EdgeInsets.symmetric(vertical: 1)),
                                          pagination: SwiperPagination(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2),
                                              alignment: Alignment.bottomCenter,
                                              builder: SwiperCustomPagination(
                                                  builder:
                                                      (BuildContext context,
                                                          SwiperPluginConfig
                                                              config) {
                                                return ConstrainedBox(
                                                  child: Container(
                                                      color: Colors.white,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .stretch,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        5,
                                                                    vertical:
                                                                        2),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                      width: (Get.width /
                                                                              2) -
                                                                          20,
                                                                      child:
                                                                          SingleChildScrollView(
                                                                        scrollDirection:
                                                                            Axis.horizontal,
                                                                        physics:
                                                                            BouncingScrollPhysics(),
                                                                        child:
                                                                            Text(
                                                                          '${snapshot.data!.ads![config.activeIndex].name} ',
                                                                          style:
                                                                              const TextStyle(fontSize: 16.0),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 2,
                                                                    ),
                                                                    const Icon(
                                                                      Icons
                                                                          .check_circle_outline,
                                                                      color:
                                                                          kPrimaryColor,
                                                                      size: 16,
                                                                    ),
                                                                  ],
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          10),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      // RatingBar(
                                                                      //   rating: snapshot
                                                                      //       .data
                                                                      //       .ads[config.activeIndex]
                                                                      //       .total_rating
                                                                      //       .toDouble(),
                                                                      //   icon:
                                                                      //       const Icon(
                                                                      //     Icons
                                                                      //         .star,
                                                                      //     size:
                                                                      //         20,
                                                                      //     color:
                                                                      //         Colors.grey,
                                                                      //   ),
                                                                      //   starCount:
                                                                      //       5,
                                                                      //   spacing:
                                                                      //       2,
                                                                      //   size:
                                                                      //       15,
                                                                      //   isIndicator:
                                                                      //       true,
                                                                      //   allowHalfRating:
                                                                      //       true,
                                                                      //   color: Colors
                                                                      //       .amber,
                                                                      // ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 8,
                                                          ),
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10),
                                                                child:
                                                                    Container(
                                                                  width:
                                                                      Get.width /
                                                                          2,
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    scrollDirection:
                                                                        Axis.horizontal,
                                                                    physics:
                                                                        BouncingScrollPhysics(),
                                                                    child: Text(
                                                                      snapshot
                                                                          .data!
                                                                          .ads![
                                                                              config.activeIndex]
                                                                          .address!,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              13,
                                                                          color:
                                                                              Colors.grey),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        5),
                                                                child: Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .end,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    if (snapshot
                                                                            .data!
                                                                            .ads![config.activeIndex]
                                                                            .distance !=
                                                                        null)
                                                                      Container(
                                                                        width:
                                                                            50,
                                                                        height:
                                                                            20,
                                                                        decoration:
                                                                            const BoxDecoration(
                                                                          color:
                                                                              Color(0xff848DFF),
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(15.0)),
                                                                        ),
                                                                        child: Center(
                                                                            child: SingleChildScrollView(
                                                                          scrollDirection:
                                                                              Axis.horizontal,
                                                                          physics:
                                                                              BouncingScrollPhysics(),
                                                                          child:
                                                                              Text(
                                                                            snapshot.data!.ads![config.activeIndex].distance!,
                                                                            style:
                                                                                TextStyle(fontSize: 10, color: Colors.white),
                                                                          ),
                                                                        )),
                                                                      )
                                                                    else
                                                                      SizedBox(),
                                                                    const SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    if (snapshot
                                                                            .data!
                                                                            .ads![config.activeIndex]
                                                                            .city !=
                                                                        null)
                                                                      Container(
                                                                        width:
                                                                            50,
                                                                        height:
                                                                            20,
                                                                        decoration:
                                                                            const BoxDecoration(
                                                                          gradient:
                                                                              kAdsHomeGradient,
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(15.0)),
                                                                        ),
                                                                        child: Center(
                                                                            child: SingleChildScrollView(
                                                                          scrollDirection:
                                                                              Axis.horizontal,
                                                                          physics:
                                                                              BouncingScrollPhysics(),
                                                                          child:
                                                                              Text(
                                                                            snapshot.data!.ads![config.activeIndex].city!,
                                                                            style:
                                                                                TextStyle(fontSize: 10, color: Colors.white),
                                                                          ),
                                                                        )),
                                                                      )
                                                                    else
                                                                      SizedBox(),
                                                                    if (snapshot
                                                                            .data!
                                                                            .ads![config.activeIndex]
                                                                            .visit_count !=
                                                                        null)
                                                                      Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Color(0xffF5F5F5),
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(8.0)),
                                                                          // border: Border.all(
                                                                          //   color: Colors.grey.withOpacity(0.3),
                                                                          //   width: 0.4,
                                                                          // ),
                                                                        ),
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets.symmetric(
                                                                              horizontal: 8,
                                                                              vertical: 5),
                                                                          child:
                                                                              Row(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            // ignore: prefer_const_literals_to_create_immutables
                                                                            children: [
                                                                              const Icon(MdiIcons.eye, size: 24, color: Color(0xff01B2CB)),
                                                                              const SizedBox(
                                                                                width: 5,
                                                                              ),
                                                                              Text(
                                                                                snapshot.data!.ads![config.activeIndex].visit_count! > 999
                                                                                    ? '${snapshot.data!.ads![config.activeIndex].visit_count! / 1000}K'
                                                                                    : snapshot.data!.ads![config.activeIndex].visit_count! > 999999
                                                                                        ? '${snapshot.data!.ads![config.activeIndex].visit_count! / 1000000}M'
                                                                                        : '${snapshot.data!.ads![config.activeIndex].visit_count}',
                                                                                style: TextStyle(fontSize: 12, color: Colors.black),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      )
                                                                    else
                                                                      SizedBox(),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          30),
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .bottomLeft,
                                                                    child: const DotSwiperPaginationBuilder(
                                                                            color: Colors
                                                                                .grey,
                                                                            activeColor:
                                                                                kPrimaryColor,
                                                                            size:
                                                                                5.0,
                                                                            activeSize:
                                                                                8.0)
                                                                        .build(
                                                                            context,
                                                                            config),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      )),
                                                  constraints:
                                                      BoxConstraints.expand(
                                                          height: 80),
                                                );
                                              })),

                                          autoplay: true,

                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Stack(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 5,
                                                      vertical: 5),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10.0)),
                                                      border: Border.all(
                                                        color: Colors.grey
                                                            .withOpacity(0.3),
                                                        width: 0.4,
                                                      ),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(
                                                                10.0),
                                                        bottomRight:
                                                            Radius.circular(
                                                                10.0),
                                                        topRight:
                                                            Radius.circular(
                                                                10.0),
                                                        bottomLeft:
                                                            Radius.circular(
                                                                10.0),
                                                      ),
                                                      child: Image.network(
                                                        snapshot
                                                                    .data!
                                                                    .ads![index]
                                                                    .image !=
                                                                null
                                                            ? '$ImgUrl${snapshot.data!.ads![index].image}'
                                                            : defaultImgUrl,
                                                        fit: BoxFit.fill,
                                                        height:
                                                            Get.height * 0.18,
                                                        width: Get.width - 20,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                    left: 15,
                                                    top: 10,
                                                    child: Container(
                                                      width: 55,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    15.0)),
                                                        border: Border.all(
                                                          color: Colors.grey
                                                              .withOpacity(0.3),
                                                          width: 0.4,
                                                        ),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          const Icon(
                                                            Icons.star,
                                                            color: Colors.amber,
                                                          ),
                                                          Text(
                                                            '${snapshot.data!.ads![index].total_rating.toStringAsFixed(1)}',
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                              ],
                                            );
                                          },
                                          itemCount: snapshot.data!.ads!.length,
                                          //itemWidth: 100.0,
                                          //autoplayDelay: 2500,
                                          onTap: (int index) {
                                            Get.to(ResturantPageScreen(
                                              flagBranch: false,
                                              compaine_id: snapshot
                                                  .data!.ads![index].company_id,
                                              ad_id:
                                                  snapshot.data!.ads![index].id,
                                            ));
                                          },

                                          loop: true,
                                          layout: SwiperLayout.DEFAULT,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return SizedBox();
                      }
                    } else {
                      return SizedBox();
                    }
                  } else if (snapshot.hasError) {
                    return ShowMessageEmtyDialog(
                      message: 'snapshot.error',
                      pathImg: 'assets/images/file.png',
                    );
                  } else {
                    return SizedBox();
                  }
                }),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: Get.height * 0.40),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffFFFFFF),
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.3),
                      width: 0.4,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              child: Text(
                                widget.name_Categories!,
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          child: GridView.count(
                            crossAxisCount: 2,
                            childAspectRatio: (itemWidth / itemHeight),
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                            controller:
                                ScrollController(keepScrollOffset: false),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            children: _buildGridTileList(widget
                                .bloc!
                                .getAllSubCategoriesSubject
                                .value
                                .sub_categories!
                                .length),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SharedPreferenceHelper helper = GetIt.instance.get<SharedPreferenceHelper>();

  Future<String?> getIsLogIn() async {
    return await helper.getToken();
  }

  Future<int?> getNumberOfNotfiction() async {
    return await helper.getNumberOfNotfiction();
  }

  List<Widget> _buildGridTileList(int count) => List.generate(
      count,
      (i) => BuildSubCategorie(
          widget
              .bloc!.getAllSubCategoriesSubject.value.sub_categories![i].name!,
          widget
              .bloc!.getAllSubCategoriesSubject.value.sub_categories![i].image!,
          widget.bloc!.getAllSubCategoriesSubject.value.sub_categories![i].id!,
          widget
              .bloc!.getAllSubCategoriesSubject.value.sub_categories![i].color!,
          widget.bloc!.getAllSubCategoriesSubject.value.sub_categories![i],
          widget.bloc!.getAllSubCategoriesSubject.value.ads!));

  Widget BuildSubCategorie(
    String name,
    String img,
    int subCategoriesID,
    String color,
    SubCategories sub_categori,
    List<adsCate.Ads> ads,
  ) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () async {
          // await _subCategoriesBloc.fetchDataSearch(subCategoriesID);
          // final SearchBloc blocCoby=_subCategoriesBloc;
          // await Get.to(ResturantsScreen(
          //   bloc: _blocSearch,
          //   subCategoriesID: subCategoriesID,
          //   targert: 1,
          // ));
          sub_categori.sub_sub_categories!.length == 0
              ? Get.to(ResturantsScreen(
                  bloc: _blocSearch,
                  subCategoriesID: subCategoriesID,
                  targert: 1,
                ))
              : await Get.to(SubSubCategorieScreen(
                  subSubCategories: sub_categori.sub_sub_categories,
                  name_Sub_Categories: name,
                  ads: ads,
                ));
        },
        child: Container(
          // height: Get.height*0.12,
          //width: MediaQuery.of(context).size.width/3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(const Radius.circular(25.0)),
              // gradient: kAdsHomeGradient,
              // color: Color(int.parse('0xff${color}')),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0, 0.8],
                colors: [
                  Color(int.parse('0xff${color}')),
                  Colors.black.withOpacity(0.8),
                ],
              ),
              image: DecorationImage(
                image:
                    NetworkImage(img != null ? '$ImgUrl${img}' : defaultImgUrl),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3), BlendMode.dstATop),
              )),
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 5,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: (Get.width / 3) - 30,
                    child: Column(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              name,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
