import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/models/categories.dart';
import 'package:al_murafiq/screens/home_page/all_resturants/resturants_screen.dart';
import 'package:al_murafiq/screens/home_page/company/resturant_page_screen.dart';
import 'package:al_murafiq/screens/home_page/search/search_bloc.dart';
import 'package:al_murafiq/screens/notification/notification_screen.dart';
import 'package:al_murafiq/widgets/show_check_login_dialog.dart';
import 'package:al_murafiq/widgets/show_message_emty_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
class SubSubCategorieScreen extends StatefulWidget {
  final List<SubSubCategories> subSubCategories;
  final List<Ads> ads;
  final String name_Sub_Categories;

  const SubSubCategorieScreen(
      {Key key, this.subSubCategories, this.ads, this.name_Sub_Categories})
      : super(key: key);

  @override
  _SubSubCategorieScreenState createState() => _SubSubCategorieScreenState();
}

class _SubSubCategorieScreenState extends State<SubSubCategorieScreen> {
  // final imgurl = [
  //   'https://cdn.pixabay.com/photo/2017/01/03/11/33/pizza-1949183__480.jpg',
  //   'https://cdn.pixabay.com/photo/2016/03/05/19/02/hamburger-1238246__480.jpg',
  //   'https://cdn.pixabay.com/photo/2016/11/20/09/06/bowl-1842294__480.jpg',
  // ];
  //
  final double itemHeight = Get.height*0.12;
  final double itemWidth = (Get.width/2)-15;
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
                  _blocSearch.searchSubject.value=true;
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
                                  //     snapshot.data ? null :context.translate('search_error'),
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
            StreamBuilder<void>(builder: (context, snapshot) {
              if (widget.ads.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.all(Radius.circular(15.0)),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 5,
                            color: Color(0xffB7B6B6),
                            blurRadius: 7,
                            offset: Offset(0, 4),
                          ),
                        ]),
                    child: Container(
                      height: Get.height*0.3,
                      width: Get.width-20,
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
                                                .spaceAround,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                    horizontal: 5,
                                                    vertical: 2),
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
                                                              width:
                                                              (Get.width / 2) - 20,
                                                              child:
                                                              SingleChildScrollView(
                                                                scrollDirection: Axis.horizontal,
                                                                physics: BouncingScrollPhysics(),
                                                                child: Text(
                                                                  '${widget.ads[config.activeIndex].name} ',
                                                                  style: const TextStyle(fontSize: 16.0),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width:
                                                              2,
                                                            ),
                                                            const Icon(
                                                              Icons.check_circle_outline,
                                                              color:
                                                              kPrimaryColor,
                                                              size:
                                                              16,
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.symmetric(horizontal: 10),
                                                          child:
                                                          Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.end,
                                                            children: [
                                                              RatingBar(
                                                                rating: widget.ads[config.activeIndex].total_rating.toDouble(),
                                                                icon: const Icon(
                                                                  Icons.star,
                                                                  size: 20,
                                                                  color: Colors.grey,
                                                                ),
                                                                starCount: 5,
                                                                spacing: 2,
                                                                size: 15,
                                                                isIndicator: true,
                                                                allowHalfRating: true,
                                                                color: Colors.amber,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
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
                                                          widget.ads[config.activeIndex]
                                                              .address,
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

                                                        if (widget.ads[config.activeIndex].distance != null)
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
                                                                    widget.ads[config.activeIndex].distance,
                                                                    style: TextStyle(fontSize: 10, color: Colors.white),
                                                                  ),
                                                                )),
                                                          ) else SizedBox(),
                                                        const SizedBox(
                                                          width:
                                                          5,
                                                        ),
                                                        if (widget.ads[config.activeIndex].city != null)
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
                                                                  widget.ads[config.activeIndex].city,
                                                                  style: TextStyle(fontSize: 10, color: Colors.white),
                                                                ),
                                                              )),
                                                        )else SizedBox(),

                                                        if (widget.ads[config.activeIndex]
                                                            .visit_count !=
                                                            null)
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 4),
                                                            child: Container(
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
                                                                    horizontal: 4,
                                                                    vertical: 2),
                                                                child:
                                                                Row(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment.center,
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment.center,
                                                                  // ignore: prefer_const_literals_to_create_immutables
                                                                  children: [
                                                                    const Icon(MdiIcons.eye, size: 18, color: Color(0xff01B2CB)),
                                                                    const SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Text(
                                                                      widget.ads[config.activeIndex].visit_count > 999
                                                                          ? '${widget.ads[config.activeIndex].visit_count / 1000}K'
                                                                          : widget.ads[config.activeIndex].visit_count > 999999
                                                                          ? '${widget.ads[config.activeIndex].visit_count / 1000000}M'
                                                                          : '${widget.ads[config.activeIndex].visit_count}',
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
                                          height: 75),
                                    );
                                  })),

                          autoplay: true,

                          itemBuilder: (BuildContext context,
                              int index) {
                            return Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
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
                                      const BorderRadius.only(
                                        topLeft:
                                        Radius.circular(10.0),
                                        bottomRight:
                                        Radius.circular(10.0),
                                        topRight:
                                        Radius.circular(10.0),
                                        bottomLeft:
                                        Radius.circular(10.0),
                                      ),
                                      child: Image.network(
                                        widget.ads[index]
                                            .image !=
                                            null
                                            ? '$ImgUrl${widget.ads[index].image}'
                                            : defaultImgUrl,
                                        fit: BoxFit.fill,
                                        height: Get.height*0.18,
                                        width: Get.width-20,
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
                                            '${widget.ads[index].total_rating.toStringAsFixed(1)}',
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
                          itemCount:
                          widget.ads.length,
                          //itemWidth: 100.0,
                          //autoplayDelay: 2500,
                          onTap: (int index) {
                            Get.to(ResturantPageScreen(
                              flagBranch: false,
                              compaine_id: widget.ads[index].company_id,
                              ad_id: widget.ads[index].id,
                            ));
                          },

                          loop: true,
                          layout: SwiperLayout.DEFAULT,
                        ),
                      ),
                    ),
                  ),
                );
              }
              return SizedBox();
            }),
            const SizedBox(
              height: 10,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: Get.height*0.40),
                child: Container(

                  decoration: BoxDecoration(
                    color: Color(0xffFFFFFF),
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
                  child: Column(
                    children: [


                      Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              child: Text(
                                widget.name_Sub_Categories,
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (widget.subSubCategories.isNotEmpty) Container(
                        child: GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: (itemWidth / itemHeight),
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 8,
                          controller: ScrollController(keepScrollOffset: false),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          children: _buildGridTileList(widget.subSubCategories.length),
                        ),
                      ) else Center(child: ShowMessageEmtyDialog(message: "",pathImg:'assets/images/noDocument.png',)),
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
  Future<String> getIsLogIn() async {
    return await helper.getToken();
  }
  Future<int> getNumberOfNotfiction() async {
    return await helper.getNumberOfNotfiction();
  }
  List<Widget> _buildGridTileList(int count) => List.generate(
      count,
      (i) => BuildSubCategorie(widget.subSubCategories[i].name,
          widget.subSubCategories[i].image, widget.subSubCategories[i].id,widget.subSubCategories[i].color));

  Widget BuildSubCategorie(String name, String img, int subSubCategoriesID,String color) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () async {
          // await _subCategoriesBloc.fetchDataSearch(subCategoriesID);
          // final SearchBloc blocCoby=_subCategoriesBloc;
          Get.to(ResturantsScreen(
            bloc: _blocSearch,
            subCategoriesID: subSubCategoriesID,
            targert: 3,
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
                image: NetworkImage(img != null
                    ? '$ImgUrl${img}'
                    : defaultImgUrl),
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
                    width: (Get.width/3)-20,
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
