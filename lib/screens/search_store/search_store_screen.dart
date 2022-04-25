import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/models/search_store.dart';
import 'package:al_murafiq/screens/contact_us/send_to_contact_bloc.dart';
import 'package:al_murafiq/screens/home_page/search/search_screen.dart';
import 'package:al_murafiq/screens/search_store/search_store_bloc.dart';
import 'package:al_murafiq/screens/ticket_support/add_ticket_bloc.dart';
import 'package:al_murafiq/widgets/gradient_appbar.dart';
import 'package:al_murafiq/widgets/show_message_emty_dialog.dart';
import 'package:al_murafiq/widgets/widgets.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:al_murafiq/extensions/extensions.dart';

class SearchStoreScreen extends StatefulWidget {
  @override
  _SearchStoreScreenState createState() => _SearchStoreScreenState();
}

class _SearchStoreScreenState extends State<SearchStoreScreen> {
  SearchStoreBloc _searchStoreBloc = SearchStoreBloc();
  @override
  void initState() {
    _searchStoreBloc.fetchAllSearchStore();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppbar(
        title: 'side_search_store'.tr,
      ),
      body: StreamBuilder<SearchStore>(
          stream: _searchStoreBloc.dataofSearchStoreSubject.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.data!.length > 0) {
                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: SideMenuContainer(),
                      ),
                      StreamBuilder<List<SearchStoreData>>(
                          stream: _searchStoreBloc
                              .dataListSearchStoreSubject.stream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: snapshot.data!.length,
                                itemBuilder:
                                    (BuildContext context, int index) => ZoomIn(
                                        duration: Duration(milliseconds: 600),
                                        delay: Duration(
                                            milliseconds: index * 100 > 1000
                                                ? 600
                                                : index * 120),
                                        child: BuildSearchCard(
                                            snapshot.data![index])),
                              );
                            } else {
                              return SizedBox();
                            }
                          }),
                      // StreamBuilder<List<SearchStoreData>>(
                      //   stream: _searchStoreBloc.dataListSearchStoreSubject.stream,
                      //   initialData: snapshot.data.data,
                      //   builder: (context, snapshotListSearchStore) {
                      //     return ListView.builder(
                      //       physics: ClampingScrollPhysics(),
                      //       shrinkWrap: true,
                      //       scrollDirection: Axis.vertical,
                      //       itemCount: snapshotListSearchStore.data.length,
                      //       itemBuilder: (BuildContext context, int index) =>
                      //       BuildSearchCard(snapshotListSearchStore.data[index]),
                      //     );
                      //   }
                      // ),
                    ],
                  ),
                );
              } else {
                return SizedBox(
                    height: Get.height,
                    child:
                        const Center(child: Text('Not Found data of search')));
              }
            } else if (snapshot.hasError) {
              return Center(
                  child: ShowMessageEmtyDialog(
                message: 'snapshot.error!',
                pathImg: 'assets/images/noSearch.png',
              ));
            } else {
              return SizedBox(
                  height: Get.height,
                  child: const Center(
                      child: CircularProgressIndicator(
                    backgroundColor: kPrimaryColor,
                  )));
            }
          }),
    );
  }

  Widget BuildSearchCard(SearchStoreData searchStoreData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: GestureDetector(
        onTap: () {
          Get.to(SearchScreen(
            query: searchStoreData.query,
          ));
        },
        child: Container(
            // height: 80,
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        searchStoreData.query,
                        style: TextStyle(fontSize: 17),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        searchStoreData.time,
                        style: TextStyle(fontSize: 12),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await _searchStoreBloc.searchStoreDestroy(
                              searchStoreData.id, context);
                        },
                        child: Icon(
                          Icons.delete,
                          color: Colors.red.withOpacity(0.7),
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
