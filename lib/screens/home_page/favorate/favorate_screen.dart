import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/models/favorate.dart';
import 'package:al_murafiq/screens/home_page/all_resturants/resturants_screen.dart';
import 'package:al_murafiq/screens/home_page/company/profile_company_bloc.dart';
import 'package:al_murafiq/screens/home_page/company/resturant_page_screen.dart';
import 'package:al_murafiq/screens/home_page/favorate/favorate_bloc.dart';
import 'package:al_murafiq/screens/home_page/search/search_bloc.dart';
import 'package:al_murafiq/screens/notification/notification_screen.dart';
import 'package:al_murafiq/widgets/need_to_login_view.dart';
import 'package:al_murafiq/widgets/show_check_login_dialog.dart';
import 'package:al_murafiq/widgets/show_message_emty_dialog.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:get_it/get_it.dart';
import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/screens/splash2/splash2.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:auto_size_text/auto_size_text.dart';
class FavorateScreen extends StatefulWidget {
  @override
  _FavorateScreenState createState() => _FavorateScreenState();
}

class _FavorateScreenState extends State<FavorateScreen> {
  FavorateBloc _bloc = FavorateBloc();
  SearchBloc _blocSearch = SearchBloc();
  @override
  void initState() {
    _bloc.fetchFavorate();
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
              stream: Stream.fromFuture(
                  getIsLogIn()),
              builder: (context,
                  snapshotToken) {

                if (snapshotToken
                    .hasData ) {

                  return  GestureDetector(
                    onTap: () async {

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
                              if(snapshotNumNotif.hasData && snapshotNumNotif.data != 0 ){
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
      body: RefreshIndicator(
        onRefresh: () async {
          await _bloc.fetchFavorate();
          return Future.delayed(Duration(milliseconds: 400));
        },
        child: SingleChildScrollView(
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
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.only(
                                        left: 5,
                                        right: 16,
                                        top: 0,
                                        bottom: 0,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          _blocSearch.searchController.text.isEmpty
                                              ? null
                                              : Get.to(ResturantsScreen(
                                                  bloc: _blocSearch,
                                                  subCategoriesID: 1,
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
                            onPressed: (){
                              _blocSearch.searchController.text
                                  .isEmpty
                                  ? null
                                  : Get.to(ResturantsScreen(
                                bloc: _blocSearch,
                                subCategoriesID: 1,
                                targert: 2,
                              ));

                            },
                            color: Colors.blue,
                            padding: EdgeInsets.symmetric(horizontal: 7,vertical: 12),

                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child:  Text(
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
              StreamBuilder<String>(
                  stream: Stream.fromFuture(getIsLogIn()),
                  builder: (context, snapshot) {

                    if (snapshot.hasData && snapshot.data != null) {

                      return StreamBuilder<List<Favourate>>(
                          stream: _bloc.dataOfFavorateSubject.stream,
                          builder: (context, snapshot) {

                            if (snapshot.hasData) {
                              if (snapshot.data.length > 0) {
                                return ListView.builder(
                                  physics: ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: snapshot.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) =>
                                          Padding(
                                            padding:
                                                const EdgeInsets.symmetric(vertical: 0),
                                            child: ZoomIn(
                                              duration: Duration(milliseconds: 600),
                                              delay: Duration(
                                                  milliseconds:
                                                  index * 100 > 1000 ? 600 : index * 120),

                                                    child: BuildCompanyCard(
                                                      // textDirection: TextDirection.ltr,
                                                      favourate: snapshot.data[index],
                                                    ),
                                            ),
                                  ),
                                );
                              } else {
                                return SizedBox(
                                  height: Get.height,
                                  child: Center(child: Text('${snapshot.error}')),
                                );
                              }
                            } else if (snapshot.hasError) {
                              return ShowMessageEmtyDialog(message: snapshot.error,pathImg:'assets/images/nowishlist.jpg',);
                            } else {
                              //return SizedBox();
                              return SizedBox(
                                  height: Get.height,
                                  child: Center(
                                      child: CircularProgressIndicator(
                                    backgroundColor: kPrimaryColor,
                                  )));
                            }
                          });
                    } else {
                      return Container(
                        height: (Get.height)*0.7,
                          child: Center(child: NeedToLogin()));
                      //   Container(
                      //   height: Get.height / 2,
                      //   child: Center(
                      //     child: Padding(
                      //       padding: const EdgeInsets.symmetric(vertical: 25),
                      //       child: FlatButton(
                      //           height: 60,
                      //           minWidth: Get.width - 100,
                      //           child: Text(context.translate('login'),
                      //               style: kTextStyle.copyWith(fontSize: 25)),
                      //           color: Colors.blue.shade800,
                      //           textColor: Color(0xffFFFFFF),
                      //           onPressed: () async {
                      //             await Get.to(Splash2());
                      //           },
                      //           shape: new RoundedRectangleBorder(
                      //               borderRadius:
                      //                   new BorderRadius.circular(30.0))),
                      //     ),
                      //   ),
                      // );
                    }
                  }),
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
  Future<int> getNumberOfNotfiction() async {
    return await helper.getNumberOfNotfiction();
  }
}

class BuildCompanyCard extends StatefulWidget {
  final Favourate favourate;

  BuildCompanyCard({Key key, this.favourate})
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

        Get.to(ResturantPageScreen(compaine_id: widget.favourate.company_id
            //snapshot.data.latest_companies[index].id,
         , flagBranch: false,
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
                          widget.favourate.company.image != null
                              ? '$ImgUrl${widget.favourate.company.image}'
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
                          padding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Container(
                              //   width: (Get.width / 2) - 30,
                              //   child: SingleChildScrollView(
                              //     scrollDirection: Axis.horizontal,
                              //     physics: BouncingScrollPhysics(),
                              //     child: Text(
                              //       widget.favourate.company.name,
                              //       style:
                              //           const TextStyle(fontSize: 17.0),
                              //     ),
                              //   ),
                              // ),
                              Expanded(
                                child: Text(
                                  widget.favourate.company.name,
                                  style: const TextStyle(fontSize: 18.0),
                                  maxLines: 2,
                                  // overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              // const Icon(
                              //   Icons.check_circle_outline,
                              //   color: kPrimaryColor,
                              //   size: 16,
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
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        // Padding(
                        //   padding:
                        //       const EdgeInsets.symmetric(horizontal: 10),
                        //   child: ReadMoreText(
                        //     widget.favourate.company.desc,
                        //     trimLines: 3,
                        //     colorClickableText: Colors.black,
                        //     trimMode: TrimMode.Line,
                        //     trimCollapsedText: '...${context.translate('read_more')}',
                        //     trimExpandedText: '${context.translate('read_less')}',
                        //     style: kTextStyle.copyWith(
                        //       fontSize: 12,
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            widget.favourate.company.desc,
                            maxLines: 3,
                            style: kTextStyle.copyWith(
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
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

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [

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
                                                '${widget.favourate.company.city.name}',
                                                style:
                                                TextStyle(fontSize: 10, color: Colors.white),
                                              ),
                                            )),
                                      ) else SizedBox(),
                                    const SizedBox(
                                      width: 8,
                                    ),
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
                                                '${widget.favourate.company.distance}',
                                                style:
                                                TextStyle(fontSize: 10, color: Colors.white),
                                              ),
                                            )),
                                      ) else SizedBox(),


                                    // const Padding(
                                    //   padding: EdgeInsets.only(left: 10, right: 10),
                                    //   child: Icon(
                                    //     Icons.favorite,
                                    //     size: 28,
                                    //     color: Color(0xffEB1346),
                                    //   ),
                                    // ),

                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 5),
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
                        ),
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

  SharedPreferenceHelper helper = GetIt.instance.get<SharedPreferenceHelper>();

  Future<String> getIsLogIn() async {
    return await helper.getToken();
  }
}
