import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/models/categories.dart';
import 'package:al_murafiq/screens/home_page/all_resturants/resturants_screen.dart';
import 'package:al_murafiq/screens/home_page/categories/categories_bloc.dart';
import 'package:al_murafiq/screens/home_page/search/search_bloc.dart';
import 'package:al_murafiq/screens/home_page/sub_categores/sub_categorie_scteen.dart';
import 'package:al_murafiq/widgets/show_check_login_dialog.dart';
import 'package:al_murafiq/widgets/show_message_emty_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:al_murafiq/screens/notification/notification_screen.dart';
import 'package:get_it/get_it.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  SearchBloc _blocSearch = SearchBloc();
  CategoriesBloc _categoriesBloc = CategoriesBloc();
  final double itemHeight = Get.height * 0.12;
  final double itemWidth = (Get.width / 2) - 15;
  @override
  void initState() {
    _categoriesBloc.fetchDataAllCategories();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
      body: RefreshIndicator(
        onRefresh: () async {
          await _categoriesBloc.fetchDataAllCategories();
          return Future.delayed(Duration(milliseconds: 400));
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  onChanged: (val) =>
                                      _blocSearch.changeSearch(val),
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
                                          _blocSearch
                                                  .searchController.text.isEmpty
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

              SizedBox(
                height: 10,
              ),

              // ignore: avoid_unnecessary_containers

              Container(
                child: StreamBuilder<List<Categories_Data>>(
                    stream: _categoriesBloc.getAllCategoriesSubject.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.length > 0) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ConstrainedBox(
                              constraints:
                                  BoxConstraints(minHeight: Get.height * 0.7),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffFFFFFF),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
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
                                              'text_all_categories'.tr,
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: GridView.count(
                                        crossAxisCount: 2,
                                        childAspectRatio:
                                            (itemWidth / itemHeight),
                                        mainAxisSpacing: 5,
                                        crossAxisSpacing: 8,
                                        controller: ScrollController(
                                            keepScrollOffset: false),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        children: _buildGridTileList(
                                            count: _categoriesBloc
                                                .getAllCategoriesSubject
                                                .stream
                                                .value
                                                .length,
                                            categoriesData: snapshot.data!),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          return SizedBox();
                        }
                      } else if (snapshot.hasError) {
                        return ShowMessageEmtyDialog(
                          message: '',
                          pathImg: 'assets/images/noDocument.png',
                        );
                      } else {
                        //return SizedBox();
                        return CircularProgressIndicator(
                          backgroundColor: kPrimaryColor,
                        );
                      }
                    }),
              ),
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

  List<Widget> _buildGridTileList(
          {int? count, List<Categories_Data>? categoriesData}) =>
      List.generate(count!, (i) => BuildCategories(categoriesData![i]));
  Widget BuildCategories(Categories_Data categoriesData) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: GestureDetector(
        onTap: () {
          Get.to(SubCategorieScreen(
            subCategories: categoriesData.sub_categories!,
            name_Categories: categoriesData.name!,
            ads: categoriesData.ads!,
          ));
        },
        child: Container(
          //width: MediaQuery.of(context).size.width/3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              // gradient: kAdsHomeGradient,
              // color: Color(int.parse('0xff${categoriesData.color}')),

              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0, 0.8],
                colors: [
                  Color(int.parse('0xff${categoriesData.color}')),
                  Colors.black.withOpacity(0.8),
                ],
              ),
              image: DecorationImage(
                image: NetworkImage(categoriesData.image != null
                    ? '$ImgUrl${categoriesData.image}'
                    : '$defaultImgUrl'),
                fit: BoxFit.cover,
                colorFilter: new ColorFilter.mode(
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
                    width: (Get.width / 3) - 20,
                    child: Column(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              '${categoriesData.name}',
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
