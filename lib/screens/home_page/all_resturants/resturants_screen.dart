import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/models/search.dart';
import 'package:al_murafiq/screens/home_page/company/resturant_page_screen.dart';
import 'package:al_murafiq/screens/notification/notification_screen.dart';
import 'package:al_murafiq/widgets/show_check_login_dialog.dart';
import 'package:al_murafiq/widgets/show_message_emty_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:readmore/readmore.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:al_murafiq/widgets/show_loading_alert.dart';

import 'package:animate_do/animate_do.dart';

class ResturantsScreen extends StatefulWidget {
  final dynamic bloc;
  final dynamic blocCountry;
  final dynamic blocCategories;
  final int? subCategoriesID;
  final int? targert;

  ResturantsScreen(
      {this.bloc,
      this.blocCountry,
      this.blocCategories,
      this.subCategoriesID,
      this.targert});

  @override
  _ResturantsScreenState createState() => _ResturantsScreenState();
}

class _ResturantsScreenState extends State<ResturantsScreen> {
  //SearchBloc _bloc =SearchBloc();

  @override
  void initState() {
    // TODO: implement initState
    widget.bloc.pageNumberSet(1);
    switch (widget.targert) {
      case 0:
        {
          widget.bloc.fetchDataCustomSearch(
              widget.blocCountry.selectedCountry.value,
              widget.blocCountry.selectedCities.value,
              widget.blocCategories.selectCategoriesSubject.value,
              widget.blocCategories.selectedSubCategories.value,
              widget.blocCategories.selectedSubSubCategories.value,
              context,
              false);
        }
        break;

      case 1:
        {
          widget.bloc
              .fetchDataSubCategories(widget.subCategoriesID, context, false);
        }
        break;
      case 2:
        {
          widget.bloc.fetchDataSearch(widget.subCategoriesID, context);
        }
        break;
      case 3:
        {
          widget.bloc.fetchDataSubSubCategories(
              widget.subCategoriesID, context, false);
        }
        break;

      default:
        {
          widget.bloc.fetchDataSearch(widget.subCategoriesID, context);
        }
        break;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.bloc.searchController.text != null
            ? widget.bloc.searchController.text
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
      // backgroundColor: Colors.grey.shade300,
      //backgroundColor: Color(0xfff2f2f1),
      body: RefreshIndicator(
        onRefresh: () async {
          widget.bloc.pageNumberSet(1);
          switch (widget.targert) {
            case 0:
              {
                await widget.bloc.fetchDataCustomSearch(
                    widget.blocCountry.selectedCountry.value,
                    widget.blocCountry.selectedCities.value,
                    widget.blocCategories.selectCategoriesSubject.value,
                    widget.blocCategories.selectedSubCategories.value,
                    context,
                    true);
              }
              break;

            case 1:
              {
                await widget.bloc.fetchDataSubCategories(
                    widget.subCategoriesID, context, true);
              }
              break;
            case 2:
              {
                await widget.bloc
                    .fetchDataSearch(widget.subCategoriesID, context);
              }
              break;
            case 3:
              {
                widget.bloc.fetchDataSubSubCategories(
                    widget.subCategoriesID, context, false);
              }
              break;
            default:
              {
                await widget.bloc
                    .fetchDataSearch(widget.subCategoriesID, context);
              }
              break;
          }
          return Future.delayed(Duration(milliseconds: 400));
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              StreamBuilder<bool>(
                  stream: widget.bloc.searchSubject.stream,
                  initialData: true,
                  builder: (context, snapshot) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Expanded(
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  onChanged: (val) =>
                                      widget.bloc.changeSearch(val),
                                  controller: widget.bloc.searchController,
                                  style: kTextStyle.copyWith(fontSize: 18),
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
                                          widget.bloc.fetchDataSearch(
                                              widget.subCategoriesID, context);
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
                              widget.bloc.fetchDataSearch(
                                  widget.subCategoriesID, context);
                            },
                            color: Colors.blue,
                            padding: EdgeInsets.symmetric(
                                horizontal: 7, vertical: 12),
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
              StreamBuilder<List<DataOfSearch>>(
                  stream: widget.targert == 2 || widget.targert == 0
                      ? widget.bloc.dataOfproductSubject.stream
                      : widget.bloc.dataOfproductSubject.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.length > 0) {
                        return Column(
                          children: [
                            ListView.builder(
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  ZoomIn(
                                duration: Duration(milliseconds: 600),
                                delay: Duration(
                                    milliseconds:
                                        index * 100 > 1000 ? 600 : index * 120),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 0),
                                  child: BuildResturantsCard(
                                    textDirection: TextDirection.rtl,
                                    dataOfSearch: snapshot.data![index],
                                  ),
                                ),
                              ),
                            ),
                            if (widget.bloc.pagesCount <=
                                widget.bloc.pageNumber)
                              Container()
                            else
                              Container(
                                width: Get.width - 20,
                                child: FlatButton(
                                  onPressed: () async {
                                    // incress the value ++

                                    widget.bloc.nextPage();
                                    var pageNumber = widget.bloc.pageNumber;
                                    switch (widget.targert) {
                                      case 0:
                                        {
                                          bool falg = await widget.bloc
                                              .fetchDataCustomSearch(
                                                  widget.blocCountry
                                                      .selectedCountry.value,
                                                  widget.blocCountry
                                                      .selectedCities.value,
                                                  widget
                                                      .blocCategories
                                                      .selectCategoriesSubject
                                                      .value,
                                                  widget
                                                      .blocCategories
                                                      .selectedSubCategories
                                                      .value,
                                                  context,
                                                  true);

                                          if (falg) {
                                            widget.bloc.dataOfproductSubject
                                                .add(widget.bloc
                                                    .dataOfproductSubject.value
                                                  ..addAll(widget
                                                      .bloc
                                                      .dataOfSearchSubject
                                                      .value
                                                      .data));
                                          }
                                        }
                                        break;

                                      case 1:
                                        {
                                          widget.bloc.fetchDataSubCategories(
                                              widget.subCategoriesID,
                                              context,
                                              true);
                                          widget.bloc.dataOfproductSubject.add(
                                              widget.bloc.dataOfproductSubject
                                                  .value
                                                ..addAll(widget
                                                    .bloc
                                                    .dataOfSubCategoriesSubject
                                                    .value
                                                    .data));
                                        }
                                        break;
                                      case 2:
                                        {
                                          widget.bloc.fetchDataSearch(
                                              widget.subCategoriesID, context);

                                          widget.bloc.dataOfproductSubject.add(
                                              widget.bloc.dataOfproductSubject
                                                  .value
                                                ..addAll(widget
                                                    .bloc
                                                    .dataOfSearchSubject
                                                    .value
                                                    .data));
                                        }
                                        break;
                                      case 3:
                                        {
                                          widget.bloc.fetchDataSubSubCategories(
                                              widget.subCategoriesID,
                                              context,
                                              false);
                                        }
                                        break;
                                      default:
                                        {
                                          widget.bloc.fetchDataSearch(
                                              widget.subCategoriesID, context);
                                          widget.bloc.dataOfproductSubject.add(
                                              widget.bloc.dataOfproductSubject
                                                  .value
                                                ..addAll(widget
                                                    .bloc
                                                    .dataOfSearchSubject
                                                    .value
                                                    .data));
                                        }
                                        break;
                                    }
                                  },
                                  child: Text(
                                    'text_more'.tr,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  textColor: Colors.white,
                                  height: 50,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  color: Color(0xff2E5BFF),
                                ),
                              ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        );
                      } else {
                        return SizedBox(
                          height: Get.height,
                          child: Center(child: Text('no_data'.tr)),
                        );
                      }
                    } else if (snapshot.hasError) {
                      return ShowMessageEmtyDialog(
                        message: '',
                        pathImg: 'assets/images/noDocument.png',
                      );
                    } else {
                      //return SizedBox();
                      return SizedBox(
                        height: Get.height,
                        child: Center(
                          child: CircularProgressIndicator(
                            backgroundColor: kPrimaryColor,
                          ),
                        ),
                      );
                    }
                  }),
            ],
          ),
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

  void goToNextPage() async {
    // await widget.bloc.getProducts(goToNextPage: true,context:context);
    // return Future.delayed(Duration(milliseconds: 500));
    widget.bloc.nextPage();
    var pageNumber = widget.bloc.pageNumber;

    switch (widget.targert) {
      case 0:
        {
          bool falg = await widget.bloc.fetchDataCustomSearch(
              widget.blocCountry.selectedCountry.value,
              widget.blocCountry.selectedCities.value,
              widget.blocCategories.selectCategoriesSubject.value,
              widget.blocCategories.selectedSubCategories.value,
              context,
              true);

          if (falg) {
            widget.bloc.dataOfproductSubject.add(
                widget.bloc.dataOfproductSubject.value
                  ..addAll(widget.bloc.dataOfSearchSubject.value.data));
          }
        }
        break;

      case 1:
        {
          widget.bloc
              .fetchDataSubCategories(widget.subCategoriesID, context, true);
          widget.bloc.dataOfproductSubject.add(
              widget.bloc.dataOfproductSubject.value
                ..addAll(widget.bloc.dataOfSubCategoriesSubject.value.data));
        }
        break;
      case 2:
        {
          widget.bloc.fetchDataSearch(widget.subCategoriesID, context);

          widget.bloc.dataOfproductSubject.add(
              widget.bloc.dataOfproductSubject.value
                ..addAll(widget.bloc.dataOfSearchSubject.value.data));
        }
        break;
      case 3:
        {
          widget.bloc.fetchDataSubSubCategories(
              widget.subCategoriesID, context, false);
        }
        break;
      default:
        {
          widget.bloc.fetchDataSearch(widget.subCategoriesID, context);
          widget.bloc.dataOfproductSubject.add(
              widget.bloc.dataOfproductSubject.value
                ..addAll(widget.bloc.dataOfSearchSubject.value.data));
        }
        break;
    }
    return Future.delayed(Duration(milliseconds: 400));
  }
}

class BuildResturantsCard extends StatelessWidget {
  final DataOfSearch? dataOfSearch;
  final TextDirection? textDirection;

  const BuildResturantsCard({Key? key, this.dataOfSearch, this.textDirection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(ResturantPageScreen(
          compaine_id: dataOfSearch!.id,
          //snapshot.data.latest_companies[index].id,
          flagBranch: false,
          ad_id: 0,
        ));
      },
      child: Container(
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
                          dataOfSearch!.image != null
                              ? '$ImgUrl${dataOfSearch!.image}'
                              : defaultImgUrl,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: (Get.width / 2) + 20,
                                child: Row(
                                  children: [
                                    // Expanded(
                                    //   child: SingleChildScrollView(
                                    //     scrollDirection: Axis.horizontal,
                                    //     physics: BouncingScrollPhysics(),
                                    //     child: Text(
                                    //       '${dataOfSearch.name}',
                                    //       style:
                                    //       const TextStyle(fontSize: 17.0),
                                    //     ),
                                    //   ),
                                    // ),
                                    Expanded(
                                      child: Text(
                                        dataOfSearch!.name!,
                                        style: const TextStyle(fontSize: 18.0),
                                        maxLines: 2,
                                        // overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // const SizedBox(
                              //   width: 2,
                              // ),
                              // const Icon(
                              //   Icons.check_circle_outline,
                              //   color: kPrimaryColor,
                              //   size: 16,
                              // ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            dataOfSearch!.desc.toString(),
                            maxLines: 3,
                            style: kTextStyle.copyWith(
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    RatingBar(
                                      ratingWidget:
                                          dataOfSearch!.total_rating.toDouble(),
                                      onRatingUpdate: (double value) {},
                                      // rating: dataOfSearch!.total_rating
                                      //     .toDouble(),
                                      // icon: const Icon(
                                      //   Icons.star,
                                      //   size: 17,
                                      //   color: Colors.grey,
                                      // ),
                                      // starCount: 5,
                                      // spacing: 1.0,
                                      // size: 12,
                                      // isIndicator: true,
                                      // allowHalfRating: true,

                                      // // onRatingCallback: (double value,ValueNotifier<bool> isIndicator){
                                      // //   print('Number of stars-->  $value');
                                      // //   isIndicator.value=true;
                                      // // },
                                      // color: Colors.amber, onRatingUpdate: (double value) {  }, ratingWidget: null,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    if (dataOfSearch!.distance != null)
                                      Container(
                                        width: 50,
                                        height: 20,
                                        decoration: const BoxDecoration(
                                          color: Color(0xff848DFF),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0)),
                                        ),
                                        child: Center(
                                            child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          physics: BouncingScrollPhysics(),
                                          child: Text(
                                            dataOfSearch!.distance!,
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white),
                                          ),
                                        )),
                                      )
                                    else
                                      const SizedBox(),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 50,
                                      height: 20,
                                      decoration: const BoxDecoration(
                                        gradient: kAdsHomeGradient,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)),
                                      ),
                                      child: Center(
                                          child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        physics: BouncingScrollPhysics(),
                                        child: Text(
                                          dataOfSearch!.city!.name!,
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white),
                                        ),
                                      )),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
            ],
          ),
        ),
      ),
    );
  }
}











// import 'package:al_murafiq/constants.dart';
// import 'package:al_murafiq/core/shared_pref_helper.dart';
// import 'package:al_murafiq/models/search.dart';
// import 'package:al_murafiq/screens/home_page/company/resturant_page_screen.dart';
// import 'package:al_murafiq/screens/notification/notification_screen.dart';
// import 'package:al_murafiq/widgets/show_check_login_dialog.dart';
// import 'package:al_murafiq/widgets/show_message_emty_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';
// import 'package:get/get.dart';
// import 'package:get_it/get_it.dart';
// import 'package:readmore/readmore.dart';
// import 'package:al_murafiq/extensions/extensions.dart';
//
// class ResturantsScreen extends StatefulWidget {
//   final dynamic bloc;
//   final dynamic blocCountry;
//   final dynamic blocCategories;
//   final int subCategoriesID;
//   final int targert;
//
//   ResturantsScreen(
//       {this.bloc,
//       this.blocCountry,
//       this.blocCategories,
//       this.subCategoriesID,
//       this.targert});
//
//   @override
//   _ResturantsScreenState createState() => _ResturantsScreenState();
// }
//
// class _ResturantsScreenState extends State<ResturantsScreen> {
//   //SearchBloc _bloc =SearchBloc();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//
//     switch (widget.targert) {
//       case 0:
//         {
//           widget.bloc.fetchDataCustomSearch(
//               widget.blocCountry.selectedCountry.value,
//               widget.blocCountry.selectedCities.value,
//               widget.blocCategories.selectCategoriesSubject.value,
//               widget.blocCategories.selectedSubCategories.value);
//         }
//         break;
//
//       case 1:
//         {
//           // widget.bloc.getProducts(context:context);
//           widget.bloc.fetchDataSubCategories(widget.subCategoriesID,context);
//         }
//         break;
//       case 2:
//         {
//           widget.bloc.fetchDataSearch(widget.subCategoriesID);
//         }
//         break;
//
//       default:
//         {
//           widget.bloc.fetchDataSearch(widget.subCategoriesID);
//         }
//         break;
//     }
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(widget.bloc.searchController.text != null
//             ? widget.bloc.searchController.text
//             : ''),
//         actions: [
//           StreamBuilder<String>(
//               stream: Stream.fromFuture(
//                   getIsLogIn()),
//               builder: (context,
//                   snapshotToken) {
//                 print(snapshotToken
//                     .hasData);
//                 if (snapshotToken
//                     .hasData ) {
//
//                   return  GestureDetector(
//                     onTap: () {
//                       print('not');
//                       Get.to(NotificationScreen());
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8),
//                       child: const Icon(
//                         Icons.notifications,
//                         size: 30,
//                       ),
//                     ),
//                   );
//                 } else {
//                   return GestureDetector(
//                     onTap: () async {
//                       await showModalBottomSheet<void>(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return ShowCheckLoginDialog();
//                         },
//                       );
//                     },
//                     child: const Padding(
//                       padding:  EdgeInsets.symmetric(horizontal: 8),
//                       child:  Icon(
//                         Icons.notifications,
//                         size: 30,
//                       ),
//                     ),
//                   );
//
//                 }
//               }),
//         ],
//         elevation: 0,
//         flexibleSpace: Column(
//           children: <Widget>[
//             Flexible(
//               child: Container(
//                 decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: <Color>[
//                       Color(0xFF03317C),
//                       Color(0xFF05B3D6),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               width: double.maxFinite,
//               height: 6,
//               color: Colors.lime,
//             ),
//           ],
//         ),
//       ),
//       backgroundColor: Colors.grey.shade300,
//       body: RefreshIndicator(
//
//         onRefresh: () async {
//           print('refresh');
//           await widget.bloc.getProducts(reset: true,context:context);
//           return Future.delayed(Duration(milliseconds: 400));
//         },
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               StreamBuilder<bool>(
//                   stream: widget.bloc.searchSubject.stream,
//                   initialData: true,
//                   builder: (context, snapshot) {
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Card(
//                         elevation: 6,
//                         //color: Colors.grey,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15.0),
//                         ),
//                         shadowColor: Colors.grey,
//                         child: Container(
//                           decoration: const BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.all(Radius.circular(15.0)),
//                           ),
//                           child: TextFormField(
//                             keyboardType: TextInputType.text,
//                             onChanged: (val) => widget.bloc.changeSearch(val),
//                             controller: widget.bloc.searchController,
//                             style: kTextStyle.copyWith(fontSize: 20),
//                             decoration: InputDecoration(
//                               prefixIcon: Padding(
//                                 padding: EdgeInsets.only(
//                                   left: 5,
//                                   right: 16,
//                                   top: 0,
//                                   bottom: 0,
//                                 ),
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     widget.bloc
//                                         .fetchDataSearch(widget.subCategoriesID);
//                                   },
//                                   child: Icon(
//                                     Icons.search,
//                                     size: 35,
//                                   ),
//                                 ),
//                               ),
//                               hintText: 'search'.tr,
//                               // errorText: snapshot.data
//                               //     ? null
//                               //     : context.translate('search_error'),
//                               contentPadding: EdgeInsets.only(
//                                 left: 16,
//                                 right: 16,
//                                 top: 10,
//                                 bottom: 10,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   }),
//               const SizedBox(
//                 height: 10,
//               ),
//               NotificationListener<ScrollNotification>(
//                 onNotification: (scrollNotification) {
//                   if (scrollNotification.metrics.pixels ==
//                       scrollNotification.metrics.maxScrollExtent) {
//                     print('scrollnot');
//                     goToNextPage();
//
//                   }
//                   return true;
//                 },
//                 child: StreamBuilder<Search>(
//                     stream: widget.targert == 2 || widget.targert == 0
//                         ? widget.bloc.dataOfSearchSubject.stream
//                         : widget.bloc.dataOfSubCategoriesSubject.stream,
//                     builder: (context, snapshot) {
//                       if (snapshot.hasData) {
//                         if (snapshot.data.data.length > 0) {
//                           return Column(
//                             children: [
//                               Container(
//                                 height: Get.height*0.8,
//                                 child: ListView.builder(
//                                   physics: ClampingScrollPhysics(),
//                                   shrinkWrap: true,
//                                   scrollDirection: Axis.vertical,
//                                   itemCount: snapshot.data.data.length,
//                                   itemBuilder: (BuildContext context, int index) =>
//                                       Padding(
//                                         padding: const EdgeInsets.symmetric(vertical: 0),
//                                         child: BuildResturantsCard(
//                                           textDirection: TextDirection.rtl,
//                                           dataOfSearch: snapshot.data.data[index],
//                                         ),
//                                       ),
//                                 ),
//                               ),
//                               // StreamBuilder<bool>(
//                               //   stream: widget.bloc.loadSubject.stream,
//                               //
//                               //   builder: (context, snapshot) {
//                               //   if(snapshot.hasData){
//                               //
//                               //     if(snapshot.data){
//                               //       return SizedBox(
//                               //         height: 100,
//                               //         child: Center(
//                               //           child: CircularProgressIndicator(
//                               //             backgroundColor: kPrimaryColor,
//                               //           ),
//                               //         ),
//                               //       );
//                               //     }else{
//                               //       return Container();
//                               //     }
//                               //   }else{
//                               //     return SizedBox(
//                               //       height: Get.height*0.8,
//                               //       child: Center(
//                               //         child: CircularProgressIndicator(
//                               //           backgroundColor: kPrimaryColor,
//                               //         ),
//                               //       ),
//                               //     );
//                               //   }
//                               //
//                               //   }
//                               // ),
//                             ],
//                           );
//                           //   StreamBuilder<List<DataOfSearch>>(
//                           //   stream: widget.bloc.dataOfproductSubject.stream,
//                           //   builder: (context, snapshotProducts) {
//                           //     if(snapshotProducts.hasData){
//                           //       return Column(
//                           //         children: [
//                           //           Container(
//                           //             height: Get.height*0.8,
//                           //             child: ListView.builder(
//                           //               physics: ClampingScrollPhysics(),
//                           //               shrinkWrap: true,
//                           //               scrollDirection: Axis.vertical,
//                           //               itemCount: snapshotProducts.data.length,
//                           //               itemBuilder: (BuildContext context, int index) =>
//                           //                   Padding(
//                           //                     padding: const EdgeInsets.symmetric(vertical: 0),
//                           //                     child: BuildResturantsCard(
//                           //                       textDirection: TextDirection.rtl,
//                           //                       dataOfSearch: snapshotProducts.data[index],
//                           //                     ),
//                           //                   ),
//                           //             ),
//                           //           ),
//                           //           // StreamBuilder<bool>(
//                           //           //   stream: widget.bloc.loadSubject.stream,
//                           //           //
//                           //           //   builder: (context, snapshot) {
//                           //           //   if(snapshot.hasData){
//                           //           //
//                           //           //     if(snapshot.data){
//                           //           //       return SizedBox(
//                           //           //         height: 100,
//                           //           //         child: Center(
//                           //           //           child: CircularProgressIndicator(
//                           //           //             backgroundColor: kPrimaryColor,
//                           //           //           ),
//                           //           //         ),
//                           //           //       );
//                           //           //     }else{
//                           //           //       return Container();
//                           //           //     }
//                           //           //   }else{
//                           //           //     return SizedBox(
//                           //           //       height: Get.height*0.8,
//                           //           //       child: Center(
//                           //           //         child: CircularProgressIndicator(
//                           //           //           backgroundColor: kPrimaryColor,
//                           //           //         ),
//                           //           //       ),
//                           //           //     );
//                           //           //   }
//                           //           //
//                           //           //   }
//                           //           // ),
//                           //         ],
//                           //       );
//                           //     } else if (snapshot.hasError) {
//                           //       return ShowMessageEmtyDialog(message: snapshot.error,pathImg:'assets/images/file.png',);
//                           //     }
//                           //     // else if(widget.bloc.loadSubject.value){
//                           //     //   //return SizedBox();
//                           //     //   return SizedBox(
//                           //     //     height: Get.height*0.8,
//                           //     //     child: Center(
//                           //     //       child: CircularProgressIndicator(
//                           //     //         backgroundColor: kPrimaryColor,
//                           //     //       ),
//                           //     //     ),
//                           //     //   );
//                           //     // }
//                           //     else{
//                           //       return SizedBox(
//                           //         height: Get.height*0.8,
//                           //         child: Center(
//                           //           child: CircularProgressIndicator(
//                           //             backgroundColor: kPrimaryColor,
//                           //           ),
//                           //         ),
//                           //       );
//                           //     }
//                           //
//                           //   }
//                           // );
//                         } else {
//                           return SizedBox(
//                             height: Get.height*0.8,
//                             child:
//                                 Center(child: Text('no_data'.tr)),
//                           );
//                         }
//                       } else if (snapshot.hasError) {
//                         return ShowMessageEmtyDialog(message: snapshot.error,pathImg:'assets/images/file.png',);
//                       } else {
//                         //return SizedBox();
//                         return SizedBox(
//                           height: Get.height*0.8,
//                           child: Center(
//                             child: CircularProgressIndicator(
//                               backgroundColor: kPrimaryColor,
//                             ),
//                           ),
//                         );
//                       }
//                     }),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   SharedPreferenceHelper helper = GetIt.instance.get<SharedPreferenceHelper>();
//   Future<String> getIsLogIn() async {
//     print(await helper.getToken());
//     return await helper.getToken();
//   }
//
//   void goToNextPage() async {
//     await widget.bloc.getProducts(goToNextPage: true,context:context);
//     return Future.delayed(Duration(milliseconds: 500));
//   }
// }
//
// class BuildResturantsCard extends StatelessWidget {
//   final DataOfSearch dataOfSearch;
//   final TextDirection textDirection;
//
//   const BuildResturantsCard({Key key, this.dataOfSearch, this.textDirection})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         print('favurate company id ${dataOfSearch.id}');
//         Get.to(ResturantPageScreen(
//           compaine_id: dataOfSearch.id,
//           //snapshot.data.latest_companies[index].id,
//           flagBranch: false,
//           ad_id: 0,
//         ));
//       },
//       child: Container(
//         decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.all(Radius.circular(15.0)),
//             boxShadow: [
//               BoxShadow(
//                 spreadRadius: 5,
//                 color: Color(0xffB7B6B6),
//                 blurRadius: 7,
//                 offset: Offset(0, 4),
//               ),
//             ]),
//         margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 10),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(left: 10, right: 10),
//                     child: Container(
//                       width: 100,
//                       height: 100,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.all(Radius.circular(50.0)),
//                         border: Border.all(
//                           color: Colors.grey.withOpacity(0.3),
//                           width: 0.4,
//                         ),
//                       ),
//                       child: CircleAvatar(
//                         radius: 70,
//                         backgroundImage: NetworkImage(
//                           dataOfSearch.image != null
//                               ? '$ImgUrl${dataOfSearch.image}'
//                               : '$defaultImgUrl',
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 4,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 5),
//                               child: Row(
//                                 children: [
//                                   Container(
//                                     width: (Get.width / 3) - 30,
//                                     child: SingleChildScrollView(
//                                       scrollDirection: Axis.horizontal,
//                                       physics: BouncingScrollPhysics(),
//                                       child: Text(
//                                         dataOfSearch.name,
//                                         style:
//                                             const TextStyle(fontSize: 18.0),
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     width: 2,
//                                   ),
//                                   const Icon(
//                                     Icons.check_circle_outline,
//                                     color: kPrimaryColor,
//                                     size: 16,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 10),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   RatingBar(
//                                     rating: dataOfSearch.total_rating
//                                         .toDouble(),
//                                     icon: const Icon(
//                                       Icons.star,
//                                       size: 17,
//                                       color: Colors.grey,
//                                     ),
//                                     starCount: 5,
//                                     spacing: 1.0,
//                                     size: 12,
//                                     isIndicator: true,
//                                     allowHalfRating: true,
//
//                                     // onRatingCallback: (double value,ValueNotifier<bool> isIndicator){
//                                     //   print('Number of stars-->  $value');
//                                     //   isIndicator.value=true;
//                                     // },
//                                     color: Colors.amber,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 7,
//                         ),
//                         Padding(
//                           padding:
//                               const EdgeInsets.symmetric(horizontal: 10),
//                           child: Text(
//                             dataOfSearch.desc.toString(),
//                             maxLines: 3,
//                             style: kTextStyle.copyWith(
//                               fontSize: 12,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 7,
//                         ),
//                         // Row(
//                         //   crossAxisAlignment: CrossAxisAlignment.start,
//                         //   children: [
//                         //     const Icon(
//                         //       Icons.location_on,
//                         //       color: kAccentColor,
//                         //     ),
//                         //     const SizedBox(
//                         //       width: 10,
//                         //     ),
//                         //     Expanded(
//                         //       child: AutoSizeText(
//                         //         address,
//                         //         style:
//                         //         const TextStyle(fontSize: 18, color: Colors.white),
//                         //         softWrap: true,
//                         //         maxFontSize: 18,
//                         //         minFontSize: 16,
//                         //       ),
//                         //     )
//                         //   ],
//                         // ),
//                         // FlatButton(
//                         //   onPressed: onPress,
//                         //   color: Colors.green,
//                         //   padding: EdgeInsets.all(7),
//                         //   shape: RoundedRectangleBorder(
//                         //       borderRadius: BorderRadius.circular(50)),
//                         //   child: const Text(
//                         //     "توكيل المحامي",
//                         //     style: TextStyle(
//                         //       color: Colors.white,
//                         //       fontSize: 17,
//                         //     ),
//                         //   ),
//                         // )
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 5,
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 5),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     if (dataOfSearch.distance != null)
//                       GestureDetector(
//                         onTap: () {
//                           print('15km');
//                         },
//                         child: Container(
//                           width: 50,
//                           height: 20,
//                           decoration: const BoxDecoration(
//                             color: Color(0xff848DFF),
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(15.0)),
//                           ),
//                           child: Center(
//                               child: SingleChildScrollView(
//                             scrollDirection: Axis.horizontal,
//                             physics: BouncingScrollPhysics(),
//                             child: Text(
//                               dataOfSearch.distance,
//                               style: TextStyle(
//                                   fontSize: 12, color: Colors.white),
//                             ),
//                           )),
//                         ),
//                       )
//                     else
//                       const SizedBox(),
//                     const SizedBox(
//                       width: 5,
//                     ),
//                     if (dataOfSearch.city != null)
//                       GestureDetector(
//                       onTap: () {
//                         print('القاهره');
//                       },
//                       child: Container(
//                         width: 50,
//                         height: 20,
//                         decoration: const BoxDecoration(
//                           gradient: kAdsHomeGradient,
//                           borderRadius:
//                               BorderRadius.all(Radius.circular(15.0)),
//                         ),
//                         child: Center(
//                             child: SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           physics: BouncingScrollPhysics(),
//                           child: Text(
//                             dataOfSearch.city.name,
//                             style:
//                                 TextStyle(fontSize: 12, color: Colors.white),
//                           ),
//                         )),
//                       ),
//                     )
//                     else
//                       const SizedBox(),
//                     const SizedBox(
//                       width: 30,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
