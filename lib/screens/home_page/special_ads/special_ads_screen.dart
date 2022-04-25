import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/models/special_ads.dart';
import 'package:al_murafiq/screens/home_page/all_resturants/resturants_screen.dart';
import 'package:al_murafiq/screens/home_page/company/resturant_page_screen.dart';
import 'package:al_murafiq/screens/home_page/search/search_bloc.dart';
import 'package:al_murafiq/screens/home_page/special_ads/special_ads_bloc.dart';
import 'package:al_murafiq/screens/notification/notification_screen.dart';
import 'package:al_murafiq/widgets/show_check_login_dialog.dart';
import 'package:al_murafiq/widgets/show_message_emty_dialog.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:marquee/marquee.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SpecialAdsScreen extends StatefulWidget {
  @override
  _SpecialAdsScreenState createState() => _SpecialAdsScreenState();
}

class _SpecialAdsScreenState extends State<SpecialAdsScreen> {
  // final imageList = [
  //   'https://cdn.pixabay.com/photo/2017/01/03/11/33/pizza-1949183__480.jpg',
  //   'https://cdn.pixabay.com/photo/2017/02/03/03/54/burger-2034433__480.jpg',
  // ];
  //
  final double itemHeight = Get.height * 0.33;

  final double itemWidth = (Get.width / 2) - 20; //160
  SpecialAdsBloc _bloc = SpecialAdsBloc();
  SearchBloc _blocSearch = SearchBloc();

  @override
  void initState() {
    _bloc.fetchSpecialAds();
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
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
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
      // backgroundColor: Colors.grey.shade300,
      body: RefreshIndicator(
        onRefresh: () async {
          _bloc.fetchSpecialAds();
          return Future.delayed(Duration(milliseconds: 400));
        },
        child: SingleChildScrollView(
          child: StreamBuilder<Special_Ads_Data>(
              stream: _bloc.dataOfSpecialAdsSubject.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          StreamBuilder<bool>(
                              stream: _blocSearch.searchSubject.stream,
                              initialData: true,
                              builder: (context, snapshot) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Card(
                                          elevation: 4,
                                          //color: Colors.grey,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          shadowColor: Colors.grey.shade300,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0)),
                                            ),
                                            child: TextFormField(
                                              keyboardType: TextInputType.text,
                                              onChanged: (val) =>
                                                  _blocSearch.changeSearch(val),
                                              controller:
                                                  _blocSearch.searchController,
                                              style: kTextStyle.copyWith(
                                                  fontSize: 18),
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
                                                              .searchController
                                                              .text
                                                              .isEmpty
                                                          ? null
                                                          : Get.to(
                                                              ResturantsScreen(
                                                              bloc: _blocSearch,
                                                              subCategoriesID:
                                                                  1,
                                                              targert: 2,
                                                            ));
                                                    },
                                                    child: Icon(
                                                      Icons.search,
                                                      size: 35,
                                                    ),
                                                  ),
                                                ),
                                                hintText: 'search'.tr,
                                                // errorText: snapshot.data
                                                //     ? null
                                                //     : context.translate('search_error'),
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
                                          _blocSearch
                                                  .searchController.text.isEmpty
                                              ? null
                                              : Get.to(ResturantsScreen(
                                                  bloc: _blocSearch,
                                                  subCategoriesID: 1,
                                                  targert: 2,
                                                ));
                                        },
                                        color: Colors.blue,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 7, vertical: 12),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
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
                          SizedBox(
                            height: Get.height * 0.01,
                          ),

                          if (snapshot.data!.slider!.length != 0)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    boxShadow: [
                                      BoxShadow(
                                        spreadRadius: 1,
                                        color: Color(0xffe6e6e4),
                                        blurRadius: 1,
                                        offset: Offset(0, 2),
                                      ),
                                      // BoxShadow(
                                      //   spreadRadius: 5,
                                      //   color: Color(0xffB7B6B6),
                                      //   blurRadius: 7,
                                      //   offset: Offset(0, 4),
                                      // ),
                                    ]),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        //flutter Swipper default
                                        if (snapshot.data!.slider!.length != 0)
                                          Container(
                                            height: Get.height * 0.3,
                                            width: Get.width - 20,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Swiper(
                                                // pagination:  SwiperPagination(margin: EdgeInsets.symmetric(vertical: 1)),
                                                pagination: SwiperPagination(
                                                    margin: const EdgeInsets
                                                        .symmetric(vertical: 2),
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    builder: SwiperCustomPagination(
                                                        builder: (BuildContext
                                                                context,
                                                            SwiperPluginConfig
                                                                config) {
                                                      return ConstrainedBox(
                                                        child: Container(
                                                            color: Colors.white,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets
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
                                                                          Row(
                                                                            children: [
                                                                              Container(
                                                                                width: (Get.width / 2) - 20,
                                                                                child: SingleChildScrollView(
                                                                                  scrollDirection: Axis.horizontal,
                                                                                  physics: BouncingScrollPhysics(),
                                                                                  child: Text(
                                                                                    '${snapshot.data!.slider![config.activeIndex].name} ',
                                                                                    style: const TextStyle(fontSize: 18.0),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              const SizedBox(
                                                                                width: 2,
                                                                              ),
                                                                              const Icon(
                                                                                Icons.check_circle_outline,
                                                                                color: kPrimaryColor,
                                                                                size: 16,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 10),
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              children: [
                                                                                // RatingBar(
                                                                                //   rating: snapshot.data.slider[config.activeIndex].total_rating.toDouble(),
                                                                                //   icon: const Icon(
                                                                                //     Icons.star,
                                                                                //     size: 20,
                                                                                //     color: Colors.grey,
                                                                                //   ),
                                                                                //   starCount: 5,
                                                                                //   spacing: 2,
                                                                                //   size: 15,
                                                                                //   isIndicator: true,
                                                                                //   allowHalfRating: true,

                                                                                //   // onRatingCallback: (double value,ValueNotifier<bool> isIndicator){

                                                                                //   //   isIndicator.value=true;
                                                                                //   // },
                                                                                //   color: Colors.amber,
                                                                                // ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
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
                                                                          child:
                                                                              Text(
                                                                            snapshot.data!.slider![config.activeIndex].address!,
                                                                            style:
                                                                                TextStyle(fontSize: 12, color: Colors.grey),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              5),
                                                                      child:
                                                                          Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.end,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.end,
                                                                        children: [
                                                                          if (snapshot.data!.slider![config.activeIndex].distance !=
                                                                              null)
                                                                            Container(
                                                                              width: 50,
                                                                              height: 20,
                                                                              decoration: const BoxDecoration(
                                                                                color: Color(0xff848DFF),
                                                                                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                                              ),
                                                                              child: Center(
                                                                                  child: SingleChildScrollView(
                                                                                scrollDirection: Axis.horizontal,
                                                                                physics: BouncingScrollPhysics(),
                                                                                child: Text(
                                                                                  snapshot.data!.slider![config.activeIndex].distance!,
                                                                                  style: TextStyle(fontSize: 10, color: Colors.white),
                                                                                ),
                                                                              )),
                                                                            )
                                                                          else
                                                                            SizedBox(),
                                                                          const SizedBox(
                                                                            width:
                                                                                5,
                                                                          ),
                                                                          if (snapshot.data!.slider![config.activeIndex].city !=
                                                                              null)
                                                                            Container(
                                                                              width: 50,
                                                                              height: 20,
                                                                              decoration: const BoxDecoration(
                                                                                gradient: kAdsHomeGradient,
                                                                                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                                              ),
                                                                              child: Center(
                                                                                  child: SingleChildScrollView(
                                                                                scrollDirection: Axis.horizontal,
                                                                                physics: BouncingScrollPhysics(),
                                                                                child: Text(
                                                                                  snapshot.data!.slider![config.activeIndex].city!,
                                                                                  style: TextStyle(fontSize: 10, color: Colors.white),
                                                                                ),
                                                                              )),
                                                                            )
                                                                          else
                                                                            SizedBox(),
                                                                          if (snapshot.data!.slider![config.activeIndex].visit_count !=
                                                                              null)
                                                                            Padding(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 4),
                                                                              child: Container(
                                                                                decoration: const BoxDecoration(
                                                                                  color: Color(0xffF5F5F5),
                                                                                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                                                                  // border: Border.all(
                                                                                  //   color: Colors.grey.withOpacity(0.3),
                                                                                  //   width: 0.4,
                                                                                  // ),
                                                                                ),
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                                                                  child: Row(
                                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    // ignore: prefer_const_literals_to_create_immutables
                                                                                    children: [
                                                                                      const Icon(MdiIcons.eye, size: 18, color: Color(0xff01B2CB)),
                                                                                      const SizedBox(
                                                                                        width: 5,
                                                                                      ),
                                                                                      Text(
                                                                                        snapshot.data!.slider![config.activeIndex].visit_count! > 999
                                                                                            ? '${snapshot.data!.slider![config.activeIndex].visit_count! / 1000}K'
                                                                                            : snapshot.data!.slider![config.activeIndex].visit_count! > 999999
                                                                                                ? '${snapshot.data!.slider![config.activeIndex].visit_count! / 1000000}M'
                                                                                                : '${snapshot.data!.slider![config.activeIndex].visit_count}',
                                                                                        style: TextStyle(fontSize: 12, color: Colors.black),
                                                                                      ),
                                                                                    ],
                                                                                  ),
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
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            30),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .bottomLeft,
                                                                      child: const DotSwiperPaginationBuilder(
                                                                              color: Colors.grey,
                                                                              activeColor: kPrimaryColor,
                                                                              size: 5.0,
                                                                              activeSize: 8.0)
                                                                          .build(context, config),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            )),
                                                        constraints:
                                                            BoxConstraints
                                                                .expand(
                                                                    height: 75),
                                                      );
                                                    })),

                                                autoplay: true,

                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Stack(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 5,
                                                                vertical: 5),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        10.0)),
                                                            border: Border.all(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.3),
                                                              width: 0.4,
                                                            ),
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      10.0),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          10.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      10.0),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      10.0),
                                                            ),
                                                            child:
                                                                Image.network(
                                                              snapshot
                                                                          .data
                                                                        !  .slider![
                                                                              index]
                                                                          .image !=
                                                                      null
                                                                  ? '$ImgUrl${snapshot.data!.slider![index].image}'
                                                                  : defaultImgUrl,
                                                              fit: BoxFit.fill,
                                                              height:
                                                                  Get.height *
                                                                      0.18,
                                                              width: Get.width -
                                                                  20,
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
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          15.0)),
                                                              border:
                                                                  Border.all(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.3),
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
                                                                  color: Colors
                                                                      .amber,
                                                                ),
                                                                Text(
                                                                  '${snapshot.data!.slider![index].total_rating.toStringAsFixed(1)}',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ],
                                                            ),
                                                          )),
                                                    ],
                                                  );
                                                },
                                                itemCount:
                                                    snapshot.data!.slider!.length,
                                                //itemWidth: 100.0,
                                                //autoplayDelay: 2500,
                                                onTap: (int index) {
                                                  Get.to(ResturantPageScreen(
                                                    flagBranch: false,
                                                    compaine_id: snapshot
                                                        .data
                                                        !.slider![index]
                                                        .company_id,
                                                    ad_id: snapshot
                                                        .data!.slider![index].id,
                                                  ));
                                                },

                                                loop: true,
                                                layout: SwiperLayout.DEFAULT,
                                              ),
                                            ),
                                          )
                                        else
                                          SizedBox(),
                                        //flutter Swipper Stack
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          else
                            SizedBox(),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 5),
                          //   child: Row(
                          //     children: [
                          //       Padding(
                          //         padding: const EdgeInsets.symmetric(horizontal: 5),
                          //         child: Container(
                          //           //height: 200,
                          //           width: (Get.width/2)-15,
                          //           decoration: const BoxDecoration(
                          //               color: Colors.white,
                          //               borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          //               boxShadow: [
                          //                 BoxShadow(
                          //                   spreadRadius: 5,
                          //                   color: Color(0xffB7B6B6),
                          //                   blurRadius: 7,
                          //                   offset: Offset(0, 4),
                          //                 ),
                          //               ]),
                          //           child: Column(
                          //             // ignore: prefer_const_literals_to_create_immutables
                          //             children: [
                          //               Container(
                          //                 decoration: const BoxDecoration(
                          //                   color: Colors.white,
                          //                   borderRadius: BorderRadius.all(
                          //                       Radius.circular(15.0)),
                          //                 ),
                          //                 child: ClipRRect(
                          //                   borderRadius: const BorderRadius.only(
                          //                     topLeft: Radius.circular(15.0),
                          //                     bottomRight: Radius.circular(15.0),
                          //                     topRight: Radius.circular(15.0),
                          //                     bottomLeft: Radius.circular(15.0),
                          //                   ),
                          //                   child: Image.asset(
                          //                     'assets/images/test.png',
                          //                     fit: BoxFit.cover,
                          //                   ),
                          //                 ),
                          //               ),
                          //               const SizedBox(
                          //                 height: 8,
                          //               ),
                          //               Row(
                          //                 crossAxisAlignment: CrossAxisAlignment.start,
                          //                 children: [
                          //                   Padding(
                          //                     padding:
                          //                     const EdgeInsets.symmetric(horizontal: 5),
                          //                     child: Row(
                          //                       children: [
                          //                         // ignore: prefer_const_literals_to_create_immutables
                          //                         SingleChildScrollView(
                          //                           scrollDirection: Axis.horizontal,
                          //                           physics: BouncingScrollPhysics(),
                          //                           child: const Text(
                          //                             "zacks",
                          //                             style: const TextStyle(fontSize: 18.0),
                          //                           ),
                          //                         ),
                          //                         const SizedBox(
                          //                           width: 2,
                          //                         ),
                          //                         const Icon(
                          //                           Icons.check_circle_outline,
                          //                           color: kPrimaryColor,
                          //                           size: 16,
                          //                         ),
                          //                       ],
                          //                     ),
                          //                   ),
                          //                   Padding(
                          //                     padding:
                          //                     const EdgeInsets.symmetric(horizontal: 10),
                          //                     child: Row(
                          //                       mainAxisAlignment: MainAxisAlignment.end,
                          //                       children: [
                          //                         RatingBar(
                          //                           rating: 4,
                          //                           icon: const Icon(
                          //                             Icons.star,
                          //                             size: 17,
                          //                             color: Colors.grey,
                          //                           ),
                          //                           starCount: 5,
                          //                           spacing: 1.0,
                          //                           size: 12,
                          //                           isIndicator: true,
                          //                           allowHalfRating: true,
                          //
                          //                           // onRatingCallback: (double value,ValueNotifier<bool> isIndicator){
                          //                           //   print('Number of stars-->  $value');
                          //                           //   isIndicator.value=true;
                          //                           // },
                          //                           color: Colors.amber,
                          //                         ),
                          //                       ],
                          //                     ),
                          //                   ),
                          //                 ],
                          //               ),
                          //               Row(
                          //                 crossAxisAlignment: CrossAxisAlignment.end,
                          //                 mainAxisAlignment: MainAxisAlignment.end,
                          //                 children: [
                          //                   // ignore: prefer_const_literals_to_create_immutables
                          //                   SingleChildScrollView(
                          //                     scrollDirection: Axis.horizontal,
                          //                     physics: BouncingScrollPhysics(),
                          //                     child: const Text(
                          //                       'القاهره الجديده -القاهره -مصر',
                          //                       style: TextStyle(
                          //                           fontSize: 14,
                          //                           color: Colors.grey),
                          //                     ),
                          //                   ),
                          //                 ],
                          //               ),
                          //               SizedBox(
                          //                 height: 5,
                          //               ),
                          //               Row(
                          //                 children: [
                          //                   SizedBox(
                          //                     width: 30,
                          //                   ),
                          //                   Padding(
                          //                     padding: const EdgeInsets.symmetric(horizontal: 5),
                          //                     child: const Icon(
                          //                       Icons.stars_rounded,
                          //                       color: Colors.amber,
                          //                       size: 20,
                          //                     ),
                          //                   ),
                          //                   Padding(
                          //                     padding: const EdgeInsets.symmetric(horizontal: 5),
                          //                     child: Row(
                          //                       crossAxisAlignment: CrossAxisAlignment.center,
                          //                       mainAxisAlignment: MainAxisAlignment.end,
                          //                       children: [
                          //                         GestureDetector(
                          //                           onTap: () {
                          //                             print('15km');
                          //                           },
                          //                           child: Container(
                          //                             width: 50,
                          //                             height: 20,
                          //                             decoration: const BoxDecoration(
                          //                               color: Color(0xff848DFF),
                          //                               borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          //                             ),
                          //                             child: const Center(
                          //                                 child: SingleChildScrollView(
                          //                                   scrollDirection: Axis.horizontal,
                          //                                   physics: BouncingScrollPhysics(),
                          //                                   child: Text(
                          //                                     '15Km',
                          //                                     style: TextStyle(fontSize: 12, color: Colors.white),
                          //                                   ),
                          //                                 )),
                          //                           ),
                          //                         ),
                          //                         const SizedBox(
                          //                           width: 5,
                          //                         ),
                          //                         GestureDetector(
                          //                           onTap: () {
                          //                             print('القاهره');
                          //                           },
                          //                           child: Container(
                          //                             width: 50,
                          //                             height: 20,
                          //                             decoration: const BoxDecoration(
                          //                               gradient: kAdsHomeGradient,
                          //                               borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          //                             ),
                          //                             child: const Center(
                          //                                 child: SingleChildScrollView(
                          //                                   scrollDirection: Axis.horizontal,
                          //                                   physics: BouncingScrollPhysics(),
                          //                                   child: Text(
                          //                                     'القاهره',
                          //                                     style: TextStyle(fontSize: 12, color: Colors.white),
                          //                                   ),
                          //                                 )),
                          //                           ),
                          //                         ),
                          //
                          //                       ],
                          //                     ),
                          //                   ),
                          //
                          //                 ],
                          //               ),
                          //
                          //               const SizedBox(
                          //                 height: 10,
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //       ),
                          //
                          //       Padding(
                          //         padding: const EdgeInsets.symmetric(horizontal: 5),
                          //         child: Container(
                          //           //height: 200,
                          //           width: (Get.width/2)-15,
                          //           decoration: const BoxDecoration(
                          //               color: Colors.white,
                          //               borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          //               boxShadow: [
                          //                 BoxShadow(
                          //                   spreadRadius: 5,
                          //                   color: Color(0xffB7B6B6),
                          //                   blurRadius: 7,
                          //                   offset: Offset(0, 4),
                          //                 ),
                          //               ]),
                          //           child: Column(
                          //             // ignore: prefer_const_literals_to_create_immutables
                          //             children: [
                          //               Container(
                          //                 decoration: const BoxDecoration(
                          //                   color: Colors.white,
                          //                   borderRadius: BorderRadius.all(
                          //                       Radius.circular(15.0)),
                          //                 ),
                          //                 child: ClipRRect(
                          //                   borderRadius: const BorderRadius.only(
                          //                     topLeft: Radius.circular(15.0),
                          //                     bottomRight: Radius.circular(15.0),
                          //                     topRight: Radius.circular(15.0),
                          //                     bottomLeft: Radius.circular(15.0),
                          //                   ),
                          //                   child: Image.asset(
                          //                     'assets/images/test.png',
                          //                     fit: BoxFit.cover,
                          //                   ),
                          //                 ),
                          //               ),
                          //               const SizedBox(
                          //                 height: 8,
                          //               ),
                          //               Row(
                          //                 crossAxisAlignment: CrossAxisAlignment.start,
                          //                 children: [
                          //                   Padding(
                          //                     padding:
                          //                     const EdgeInsets.symmetric(horizontal: 5),
                          //                     child: Row(
                          //                       children: [
                          //                         SingleChildScrollView(
                          //                           scrollDirection: Axis.horizontal,
                          //                           physics: BouncingScrollPhysics(),
                          //                           child: const Text(
                          //                             "zacks",
                          //                             style: const TextStyle(fontSize: 18.0),
                          //                           ),
                          //                         ),
                          //                         const SizedBox(
                          //                           width: 2,
                          //                         ),
                          //                         const Icon(
                          //                           Icons.check_circle_outline,
                          //                           color: kPrimaryColor,
                          //                           size: 16,
                          //                         ),
                          //                       ],
                          //                     ),
                          //                   ),
                          //                   Padding(
                          //                     padding:
                          //                     const EdgeInsets.symmetric(horizontal: 10),
                          //                     child: Row(
                          //                       mainAxisAlignment: MainAxisAlignment.end,
                          //                       children: [
                          //                         RatingBar(
                          //                           rating: 4,
                          //                           icon: const Icon(
                          //                             Icons.star,
                          //                             size: 17,
                          //                             color: Colors.grey,
                          //                           ),
                          //                           starCount: 5,
                          //                           spacing: 1.0,
                          //                           size: 12,
                          //                           isIndicator: true,
                          //                           allowHalfRating: true,
                          //
                          //                           // onRatingCallback: (double value,ValueNotifier<bool> isIndicator){
                          //                           //   print('Number of stars-->  $value');
                          //                           //   isIndicator.value=true;
                          //                           // },
                          //                           color: Colors.amber,
                          //                         ),
                          //                       ],
                          //                     ),
                          //                   ),
                          //                 ],
                          //               ),
                          //               Row(
                          //                 crossAxisAlignment: CrossAxisAlignment.end,
                          //                 mainAxisAlignment: MainAxisAlignment.end,
                          //                 children: [
                          //                   SingleChildScrollView(
                          //                     scrollDirection: Axis.horizontal,
                          //                     physics: BouncingScrollPhysics(),
                          //                     child: const Text(
                          //                       'القاهره الجديده -القاهره -مصر',
                          //                       style: TextStyle(
                          //                           fontSize: 14,
                          //                           color: Colors.grey),
                          //                     ),
                          //                   ),
                          //                 ],
                          //               ),
                          //               SizedBox(
                          //                 height: 5,
                          //               ),
                          //               Row(
                          //                 children: [
                          //                   SizedBox(
                          //                     width: 30,
                          //                   ),
                          //                   Padding(
                          //                     padding: const EdgeInsets.symmetric(horizontal: 5),
                          //                     child: const Icon(
                          //                       Icons.stars_rounded,
                          //                       color: Colors.amber,
                          //                       size: 20,
                          //                     ),
                          //                   ),
                          //                   Padding(
                          //                     padding: const EdgeInsets.symmetric(horizontal: 5),
                          //                     child: Row(
                          //                       crossAxisAlignment: CrossAxisAlignment.center,
                          //                       mainAxisAlignment: MainAxisAlignment.end,
                          //                       children: [
                          //                         GestureDetector(
                          //                           onTap: () {
                          //                             print('15km');
                          //                           },
                          //                           child: Container(
                          //                             width: 50,
                          //                             height: 20,
                          //                             decoration: const BoxDecoration(
                          //                               color: Color(0xff848DFF),
                          //                               borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          //                             ),
                          //                             child: const Center(
                          //                                 child: SingleChildScrollView(
                          //                                   scrollDirection: Axis.horizontal,
                          //                                   physics: BouncingScrollPhysics(),
                          //                                   child: Text(
                          //                                     '15Km',
                          //                                     style: TextStyle(fontSize: 12, color: Colors.white),
                          //                                   ),
                          //                                 )),
                          //                           ),
                          //                         ),
                          //                         const SizedBox(
                          //                           width: 5,
                          //                         ),
                          //                         GestureDetector(
                          //                           onTap: () {
                          //                             print('القاهره');
                          //                           },
                          //                           child: Container(
                          //                             width: 50,
                          //                             height: 20,
                          //                             decoration: const BoxDecoration(
                          //                               gradient: kAdsHomeGradient,
                          //                               borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          //                             ),
                          //                             child: const Center(
                          //                                 child: SingleChildScrollView(
                          //                                   scrollDirection: Axis.horizontal,
                          //                                   physics: BouncingScrollPhysics(),
                          //                                   child: Text(
                          //                                     'القاهره',
                          //                                     style: TextStyle(fontSize: 12, color: Colors.white),
                          //                                   ),
                          //                                 )),
                          //                           ),
                          //                         ),
                          //
                          //                       ],
                          //                     ),
                          //                   ),
                          //
                          //                 ],
                          //               ),
                          //
                          //               SizedBox(
                          //                 height: 10,
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: GridView.count(
                              crossAxisCount: 2,
                              childAspectRatio: (itemWidth / itemHeight),
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 8,
                              controller:
                                  ScrollController(keepScrollOffset: false),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              children: _buildGridTileList(
                                  count: snapshot.data!.banner!.length,
                                  bn: snapshot.data),
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                } else if (snapshot.hasError) {
                  // return SizedBox(
                  //   height: Get.height,
                  //   child: Center(child: Text('${snapshot.error}')),
                  // );
                  return Container(
                    height: Get.height * 0.8,
                    child: Center(
                      child: ShowMessageEmtyDialog(
                        message: 'snapshot.error',
                        pathImg: 'assets/images/noAds.jpg',
                      ),
                    ),
                  );
                } else {
                  return SizedBox(
                      height: Get.height,
                      child: Center(
                          child: CircularProgressIndicator(
                        backgroundColor: kPrimaryColor,
                      )));
                }
              }),
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

  List<Widget> _buildGridTileList({
    int? count,
    Special_Ads_Data? bn,
  }) =>
      List.generate(
          count!,
          (i) => ZoomIn(
              duration: Duration(milliseconds: 600),
              delay: Duration(milliseconds: i * 100 > 1000 ? 600 : i * 120),
              child: BuildCart(bn!.banner![i])));

  Widget BuildCart(bn) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: GestureDetector(
        onTap: () {
          Get.to(ResturantPageScreen(
            flagBranch: false,
            compaine_id: bn.company_id,
            ad_id: bn.id,
          ));
        },
        child: Container(
          //height: 220,
          width: (Get.width / 2) - 15,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              boxShadow: [
                BoxShadow(
                  spreadRadius: 1,
                  color: Color(0xffe6e6e4),
                  blurRadius: 1,
                  offset: Offset(0, 2),
                ),
                // BoxShadow(
                //   spreadRadius: 5,
                //   color: Color(0xffB7B6B6),
                //   blurRadius: 7,
                //   offset: Offset(0, 4),
                // ),
              ]),
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.3),
                      width: 0.4,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                      bottomLeft: Radius.circular(15.0),
                    ),
                    child: Image.network(
                      bn.image != null ? '$ImgUrl${bn.image}' : defaultImgUrl,
                      fit: BoxFit.fill,
                      height: 135,
                      width: 165,
                      //width: Get.width,
                    ),
                  ),
                ),
              ),
              // const SizedBox(
              //   height: 8,
              // ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        Container(
                          width: (Get.width / 2) - 55,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            child: Text(
                              '${bn.name} ',
                              style: const TextStyle(fontSize: 17.0),
                            ),
                          ),

                          // Container(
                          //   height: 20,
                          //   child: Marquee(
                          //     text: '${bn.name}',
                          //     style: TextStyle(fontSize: 16.0),
                          //     scrollAxis: Axis.horizontal,
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     blankSpace: 15.0,
                          //     velocity: 10.0,
                          //     pauseAfterRound: Duration(seconds: 2),
                          //     startPadding: 5.0,
                          //     accelerationDuration: Duration(seconds: 2),
                          //     accelerationCurve: Curves.linear,
                          //     decelerationDuration: Duration(milliseconds: 700),
                          //     decelerationCurve: Curves.easeOut,
                          //   ),
                          // ),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        const Icon(
                          Icons.check_circle_outline,
                          color: kPrimaryColor,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // RatingBar(
                    //   rating: bn.total_rating.toDouble(),
                    //   icon: const Icon(
                    //     Icons.star,
                    //     size: 17,
                    //     color: Colors.grey,
                    //   ),
                    //   starCount: 5,
                    //   spacing: 1.0,
                    //   size: 12,
                    //   isIndicator: true,
                    //   allowHalfRating: true,
                    //   color: Colors.amber,
                    // ),
                  ],
                ),
              ),

              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   physics: BouncingScrollPhysics(),
              //   child: Text(
              //     bn.address,
              //     style: TextStyle(fontSize: 12, color: Colors.grey),
              //   ),
              // ),
              SizedBox(
                height: 2,
              ),
              Container(
                height: 20,
                child: Marquee(
                  text: bn.address,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                  scrollAxis: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  blankSpace: 20.0,
                  velocity: 10.0,
                  pauseAfterRound: Duration(seconds: 2),
                  startPadding: 5.0,
                  accelerationDuration: Duration(seconds: 2),
                  accelerationCurve: Curves.linear,
                  decelerationDuration: Duration(milliseconds: 700),
                  decelerationCurve: Curves.easeOut,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: const Icon(
                      Icons.stars_rounded,
                      color: Colors.amber,
                      size: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (bn.distance != null)
                          Container(
                            width: 50,
                            height: 20,
                            decoration: const BoxDecoration(
                              color: Color(0xff848DFF),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            child: Center(
                                child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              child: Text(
                                bn.distance,
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                            )),
                          )
                        else
                          SizedBox(),
                        const SizedBox(
                          width: 5,
                        ),
                        if (bn.city != null)
                          Container(
                            width: 50,
                            height: 20,
                            decoration: const BoxDecoration(
                              gradient: kAdsHomeGradient,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            child: Center(
                                child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              child: Text(
                                bn.city,
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                            )),
                          )
                        else
                          SizedBox(),
                        if (bn.visit_count != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color(0xffF5F5F5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                // border: Border.all(
                                //   color: Colors.grey.withOpacity(0.3),
                                //   width: 0.4,
                                // ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 2, vertical: 2),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    const Icon(MdiIcons.eye, size: 15, color: Color(0xff01B2CB)),

                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      bn.visit_count > 999
                                          ? '${bn.visit_count / 1000}K'
                                          : bn.visit_count > 999999
                                              ? '${bn.visit_count / 1000000}M'
                                              : '${bn.visit_count}',
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.black),
                                    ),
                                  ],
                                ),
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

              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
