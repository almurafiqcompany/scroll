import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/models/profile_compaine.dart';
import 'package:al_murafiq/models/side_menu.dart';
import 'package:al_murafiq/screens/contact_us/send_to_contact_screen.dart';
import 'package:al_murafiq/screens/home_page/company/add_branch_of_company_screen.dart';
import 'package:al_murafiq/screens/home_page/logout_bloc.dart';
import 'package:al_murafiq/screens/notification/notification_screen.dart';
import 'package:al_murafiq/screens/profile_edit/profle_edit_user_delegate_screen.dart';
import 'package:al_murafiq/screens/search_store/search_store_screen.dart';
import 'package:al_murafiq/screens/side_menu/about_us_screen.dart';
import 'package:al_murafiq/screens/side_menu/be_afflator.dart';
import 'package:al_murafiq/screens/side_menu/change_language/change_lang_screen.dart';
import 'package:al_murafiq/screens/side_menu/policy_screen.dart';
import 'package:al_murafiq/screens/side_menu/side_menu_bloc.dart';
import 'package:al_murafiq/screens/side_menu/subscription/socials_screen.dart';
import 'package:al_murafiq/screens/side_menu/subscription/subscription_screen.dart';
import 'package:al_murafiq/screens/side_menu/total_clients_screen.dart';
import 'package:al_murafiq/screens/ticket_support/ticket_support_screen.dart';
import 'package:al_murafiq/utils/scroll_physics_like_ios.dart';
import 'package:al_murafiq/widgets/app_bar_home.dart';
import 'package:al_murafiq/widgets/social_circles_sidemenu.dart';
import 'package:al_murafiq/widgets/widgets.dart';
import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:al_murafiq/screens/splash2/splash2.dart';
import 'package:al_murafiq/screens/home_page/company/branches_screen.dart';

class SideMenu extends StatefulWidget {
  final SideMenuTypes? sideMenuType;

  SideMenu({Key? key, @required this.sideMenuType}) : super(key: key);

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  SideMenuBloc sideMenuBloc = SideMenuBloc();

  @override
  void initState() {
    sideMenuBloc.fetchSideMenu();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<_SideMenuItem>? _data;
    switch (widget.sideMenuType) {
      case SideMenuTypes.User:
        _data = _userData;
        break;

      case SideMenuTypes.Delegate:
        _data = _delegateData;
        break;

      case SideMenuTypes.Merchant:
        _data = _merchantData;
        break;
      case SideMenuTypes.defaultUser:
        _data = _defaultUserData;
        break;
    }
    return Scaffold(
      // appBar: const GradientAppbar(title: 'sas',),

      body: SingleChildScrollView(
        child: StreamBuilder<Settings>(
            stream: sideMenuBloc.dataOfSideMenuSubject.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: [
                              Container(
                                height: 75,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      Color(0xFF03317C),
                                      Color(0xFF05B3D6),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 20,
                                top: 35,
                                child: GestureDetector(
                                    onTap: () async {},
                                    child: AutoSizeText(
                                      'al_murafiq'.tr,
                                      maxFontSize: 18,
                                      minFontSize: 14,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    )),
                              ),
                            ],
                          ),
                          Container(
                            width: double.maxFinite,
                            height: 6,
                            color: Colors.lime,
                          ),
                        ],
                      ),
                    ),
                    if (widget.sideMenuType == SideMenuTypes.defaultUser)
                      Container(
                        height: Get.height * 0.17,
                        decoration: BoxDecoration(
                            color: Color(0xffFFFFFF),
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(0.3),
                                      width: 0.4,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50.0)),
                                  ),
                                  child: const CircleAvatar(
                                    radius: 50,
                                    backgroundImage: AssetImage(
                                      'assets/images/userImg.jpeg',
                                    ),
                                  )),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                'al_murafiq'.tr,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      SideMenuContainer(),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: Get.height * 0.55,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF1F4FB),
                        image: DecorationImage(
                          image:
                              AssetImage('assets/images/backgroundImage.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: SingleChildScrollView(
                        physics: iosScrollPhysics(),
                        child: Column(
                            children: _data!
                                .map(
                                  (_SideMenuItem e) => ZoomIn(
                                    duration: Duration(milliseconds: 600),
                                    delay: Duration(milliseconds: 600),
                                    child: InkWell(
                                      onTap: e.onClick,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          CircleAvatar(
                                            backgroundColor:
                                                const Color(0xFFCDECF5),
                                            radius: 20,
                                            child: Icon(e.icon,
                                                color: const Color(0xFF293DC1)),
                                          ),
                                          const SizedBox(width: 30),
                                          Text(
                                            '${e.textKey}'.tr,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ).addPaddingOnly(
                                          right: 55, left: 55, bottom: 14),
                                    ),
                                  ),
                                )
                                .toList()),
                      ),
                    ),
                    // Container(
                    //   height: 50,
                    //   child: SocialCircle(
                    //     // socail: [
                    //     //   Social(icon_type: 'instagram'),
                    //     //   Social(icon_type: 'whatsapp'),
                    //     //   Social(icon_type: 'facebook'),
                    //     //   Social(icon_type: 'twitter'),
                    //     // ],
                    //
                    //   )
                    //       .addPaddingHorizontalVertical(horizontal: 40, vertical: 4),
                    // ),
                    StreamBuilder<void>(builder: (context, snapshotSoc) {
                      if (snapshot.data!.social != null) {
                        return Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                          child: Container(
                            height: Get.height * 0.08,
                            child: SocialCircleSideMenu(
                              socail: snapshot.data!.social,
                            ),
                          ),
                        );
                      } else {
                        return SizedBox();
                      }
                    }),
                    // const Spacer(),
                  ],
                );
              } else {
                //return SizedBox();
                return SizedBox(
                    height: Get.height,
                    child: const Center(
                        child: CircularProgressIndicator(
                      backgroundColor: kPrimaryColor,
                    )));
              }
            }),
      ),
    );
  }

  final List<_SideMenuItem> _defaultUserData = <_SideMenuItem>[
    _SideMenuItem(
      textKey: 'side_policy',
      icon: FontAwesomeIcons.exclamationCircle,
      onClick: () {
        Get.to(PolicyScreen());
      },
    ),
    _SideMenuItem(
      textKey: 'side_who_us',
      icon: FontAwesomeIcons.questionCircle,
      onClick: () {
        Get.to(AboutUsScreen());
      },
    ),
    _SideMenuItem(
      textKey: 'side_language_country',
      icon: FontAwesomeIcons.globe,
      onClick: () {
        Get.to(ChangeLanguageScreen());
      },
    ),
    _SideMenuItem(
      textKey: 'login',
      icon: FontAwesomeIcons.signInAlt,
      onClick: () async {
        await Get.to(Splash2());
      },
    ),
  ];
  final List<_SideMenuItem> _userData = <_SideMenuItem>[
    // _SideMenuItem(
    //   textKey: 'favourite',
    //   icon: Icons.fact_check,
    //   onClick: () {},
    // ),
    // _SideMenuItem(
    //   textKey: 'side_reach_point',
    //   icon: Icons.add_location,
    //   onClick: () {},
    // ),
    _SideMenuItem(
      textKey: 'side_edit_profile',
      icon: Icons.account_circle,
      onClick: () {
        Get.to(ProfileEditUserDelegateScreen(
          bedelegate: false,
        ));
      },
    ),

    _SideMenuItem(
      textKey: 'side_search_store',
      icon: Icons.web_outlined,
      onClick: () {
        Get.to(SearchStoreScreen());
      },
    ),
    _SideMenuItem(
      textKey: 'side_notifications',
      icon: Icons.notifications,
      onClick: () {
        Get.to(NotificationScreen());
      },
    ),
// _SideMenuItem(
//       textKey: 'side_be_delegate',
//       icon: Icons.web_outlined,
//       onClick: () {
//         Get.to(ProfileEditUserDelegateScreen(bedelegate: true,));
//       },
//     ),
// _SideMenuItem(
//       textKey: 'side_be_company',
//       icon: Icons.web_outlined,
//       onClick: () async {
//         //Get.to(SearchStoreScreen());
//         dynamic lng=0.0;
//         dynamic lat=0.0;
//
//         await BackgroundLocation.startLocationService();
//         BackgroundLocation.getLocationUpdates((location) async {
//           lng = await location.longitude;
//           lat = await location.latitude;
//           // setState(() {
//           //   print('dd${location.longitude}');
//           //   print('${location}');
//           // });
//
//         });
//         // print('fffffdd${lng}');
//         // print('ffffrr${lat}');
//         await Get.to(AddBranchOfCompanyScreen(lng: lng,lat: lat,beCompany: true,));
//       },
//     ),

    _SideMenuItem(
      textKey: 'side_contactus',
      // icon: FontAwesomeIcons.questionCircle,
      icon: Icons.contact_support,
      onClick: () {
        Get.to(SendContactScreen());
      },
    ),
    _SideMenuItem(
      textKey: 'side_policy',
      icon: FontAwesomeIcons.exclamationCircle,
      onClick: () {
        Get.to(PolicyScreen());
      },
    ),
    _SideMenuItem(
      textKey: 'side_who_us',
      icon: FontAwesomeIcons.questionCircle,
      onClick: () {
        Get.to(AboutUsScreen());
      },
    ),

    _SideMenuItem(
      textKey: 'side_language_country',
      icon: FontAwesomeIcons.globe,
      onClick: () {
        Get.to(ChangeLanguageScreen());
      },
    ),
    _SideMenuItem(
      textKey: 'side_logout',
      icon: FontAwesomeIcons.signOutAlt,
      onClick: () async {
        LogoutBloc bloc = LogoutBloc();

        await bloc.logOut();
      },
    ),
  ];

  final List<_SideMenuItem> _delegateData = <_SideMenuItem>[
    // _SideMenuItem(
    //   textKey: 'side_customers',
    //   icon: Icons.fact_check,
    //   onClick: () {
    //     print('customers');
    //   },
    // ),
    // _SideMenuItem(
    //   textKey: 'side_reach_point',
    //   icon: Icons.add_location,
    //   onClick: () {},
    // ),
    _SideMenuItem(
      textKey: 'side_total_client',
      icon: Icons.article,
      onClick: () {
        Get.to(TotalClients());
      },
    ),

    _SideMenuItem(
      textKey: 'side_edit_profile',
      icon: Icons.account_circle,
      onClick: () {
        Get.to(ProfileEditUserDelegateScreen(
          bedelegate: false,
        ));
      },
    ),
    // _SideMenuItem(
    //   textKey: 'side_ads',
    //   icon: FontAwesomeIcons.questionCircle,
    //   onClick: () {},
    // ),

    _SideMenuItem(
      textKey: 'side_search_store',
      icon: Icons.web_outlined,
      onClick: () {
        Get.to(SearchStoreScreen());
      },
    ),
    _SideMenuItem(
      textKey: 'side_notifications',
      icon: Icons.notifications,
      onClick: () {
        Get.to(NotificationScreen());
      },
    ),

    _SideMenuItem(
      textKey: 'side_ask',
      icon: FontAwesomeIcons.question,
      onClick: () {
        Get.to(TicketSupportScreen());
      },
    ),
    _SideMenuItem(
      textKey: 'side_policy',
      icon: FontAwesomeIcons.exclamationCircle,
      onClick: () {
        Get.to(PolicyScreen());
      },
    ),
    _SideMenuItem(
      textKey: 'side_who_us',
      icon: FontAwesomeIcons.questionCircle,
      onClick: () {
        Get.to(AboutUsScreen());
      },
    ),
    _SideMenuItem(
      textKey: 'side_language_country',
      icon: FontAwesomeIcons.globe,
      onClick: () {
        Get.to(ChangeLanguageScreen());
      },
    ),
    _SideMenuItem(
      textKey: 'side_logout',
      icon: FontAwesomeIcons.signOutAlt,
      onClick: () async {
        LogoutBloc bloc = LogoutBloc();
        await bloc.logOut();
      },
    ),
  ];

  final List<_SideMenuItem> _merchantData = <_SideMenuItem>[
    // _SideMenuItem(
    //   textKey: 'eshtrakaty',
    //   icon: Icons.fact_check,
    //   onClick: () {
    //     print('eshtrakaty');
    //     Get.to(Eshtrkaty());
    //   },
    // ),
    // _SideMenuItem(
    //   textKey: 'side_ads',
    //   icon: Icons.auto_awesome,
    //   onClick: () {},
    // ),

    _SideMenuItem(
      textKey: 'side_edit_profile',
      icon: Icons.account_circle,
      onClick: () {
        Get.to(ProfileEditUserDelegateScreen(
          bedelegate: false,
        ));
      },
    ),
    _SideMenuItem(
      textKey: 'side_mybranches',
      icon: Icons.stream,
      onClick: () {
        Get.to(BranchesScreen());
      },
    ),
    _SideMenuItem(
      textKey: 'side_eshtrakaty',
      icon: FontAwesomeIcons.dollarSign,
      onClick: () {
        Get.to(SubscriptionScreen(
          sub_or_ads: 0,
        ));
      },
    ),
    _SideMenuItem(
      textKey: 'side_ads',
      icon: FontAwesomeIcons.handSparkles,
      onClick: () {
        Get.to(SubscriptionScreen(
          sub_or_ads: 1,
        ));
      },
    ),
    _SideMenuItem(
      textKey: 'side_social',
      icon: FontAwesomeIcons.facebook,
      onClick: () {
        Get.to(SocialsMediaScreen());
      },
    ),
    _SideMenuItem(
      textKey: 'side_notifications',
      icon: Icons.notifications,
      onClick: () {
        Get.to(NotificationScreen());
      },
    ),
    _SideMenuItem(
      textKey: 'side_search_store',
      icon: Icons.web_outlined,
      onClick: () {
        Get.to(SearchStoreScreen());
      },
    ),

    _SideMenuItem(
      textKey: 'side_ask',
      icon: FontAwesomeIcons.question,
      onClick: () {
        Get.to(TicketSupportScreen());
      },
    ),
    _SideMenuItem(
      textKey: 'side_policy',
      icon: FontAwesomeIcons.exclamationCircle,
      onClick: () {
        Get.to(PolicyScreen());
      },
    ),

    _SideMenuItem(
      textKey: 'side_who_us',
      icon: FontAwesomeIcons.questionCircle,
      onClick: () {
        Get.to(AboutUsScreen());
      },
    ),

    _SideMenuItem(
      textKey: 'side_language_country',
      icon: FontAwesomeIcons.globe,
      onClick: () {
        Get.to(ChangeLanguageScreen());
      },
    ),

    _SideMenuItem(
      textKey: 'side_logout',
      icon: FontAwesomeIcons.signOutAlt,
      onClick: () async {
        LogoutBloc bloc = LogoutBloc();
        await bloc.logOut();
      },
    ),
  ];
}

class _SideMenuItem {
  final String? textKey;
  final IconData? icon;
  final VoidCallback? onClick;

  _SideMenuItem({
    @required this.textKey,
    @required this.icon,
    @required this.onClick,
  });
}

enum SideMenuTypes {
  User,
  Delegate,
  Merchant,
  defaultUser,
}

extension SideMenuTypesExt on SideMenuTypes {
  static const Map<SideMenuTypes, String> SideMenuTypesMap =
      <SideMenuTypes, String>{
    SideMenuTypes.User: 'User',
    SideMenuTypes.Delegate: 'Delegate',
    SideMenuTypes.Merchant: 'Merchant',
    SideMenuTypes.defaultUser: 'defaultUser',
  };

  void console() {
    print('$index $text');
  }

  String get text => SideMenuTypesMap[this]!;
}
