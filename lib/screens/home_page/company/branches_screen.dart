import 'dart:async';

import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/models/favorate.dart';
import 'package:al_murafiq/screens/home_page/all_resturants/resturants_screen.dart';
import 'package:al_murafiq/screens/home_page/company/profile_company_bloc.dart';
import 'package:al_murafiq/screens/home_page/company/resturant_page_screen.dart';
import 'package:al_murafiq/screens/home_page/favorate/favorate_bloc.dart';
import 'package:al_murafiq/screens/notification/notification_screen.dart';
import 'package:al_murafiq/widgets/build_card_branch.dart';
import 'package:al_murafiq/screens/home_page/search/search_bloc.dart';
import 'package:al_murafiq/widgets/show_check_login_dialog.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:readmore/readmore.dart';
import 'package:get_it/get_it.dart';
import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/screens/splash2/splash2.dart';
import 'package:al_murafiq/screens/home_page/company/branches_of_company_bloc.dart';
import 'package:al_murafiq/screens/home_page/company/add_branch_of_company_screen.dart';

import 'package:al_murafiq/models/branch.dart';
import 'package:al_murafiq/extensions/extensions.dart';

import 'edit_company/map_teat.dart';
class BranchesScreen extends StatefulWidget {
  @override
  _BranchesScreenState createState() => _BranchesScreenState();
}

class _BranchesScreenState extends State<BranchesScreen> {
  SearchBloc _blocSearch = SearchBloc();
  BranchesOfCompanyBloc _branchesOfCompanyBloc = BranchesOfCompanyBloc();
  @override
  void initState() {
    _branchesOfCompanyBloc.fetchDataOfBranchCompany();
    // TODO: implement initState
    super.initState();
  }
  SharedPreferenceHelper _helper = GetIt.instance.get<SharedPreferenceHelper>();
  dynamic lng=0.0;
  dynamic lat=0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(''),
        actions: [
          StreamBuilder<String>(
              stream: Stream.fromFuture(
                  getIsLogIn()),
              builder: (context,
                  snapshotToken) {

                if (snapshotToken
                    .hasData ) {

                  return  GestureDetector(
                    onTap: () {

                      Get.to(NotificationScreen());
                    },
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                          child: const Icon(
                            Icons.notifications,
                            size: 30,
                          ),
                        ),
                        StreamBuilder<int>(
                            stream: Stream.fromFuture(
                                getNumberOfNotfiction()),
                            builder: (context, snapshotNumNotif) {
                              if(snapshotNumNotif.hasData && snapshotNumNotif.data != 0){
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 2),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal:3,vertical: 0),
                                      child: Text('${snapshotNumNotif.data}',style: TextStyle(fontSize: 12),textAlign: TextAlign.center,),
                                    ),
                                  ),
                                );
                              }
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                                child: Container(),
                              );
                            }
                        ),
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
                      padding:  EdgeInsets.symmetric(horizontal: 8),
                      child:  Icon(
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
      floatingActionButton: FloatingActionButton(
          elevation: 0.0,
          child: Icon(
            Icons.add,
            size: 30,
            color: Color(0xffFFFFFF),
          ),
          backgroundColor: Color(0xff2E5BFF),
          onPressed: () async {
            // BackgroundLocation.getLocationUpdates((location) {
            //   lng = location.longitude;
            //   lat = location.latitude;
            // });


            // await Get.to(AddBranchOfCompanyScreen(lng: lng,lat: lat,beCompany: false,));
            await Get.to(AddBranchOfCompanyScreen(lng:await _helper.getLng(),lat: await _helper.getLat(),beCompany: false,));
            // await Get.to(MapTest());
          }),
      body: SingleChildScrollView(
        child: StreamBuilder<CompanyOfBranches>(
            stream: _branchesOfCompanyBloc.dataOfBranchCompanySubject.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    // StreamBuilder<Position>(
                    //     stream: Stream.fromFuture(_determinePosition()),
                    //     builder: (context, snapshot) {
                    //       print(snapshot.hasData);
                    //       print("locationnnnnnnnn");
                    //       if (snapshot.hasData && snapshot.data != null) {
                    //         print(snapshot.data.latitude);
                    //         return SizedBox();
                    //       }else if(snapshot.hasError){
                    //         return Text('${snapshot.hasError}');
                    //       }
                    //       return SizedBox();
                    //     }),
                    // StreamBuilder<bool>(
                    //     stream: _blocSearch.searchSubject.stream,
                    //     initialData: true,
                    //     builder: (context, snapshot) {
                    //       return Padding(
                    //         padding:
                    //             const EdgeInsets.symmetric(horizontal: 16.0),
                    //         child: Card(
                    //           elevation: 6,
                    //           //color: Colors.grey,
                    //           shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(15.0),
                    //           ),
                    //           shadowColor: Colors.grey,
                    //           child: Container(
                    //             decoration: const BoxDecoration(
                    //               color: Colors.white,
                    //               borderRadius:
                    //                   BorderRadius.all(Radius.circular(15.0)),
                    //             ),
                    //             child: TextFormField(
                    //               keyboardType: TextInputType.text,
                    //               onChanged: (val) =>
                    //                   _blocSearch.changeSearch(val),
                    //               controller: _blocSearch.searchController,
                    //               style: kTextStyle.copyWith(fontSize: 20),
                    //               decoration: InputDecoration(
                    //                 prefixIcon: Padding(
                    //                   padding: EdgeInsets.only(
                    //                     left: 5,
                    //                     right: 16,
                    //                     top: 0,
                    //                     bottom: 0,
                    //                   ),
                    //                   child: GestureDetector(
                    //                     onTap: () {
                    //                       _blocSearch
                    //                               .searchController.text.isEmpty
                    //                           ? null
                    //                           : Get.to(ResturantsScreen(
                    //                               bloc: _blocSearch,
                    //                               subCategoriesID: 1,
                    //                               targert: 2,
                    //                             ));
                    //                     },
                    //                     child: Icon(
                    //                       Icons.search,
                    //                       size: 35,
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 hintText: "Search",
                    //                 errorText: snapshot.data
                    //                     ? null
                    //                     : 'Search is not empty',
                    //                 contentPadding: EdgeInsets.only(
                    //                   left: 16,
                    //                   right: 16,
                    //                   top: 10,
                    //                   bottom: 10,
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       );
                    //     }),

                    BuildCardHeaderBranchComoany(
                      id: snapshot.data.id,
                      name: snapshot.data.name,
                      image: snapshot.data.image,
                      desc: snapshot.data.desc,
                      total_rating: snapshot.data.total_rating,
                      visit_count:  snapshot.data.visit_count,
                      active:  snapshot.data.active,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    snapshot.data.branch.length > 0
                        ? ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data.branch.length,
                            itemBuilder: (BuildContext context, int index) =>
                                ZoomIn(
                                  duration: Duration(milliseconds: 600),
                                  delay: Duration(
                                      milliseconds:
                                      index * 100 > 1000 ? 600 : index * 120),

                                  child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 0),
                              child: BuildCardBranch(
                                  branches: snapshot.data.branch[index],
                              ),
                            ),
                                ),
                          )
                        : SizedBox(),
                    // StreamBuilder<String>(
                    //     stream: Stream.fromFuture(getIsLogIn()),
                    //     builder: (context, snapshot) {
                    //       print(snapshot.hasData);
                    //       if (snapshot.hasData && snapshot.data != null) {
                    //         print('snap ' + snapshot.data);
                    //         return StreamBuilder<List<Favourate>>(
                    //             stream: _bloc.dataOfFavorateSubject.stream,
                    //             builder: (context, snapshot) {
                    //               print('wetrgfcx${snapshot.data}');
                    //               if (snapshot.hasData) {
                    //                 if (snapshot.data.length > 0) {
                    //                   return ListView.builder(
                    //                     physics: ClampingScrollPhysics(),
                    //                     shrinkWrap: true,
                    //                     scrollDirection: Axis.vertical,
                    //                     itemCount: snapshot.data.length,
                    //                     itemBuilder:
                    //                         (BuildContext context, int index) =>
                    //                             Padding(
                    //                       padding:
                    //                           const EdgeInsets.symmetric(vertical: 0),
                    //                       child: BuildCompanyCard(
                    //                         textDirection: TextDirection.rtl,
                    //                         favourate: snapshot.data[index],
                    //                       ),
                    //                     ),
                    //                   );
                    //                 } else {
                    //                   return SizedBox(
                    //                     height: Get.height,
                    //                     child: Center(child: Text('${snapshot.error}')),
                    //                   );
                    //                 }
                    //               } else if (snapshot.hasError) {
                    //                 return SizedBox(
                    //                   height: Get.height,
                    //                   child: Center(child: Text('${snapshot.error}')),
                    //                 );
                    //               } else {
                    //                 //return SizedBox();
                    //                 return SizedBox(
                    //                     height: Get.height,
                    //                     child: Center(
                    //                         child: CircularProgressIndicator(
                    //                       backgroundColor: kPrimaryColor,
                    //                     )));
                    //               }
                    //             });
                    //       } else {
                    //         return Container(
                    //           height: Get.height / 2,
                    //           child: Center(
                    //             child: Padding(
                    //               padding: const EdgeInsets.symmetric(vertical: 25),
                    //               child: FlatButton(
                    //                   height: 60,
                    //                   minWidth: Get.width - 100,
                    //                   child: Text('Login',
                    //                       style: kTextStyle.copyWith(fontSize: 25)),
                    //                   color: Colors.blue.shade800,
                    //                   textColor: Color(0xffFFFFFF),
                    //                   onPressed: () async {
                    //                     await Get.to(Splash2());
                    //                   },
                    //                   shape: new RoundedRectangleBorder(
                    //                       borderRadius:
                    //                           new BorderRadius.circular(30.0))),
                    //             ),
                    //           ),
                    //         );
                    //       }
                    //     }),
                  ],
                );
              } else if (snapshot.hasError) {
                return SizedBox(
                  height: Get.height,
                  child: Center(child: Text('${snapshot.error}')),
                );
              } else {
                //return SizedBox();
                return SizedBox(
                    height: Get.height,
                    child: Center(
                        child: CircularProgressIndicator(
                      backgroundColor: kPrimaryColor,
                    )));
              }
            }),
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
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }
    print('location # ${await Geolocator.getCurrentPosition()}');
    return await Geolocator.getCurrentPosition();
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}

class BuildCompanyCard extends StatefulWidget {
  final Favourate favourate;
  final TextDirection textDirection;

  BuildCompanyCard({Key key, this.favourate, this.textDirection})
      : super(key: key);

  @override
  _BuildCompanyCardState createState() => _BuildCompanyCardState();
}

class _BuildCompanyCardState extends State<BuildCompanyCard> {
  ProfileCompanyBloc profileCompaineBloc = ProfileCompanyBloc();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(ResturantPageScreen(compaine_id: widget.favourate.company_id,
            //snapshot.data.latest_companies[index].id,
          flagBranch: false,
          ad_id: 0,
            ));
      },
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            boxShadow: [
              BoxShadow(
                spreadRadius: 5,
                color: Color(0xffB7B6B6),
                blurRadius: 7,
                offset: Offset(0, 4),
              ),
            ]),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.3),
                          width: 0.4,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 70,
                        backgroundImage: NetworkImage(
                          widget.favourate.company.image != null
                              ? '$ImgUrl${widget.favourate.company.image}'
                              : '$defaultImgUrl',
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                children: [
                                  Container(
                                    width: (Get.width / 3) - 30,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      physics: BouncingScrollPhysics(),
                                      child: Text(
                                        widget.favourate.company.name,
                                        style:
                                            const TextStyle(fontSize: 18.0),
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
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  RatingBar(
                                    rating: widget
                                        .favourate.company.total_rating
                                        .toDouble(),
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

                                    // onRatingCallback: (double value,ValueNotifier<bool> isIndicator){

                                    //   isIndicator.value=true;
                                    // },
                                    color: Color(0xffFFAC41),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          child: ReadMoreText(
                            widget.favourate.company.desc,
                            trimLines: 3,
                            colorClickableText: Colors.black,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: '...${'read_more'.tr}',
                            trimExpandedText: '${'read_less'.tr}',
                            style: kTextStyle.copyWith(
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     const Icon(
                        //       Icons.location_on,
                        //       color: kAccentColor,
                        //     ),
                        //     const SizedBox(
                        //       width: 10,
                        //     ),
                        //     Expanded(
                        //       child: AutoSizeText(
                        //         address,
                        //         style:
                        //         const TextStyle(fontSize: 18, color: Colors.white),
                        //         softWrap: true,
                        //         maxFontSize: 18,
                        //         minFontSize: 16,
                        //       ),
                        //     )
                        //   ],
                        // ),
                        // FlatButton(
                        //   onPressed: onPress,
                        //   color: Colors.green,
                        //   padding: EdgeInsets.all(7),
                        //   shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(50)),
                        //   child: const Text(
                        //     "توكيل المحامي",
                        //     style: TextStyle(
                        //       color: Colors.white,
                        //       fontSize: 17,
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (widget.favourate.company.distance != null)
                      Container(
                        width: 50,
                        height: 20,
                        decoration: const BoxDecoration(
                          color: Color(0xff848DFF),
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child:  Center(
                            child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          child: Text(
                            widget.favourate.company.distance,
                            style:
                                TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        )),
                      ) else SizedBox(),
                    const SizedBox(
                      width: 8,
                    ),
                    if (widget.favourate.company.city != null)
                      Container(
                        width: 50,
                        height: 20,
                        decoration: const BoxDecoration(
                          gradient: kAdsHomeGradient,
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child:  Center(
                            child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          child: Text(
                            widget.favourate.company.city.name,
                            style:
                                TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        )),
                      ) else  SizedBox(),
                    const SizedBox(
                      width: 12,
                    ),
                    // const Padding(
                    //   padding: EdgeInsets.only(left: 10, right: 10),
                    //   child: Icon(
                    //     Icons.favorite,
                    //     size: 28,
                    //     color: Color(0xffEB1346),
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: StreamBuilder<String>(
                          stream: Stream.fromFuture(getIsLogIn()),
                          builder: (context, snapshotToken) {
                            if (snapshotToken.hasData) {
                              //  if(snapshot.data.fav == 0){
                              //   return Icon(Icons.favorite,color: Colors.grey[600],);
                              // }else if(snapshot.data.fav == 1){
                              //   return Icon(Icons.favorite,color: Color(0xffEB1346),);
                              // }
                              return StreamBuilder<int>(
                                  stream: profileCompaineBloc
                                      .favCompanySubject.stream,
                                  initialData: 1,
                                  builder: (context, snapshotfav) {
                                    if (snapshotfav.data == 0) {
                                      return GestureDetector(
                                          onTap: () async {
                                            await profileCompaineBloc
                                                .favCompany(widget
                                                    .favourate.company_id,context);
                                            // profileCompaineBloc
                                            //     .favCompanySubject.sink
                                            //     .add(1);
                                          },
                                          child: Icon(
                                            Icons.favorite,
                                            color: Colors.grey[600],
                                          ));
                                    } else if (snapshotfav.data == 1) {
                                      return GestureDetector(
                                          onTap: () async {
                                            await profileCompaineBloc
                                                .favDesCompany(widget
                                                    .favourate.company_id,context);

                                          },
                                          child: Icon(
                                            Icons.favorite,
                                            color: Color(0xffEB1346),
                                          ));
                                    }
                                    return Icon(
                                      Icons.favorite,
                                      color: Colors.grey[600],
                                    );
                                  });
                            } else {
                              return Icon(
                                Icons.favorite,
                                color: Colors.grey[600],
                              );
                            }
                          }),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SharedPreferenceHelper helper = GetIt.instance.get<SharedPreferenceHelper>();

  Future<String> getIsLogIn() async {

    return await helper.getToken();
  }
}
