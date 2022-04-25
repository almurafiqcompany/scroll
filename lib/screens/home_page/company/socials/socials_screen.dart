import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/models/search_store.dart';
import 'package:al_murafiq/models/socials.dart';
import 'package:al_murafiq/screens/contact_us/send_to_contact_bloc.dart';
import 'package:al_murafiq/screens/home_page/company/socials/add_social/add_social_screen.dart';
import 'package:al_murafiq/screens/home_page/search/search_screen.dart';
import 'package:al_murafiq/screens/home_page/company/socials/socials_bloc.dart';
import 'package:al_murafiq/screens/ticket_support/add_ticket_bloc.dart';
import 'package:al_murafiq/widgets/gradient_appbar.dart';
import 'package:al_murafiq/widgets/show_message_emty_dialog.dart';
import 'package:al_murafiq/widgets/widgets.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:url_launcher/url_launcher.dart';
class SocialsScreen extends StatefulWidget {
  final int? company_id;

  const SocialsScreen({Key? key, this.company_id}) : super(key: key);
  @override
  _SocialsScreenState createState() => _SocialsScreenState();
}

class _SocialsScreenState extends State<SocialsScreen> {
  SocialsBloc _SocialsBloc = SocialsBloc();
  @override
  void initState() {
    _SocialsBloc.fetchAllSocialsOfCompany(widget.company_id!);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppbar(),
      floatingActionButton: FloatingActionButton(
          elevation: 0.0,
          child: Icon(
            Icons.add,
            size: 30,
            color: Color(0xffFFFFFF),
          ),
          backgroundColor: Color(0xff2E5BFF),
          onPressed: () async {
            SocialData socialData = await Get.to(AddSocialScreen(company_id: widget.company_id!,));

            if (socialData != null) {
              _SocialsBloc.dataListSocialsOfCompanySubject
                  .add(_SocialsBloc.dataListSocialsOfCompanySubject.value..add(socialData));
            }

          }),
      body: StreamBuilder<SocialsOfComapny>(
          stream: _SocialsBloc.dataofSocialsOfCompanySubject.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {

              if (snapshot.data!.socialData!.length > 0) {
                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: SideMenuContainer(),
                      ),
                      StreamBuilder<List<SocialData>>(
                        stream: _SocialsBloc.dataListSocialsOfCompanySubject.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data!.length > 0) {
                              return ListView.builder(
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount:  snapshot.data!.length,
                                itemBuilder: (BuildContext context, int index) =>
                                    ZoomIn(
                                        duration: Duration(milliseconds: 600),
                                        delay: Duration(
                                            milliseconds:
                                            index * 100 > 1000 ? 600 : index * 120),
                                        child: BuildSocialCard( snapshot.data![index])),
                              );
                            }else{
                              return SizedBox();
                            }
                          }
                          else{
                            return SizedBox();
                          }

                        }
                      ),
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
              }
              else {
                return SizedBox(
                    height: Get.height,
                    child: Center(
                        child: Text(
                      'no data',
                    )));
              }
            } else if(snapshot.hasError){
              return Center(child: ShowMessageEmtyDialog(message: 'snapshot.error',pathImg:'assets/images/noDocument.png',));
            }
            else {
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
  Widget BuildSocialCard(SocialData socialData){
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 20, vertical: 10),
      child: Container(

          padding: const EdgeInsets.symmetric(
              vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start ,
                        children: [
                          Text(
                            socialData.icon_type,
                            style: TextStyle(fontSize: 17),
                          ),
                          SizedBox(
                              height:10,
                          ),
                          GestureDetector(
                            onTap: () async {
                              await launch(socialData.link);
                            },
                            child: Text(
                              '${socialData.link}',
                              style: TextStyle(fontSize: 14,color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: GestureDetector(
                  onTap: () async {
                  await _SocialsBloc.socialsDestroy(social_id: socialData.id,company_id:widget.company_id!,context: context);
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.red.withOpacity(0.7),
                    size: 30,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
