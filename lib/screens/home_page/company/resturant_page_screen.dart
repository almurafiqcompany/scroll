import 'dart:io';

import 'package:al_murafiq/components/full_image_viewer.dart';
import 'package:al_murafiq/components/full_photo_view.dart';
import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/screens/home_page/company/pdf.dart';
import 'package:al_murafiq/screens/home_page/company/profile_company_bloc.dart';
import 'package:al_murafiq/screens/home_page/reviews/reviews_screen.dart';
import 'package:al_murafiq/screens/notification/notification_screen.dart';
import 'package:al_murafiq/widgets/pdfview.dart';
import 'package:al_murafiq/widgets/show_check_login_dialog.dart';
import 'package:al_murafiq/widgets/show_close_reason_alert.dart';
import 'package:al_murafiq/widgets/show_loading_alert.dart';
import 'package:al_murafiq/widgets/show_loading_dialog.dart';
import 'package:al_murafiq/widgets/social_circles.dart';
import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:readmore/readmore.dart';
import 'package:al_murafiq/models/profile_compaine.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:http/http.dart' as http;
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ResturantPageScreen extends StatefulWidget {
  final compaine_id;
  final bool? flagBranch;
  final int? ad_id;

  const ResturantPageScreen(
      {Key? key, this.compaine_id, this.flagBranch, this.ad_id})
      : super(key: key);

  @override
  _ResturantPageScreenState createState() => _ResturantPageScreenState();
}

class _ResturantPageScreenState extends State<ResturantPageScreen> {
  ProfileCompanyBloc _bloc = ProfileCompanyBloc();

  @override
  void initState() {
    _bloc.fetchDataProfileCompany(
        widget.compaine_id, widget.flagBranch!, widget.ad_id!, context);
    // TODO: implement initState
    super.initState();
  }

  // final List<String> imageList = [
  //   'https://cdn.pixabay.com/photo/2016/03/05/19/02/hamburger-1238246__480.jpg',
  //   'https://cdn.pixabay.com/photo/2016/11/20/09/06/bowl-1842294__480.jpg',
  //   'https://cdn.pixabay.com/photo/2017/01/03/11/33/pizza-1949183__480.jpg',
  //   'https://cdn.pixabay.com/photo/2017/02/03/03/54/burger-2034433__480.jpg',
  // ];
  var rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   // title: Text('text_resturant'.tr),
      //   title: Text(title),
      //   // title: Text(_bloc.dataOfProfileCompanySubject.value.category.name),
      //   actions: [
      //     StreamBuilder<String>(
      //         stream: Stream.fromFuture(getIsLogIn()),
      //         builder: (context, snapshotToken) {
      //           print(snapshotToken.hasData);
      //           if (snapshotToken.hasData) {
      //             return GestureDetector(
      //               onTap: () {
      //                 print('not');
      //                 Get.to(NotificationScreen());
      //               },
      //               child: Padding(
      //                 padding: const EdgeInsets.symmetric(horizontal: 8),
      //                 child: const Icon(
      //                   Icons.notifications,
      //                   size: 30,
      //                 ),
      //               ),
      //             );
      //           } else {
      //             return GestureDetector(
      //               onTap: () async {
      //                 await showModalBottomSheet<void>(
      //                   context: context,
      //                   builder: (BuildContext context) {
      //                     return ShowCheckLoginDialog();
      //                   },
      //                 );
      //               },
      //               child: const Padding(
      //                 padding: EdgeInsets.symmetric(horizontal: 8),
      //                 child: Icon(
      //                   Icons.notifications,
      //                   size: 30,
      //                 ),
      //               ),
      //             );
      //           }
      //         }),
      //   ],
      //   elevation: 0,
      //   flexibleSpace: Column(
      //     children: <Widget>[
      //       Flexible(
      //         child: Container(
      //           decoration: const BoxDecoration(
      //             gradient: LinearGradient(
      //               colors: <Color>[
      //                 Color(0xFF03317C),
      //                 Color(0xFF05B3D6),
      //               ],
      //             ),
      //           ),
      //         ),
      //       ),
      //       Container(
      //         width: double.maxFinite,
      //         height: 6,
      //         color: Colors.lime,
      //       ),
      //     ],
      //   ),
      // ),

      body: SingleChildScrollView(
        child: StreamBuilder<ProfileCompany>(
            stream: _bloc.dataOfProfileCompanySubject.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.11,
                      child: AppBar(
                        centerTitle: true,
                        // title: Text('text_resturant'.tr),
                        // title: Text(title),
                        title: Text("${snapshot.data!.category!.name}"),
                        actions: [
                          StreamBuilder<String>(
                              //stream: Stream.fromFuture(getIsLogIn()),
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
                                         //   stream: Stream.fromFuture(getNumberOfNotfiction()),
                                            builder:
                                                (context, snapshotNumNotif) {
                                              if (snapshotNumNotif.hasData &&
                                                  snapshotNumNotif.data != 0) {
                                                return Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 0,
                                                      vertical: 2),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.red
                                                          .withOpacity(0.8),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50.0),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 3,
                                                          vertical: 0),
                                                      child: Text(
                                                        '${snapshotNumNotif.data}',
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 4),
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
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8),
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                      child: Container(
                          //   margin: EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Color(0xffFFFFFF),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.grey.withOpacity(0.3),
                                          width: 0.4,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50.0)),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(50.0),
                                          bottomRight: Radius.circular(50.0),
                                          topRight: Radius.circular(50.0),
                                          bottomLeft: Radius.circular(50.0),
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.to(FullPhotoView(
                                              path: snapshot.data!.image != null
                                                  ? '$ImgUrl${snapshot.data!.image}'
                                                  : defaultImgUrl,
                                              type: PhotoType.Network,
                                            ));
                                          },
                                          child: Image.network(
                                            snapshot.data!.image != null
                                                ? '$ImgUrl${snapshot.data!.image}'
                                                : defaultImgUrl,
                                            fit: BoxFit.fitWidth,
                                            width: 110,
                                            height: 110,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Container(
                                    //   width: 100,
                                    //   height: 100,
                                    //   child: CircleAvatar(
                                    //     radius: 60,
                                    //
                                    //     backgroundImage: NetworkImage(
                                    //       snapshot.data.image != null
                                    //           ? '$ImgUrl${snapshot.data.image}'
                                    //           :
                                    //       'https://cdn.pixabay.com/photo/2017/02/03/03/54/burger-2034433__480.jpg',
                                    //
                                    //     ),
                                    //   ),
                                    // ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Text(
                                            '${snapshot.data!.name}',
                                            style: TextStyle(fontSize: 18.0),
                                          ),
                                        ),
                                        // Padding(
                                        //   padding: const EdgeInsets.symmetric(
                                        //       horizontal: 15),
                                        //   child: Row(
                                        //     // ignore: prefer_const_literals_to_create_immutables
                                        //     children: [
                                        //       Text(
                                        //         snapshot.data.name,
                                        //         style: TextStyle(
                                        //             fontSize: 18.0),
                                        //       ),
                                        //       const SizedBox(
                                        //         width: 2,
                                        //       ),
                                        //       const Icon(
                                        //         Icons.check_circle_outline,
                                        //         color: kPrimaryColor,
                                        //         size: 16,
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.location_on,
                                              color: Color(0xff6E7989),
                                              size: 16,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            if (snapshot.data!.location != null)
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 5),
                                                  child: Container(
                                                    width: Get.width / 2,
                                                    child: Text(
                                                      '${snapshot.data!.location}',
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            else
                                              SizedBox(),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Row(
                                            //crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    // RatingBar(
                                                    //   rating: snapshot
                                                    //       .data.total_rating
                                                    //       .toDouble(),
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

                                                    //   // onRatingCallback: (double value,ValueNotifier<bool> isIndicator){
                                                    //   //   isIndicator.value=true;
                                                    //   // },
                                                    //   color: Color(0xffFFAC41),
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.remove_red_eye,
                                                      color: Color(0xffFFAC41),
                                                      size: 18,
                                                    ),
                                                    SizedBox(
                                                      width: 3,
                                                    ),
                                                    SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      physics:
                                                          BouncingScrollPhysics(),
                                                      child: Text(
                                                        // '${snapshot.data.visit_count}',
                                                        snapshot.data
                                                                    !.visit_count >
                                                                999
                                                            ? '${snapshot.data!.visit_count / 1000}K'
                                                            : snapshot.data
                                                                        !.visit_count >
                                                                    999999
                                                                ? '${snapshot.data!.visit_count / 1000000}M'
                                                                : '${snapshot.data!.visit_count}',
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: Color(
                                                                0xffFFAC41)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              if (widget.flagBranch!)
                                                SizedBox()
                                              else
                                                StreamBuilder<String>(
                                                    //stream: Stream.fromFuture( getIsLogIn()),
                                                    builder: (context,
                                                        snapshotToken) {
                                                      if (snapshotToken
                                                              .hasData &&
                                                          snapshot.data !=
                                                              null) {
                                                        //  if(snapshot.data.fav == 0){
                                                        //   return Icon(Icons.favorite,color: Colors.grey[600],);
                                                        // }else if(snapshot.data.fav == 1){
                                                        //   return Icon(Icons.favorite,color: Color(0xffEB1346),);
                                                        // }
                                                        return StreamBuilder<
                                                                int>(
                                                            stream: _bloc
                                                                .favCompanySubject
                                                                .stream,
                                                            initialData: _bloc
                                                                .dataOfProfileCompanySubject
                                                                .value
                                                                .fav,
                                                            builder: (context,
                                                                snapshotfav) {
                                                              if (snapshotfav
                                                                      .data ==
                                                                  0) {
                                                                return GestureDetector(
                                                                    onTap:
                                                                        () async {
                                                                      await _bloc.favCompany(
                                                                          snapshot
                                                                              .data
                                                                              !.id!,
                                                                          context);
                                                                    },
                                                                    child: Icon(
                                                                      Icons
                                                                          .favorite_border_outlined,
                                                                      color: Colors
                                                                              .grey[
                                                                          600],
                                                                    ));
                                                              } else if (snapshotfav
                                                                      .data ==
                                                                  1) {
                                                                return GestureDetector(
                                                                    onTap:
                                                                        () async {
                                                                      // LoadingView();
                                                                      await _bloc.favDesCompany(
                                                                          snapshot
                                                                              .data
                                                                             ! .id!,
                                                                          context);
                                                                    },
                                                                    child: Icon(
                                                                      Icons
                                                                          .favorite,
                                                                      color: Color(
                                                                          0xffEB1346),
                                                                    ));
                                                              }
                                                              return Icon(
                                                                Icons
                                                                    .favorite_border_outlined,
                                                                color: Colors
                                                                    .grey[600],
                                                              );
                                                            });
                                                      } else {
                                                        return GestureDetector(
                                                          onTap: () async {
                                                            await showModalBottomSheet<
                                                                void>(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return ShowCheckLoginDialog();
                                                              },
                                                            );
                                                          },
                                                          child: Icon(
                                                            Icons
                                                                .favorite_border_outlined,
                                                            color: Colors
                                                                .grey[600],
                                                          ),
                                                        );
                                                      }
                                                    }),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              if (widget.flagBranch!)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      StreamBuilder<File>(
                                          stream: _bloc.fileController.stream,
                                          initialData: null,
                                          builder: (context, snapshotFile) {
                                            if (snapshotFile.hasData &&
                                                snapshotFile.data != null) {
                                              return Center(
                                                child: Container(
                                                  height: 100,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: kAccentColor
                                                          .withOpacity(0.6),
                                                      width: 2,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                  ),
                                                  child: Stack(
                                                    fit: StackFit.expand,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25),
                                                        child: Image.asset(
                                                          'assets/images/pdf.png',
                                                          fit: BoxFit.fill,
                                                          color: Colors.grey
                                                              .withOpacity(0.7),
                                                        ),
                                                      ),
                                                      StreamBuilder<bool>(
                                                          stream: _bloc
                                                              .loadFileSubject
                                                              .stream,
                                                          builder: (context,
                                                              snapshotLaodPdf) {
                                                            if (snapshotLaodPdf
                                                                .hasData) {
                                                              return Center(
                                                                child:
                                                                    GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    _bloc
                                                                        .loadFileSubject
                                                                        .sink
                                                                        .add(
                                                                            null!);
                                                                    try {
                                                                       FilePickerResult?
                                                                          res =
                                                                          await FilePicker.platform.pickFiles(
                                                                              type: FileType.custom,
                                                                              allowedExtensions: [
                                                                            'pdf'
                                                                          ]);
                                                                      File? pdfFile = res !=
                                                                              null
                                                                          ? File(res
                                                                              .files
                                                                              .single
                                                                              .path!)
                                                                          : null;

                                                                      if (pdfFile !=
                                                                          null) {
                                                                        _bloc
                                                                            .fileController
                                                                            .sink
                                                                            .add(pdfFile);
                                                                        await _bloc.uploadFile(
                                                                            companyId: snapshot
                                                                                .data!.id,
                                                                            type:
                                                                                'pdf',
                                                                            context:
                                                                                context);
                                                                      }
                                                                    } catch (e) {
                                                                      print(e
                                                                          .toString());
                                                                    }
                                                                  },
                                                                  child: Card(
                                                                    elevation:
                                                                        0,
                                                                    margin: EdgeInsets
                                                                        .all(0),
                                                                    shape:
                                                                        CircleBorder(),
                                                                    color: kAccentColor
                                                                        .withOpacity(
                                                                            0.6),
                                                                    child: Padding(
                                                                        padding: EdgeInsets.all(8),
                                                                        child: Icon(
                                                                          MdiIcons
                                                                              .filePdf,
                                                                          color:
                                                                              Colors.white,
                                                                          size:
                                                                              32,
                                                                        )),
                                                                  ),
                                                                ),
                                                              );
                                                            } else {
                                                              return SizedBox(
                                                                  child: Center(
                                                                      child:
                                                                          CircularProgressIndicator(
                                                                backgroundColor:
                                                                    kPrimaryColor,
                                                              )));
                                                            }
                                                          }),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            } else {
                                              return Center(
                                                child: Container(
                                                  height: 100,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: kAccentColor
                                                          .withOpacity(0.6),
                                                      width: 2,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                  ),
                                                  child: Center(
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        try {
                                                          FilePickerResult? res =
                                                              await FilePicker
                                                                  .platform
                                                                  .pickFiles(
                                                                      type: FileType
                                                                          .custom,
                                                                      allowedExtensions: [
                                                                'pdf'
                                                              ]);
                                                          File? pdfFile =
                                                              res != null
                                                                  ? File(res
                                                                      .files
                                                                      .single
                                                                      .path!)
                                                                  : null;

                                                          if (pdfFile != null) {
                                                            _bloc.fileController
                                                                .sink
                                                                .add(pdfFile);
                                                            await _bloc
                                                                .uploadFile(
                                                                    companyId:
                                                                        snapshot
                                                                            .data
                                                                            !.id,
                                                                    type: 'pdf',
                                                                    context:
                                                                        context);
                                                          }
                                                        } catch (e) {
                                                          print(e.toString());
                                                        }
                                                      },
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Card(
                                                            elevation: 0,
                                                            margin:
                                                                EdgeInsets.all(
                                                                    0),
                                                            shape:
                                                                CircleBorder(),
                                                            color: kAccentColor
                                                                .withOpacity(
                                                                    0.6),
                                                            child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(8),
                                                                child: Icon(
                                                                  MdiIcons
                                                                      .filePdf,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 32,
                                                                )),
                                                          ),
                                                          SizedBox(
                                                            height: 2,
                                                          ),
                                                          AutoSizeText(
                                                            'text_select_Pdf'
                                                                .tr,
                                                            style: kTextStyle,
                                                            softWrap: true,
                                                            maxFontSize: 18,
                                                            minFontSize: 16,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                          }),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      // Expanded(
                                      //   child: SingleChildScrollView(
                                      //     scrollDirection: Axis.horizontal,
                                      //     physics: BouncingScrollPhysics(),
                                      //     child: Text(
                                      //       snapshot.data.desc,
                                      //       maxLines: 3,
                                      //       style: TextStyle(fontSize: 12),
                                      //     ),
                                      //   ),
                                      // ),
                                      Expanded(
                                        child: ReadMoreText(
                                          '${snapshot.data!.desc}',
                                          trimLines: 3,
                                          colorClickableText: Colors.blue,
                                          trimMode: TrimMode.Line,
                                          trimCollapsedText:
                                              '${'read_more'.tr}',
                                          trimExpandedText: '${'read_less'.tr}',
                                          style: kTextStyle.copyWith(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              else
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: GestureDetector(
                                          onTap: snapshot.data!.pdf != null
                                              ? () async {
                                                  //snapshot.data.pdf

                                                  // var data = await http.get("http://www.pdf995.com/samples/pdf.pdf");

                                                  // await showModalBottomSheet<
                                                  //     void>(
                                                  //   context: context,
                                                  //   builder:
                                                  //       (BuildContext context) {
                                                  //     return BuildReadOrDownload(
                                                  //         snapshot.data.pdf,
                                                  //         snapshot.data.name);
                                                  //   },
                                                  // );
                                                  await launch(
                                                      '$ImgUrl${snapshot.data!.pdf}');
                                                }
                                              : () {},
                                          child: Image.asset(
                                            'assets/images/pdf.png',
                                            height: 70,
                                            width: 65,
                                            color: snapshot.data!.pdf != null
                                                ? Colors.blue
                                                : Colors.grey,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      // Expanded(
                                      //   child: SingleChildScrollView(
                                      //     scrollDirection: Axis.horizontal,
                                      //     physics: BouncingScrollPhysics(),
                                      //     child: Text(
                                      //       snapshot.data.desc,
                                      //       maxLines: 3,
                                      //       style: TextStyle(fontSize: 12),
                                      //     ),
                                      //   ),
                                      // ),
                                      Expanded(
                                        child: ReadMoreText(
                                          '${snapshot.data!.desc}',
                                          trimLines: 3,
                                          colorClickableText: Colors.blue,
                                          trimMode: TrimMode.Line,
                                          trimCollapsedText: ' ▼',
                                          trimExpandedText: '▲',
                                          style: kTextStyle.copyWith(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              const Divider(
                                height: 5,
                                color: Color(0xffB2B1B1),
                                indent: 30,
                                endIndent: 30,
                                thickness: 1.5,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              if (widget.flagBranch!)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(
                                    children: [
                                      StreamBuilder<File>(
                                          stream: _bloc.imgController.stream,
                                          initialData: null,
                                          builder: (context, snapshotFile) {
                                            if (snapshotFile.hasData &&
                                                snapshotFile.data != null) {
                                              return Center(
                                                child: Container(
                                                  height: 100,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: kAccentColor
                                                          .withOpacity(0.6),
                                                      width: 2,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                  ),
                                                  child: Stack(
                                                    fit: StackFit.expand,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25),
                                                        child: Image.file(
                                                          snapshotFile.data!,
                                                          fit: BoxFit.fitHeight,
                                                        ),
                                                      ),
                                                      StreamBuilder<bool>(
                                                          stream: _bloc
                                                              .loadImgSubject
                                                              .stream,
                                                          builder: (context,
                                                              snapshotLaodImg) {
                                                            if (snapshotLaodImg
                                                                .hasData) {
                                                              return Center(
                                                                child:
                                                                    GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    _bloc
                                                                        .loadImgSubject
                                                                        .sink
                                                                        .add(
                                                                            null!);
                                                                    try {
                                                                      FilePickerResult?
                                                                          res =
                                                                          await FilePicker.platform.pickFiles(
                                                                              type: FileType.custom,
                                                                              allowedExtensions: [
                                                                            'jpg',
                                                                            'png',
                                                                            'jpeg',
                                                                            'gif'
                                                                          ]);
                                                                      File? img = res !=
                                                                              null
                                                                          ? File(res
                                                                              .files
                                                                              .single
                                                                              .path!)
                                                                          : null;

                                                                      if (img !=
                                                                          null) {
                                                                        _bloc
                                                                            .imgController
                                                                            .sink
                                                                            .add(img);
                                                                        await _bloc.uploadFile(
                                                                            companyId: snapshot
                                                                                .data!.id,
                                                                            type:
                                                                                'image',
                                                                            context:
                                                                                context);
                                                                      }
                                                                    } catch (e) {
                                                                      print(e
                                                                          .toString());
                                                                    }
                                                                  },
                                                                  child: Card(
                                                                    elevation:
                                                                        0,
                                                                    margin: EdgeInsets
                                                                        .all(0),
                                                                    shape:
                                                                        CircleBorder(),
                                                                    color: kAccentColor
                                                                        .withOpacity(
                                                                            0.6),
                                                                    child: Padding(
                                                                        padding: EdgeInsets.all(8),
                                                                        child: Icon(
                                                                          MdiIcons
                                                                              .imagePlus,
                                                                          color:
                                                                              Colors.white,
                                                                          size:
                                                                              32,
                                                                        )),
                                                                  ),
                                                                ),
                                                              );
                                                            } else {
                                                              return SizedBox(
                                                                  child: Center(
                                                                      child:
                                                                          CircularProgressIndicator(
                                                                backgroundColor:
                                                                    kPrimaryColor,
                                                              )));
                                                            }
                                                          }),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            } else {
                                              return Center(
                                                child: Container(
                                                  height: 100,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: kAccentColor
                                                          .withOpacity(0.6),
                                                      width: 2,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                  ),
                                                  child: Center(
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        try {
                                                          FilePickerResult? res =
                                                              await FilePicker
                                                                  .platform
                                                                  .pickFiles(
                                                                      type: FileType
                                                                          .image);
                                                          File? img = res != null
                                                              ? File(res.files
                                                                  .single.path!)
                                                              : null;

                                                          if (img != null) {
                                                            _bloc.imgController
                                                                .sink
                                                                .add(img);
                                                            await _bloc
                                                                .uploadFile(
                                                                    companyId:
                                                                        snapshot
                                                                            .data
                                                                            !.id,
                                                                    type:
                                                                        'image',
                                                                    context:
                                                                        context);
                                                          }
                                                        } catch (e) {
                                                          print(e.toString());
                                                        }
                                                      },
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Card(
                                                            elevation: 0,
                                                            margin:
                                                                EdgeInsets.all(
                                                                    0),
                                                            shape:
                                                                CircleBorder(),
                                                            color: kAccentColor
                                                                .withOpacity(
                                                                    0.6),
                                                            child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(8),
                                                                child: Icon(
                                                                  MdiIcons
                                                                      .imagePlus,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 32,
                                                                )),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                          }),
                                      Expanded(
                                        child: SizedBox(
                                          height: 100,
                                          child: StreamBuilder<List<Files>>(
                                              stream: _bloc
                                                  .dataOfPhotosSubject.stream,
                                              builder:
                                                  (context, snapshotPhotos) {
                                                if (snapshotPhotos.hasData) {
                                                  return ListView.builder(
                                                    physics:
                                                        ClampingScrollPhysics(),
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: snapshotPhotos
                                                        .data!.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                                int index) =>
                                                            Stack(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal: 4,
                                                                  vertical: 7),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              border:
                                                                  Border.all(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.3),
                                                                width: 0.4,
                                                              ),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          15.0)),
                                                            ),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        15.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        15.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        15.0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        15.0),
                                                              ),
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  // Get.to(
                                                                  //     FullPhotoView(
                                                                  //       path: snapshotPhotos
                                                                  //           .data[index]
                                                                  //           .source !=
                                                                  //           null
                                                                  //           ? '$ImgUrl${snapshotPhotos
                                                                  //           .data[index]
                                                                  //           .source}'
                                                                  //           : defaultImgUrl,
                                                                  //       type: PhotoType
                                                                  //           .Network,
                                                                  //     ));
                                                                  Get.to(
                                                                      FullImageViewer(
                                                                    urls: snapshotPhotos
                                                                        .data,
                                                                  ));
                                                                },
                                                                child: Image
                                                                    .network(
                                                                  snapshotPhotos
                                                                              .data![index]
                                                                              .source !=
                                                                          null
                                                                      ? '$ImgUrl${snapshotPhotos.data![index].source}'
                                                                      : defaultImgUrl,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                  width: 110,
                                                                  height: 110,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                            left: 3,
                                                            top: 3,
                                                            child: GestureDetector(
                                                                onTap: () {
                                                                  _bloc.imageDestroyOfCompany(
                                                                      file_id: snapshotPhotos
                                                                          .data![
                                                                              index]
                                                                          .id,
                                                                      company_id:
                                                                          widget
                                                                              .compaine_id,
                                                                      context:
                                                                          context);
                                                                },
                                                                child: Container(
                                                                    color: Colors.white,
                                                                    child: Icon(
                                                                      Icons
                                                                          .delete,
                                                                      color: Colors
                                                                          .red
                                                                          .withOpacity(
                                                                              0.8),
                                                                    ))))
                                                      ],
                                                    ),
                                                  );
                                                }
                                                return const SizedBox(
                                                    child: Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                  backgroundColor:
                                                      kPrimaryColor,
                                                )));
                                              }),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              else
                                SizedBox(
                                  height: 100,
                                  child: ListView.builder(
                                    physics: ClampingScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.files!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) =>
                                            Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 7),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Colors.grey.withOpacity(0.3),
                                            width: 0.4,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0)),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(15.0),
                                            bottomRight: Radius.circular(15.0),
                                            topRight: Radius.circular(15.0),
                                            bottomLeft: Radius.circular(15.0),
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              // Get.to(FullPhotoView(
                                              //   path: snapshot.data
                                              //       .files[index].source !=
                                              //       null
                                              //       ? '$ImgUrl${snapshot
                                              //       .data.files[index]
                                              //       .source}'
                                              //       : 'https://cdn.pixabay.com/photo/2017/01/03/11/33/pizza-1949183__480.jpg',
                                              //   type: PhotoType.Network,
                                              // ));
                                              Get.to(FullImageViewer(
                                                urls: snapshot.data!.files,
                                              ));
                                            },
                                            child: Image.network(
                                              snapshot.data!.files![index]
                                                          .source !=
                                                      null
                                                  ? '$ImgUrl${snapshot.data!.files![index].source}'
                                                  : defaultImgUrl,
                                              fit: BoxFit.fill,
                                              width: 110,
                                              height: 110,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Divider(
                                height: 5,
                                color: Color(0xffB2B1B1),
                                indent: 30,
                                endIndent: 30,
                                thickness: 1.5,
                              ),
                              const SizedBox(
                                height: 10,
                              ),

                              if (snapshot.data!.lat != null &&
                                  snapshot.data!.lon != null)
                                GestureDetector(
                                  onTap: () async {
                                    String _destination =
                                        "${snapshot.data!.lat},${snapshot.data!.lon}";
                                    if (Platform.isAndroid) {
                                      final AndroidIntent intent = new AndroidIntent(
                                          action: 'action_view',
                                          data: Uri.encodeFull(
                                              "https://www.google.com/maps/dir/?api=1&destination=" +
                                                  _destination +
                                                  "&travelmode=driving"),
                                          package:
                                              "com.google.android.apps.maps");
                                      intent.launch();
                                    } else {
                                      String url =
                                          "http://maps.apple.com/?daddr=$_destination&dirflg=d&t=h";
                                      //      “https://www.google.com/maps/dir/?api=1&origin=” +
                                      //          origin +
                                      //          “&destination=” +
                                      //          destination +
                                      //          “&travelmode=driving&dir_action=navigate”;
                                      if (await canLaunch(url)) {
                                        await launch(url);
                                      } else {
                                        throw "Could not launch $url";
                                      }
                                    }

                                    // print(snapshot.data.lat);
                                    // print(snapshot.data.lon);
                                    // List<AvailableMap> availableMaps = [];
                                    // availableMaps.add(AvailableMap());
                                    // await MapLauncher.installedMaps;
                                    //
                                    // await availableMaps.first.showMarker(
                                    //   coords: Coords(
                                    //       snapshot.data.lat, snapshot.data.lon),
                                    //   // ignore: unnecessary_string_interpolations
                                    //   title: '${snapshot.data.address}',
                                    // );
                                  },
                                  child: Container(
                                    child: BuildViewMap(
                                        lat: snapshot.data!.lat,
                                        lng: snapshot.data!.lon),
                                  ),
                                ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Divider(
                                  height: 5,
                                  color: Color(0xffB2B1B1).withOpacity(0.5),
                                  indent: 30,
                                  endIndent: 30,
                                  thickness: 1.5,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: Color(0xff6E7989),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                        'text_address'.tr,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xff6E7989)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //شارع التسعين الشمالي - القاهره الجديد - مصر

                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30),
                                      child: Text(
                                        snapshot.data!.address!,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xff6E7989)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // Row(
                              //   children: [
                              //     Padding(
                              //       padding: const EdgeInsets.symmetric(
                              //           horizontal: 30),
                              //       child: Expanded(
                              //         child: SingleChildScrollView(
                              //           scrollDirection: Axis.horizontal,
                              //           physics: BouncingScrollPhysics(),
                              //           child: Text(
                              //             snapshot.data.address,
                              //             style: TextStyle(
                              //                 fontSize: 16,
                              //                 color: Color(0xff6E7989)),
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              const SizedBox(
                                height: 10,
                              ),

                              if (snapshot.data!.phone1 != null ||
                                  snapshot.data!.phone2 != null)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    children: [
                                      Row(
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          const Icon(
                                            Icons.phone,
                                            color: Color(0xff6E7989),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              'text_phone'.tr,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xff6E7989)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        // ignore: prefer_const_literals_to_create_immutables
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: snapshot.data!.phone1 != null
                                                ? GestureDetector(
                                                    onTap: () {
                                                      launch(
                                                          'tel://${snapshot.data!.phone1}');
                                                    },
                                                    child: Text(
                                                      '${snapshot.data!.phone1}',
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          color:
                                                              Color(0xff6E7989),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  )
                                                : SizedBox(),
                                          ),
                                          snapshot.data!.phone2 != null
                                              ? Text(
                                                  '/',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Color(0xff6E7989)),
                                                )
                                              : SizedBox(),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: snapshot.data!.phone2 != null
                                                ? GestureDetector(
                                                    onTap: () {
                                                      launch(
                                                          'tel://${snapshot.data!.phone2}');
                                                    },
                                                    child: Text(
                                                      '${snapshot.data!.phone2}',
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          color:
                                                              Color(0xff6E7989),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  )
                                                : SizedBox(),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.symmetric(
                                      //       horizontal: 5),
                                      //   child: Column(
                                      //     children: [
                                      //       Row(
                                      //         // ignore: prefer_const_literals_to_create_immutables
                                      //         children: [
                                      //           const Icon(
                                      //             Icons.phone,
                                      //             color: Color(0xff6E7989),
                                      //           ),
                                      //           Padding(
                                      //             padding: const EdgeInsets
                                      //                     .symmetric(
                                      //                 horizontal: 10),
                                      //             child: Text(
                                      //               'text_fax'.tr,
                                      //               style: TextStyle(
                                      //                   fontSize: 16,
                                      //                   color:
                                      //                       Color(0xff6E7989)),
                                      //             ),
                                      //           ),
                                      //         ],
                                      //       ),
                                      //       Row(
                                      //         // ignore: prefer_const_literals_to_create_immutables
                                      //         children: [
                                      //           Padding(
                                      //             padding: const EdgeInsets
                                      //                     .symmetric(
                                      //                 horizontal: 25),
                                      //             child: Text(
                                      //               snapshot.data.fax != null
                                      //                   ? '${snapshot.data.fax}'
                                      //                   : '',
                                      //               style: TextStyle(
                                      //                   fontSize: 15,
                                      //                   color:
                                      //                       Color(0xff6E7989),
                                      //                   fontWeight:
                                      //                       FontWeight.bold),
                                      //             ),
                                      //           ),
                                      //         ],
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),

                                      const SizedBox(
                                        height: 8,
                                      ),
                                      if (snapshot.data!.tel != null)
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 0),
                                          child: Column(
                                            children: [
                                              Row(
                                                // ignore: prefer_const_literals_to_create_immutables
                                                children: [
                                                  const Icon(
                                                    Icons
                                                        .phone_android_outlined,
                                                    color: Color(0xff6E7989),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10),
                                                    child: Text(
                                                      'text_Tel'.tr,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Color(
                                                              0xff6E7989)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                // ignore: prefer_const_literals_to_create_immutables
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 25),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        launch(
                                                            'tel://${snapshot.data!.tel}');
                                                      },
                                                      child: Text(
                                                        '${snapshot.data!.tel}',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: Color(
                                                                0xff6E7989),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      else
                                        const SizedBox(),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            // ignore: prefer_const_literals_to_create_immutables
                                            children: [
                                              const Icon(
                                                Icons.date_range,
                                                color: Color(0xff6E7989),
                                              ),
                                              if (snapshot.data!.is_open == 1)
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  child: Text(
                                                    'text_open_Now'.tr,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color:
                                                            Color(0xff169B1A)),
                                                  ),
                                                )
                                              else
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  child: Text(
                                                    'text_close'.tr,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color:
                                                            Colors.redAccent),
                                                  ),
                                                ),
                                            ],
                                          ),
                                          Row(
                                            // ignore: prefer_const_literals_to_create_immutables
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 3),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      '${snapshot.data!.open_to}',
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color:
                                                              Color(0xff6E7989),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      ' - ',
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color:
                                                              Color(0xff6E7989),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      '${snapshot.data!.open_from}',
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color:
                                                              Color(0xff6E7989),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                '/',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Color(0xff6E7989)),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 3),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      '${snapshot.data!.week_from}',
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color:
                                                              Color(0xff6E7989),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      ' - ',
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color:
                                                              Color(0xff6E7989),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      '${snapshot.data!.week_to}',
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color:
                                                              Color(0xff6E7989),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              else
                                const SizedBox(),
                              const SizedBox(
                                height: 10,
                              ),

                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Divider(
                                  height: 5,
                                  color: Color(0xffB2B1B1).withOpacity(0.5),
                                  indent: 30,
                                  endIndent: 30,
                                  thickness: 1.5,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              //const Spacer(),
                              StreamBuilder<void>(
                                  builder: (context, snapshotSoc) {
                                if (snapshot.data!.social!.isNotEmpty) {
                                  // print('social ${snapshot.data.social[3].icon_type}');
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 30),
                                    child: SocialCircle(
                                      socail: snapshot.data!.social,
                                    ),
                                  );
                                } else {
                                  return SizedBox();
                                }
                              }),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  'text_reviews'.tr,
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xff787878)),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              if (snapshot.data!.reviews!.length >= 1)
                                // BuildCommentOfCompany(
                                //   textDirection: TextDirection.rtl,
                                //   reviews: snapshot.data.reviews[0],
                                // )
                                BuildComment(
                                  textDirection: TextDirection.rtl,
                                  reviews: snapshot.data!.reviews![0],
                                  profileCompaineBloc: _bloc,
                                  like_init:
                                      snapshot.data!.reviews![0].comment_likes !=
                                              null
                                          ? 1
                                          : 0,
                                  dis_like_init: snapshot.data!.reviews![0]
                                              .comment_dis_likes !=
                                          null
                                      ? 1
                                      : 0,
                                )
                              else
                                const SizedBox(),
                              if (snapshot.data!.reviews!.length >= 2)
                                // BuildCommentOfCompany(
                                //   textDirection: TextDirection.rtl,
                                //   reviews: snapshot.data.reviews[1],
                                // )
                                BuildComment(
                                  textDirection: TextDirection.rtl,
                                  reviews: snapshot.data!.reviews![1],
                                  profileCompaineBloc: _bloc,
                                  like_init:
                                      snapshot.data!.reviews![1].comment_likes !=
                                              null
                                          ? 1
                                          : 0,
                                  dis_like_init: snapshot.data!.reviews![1]
                                              .comment_dis_likes !=
                                          null
                                      ? 1
                                      : 0,
                                )
                              else
                                const SizedBox(),
                              const SizedBox(
                                height: 10,
                              ),
                              if (snapshot.data!.reviews!.length > 2)
                                GestureDetector(
                                  onTap: () {
                                    Get.to(ReviewsScreen(
                                      reviews: snapshot.data!.reviews!,
                                      profileCompany: snapshot.data!,
                                      profileCompaineBloc: _bloc,
                                    ));
                                    //CustomDialog.showWithOk(context,'ds','rrrrrrr');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                      'text_see_more'.tr,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xff787878)),
                                    ),
                                  ),
                                )
                              else
                                const SizedBox(),
                              //const Spacer(),
                              SizedBox(
                                height: 10,
                              ),
                              StreamBuilder<String>(
                                  //stream: Stream.fromFuture(getIsLogIn()),
                                  builder: (context, snapshotToken) {
                                    if (snapshotToken.hasData &&
                                        snapshot.data != null) {
                                      //  if(snapshot.data.fav == 0){
                                      //   return Icon(Icons.favorite,color: Colors.grey[600],);
                                      // }else if(snapshot.data.fav == 1){
                                      //   return Icon(Icons.favorite,color: Color(0xffEB1346),);
                                      // }
                                      // FlatButton(
                                      //
                                      //     height: 50,
                                      //     minWidth: Get.width/3,
                                      //     child: Text(context.translate('bt_cancel'), style: kTextStyle.copyWith(fontSize: 18)),
                                      //     color: Color(0xffd39e00),
                                      //     textColor: Color(0xff000000),
                                      //     onPressed: () async {
                                      //       await Get.back();
                                      //     },
                                      //     shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0))
                                      // )
                                      print('Q ${snapshot.data!.closed_reason}');
                                      print('Q ${snapshot.data!.is_review}');
                                      if (widget.flagBranch!) {
                                        return FlatButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          height: 50,
                                          minWidth: Get.width,
                                          color: Color(0xff2E5BFF)
                                              .withOpacity(0.5),
                                          child: Text(
                                            'bt_leave_review'.tr,
                                            style: TextStyle(
                                                color: Color(0xffFFFFFF)),
                                          ),
                                          onPressed: () {},
                                        );
                                      } else if (snapshot.data!.closed_reason !=
                                              null ||
                                          snapshot.data!.is_review == 1) {
                                        return FlatButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          height: 50,
                                          minWidth: Get.width,
                                          color: Color(0xff2E5BFF)
                                              .withOpacity(0.5),
                                          child: Text(
                                            'bt_leave_review'.tr,
                                            style: TextStyle(
                                                color: Color(0xffFFFFFF)),
                                          ),
                                          onPressed: () {},
                                        );
                                      } else {
                                        return StreamBuilder<bool>(
                                            stream:
                                                _bloc.showCommentSubject.stream,
                                            initialData: false,
                                            builder:
                                                (context, snapshotShowComment) {
                                              if (snapshotShowComment.hasData &&
                                                  snapshotShowComment.data ==
                                                      false) {
                                                return Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 3,
                                                      vertical: 2),
                                                  child: FlatButton(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                    ),
                                                    height: 50,
                                                    minWidth: Get.width,
                                                    color: Color(0xff2E5BFF),
                                                    child: Text(
                                                      'bt_leave_review'.tr,
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xffFFFFFF)),
                                                    ),
                                                    onPressed: () async {
                                                      _bloc.commentController
                                                          .text = '';
                                                      await showModalBottomSheet<
                                                          void>(
                                                        context: context,
                                                        isScrollControlled:
                                                            true,
                                                        builder: (BuildContext
                                                            context) {
                                                          return Padding(
                                                            padding:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .viewInsets,
                                                            child: Container(
                                                              height: 430,
                                                              color: Color(
                                                                  0xffFFFFFF),
                                                              child: Center(
                                                                child:
                                                                    SingleChildScrollView(
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: <
                                                                        Widget>[
                                                                      Padding(
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                5,
                                                                            right:
                                                                                5),
                                                                        child:
                                                                            // Container(
                                                                            //   width: 90,
                                                                            //   height: 90,
                                                                            //   child: CircleAvatar(
                                                                            //     radius: 70,
                                                                            //     backgroundImage: NetworkImage(
                                                                            //       snapshot.data.image != null
                                                                            //           ? '$ImgUrl${snapshot.data.image}'
                                                                            //           : 'https://cdn.pixabay.com/photo/2016/11/20/09/06/bowl-1842294__480.jpg',
                                                                            //     ),
                                                                            //   ),
                                                                            // ),
                                                                            Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.white,
                                                                            border:
                                                                                Border.all(
                                                                              color: Colors.grey.withOpacity(0.3),
                                                                              width: 0.4,
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(50.0)),
                                                                          ),
                                                                          child:
                                                                              ClipRRect(
                                                                            borderRadius:
                                                                                const BorderRadius.only(
                                                                              topLeft: Radius.circular(50.0),
                                                                              bottomRight: Radius.circular(50.0),
                                                                              topRight: Radius.circular(50.0),
                                                                              bottomLeft: Radius.circular(50.0),
                                                                            ),
                                                                            child:
                                                                                Image.network(
                                                                              snapshot.data!.image != null ? '$ImgUrl${snapshot.data!.image}' : defaultImgUrl,
                                                                              fit: BoxFit.fitWidth,
                                                                              width: 110,
                                                                              height: 110,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      SingleChildScrollView(
                                                                          scrollDirection: Axis
                                                                              .horizontal,
                                                                          physics:
                                                                              BouncingScrollPhysics(),
                                                                          child:
                                                                              Text(
                                                                            snapshot.data!.name!,
                                                                            style:
                                                                                TextStyle(fontSize: 22),
                                                                          )),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.symmetric(horizontal: 5),
                                                                        child: SingleChildScrollView(
                                                                            scrollDirection: Axis.horizontal,
                                                                            physics: BouncingScrollPhysics(),
                                                                            child: Text(
                                                                              snapshot.data!.address!,
                                                                              style: TextStyle(fontSize: 15),
                                                                            )),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      StreamBuilder<
                                                                              dynamic>(
                                                                          stream: _bloc
                                                                              .rateSubject
                                                                              .stream,
                                                                          builder:
                                                                              (context, snapshot) {
                                                                            return Directionality(
                                                                              textDirection: TextDirection.ltr,
                                                                              child: SmoothStarRating(
                                                                                rating: 0,
                                                                                
                                                                                color: Color(0xffFFAC41),
                                                                                borderColor: Colors.grey,
                                                                                size: 40,
                                                                                filledIconData: Icons.star,
                                                                                halfFilledIconData: Icons.star_half,
                                                                                defaultIconData: Icons.star_border,
                                                                                starCount: 5,
                                                                                allowHalfRating: true,
                                                                                spacing: 2.0,
                                                                                
                                                                              ),
                                                                            );
                                                                          }),
                                                                      const SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                15,
                                                                            vertical:
                                                                                5),
                                                                        child: StreamBuilder<
                                                                                bool>(
                                                                            stream: _bloc
                                                                                .commentSubject.stream,
                                                                            initialData:
                                                                                true,
                                                                            builder:
                                                                                (context, snapshot) {
                                                                              return TextField(
                                                                                controller: _bloc.commentController,
                                                                                onChanged: (val) => _bloc.changeComment(val),
                                                                                style: TextStyle(fontSize: 18),
                                                                                decoration: InputDecoration(
                                                                                  filled: true,
                                                                                  fillColor: Colors.white,
                                                                                  focusedBorder: OutlineInputBorder(
                                                                                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                                                                                    borderSide: BorderSide(width: 1, color: Colors.grey),
                                                                                  ),
                                                                                  disabledBorder: const OutlineInputBorder(
                                                                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                                    borderSide: BorderSide(width: 1, color: Colors.black54),
                                                                                  ),
                                                                                  enabledBorder: const OutlineInputBorder(
                                                                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                                    borderSide: BorderSide(width: 1, color: Colors.grey),
                                                                                  ),
                                                                                  border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(6)), borderSide: BorderSide(width: 1, color: Colors.grey)),
                                                                                  errorBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(6)), borderSide: BorderSide(width: 1, color: Colors.red)),
                                                                                  focusedErrorBorder: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(6)), borderSide: BorderSide(width: 1, color: Colors.red.shade800)),
                                                                                  hintText: 'bt_leave_review'.tr,

                                                                                  errorText: snapshot.data! ? null : 'bt_leave_review_error'.tr,
                                                                                  hintStyle: const TextStyle(fontSize: 16, color: Color(0xFF9797AD)),
                                                                                  //errorText: snapshot.data ? null : 'name is not empty',
                                                                                ),
                                                                                keyboardType: TextInputType.text,
                                                                                maxLines: 3,
                                                                                //onChanged: (val) => widget.bloc.changeName(val),
                                                                                //controller: widget.bloc.nameController,
                                                                              );
                                                                            }),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.symmetric(horizontal: 15),
                                                                        child: FlatButton(
                                                                            shape: RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(5.0),
                                                                            ),
                                                                            height: 50,
                                                                            minWidth: Get.width,
                                                                            color: Color(0xff2E5BFF),
                                                                            child: Text(
                                                                              'bt_leave_review'.tr,
                                                                              style: TextStyle(color: Colors.white),
                                                                            ),
                                                                            onPressed: () async {
                                                                              bool co = await _bloc.commentToCompany(widget.compaine_id, context);
                                                                              if (co) {
                                                                                Get.back();
                                                                                await _bloc.fetchDataProfileCompany(widget.compaine_id, widget.flagBranch!, widget.ad_id!, context);
                                                                              }
                                                                              // if (co) {
                                                                              //   // await Get.back();
                                                                              //   await showModalBottomSheet<
                                                                              //       void>(
                                                                              //     context:
                                                                              //         context,
                                                                              //     builder:
                                                                              //         (BuildContext
                                                                              //             context) {
                                                                              //       return Container(
                                                                              //         height:
                                                                              //             400,
                                                                              //         child:
                                                                              //             Center(
                                                                              //           child: SingleChildScrollView(
                                                                              //             child: Column(
                                                                              //               mainAxisAlignment: MainAxisAlignment.center,
                                                                              //               mainAxisSize: MainAxisSize.min,
                                                                              //               children: <Widget>[
                                                                              //                 Padding(
                                                                              //                   padding: EdgeInsets.only(left: 5, right: 5),
                                                                              //                   child: Container(
                                                                              //                       width: 100,
                                                                              //                       height: 100,
                                                                              //                       color: Colors.white,
                                                                              //                       child: Image(
                                                                              //                         image: AssetImage(
                                                                              //                           'assets/images/checkDone.png',
                                                                              //                         ),
                                                                              //                       )),
                                                                              //                 ),
                                                                              //                 const SizedBox(
                                                                              //                   height: 5,
                                                                              //                 ),
                                                                              //                 Text(
                                                                              //                   context.translate('text_done_review'),
                                                                              //                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                                                              //                 ),
                                                                              //                 Text(
                                                                              //                   context.translate('text_under_reiew'),
                                                                              //                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                                                              //                 ),
                                                                              //                 const SizedBox(
                                                                              //                   height: 5,
                                                                              //                 ),
                                                                              //                 FlatButton(
                                                                              //                   shape: RoundedRectangleBorder(
                                                                              //                     borderRadius: BorderRadius.circular(5.0),
                                                                              //                   ),
                                                                              //                   height: 50,
                                                                              //                   minWidth: Get.width,
                                                                              //                   color: Color(0xff2E5BFF),
                                                                              //                   child: Text(context.translate('bt_done')),
                                                                              //                   onPressed: () {
                                                                              //                     Get.back();
                                                                              //                     Get.back();
                                                                              //                   },
                                                                              //                 )
                                                                              //               ],
                                                                              //             ),
                                                                              //           ),
                                                                              //         ),
                                                                              //       );
                                                                              //     },
                                                                              //   );
                                                                              // }
                                                                            }),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                      //await Get.back();
                                                    },
                                                  ),
                                                );
                                              }
                                              return FlatButton(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                height: 50,
                                                minWidth: Get.width,
                                                color: Color(0xff2E5BFF)
                                                    .withOpacity(0.5),
                                                child: Text(
                                                  'bt_leave_review'.tr,
                                                  style: TextStyle(
                                                      color: Color(0xffFFFFFF)),
                                                ),
                                                onPressed: () {},
                                              );
                                            });
                                      }
                                    } else {
                                      return FlatButton(
                                        height: 50,
                                        minWidth: Get.width,
                                        color: Color(0xff2E5BFF),
                                        child: Text(
                                          'bt_leave_review'.tr,
                                          style: TextStyle(
                                              color: Color(0xffFFFFFF)),
                                        ),
                                        onPressed: () async {
                                          await showModalBottomSheet<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return ShowCheckLoginDialog();
                                            },
                                          );
                                          //await Get.back();
                                        },
                                      );
                                    }
                                  }),
                            ],
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Container(
                    height: Get.height,
                    child: Center(child: Text('snapshot.error')));
              } else {
                //return SizedBox();
                return Container(
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

  Future<String?> getIsLogIn() async {
    return await helper.getToken();
  }

  Future<int?> getNumberOfNotfiction() async {
    return await helper.getNumberOfNotfiction();
  }

  Widget BuildViewMap({dynamic lat, dynamic lng}) {
    final controller = MapController(
      location: LatLng(lat, lng),
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
        // _dragStart = now;
        // controller.drag(diff.dx, diff.dy);
      }
    }
    print('Location:Location:  $lat $lng');
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

  Widget BuildReadOrDownload(String UrlPdf, String namePdf) {
    return Container(
      color: Color(0xffFFFFFF),
      height: Get.height * 0.3,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: Container(
                    width: Get.width / 2,
                    height: Get.height / 8,
                    child: const Image(
                      image: AssetImage(
                        'assets/images/Logo.png',
                      ),
                    )),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton(
                      height: 50,
                      minWidth: Get.width / 3,
                      child: Text('read'.tr,
                          style: kTextStyle.copyWith(fontSize: 18)),
                      color: Color(0xffd39e00),
                      textColor: Color(0xff000000),
                      onPressed: () async {
                        // showAlertDialog(context);
                        // var data =  http.get('$ImgUrl${UrlPdf}');
                        // var bytes = data.bodyBytes;
                        // var dir = await getApplicationDocumentsDirectory();
                        // File file = File("${dir.path}/mypdfonline.pdf");

                        // File urlFile = await file.writeAsBytes(bytes);

                        // if (urlFile != null) {
                        //   await Get.to(PdfViewPage(
                        //     path: urlFile.path,
                        //   ));
                        // }
                        // // Get.back();
                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15.0))),
                  StreamBuilder<String>(
                     // stream: Stream.fromFuture(getIsLogIn()),
                      builder: (context, snapshotToken) {
                        print(snapshotToken.hasData);
                        if (snapshotToken.hasData) {
                          return FlatButton(
                              height: 50,
                              minWidth: Get.width / 3,
                              child: Text('Download'.tr,
                                  style: kTextStyle.copyWith(fontSize: 18)),
                              color: Colors.blue.shade800,
                              textColor: Color(0xffFFFFFF),
                              onPressed: () async {
                                print('$ImgUrl${UrlPdf}');
                                await launch('$ImgUrl${UrlPdf}');
                                // var dio = Dio();
                                // // // await getPermission();
                                // // await Permission.storage.request();
                                // bool status = await Permission.storage.isGranted;
                                // print(status);
                                // if (!status) await Permission.storage.request();
                                // // ProgressDialog progressDialog=ProgressDialog(context,type: ProgressDialogType.Download);
                                // // progressDialog.style(message: 'Loading'.tr);
                                // // progressDialog.show();
                                // showAlertDialog(context);
                                // String path = await ExtStorage
                                //     .getExternalStoragePublicDirectory(
                                //         ExtStorage.DIRECTORY_DOWNLOADS);
                                // String fullPath = '$path/$namePdf.pdf';
                                // print('path2 $fullPath');
                                //
                                // await download2(
                                //     dio, '$ImgUrl${UrlPdf}', fullPath);
                                //
                                // // _requestDownload('$ImgUrl${UrlPdf}', fullPath);
                                // Get.back();
                                // progressDialog.hide();

                                // Get.to(FileDownload());
                                //    final taskId = await FlutterDownloader.enqueue(
                                //    url: '$ImgUrl${UrlPdf}',
                                //    savedDir: '$fullPath',
                                //    showNotification: true, // show download progress in status bar (for Android)
                                //    openFileFromNotification: true, // click on notification to open downloaded file (for Android)
                                //  );
                                //  print('download ${taskId}');
                              },
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(15.0)));
                        } else {
                          return FlatButton(
                              height: 50,
                              minWidth: Get.width / 3,
                              child: Text('Download'.tr,
                                  style: kTextStyle.copyWith(fontSize: 18)),
                              color: Colors.blue.shade800,
                              textColor: Color(0xffFFFFFF),
                              onPressed: () async {
                                await showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ShowCheckLoginDialog();
                                  },
                                );
                              },
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(15.0)));
                        }
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void getPermission() async {
    print("getPermission");
    // await PermissionHandler().requestPermissions([PermissionGroup.storage]);
    await Permission.storage.request();
  }

  Future download2(Dio dio, String url, String savePath) async {
    //get pdf from link
    String progress = "";

    // ProgressDialog progressDialog =ProgressDialog(context, type: ProgressDialogType.Normal);
    // progressDialog.style(message: 'Download'.tr);
    // progressDialog.show();

    var response = await dio.get(
      url,
      onReceiveProgress: (count, total) {
        progress = (count / total * 100).toStringAsFixed(0) + "%";
      //  progressDialog.update(message: "${'Download'.tr} $progress");
      },
      // showDownloadProgress,
      //Received data with List<int>
      options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          }),
    );

    //write in download folder
    print('path $savePath');
    File file = File(savePath);
    var raf = await file.openSync(mode: FileMode.write);
    raf.writeFromSync(response.data);
    await raf.close();

    //progressDialog.hide();
  }

  void _requestDownload(String link, String savePath) async {
    final taskId = await FlutterDownloader.enqueue(
      url: '$link',
      savedDir: '$savePath',
      showNotification:
          true, // show download progress in status bar (for Android)
      openFileFromNotification:
          true, // click on notification to open downloaded file (for Android)
    );
  }

//progress bar

  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
    }
  }
}

class BuildCommentOfCompany extends StatelessWidget {
  final Reviews? reviews;
  final TextDirection? textDirection;

  BuildCommentOfCompany({Key? key, this.reviews, this.textDirection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          boxShadow: [
            BoxShadow(
              spreadRadius: 3,
              color: Color(0xffB7B6B6),
              blurRadius: 7,
              offset: Offset(0, 4),
            ),
          ]),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Stack(
        children: [
          StreamBuilder<String>(
              stream: Stream.fromFuture(getLangCode()),
              builder: (context, snapshotCode) {
                if (snapshotCode.hasData) {
                  if (snapshotCode.data == 'ar') {
                    return Positioned(
                        left: 15,
                        top: 15,
                        child: Container(
                          width: 70,
                          height: 30,
                          decoration: BoxDecoration(
                            //color: Colors.redAccent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.3),
                              width: 0.4,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${reviews!.rate}',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                            ],
                          ),
                        ));
                  } else {
                    return Positioned(
                        right: 15,
                        top: 15,
                        child: Container(
                          width: 70,
                          height: 30,
                          decoration: BoxDecoration(
                            //color: Colors.redAccent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.3),
                              width: 0.4,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${reviews!.rate}',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                            ],
                          ),
                        ));
                  }
                } else {
                  return SizedBox();
                }
              }),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: SizedBox(
                        width: 5,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(left: 7, right: 7),
                        child: Container(
                          width: 5,
                          height: 65,
                          decoration: const BoxDecoration(
                            color: Color(0xff09BBCF),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: Container(
                          width: 80,
                          height: 80,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(
                              reviews!.user!.avatar != null
                                  ? '$ImgUrl${reviews!.user!.avatar}'
                                  : defaultImgUrl,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 13,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              child: Text(
                                reviews!.user!.name!,
                                style: const TextStyle(fontSize: 18.0),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              child: Text(
                                reviews!.comment,
                                maxLines: 3,
                                style: kTextStyle.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (reviews!.created_at != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      child: Text(
                        // ignore: unnecessary_string_interpolations
                        '${reviews!.created_at.split('T')[0].trim()}',
                        style:
                            const TextStyle(fontSize: 13, color: Colors.black),
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
    );
  }

  SharedPreferenceHelper helper = GetIt.instance.get<SharedPreferenceHelper>();

  Future<String> getLangCode() async {
    return await helper.getCodeLang();
  }
}
