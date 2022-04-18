import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/screens/home_page/all_resturants/resturants_screen.dart';
import 'package:al_murafiq/screens/home_page/categories/categories_screen.dart';
import 'package:al_murafiq/screens/home_page/company/resturant_page_screen.dart';
import 'package:al_murafiq/screens/home_page/search/search_bloc.dart';
import 'package:al_murafiq/screens/notification/notification_bloc.dart';
import 'package:al_murafiq/widgets/build_card.dart';
import 'package:al_murafiq/widgets/build_categiro.dart';
import 'package:al_murafiq/widgets/build_comment.dart';
import 'package:al_murafiq/widgets/build_last_addtion.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:al_murafiq/constants.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:al_murafiq/widgets/app_bar_home.dart';
import 'package:get_it/get_it.dart';
import 'package:al_murafiq/screens/home_page/home_page_bloc.dart';
import 'package:al_murafiq/models/home_page.dart';
import 'package:al_murafiq/components/firebase_notifications.dart';
import 'package:new_version/new_version.dart';

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final HomePageBloc _bloc = HomePageBloc();
  final SearchBloc _blocSearch = SearchBloc();
  NotificationBloc _notificationBloc = NotificationBloc();

  // final List<String> imageList = [
  //   'https://cdn.pixabay.com/photo/2016/03/05/19/02/hamburger-1238246__480.jpg',
  //   'https://cdn.pixabay.com/photo/2016/11/20/09/06/bowl-1842294__480.jpg',
  //   'https://cdn.pixabay.com/photo/2017/01/03/11/33/pizza-1949183__480.jpg',
  //   'https://cdn.pixabay.com/photo/2017/02/03/03/54/burger-2034433__480.jpg',
  // ];

  @override
  void initState() {
    _bloc.fetchDataHome();

    // getLocation();
    getCheckUpdade();
    super.initState();
  }

  Future<void> getLocation() async {
    try {
      print('getttt location');

      LocationPermission permission = await Geolocator.requestPermission();
      print('location enabled: $permission');
      print(permission);
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        print('get location');
        print(position);
        print(position);
        await helper.setLng(position.longitude);
        await helper.setLat(position.latitude);
      } else {
        await helper.setLng(0.0);
        await helper.setLat(0.0);
      }

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

  Future<void> getCheckUpdade() async {
    print('eeeeeeeeeeeeee');
    // Instantiate NewVersion manager object (Using GCP Console app as example)
    final newVersion = NewVersion(
      iOSId: 'io.krito.al_murafiq',
      androidId: 'io.krito.al_murafiq',
      context: context,

    );

    // You can let the plugin handle fetching the status and showing a dialog,
    // or you can fetch the status and display your own dialog, or no dialog.
    const simpleBehavior = true;

    if (simpleBehavior) {

      basicStatusCheck(newVersion);
    } else {
      advancedStatusCheck(newVersion);
    }
  }

  basicStatusCheck(NewVersion newVersion) {
    newVersion.showAlertIfNecessary();
  }

  advancedStatusCheck(NewVersion newVersion) async {
    final status = await newVersion.getVersionStatus();
    if (status != null) {
      // debugPrint(status.releaseNotes);
      print('eeeeeeeeeeeeee');
      print(status.appStoreLink);
      print(status.localVersion);
      print(status.storeVersion);
      print(status.canUpdate.toString());
      newVersion.showUpdateDialog(
          // context: context,
          // versionStatus: status,
          // dialogTitle: 'Custom Title',
          // dialogText: 'Custom Text',
          VersionStatus(
              canUpdate: status.canUpdate,
              localVersion: status.localVersion,
              storeVersion: status.storeVersion,
          )

      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey.shade300,
      body: RefreshIndicator(
        onRefresh: () async {
          await _bloc.fetchDataHome();
          return Future.delayed(const Duration(milliseconds: 400));
        },
        child: SingleChildScrollView(
          child: StreamBuilder<HomePageData>(
              stream: _bloc.homeDataSubject.stream,
              builder: (context, snapshotHomee) {
                if (snapshotHomee.hasData) {
                  return Column(
                    children: [
                      AppBarHome(),
                      StreamBuilder<String>(
                          stream: Stream.fromFuture(getIsLogIn()),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data.isNotEmpty) {
                                FirebaseNotifications().configFcm();
                                _notificationBloc.fetchNumberOfNotifications();
                              }
                              return SizedBox();
                            } else {
                              return SizedBox();
                            }
                          }),
                      StreamBuilder<int>(
                          stream: Stream.fromFuture(getActiveAccount()),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              print('sas ${snapshot.data}');
                              if (snapshot.data == 0) {
                                return StreamBuilder<String>(
                                    stream:
                                        Stream.fromFuture(getMessageActive()),
                                    builder: (context, snapshotMessageActive) {
                                      if (snapshotMessageActive.hasData) {
                                        print(
                                            'wwe ${snapshotMessageActive.data}');
                                        if (snapshotMessageActive
                                            .data.isNotEmpty) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: Text(
                                              // ignore: unnecessary_string_interpolations
                                              '${snapshotMessageActive.data}',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.red),
                                            ),
                                          );
                                        }
                                        return SizedBox();
                                      } else {
                                        return SizedBox();
                                      }
                                    });
                              }
                              return SizedBox();
                            } else {
                              return SizedBox();
                            }
                          }),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      StreamBuilder<bool>(
                          stream: _blocSearch.searchSubject.stream,
                          initialData: true,
                          builder: (context, snapshot) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
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
                                          style:
                                              kTextStyle.copyWith(fontSize: 18),
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
                                                  _blocSearch.searchController
                                                          .text.isEmpty
                                                      ? null
                                                      : Get.to(ResturantsScreen(
                                                          bloc: _blocSearch,
                                                          subCategoriesID: 1,
                                                          targert: 2,
                                                        ));
                                                },
                                                child: const Icon(
                                                  Icons.search,
                                                  size: 35,
                                                ),
                                              ),
                                            ),
                                            hintText: 'search'.tr,
                                            // errorText:
                                            // snapshot.data ? null : context.translate('search_error'),
                                            contentPadding:
                                                const EdgeInsets.only(
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          height: Get.height * 0.5,
                          width: Get.width,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 2,
                                  color: Color(0xffe6e6e4),
                                  blurRadius: 5,
                                  offset: Offset(0, 2),
                                ),
                              ]),
                          child: Column(
                            children: [
                              SizedBox(
                                height: Get.height * 0.005,
                              ),
                              StreamBuilder<HomePageData>(
                                  stream: _bloc.homeDataSubject.stream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data.slider.length > 0) {
                                        return SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: List.generate(
                                                snapshot.data.slider.length,
                                                (index) {
                                              return ZoomIn(
                                                duration:
                                                    Duration(milliseconds: 600),
                                                delay: Duration(
                                                    milliseconds:
                                                        index * 100 > 1000
                                                            ? 600
                                                            : index * 120),
                                                child: BuildSlider(
                                                  slider: snapshot
                                                      .data.slider[index],
                                                ),
                                              );
                                            }),
                                          ),
                                        );
                                      } else if (snapshot.data.slider.isEmpty) {
                                        return SizedBox(
                                          height: Get.height * 0.32,
                                        );
                                      } else {
                                        return SizedBox(
                                          height: Get.height * 0.32,
                                        );
                                      }
                                    } else {
                                      //return SizedBox();
                                      return Container(
                                        height: 220,
                                        child: Center(
                                            child: CircularProgressIndicator(
                                          backgroundColor: kPrimaryColor,
                                        )),
                                      );
                                    }
                                  }),
                              _bloc.homeDataSubject.value.slider.length > 2
                                  ? const Icon(
                                      FontAwesomeIcons.arrowsAltH,
                                      color: Colors.grey,
                                      size: 15,
                                    )
                                  : SizedBox(),
                              const SizedBox(
                                height: 8,
                              ),
                              StreamBuilder<HomePageData>(
                                  stream: _bloc.homeDataSubject.stream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data.categories.length > 0) {
                                        return SizedBox(
                                          height: Get.height * 0.08,
                                          child: ListView.builder(
                                            physics: ClampingScrollPhysics(),
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                snapshot.data.categories.length,
                                            itemBuilder: (BuildContext context,
                                                    int index) =>
                                                ZoomIn(
                                              duration:
                                                  Duration(milliseconds: 600),
                                              delay: Duration(
                                                  milliseconds:
                                                      index * 100 > 1000
                                                          ? 600
                                                          : index * 120),
                                              child: BulidCategiro(
                                                name: snapshot.data
                                                    .categories[index].name,
                                                id: snapshot
                                                    .data.categories[index].id,
                                                image: snapshot.data
                                                    .categories[index].image,
                                                color: snapshot.data
                                                    .categories[index].color,
                                              ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        return SizedBox();
                                      }
                                    } else
                                      return Container(
                                          height: 55,
                                          child: Center(
                                              child:
                                                  CircularProgressIndicator()));
                                  }),
                              const SizedBox(
                                height: 5,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Get.to(CategoriesScreen());
                                  },
                                  child: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.grey,
                                  )),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      StreamBuilder<HomePageData>(
                          stream: _bloc.homeDataSubject.stream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data.banner.length > 0) {
                                return Container(
                                  color: Colors.transparent,
                                  height: Get.height * 0.24,
                                  //width: Get.width,
                                  child: Swiper(
                                    // pagination:  SwiperPagination(margin: EdgeInsets.only(right: 250,top: 1),),

                                    pagination: SwiperPagination(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 1),
                                        alignment: Alignment.topCenter,
                                        builder: SwiperCustomPagination(builder:
                                            (BuildContext context,
                                                SwiperPluginConfig config) {
                                          return ConstrainedBox(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 35),
                                              // ignore: avoid_unnecessary_containers
                                              child: Container(
                                                  //color: Colors.white,
                                                  child: Column(
                                                children: [
                                                  Expanded(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: const DotSwiperPaginationBuilder(
                                                              color:
                                                                  Colors.grey,
                                                              activeColor:
                                                                  kPrimaryColor,
                                                              size: 6.0,
                                                              activeSize: 10.0)
                                                          .build(
                                                              context, config),
                                                    ),
                                                  )
                                                ],
                                              )),
                                            ),
                                            constraints:
                                                const BoxConstraints.expand(
                                                    height: 20.0),
                                          );
                                        })),
                                    autoplay: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        child: BuildCard(
                                          bannerData:
                                              snapshot.data.banner[index],
                                        ),
                                      );
                                    },
                                    itemCount: snapshot.data.banner.length,
                                    //itemWidth: 100.0,
                                    //autoplayDelay: 3000,
                                    onTap: (int index) {
                                      Get.to(ResturantPageScreen(
                                        flagBranch: false,
                                        compaine_id: snapshot
                                            .data.banner[index].company_id,
                                        ad_id: snapshot.data.banner[index].id,
                                      ));
                                    },

                                    loop: true,
                                    layout: SwiperLayout.DEFAULT,
                                  ),
                                );
                              } else {
                                return SizedBox();
                              }
                            } else {
                              //return SizedBox();
                              return Container(
                                height: Get.height * 0.22,
                                child: Center(
                                    child: CircularProgressIndicator(
                                  backgroundColor: kPrimaryColor,
                                )),
                              );
                            }
                          }),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Stack(
                        children: [
                          Positioned(
                            right: 10,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 25, right: 25, bottom: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    physics: BouncingScrollPhysics(),
                                    child: Text(
                                      'text_last_company'.tr,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          StreamBuilder<HomePageData>(
                              stream: _bloc.homeDataSubject.stream,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data.latest_companies.length >
                                      0) {
                                    return Container(
                                      color: Colors.transparent,
                                      height: Get.height * 0.28,
                                      //width: Get.width,
                                      child: Swiper(
                                        // pagination:  SwiperPagination(margin: EdgeInsets.only(right: 250,top: 1),),

                                        pagination: SwiperPagination(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 1),
                                            alignment: Alignment.topCenter,
                                            builder: SwiperCustomPagination(
                                                builder: (BuildContext context,
                                                    SwiperPluginConfig config) {
                                              return ConstrainedBox(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 35),
                                                  // ignore: avoid_unnecessary_containers
                                                  child: Container(
                                                      //color: Colors.white,
                                                      child: Column(
                                                    children: [
                                                      Expanded(
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: const DotSwiperPaginationBuilder(
                                                                  color: Colors
                                                                      .grey,
                                                                  activeColor:
                                                                      kPrimaryColor,
                                                                  size: 6.0,
                                                                  activeSize:
                                                                      10.0)
                                                              .build(context,
                                                                  config),
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                                ),
                                                constraints:
                                                    const BoxConstraints.expand(
                                                        height: 20.0),
                                              );
                                            })),
                                        autoplay: true,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15),
                                            child: BuildLastAddtion(
                                              textDirection: TextDirection.rtl,
                                              latestCompaniesData: snapshot
                                                  .data.latest_companies[index],
                                            ),
                                          );
                                        },
                                        itemCount: snapshot
                                            .data.latest_companies.length,
                                        //itemWidth: 100.0,
                                        //autoplayDelay: 3000,
                                        onTap: (int index) {
                                          Get.to(ResturantPageScreen(
                                            flagBranch: false,
                                            compaine_id: snapshot.data
                                                .latest_companies[index].id,
                                            ad_id: 0,
                                          ));
                                        },

                                        loop: true,
                                        layout: SwiperLayout.DEFAULT,
                                      ),
                                    );
                                  } else {
                                    return SizedBox();
                                  }
                                } else {
                                  //return SizedBox();
                                  return Container(
                                    height: Get.height * 0.25,
                                    child: Center(
                                        child: CircularProgressIndicator(
                                      backgroundColor: kPrimaryColor,
                                    )),
                                  );
                                }
                              }),
                        ],
                      ),
                      Stack(
                        children: [
                          Positioned(
                            right: 10,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 25, right: 25, bottom: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    physics: BouncingScrollPhysics(),
                                    child: Text(
                                      'text_review'.tr,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          StreamBuilder<HomePageData>(
                              stream: _bloc.homeDataSubject.stream,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data.reviews.length > 0) {
                                    return Container(
                                      color: Colors.transparent,
                                      height: Get.height * 0.24,
                                      //width: Get.width,
                                      child: Swiper(
                                        // pagination: SwiperPagination(
                                        //   margin: EdgeInsets.only(right: 250, top: 1),
                                        // ),
                                        pagination: SwiperPagination(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 1),
                                            alignment: Alignment.topCenter,
                                            builder: SwiperCustomPagination(
                                                builder: (BuildContext context,
                                                    SwiperPluginConfig config) {
                                              return ConstrainedBox(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 35),
                                                  // ignore: avoid_unnecessary_containers
                                                  child: Container(
                                                      //color: Colors.white,
                                                      child: Column(
                                                    children: [
                                                      Expanded(
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: const DotSwiperPaginationBuilder(
                                                                  color: Colors
                                                                      .grey,
                                                                  activeColor:
                                                                      kPrimaryColor,
                                                                  size: 6.0,
                                                                  activeSize:
                                                                      10.0)
                                                              .build(context,
                                                                  config),
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                                ),
                                                constraints:
                                                    const BoxConstraints.expand(
                                                        height: 20.0),
                                              );
                                            })),
                                        autoplay: true,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: BuildComment(
                                              textDirection: TextDirection.rtl,
                                              reviewsData:
                                                  snapshot.data.reviews[index],
                                            ),
                                          );
                                        },
                                        itemCount: snapshot.data.reviews.length,
                                        //itemWidth: 100.0,
                                        autoplayDelay: 4000,
                                        onTap: (int index) {
                                          Get.to(ResturantPageScreen(
                                            flagBranch: false,
                                            compaine_id: snapshot
                                                .data.reviews[index].company.id,
                                            ad_id: 0,
                                          ));
                                        },

                                        loop: true,
                                        layout: SwiperLayout.DEFAULT,
                                      ),
                                    );
                                  } else {
                                    return SizedBox();
                                  }
                                } else {
                                  //return SizedBox();
                                  return SizedBox(
                                    height: Get.height * 0.22,
                                    child: Center(
                                        child: CircularProgressIndicator(
                                      backgroundColor: kPrimaryColor,
                                    )),
                                  );
                                }
                              }),
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                    ],
                  );
                } else if (snapshotHomee.hasError) {
                  return Container(
                    height: Get.height,
                    child: Center(
                      child: Text('${snapshotHomee.error}'),
                    ),
                  );
                } else {
                  return Container(
                    height: Get.height,
                    child: const Center(
                        child: CircularProgressIndicator(
                      backgroundColor: kPrimaryColor,
                    )),
                  );
                }
              }),
        ),
      ),
    );
  }

  SharedPreferenceHelper helper = GetIt.instance.get<SharedPreferenceHelper>();

  Future<String> getIsLogIn() async {
    return await helper.getToken();
  }

  Future<String> getMessageActive() async {
    return await helper.getActivationMessage();
  }

  Future<int> getActiveAccount() async {
    return await helper.getActive();
  }
}

class BuildSlider extends StatelessWidget {
  final SliderData slider;

  const BuildSlider({Key key, this.slider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: GestureDetector(
        onTap: () {
          Get.to(ResturantPageScreen(
            flagBranch: false,
            compaine_id: slider.company_id,
            ad_id: slider.id,
          ));
        },
        child: Stack(
          children: [
            Container(
              height: Get.height * 0.32,
              width: (Get.width / 2) - 20,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 1,
                      color: Color(0xffe6e6e4),
                      blurRadius: 1,
                      offset: Offset(0, 2),
                    ),
                  ]),
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
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
                        '$ImgUrl${slider.image}',
                        fit: BoxFit.fill,
                        height: 135,
                        width: 165,
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          children: [
                            Container(
                              width: (Get.width / 2) - 55,
                              child:
                                  // Marquee(
                                  //     text: "zacks",
                                  //     style: const TextStyle(fontSize: 18.0)),
                                  SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                physics: BouncingScrollPhysics(),
                                child: Text(
                                  slider.name,
                                  style: const TextStyle(fontSize: 16.0),
                                  //overflow: TextOverflow.ellipsis,
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
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RatingBar(
                          rating: slider.total_rating.toDouble(),
                          icon: const Icon(
                            Icons.star,
                            size: 17,
                            color: Colors.grey,
                          ),
                          starCount: 5,
                          spacing: 1.0,
                          size: 12,
                          isIndicator: true,
                          allowHalfRating: true,
                          color: Color(0xffFFAC41),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    child: Text(
                      slider.address,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (slider.distance != null)
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
                                slider.distance,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            )),
                          )
                        else
                          SizedBox(),
                        const SizedBox(
                          width: 5,
                        ),
                        if (slider.city != null)
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
                                slider.city,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            )),
                          )
                        else
                          SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                right: 15,
                top: 10,
                child: Container(
                  width: 55,
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  child: Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${slider.total_rating.toStringAsFixed(1)}',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      const Icon(
                        Icons.star,
                        color: Color(0xffFFCC00),
                        size: 20,
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
