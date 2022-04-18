import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/screens/home_page/logout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:al_murafiq/screens/side_menu/sidemenu_screen.dart';
import 'package:get_it/get_it.dart';
import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/widgets/need_to_login_view.dart';
class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  LogoutBloc _bloc = LogoutBloc();
@override
  void initState() {
  getIsLogIn();
  // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   actions: [
      //     GestureDetector(
      //       onTap: () {
      //         print('not');
      //       },
      //       child: const Icon(
      //         Icons.notifications,
      //         size: 30,
      //       ),
      //     ),
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
      body: StreamBuilder<String>(
          stream: Stream.fromFuture(getIsLogIn()),
          builder: (context, snapshot) {
            if (snapshot.hasData ) {
              return
              //   Column(
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.symmetric(vertical: 25),
              //       child: Center(
              //         child: FlatButton(
              //             height: 60,
              //             minWidth: Get.width - 100,
              //             child: Text('Log Out',
              //                 style: kTextStyle.copyWith(fontSize: 25)),
              //             color: Colors.blue.shade800,
              //             textColor: Color(0xffFFFFFF),
              //             onPressed: () async {
              //               await _bloc.logOut();
              //             },
              //             shape: new RoundedRectangleBorder(
              //                 borderRadius:
              //                     new BorderRadius.circular(30.0))),
              //       ),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.symmetric(vertical: 25),
              //       child: Center(
              //         child: FlatButton(
              //             height: 60,
              //             minWidth: Get.width - 100,
              //             child: Text('payment',
              //                 style: kTextStyle.copyWith(fontSize: 25)),
              //             color: Colors.blue.shade800,
              //             textColor: Color(0xffFFFFFF),
              //             onPressed: () async {
              //               await Get.to(PayPlansScreen());
              //               // await Get.to(PayInfoScreen());
              //               // await Get.to(Eshtrkaty());
              //               // await Get.to(OfflinePayment());
              //               // await Get.to(OnlinePayment());
              //             },
              //             shape: new RoundedRectangleBorder(
              //                 borderRadius:
              //                     new BorderRadius.circular(30.0))),
              //       ),
              //     ),
              //     StreamBuilder<String>(
              //         stream: Stream.fromFuture(getTypeOfUser()),
              //         builder: (context, snapshotTypeUser) {
              //           print(snapshotTypeUser.hasData);
              //           if (snapshotTypeUser.hasData) {
              //             print('snap ' + snapshotTypeUser.data);
              //             return Padding(
              //               padding:
              //                   const EdgeInsets.symmetric(vertical: 25),
              //               child: Center(
              //                 child: FlatButton(
              //                     height: 60,
              //                     minWidth: Get.width - 100,
              //                     child: Text('Side Menu',
              //                         style: kTextStyle.copyWith(
              //                             fontSize: 25)),
              //                     color: Colors.blue.shade800,
              //                     textColor: Color(0xffFFFFFF),
              //                     onPressed: () async {
              //                       switch (snapshotTypeUser.data) {
              //                         case 'Customer':
              //                           {
              //                             await Get.to(
              //                               SideMenu(
              //                                 sideMenuType:
              //                                     SideMenuTypes.User,
              //                               ),
              //                             );
              //                           }
              //                           break;
              //
              //                         case 'Marketer':
              //                           {
              //                             await Get.to(
              //                               SideMenu(
              //                                 sideMenuType:
              //                                     SideMenuTypes.Merchant,
              //                               ),
              //                             );
              //                           }
              //                           break;
              //                         case 'Company':
              //                           {
              //                             await Get.to(
              //                               SideMenu(
              //                                 sideMenuType:
              //                                     SideMenuTypes.Delegate,
              //                               ),
              //                             );
              //                           }
              //                           break;
              //
              //                         default:
              //                           {
              //                             await Get.to(
              //                               SideMenu(
              //                                 sideMenuType:
              //                                     SideMenuTypes.User,
              //                               ),
              //                             );
              //                           }
              //                           break;
              //                       }
              //                     },
              //                     shape: new RoundedRectangleBorder(
              //                         borderRadius:
              //                             new BorderRadius.circular(30.0))),
              //               ),
              //             );
              //           } else {
              //             return Container(
              //               height: Get.height / 2,
              //               child: Center(
              //                 child: Padding(
              //                   padding: const EdgeInsets.symmetric(
              //                       vertical: 25),
              //                   child: FlatButton(
              //                       height: 60,
              //                       minWidth: Get.width - 100,
              //                       child: Text('Login',
              //                           style: kTextStyle.copyWith(
              //                               fontSize: 25)),
              //                       color: Colors.blue.shade800,
              //                       textColor: Color(0xffFFFFFF),
              //                       onPressed: () async {
              //                         await Get.to(Splash2());
              //                       },
              //                       shape: new RoundedRectangleBorder(
              //                           borderRadius:
              //                               new BorderRadius.circular(
              //                                   30.0))),
              //                 ),
              //               ),
              //             );
              //           }
              //         }),
              //   ],
              // );
                StreamBuilder<String>(
                    stream: Stream.fromFuture(getTypeOfUser()),
                    builder: (context, snapshotTypeUser) {
                      var screen;
                      switch (snapshotTypeUser.data) {
                        case 'Customer':
                          {
                            screen=SideMenu(
                              sideMenuType:
                              SideMenuTypes.User,
                            );
                          }
                          break;
                        case 'Marketer':
                          {

                            screen=SideMenu(
                              sideMenuType:
                              SideMenuTypes.Delegate,
                            );
                          }
                          break;
                        case 'Company':
                          {
                            screen=SideMenu(
                              sideMenuType:
                              SideMenuTypes.Merchant,
                            );
                          }
                          break;

                        default:
                          {
                            screen=SideMenu(
                              sideMenuType:
                              SideMenuTypes.User,
                            );
                          }
                          break;
                      }
                      if (snapshotTypeUser.hasData) {

                        return Scaffold(
                            body: screen
                        );
                      } else {
                        return
                        //   Scaffold(
                        //   appBar: AppBar(
                        //     centerTitle: true,
                        //     actions: [
                        //       GestureDetector(
                        //         onTap: () {
                        //           print('not');
                        //         },
                        //         child: const Icon(
                        //           Icons.notifications,
                        //           size: 30,
                        //         ),
                        //       ),
                        //     ],
                        //     elevation: 0,
                        //     flexibleSpace: Column(
                        //       children: <Widget>[
                        //         Flexible(
                        //           child: Container(
                        //             decoration: const BoxDecoration(
                        //               gradient: LinearGradient(
                        //                 colors: <Color>[
                        //                   Color(0xFF03317C),
                        //                   Color(0xFF05B3D6),
                        //                 ],
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //         Container(
                        //           width: double.maxFinite,
                        //           height: 6,
                        //           color: Colors.lime,
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        //   body: Container(
                        //     height: Get.height / 2,
                        //     child: Center(
                        //       child: Padding(
                        //         padding: const EdgeInsets.symmetric(
                        //             vertical: 25),
                        //         child: FlatButton(
                        //             height: 60,
                        //             minWidth: Get.width - 100,
                        //             child: Text('Login',
                        //                 style: kTextStyle.copyWith(
                        //                     fontSize: 25)),
                        //             color: Colors.blue.shade800,
                        //             textColor: Color(0xffFFFFFF),
                        //             onPressed: () async {
                        //               await Get.to(Splash2());
                        //             },
                        //             shape: new RoundedRectangleBorder(
                        //                 borderRadius:
                        //                 new BorderRadius.circular(
                        //                     30.0))),
                        //       ),
                        //     ),
                        //   ),
                        // );
                        SizedBox();
                      }
                    });
            }else if (snapshot.hasData == null){
              return
                SideMenu(
                  sideMenuType:
                  SideMenuTypes.defaultUser,
                );
                // Container(
                //   height: (Get.height)*0.7,
                //   child: Center(child: NeedToLogin()));
              //   Container(
              //   height: Get.height / 2,
              //   child: Center(
              //     child: Padding(
              //       padding: const EdgeInsets.symmetric(vertical: 25),
              //       child: FlatButton(
              //           height: 60,
              //           minWidth: Get.width - 100,
              //           child: Text('Login',
              //               style: kTextStyle.copyWith(fontSize: 25)),
              //           color: Colors.blue.shade800,
              //           textColor: Color(0xffFFFFFF),
              //           onPressed: () async {
              //             await Get.to(Splash2());
              //           },
              //           shape: new RoundedRectangleBorder(
              //               borderRadius: new BorderRadius.circular(30.0))),
              //     ),
              //   ),
              // );
            }else if (snapshot.hasData == false){
              return  SideMenu(
                sideMenuType:
                SideMenuTypes.defaultUser,
              );
                // Container(
                //   height: (Get.height),
                //   child: Center(child: NeedToLogin()));
              //   Container(
              //   height: Get.height / 2,
              //   child: Center(
              //     child: Padding(
              //       padding: const EdgeInsets.symmetric(vertical: 25),
              //       child: FlatButton(
              //           height: 60,
              //           minWidth: Get.width - 100,
              //           child: Text('Login',
              //               style: kTextStyle.copyWith(fontSize: 25)),
              //           color: Colors.blue.shade800,
              //           textColor: Color(0xffFFFFFF),
              //           onPressed: () async {
              //             await Get.to(Splash2());
              //           },
              //           shape: new RoundedRectangleBorder(
              //               borderRadius: new BorderRadius.circular(30.0))),
              //     ),
              //   ),
              // );
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

  SharedPreferenceHelper helper = GetIt.instance.get<SharedPreferenceHelper>();
  Future<String> getIsLogIn() async {
    return await helper.getToken();
  }

  Future<String> getTypeOfUser() async {
    return await helper.getType();
  }
}
