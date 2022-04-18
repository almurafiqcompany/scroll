import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/models/side_menu.dart';
import 'package:al_murafiq/models/total_cliets.dart';
import 'package:al_murafiq/screens/side_menu/side_menu_bloc.dart';
import 'package:al_murafiq/widgets/social_circles_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:al_murafiq/utils/utils.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:al_murafiq/widgets/widgets.dart';
import 'package:get/get.dart';

class TotalClients extends StatefulWidget {
  @override
  _TotalClientsState createState() => _TotalClientsState();
}

class _TotalClientsState extends State<TotalClients> {
  SideMenuBloc _sideMenuBloc=SideMenuBloc();
  @override
  void initState() {
    _sideMenuBloc.fetchSideMenu();
    _sideMenuBloc.fetchTotalClients();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientAppbar(),
      body: RefreshIndicator(
        onRefresh: () async {
            await _sideMenuBloc.fetchSideMenu();
            await _sideMenuBloc.fetchTotalClients();
          return Future.delayed(Duration(milliseconds: 400));
        },
        child: SingleChildScrollView(
          child: StreamBuilder<TotalClents>(
            stream: _sideMenuBloc.dataOfTotalClientsSubject.stream,
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return Container(
                  height: Get.height*0.80,
                  decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0)),
                  ),
                  child: Column(
                    children: <Widget>[

                      SideMenuContainer().addPaddingOnly(bottom: 5),
                      SizedBox(height: 15,),
                      Container(
                        height: Get.height*0.5,
                        child: Column(
                          // ignore: prefer_const_literals_to_create_immutables
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment:  MainAxisAlignment.center,
                          children: <Widget>[
                            const CircleAvatar(
                              radius: 40,
                              backgroundColor: Color(0xFFCDECF5),
                              child: Icon(
                                Icons.article,
                                size: 40,
                                color: Color(0xFF293DC1),
                              ),
                            ),
                             Text('side_total_client'.tr,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20))
                                .addPaddingOnly(top: 10, bottom: 20),
                            Text('${snapshot.data.count}',
                                style:
                                TextStyle(fontWeight: FontWeight.bold, fontSize: 50)),
                          ],
                        ),
                      ),

                      // SocialCircle().addPaddingHorizontalVertical(horizontal: 40),
                      StreamBuilder<Settings>(
                          stream: _sideMenuBloc.dataOfSideMenuSubject.stream,
                          builder: (context, snapshot) {
                            if(snapshot.hasData){
                              return StreamBuilder<void>(
                                  builder: (context, snapshotSoc) {
                                    if (snapshot.data.social.isNotEmpty){
                                      return Padding(
                                        padding:
                                        EdgeInsets.symmetric(horizontal: 30),
                                        child: Container(
                                          height: 50,
                                          child: SocialCircleSideMenu(
                                            socail: snapshot.data.social,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return SizedBox();
                                    }
                                  });
                            }
                            else {
                              //return SizedBox();
                              return SizedBox();
                            }
                          }
                      ),
                    ],
                  ),
                );
              }else{
                return SizedBox(
                    height: Get.height,
                    child: Center(
                        child: CircularProgressIndicator(
                          backgroundColor: kPrimaryColor,
                        )));
              }

            }
          ),
        ),
      ),
    );
  }
}
