import 'package:al_murafiq/models/branch.dart';
import 'package:al_murafiq/screens/home_page/company/edit_company/edit_company_screen.dart';
import 'package:al_murafiq/screens/home_page/company/resturant_page_screen.dart';
import 'package:al_murafiq/screens/home_page/company/socials/socials_screen.dart';
import 'package:al_murafiq/widgets/show_check_active_sub_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../constants.dart';
import 'package:al_murafiq/screens/payment/eshtrakaty_screen.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BuildCardBranch extends StatelessWidget {
  final Branches? branches;

  const BuildCardBranch({Key? key, this.branches}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () async {
            if (branches!.active == 1) {
              Get.to(ResturantPageScreen(
                compaine_id: branches!.id,
                flagBranch: true,
                ad_id: 0,
              ));
            } else {
              await showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return ShowCheckActiveSubDialog(
                    company_id: branches!.id,
                  );
                },
              );
            }
          },
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
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
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius?.all(Radius.circular(50.0)),
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.3),
                              width: 0.4,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(branches!.image != null
                                ? '$ImgUrl${branches!.image}'
                                : defaultImgUrl),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Container(
                                        //   width: Get.width * 0.5,
                                        //   child:
                                        //       // Marquee(
                                        //       //     text: "zacks",
                                        //       //     style: const TextStyle(fontSize: 18.0)),
                                        //       SingleChildScrollView(
                                        //     scrollDirection: Axis.horizontal,
                                        //     physics: BouncingScrollPhysics(),
                                        //     child: Text(
                                        //       branches.name,
                                        //       style:
                                        //           const TextStyle(fontSize: 18.0),
                                        //       //overflow: TextOverflow.ellipsis,
                                        //     ),
                                        //   ),
                                        // ),
                                        Expanded(
                                          child: Text(
                                            branches!.name!,
                                            style:
                                                const TextStyle(fontSize: 18.0),
                                            maxLines: 2,
                                            // overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        // Text(
                                        //   bannerData.name,
                                        //   style: const TextStyle(fontSize: 18.0),
                                        //   overflow: TextOverflow.ellipsis,
                                        // ),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        if (branches!.active == 1)
                                          const Icon(
                                            Icons.check_circle_outline,
                                            color: Colors.green,
                                            size: 16,
                                          )
                                        else
                                          const Icon(
                                            Icons.check_circle_outline,
                                            color: Colors.grey,
                                            size: 16,
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                '${branches!.desc}',
                                maxLines: 3,
                                style: kTextStyle.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 7,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 100,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Color(0xffF5F5F5),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                      // border: Border.all(
                                      //   color: Colors.grey.withOpacity(0.3),
                                      //   width: 0.4,
                                      // ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 5),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 24,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '${branches!.total_rating}',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Color(0xffF5F5F5),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                      // border: Border.all(
                                      //   color: Colors.grey.withOpacity(0.3),
                                      //   width: 0.4,
                                      // ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 5),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          Icon(
                                            MdiIcons.eye,
                                            size: 24,
                                            color: Color(0xff01B2CB),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          // Text(
                                          //   branches?.visit_count > 999
                                          //       ? '${branches?.visit_count / 1000}K'
                                          //       : branches?.visit_count> 999999
                                          //           ? '${branches?.visit_count / 1000000}M'
                                          //           : '${branches?.visit_count}',
                                          //   style: TextStyle(
                                          //       fontSize: 12,
                                          //       color: Colors.black),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.end,
                              //   children: [
                              //     Padding(
                              //       padding: const EdgeInsets.symmetric(horizontal: 10),
                              //       child: GestureDetector(
                              //         onTap: () async {
                              //           if (branches.active == 1) {
                              //             Get.to(SocialsScreen(
                              //               company_id: branches.id,
                              //             ));
                              //           } else {
                              //             await showModalBottomSheet<void>(
                              //               context: context,
                              //               builder: (BuildContext context) {
                              //                 return ShowCheckActiveSubDialog(
                              //                   company_id: branches.id,
                              //                 );
                              //               },
                              //             );
                              //           }
                              //         },
                              //         // child: Icon(MdiIcons.socialDistance6Feet,size: 24,color: Color(0xff01B2CB),),
                              //         child: Image.asset(
                              //           'assets/images/social.png',
                              //           // color: Color(0xff01B2CB),
                              //           width: 24,
                              //         ),
                              //       ),
                              //     ),
                              //     // Padding(
                              //     //   padding: const EdgeInsets.symmetric(horizontal: 10),
                              //     //   child: GestureDetector(
                              //     //     onTap: () {
                              //     //       print('1');
                              //     //       Get.to(Eshtrkaty(
                              //     //         company_id: branches.id,
                              //     //         typeAdsOrPlan: 0,
                              //     //       ));
                              //     //     },
                              //     //     child: Image.asset(
                              //     //       'assets/images/subscription.png',
                              //     //       color: Color(0xffFF5673),
                              //     //       width: 24,
                              //     //     ),
                              //     //   ),
                              //     // ),
                              //     // Padding(
                              //     //   padding: const EdgeInsets.symmetric(horizontal: 10),
                              //     //   child: GestureDetector(
                              //     //     onTap: () {
                              //     //       print('1');
                              //     //       Get.to(Eshtrkaty(
                              //     //         company_id: branches.id,
                              //     //         typeAdsOrPlan: 1,
                              //     //       ));
                              //     //     },
                              //     //     child: Image.asset(
                              //     //       'assets/images/ads.png',
                              //     //       color: Colors.green,
                              //     //       width: 24,
                              //     //     ),
                              //     //   ),
                              //     // ),
                              //     // Padding(
                              //     //   padding: const EdgeInsets.symmetric(horizontal: 10),
                              //     //   child: GestureDetector(
                              //     //       onTap: (){
                              //     //         print('2');
                              //     //         Get.to(EditCompanyScreen(company_id: branches.id,));
                              //     //       },
                              //     //       child: Icon(Icons.edit,size: 24,color: Color(0xff848DFF),)),
                              //     // ),
                              //     // Padding(
                              //     //   padding: const EdgeInsets.symmetric(horizontal: 10),
                              //     //   child: GestureDetector(
                              //     //       onTap: (){
                              //     //         Get.to(ResturantPageScreen(compaine_id: branches.id,flagBranch: true,));
                              //     //       },
                              //     //       child: Icon(MdiIcons.eye,size: 28,color: Color(0xff01B2CB),)),
                              //     // ),
                              //   ],
                              // ),
                              GestureDetector(
                                onTap: () async {
                                  if (branches!.active == 1) {
                                    Get.to(EditCompanyScreen(
                                      company_id: branches!.id,
                                    ));
                                  } else {
                                    await showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ShowCheckActiveSubDialog(
                                          company_id: branches!.id,
                                        );
                                      },
                                    );
                                  }
                                },
                                child: Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 7),
                                    child: Text(
                                      'bt_edit_bran'.tr,
                                      style: const TextStyle(
                                          fontSize: 13.0,
                                          color: Color(0xff01B2CB)),
                                      //overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        // Positioned(
        //   right: 10,
        //   top: 10,
        //   child:
        // // FlatButton(
        // //
        // //     // height: 60,
        // //     // minWidth: Get.width-100,
        // //     child: Text('Edit', style: kTextStyle.copyWith(fontSize: 13)),
        // //     color: Color(0xff848DFF),
        // //     textColor: Color(0xffFFFFFF),
        // //     onPressed: () async {
        // //
        // //       },
        // //     shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0))
        // // ),
        // // Container(
        // //   decoration: const BoxDecoration(
        // //       color: Color(0xff848DFF),
        // //       borderRadius: BorderRadius.all(Radius.circular(10.0)),
        // //      ),
        // //   child: Padding(
        // //     padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 5),
        // //     child: Icon(MdiIcons.accountEditOutline,size: 30,color: Color(0xff848DFF),)
        // //     // Text(
        // //     //   'Edit',
        // //     //   style: TextStyle(color: Color(0xffFFFFFF)),
        // //     // ),
        // //   ),
        // // )
        //   Icon(MdiIcons.accountEdit,size: 32,color: Color(0xff848DFF),),
        // ),
        // Positioned(
        //   right: 12,
        //   bottom:  10,
        //   child:
        // FlatButton(
        //
        //     // height: 60,
        //     // minWidth: Get.width-100,
        //     child: Text('details', style: kTextStyle.copyWith(fontSize: 13)),
        //     color: Color(0xffFF5673),
        //     textColor: Color(0xffFFFFFF),
        //     onPressed: () async {
        //
        //       },
        //     shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0))
        // ),)
      ],
    );
  }
}

class BuildCardHeaderBranchComoany extends StatelessWidget {
  final int? id;
  final String? name;
  final String? desc;
  final String? image;
  final int? total_rating;
  final int? visit_count;
  final int? active;

  const BuildCardHeaderBranchComoany(
      {Key? key,
      this.id,
      this.name,
      this.desc,
      this.image,
      this.total_rating,
      this.visit_count,
      this.active})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () async {
            if (active == 1) {
              Get.to(ResturantPageScreen(
                compaine_id: id,
                flagBranch: true,
                ad_id: 0,
              ));
            } else {
              await showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return ShowCheckActiveSubDialog(
                    company_id: id,
                  );
                },
              );
            }
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 1,
                    color: Color(0xffe6e6e4),
                    blurRadius: 1,
                    offset: Offset(0, 2),
                  ),
                ]),
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // const Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 8),
                  //   child: Divider(
                  //     height: 2,
                  //     color: Color(0xffB2B1B1),
                  //     indent: 30,
                  //     endIndent: 30,
                  //     thickness: 1.5,
                  //   ),
                  // ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.3),
                              width: 0.4,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(image != null
                                ? '$ImgUrl${image}'
                                : defaultImgUrl),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Container(
                                        //   width: Get.width * 0.55,
                                        //   child:
                                        //       // Marquee(
                                        //       //     text: "zacks",
                                        //       //     style: const TextStyle(fontSize: 18.0)),
                                        //       SingleChildScrollView(
                                        //     scrollDirection: Axis.horizontal,
                                        //     physics: BouncingScrollPhysics(),
                                        //     child: Text(
                                        //       name,
                                        //       style:
                                        //           const TextStyle(fontSize: 18.0),
                                        //       //overflow: TextOverflow.ellipsis,
                                        //     ),
                                        //   ),
                                        // ),
                                        Expanded(
                                          child: Text(
                                            name!,
                                            style:
                                                const TextStyle(fontSize: 18.0),
                                            maxLines: 2,
                                            // overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        // Text(
                                        //   bannerData.name,
                                        //   style: const TextStyle(fontSize: 18.0),
                                        //   overflow: TextOverflow.ellipsis,
                                        // ),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        if (active == 1)
                                          const Icon(
                                            Icons.check_circle_outline,
                                            color: Colors.green,
                                            size: 16,
                                          )
                                        else
                                          const Icon(
                                            Icons.check_circle_outline,
                                            color: Colors.grey,
                                            size: 16,
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                '${desc}',
                                maxLines: 3,
                                style: kTextStyle.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 7,
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
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 100,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Color(0xffF5F5F5),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                      // border: Border.all(
                                      //   color: Colors.grey.withOpacity(0.3),
                                      //   width: 0.4,
                                      // ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 5),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 24,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '${total_rating}',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xffF5F5F5),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                      // border: Border.all(
                                      //   color: Colors.grey.withOpacity(0.3),
                                      //   width: 0.4,
                                      // ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 5),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          const Icon(MdiIcons.eye,
                                              size: 24,
                                              color: Color(0xff01B2CB)),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          // Text(
                                          //   visit_count > 999
                                          //       ? '${visit_count / 1000}K'
                                          //       : visit_count > 999999
                                          //           ? '${visit_count / 1000000}M'
                                          //           : '${visit_count}',
                                          //   style: TextStyle(
                                          //       fontSize: 12,
                                          //       color: Colors.black),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.end,
                              //   children: [
                              //     Padding(
                              //       padding: const EdgeInsets.symmetric(horizontal: 10),
                              //       child: GestureDetector(
                              //         onTap: () async {
                              //
                              //           if (active == 1) {
                              //             Get.to(SocialsScreen(
                              //               company_id: id,
                              //             ));
                              //           } else {
                              //             await showModalBottomSheet<void>(
                              //               context: context,
                              //               builder: (BuildContext context) {
                              //                 return ShowCheckActiveSubDialog(
                              //                   company_id: id,
                              //                 );
                              //               },
                              //             );
                              //           }
                              //         },
                              //         //social 0xff01B2CB
                              //         // child: Icon(MdiIcons.socialDistance6Feet,size: 24,color: Color(0xff01B2CB),),
                              //         child: Image.asset(
                              //           'assets/images/social.png',
                              //           // color: Color(0xff01B2CB),
                              //           width: 24,
                              //         ),
                              //       ),
                              //     ),
                              //     // Padding(
                              //     //   padding: const EdgeInsets.symmetric(horizontal: 10),
                              //     //   child: GestureDetector(
                              //     //     onTap: () {
                              //     //       print('1');
                              //     //       Get.to(Eshtrkaty(
                              //     //         company_id: id,
                              //     //         typeAdsOrPlan: 0,
                              //     //       ));
                              //     //     },
                              //     //     child: Image.asset(
                              //     //       'assets/images/subscription.png',
                              //     //       color: Color(0xffFF5673),
                              //     //       width: 24,
                              //     //     ),
                              //     //   ),
                              //     // ),
                              //     // Padding(
                              //     //   padding: const EdgeInsets.symmetric(horizontal: 10),
                              //     //   child: GestureDetector(
                              //     //     onTap: () {
                              //     //       print('1');
                              //     //       Get.to(Eshtrkaty(
                              //     //         company_id: id,
                              //     //         typeAdsOrPlan: 1,
                              //     //       ));
                              //     //     },
                              //     //     child: Image.asset(
                              //     //       'assets/images/ads.png',
                              //     //       color: Colors.green,
                              //     //       width: 24,
                              //     //     ),
                              //     //   ),
                              //     // ),
                              //     // Padding(
                              //     //   padding: const EdgeInsets.symmetric(horizontal: 10),
                              //     //   child: GestureDetector(
                              //     //       onTap: (){
                              //     //         print('2');
                              //     //         print(id);
                              //     //
                              //     //         Get.to(EditCompanyScreen(company_id: id,));
                              //     //       },
                              //     //       child: Icon(Icons.edit,size: 24,color: Color(0xff848DFF),)),
                              //     // ),
                              //     // Padding(
                              //     //   padding: const EdgeInsets.symmetric(horizontal: 10),
                              //     //   child: GestureDetector(
                              //     //       onTap: (){
                              //     //         Get.to(ResturantPageScreen(compaine_id: id,flagBranch: true,));
                              //     //       },
                              //     //       child: Icon(MdiIcons.eye,size: 28,color: Color(0xff01B2CB),)),
                              //     // ),
                              //   ],
                              // ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (active == 1) {
                                    Get.to(EditCompanyScreen(
                                      company_id: id,
                                    ));
                                  } else {
                                    await showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ShowCheckActiveSubDialog(
                                          company_id: id,
                                        );
                                      },
                                    );
                                  }
                                },
                                child: Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 7),
                                    child: Text(
                                      'bt_edit_bran'.tr,
                                      style: const TextStyle(
                                          fontSize: 13.0,
                                          color: Color(0xff01B2CB)),
                                      //overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        // Positioned(
        //   right: 10,
        //   top: 10,
        //   child:
        // // FlatButton(
        // //
        // //     // height: 60,
        // //     // minWidth: Get.width-100,
        // //     child: Text('Edit', style: kTextStyle.copyWith(fontSize: 13)),
        // //     color: Color(0xff848DFF),
        // //     textColor: Color(0xffFFFFFF),
        // //     onPressed: () async {
        // //
        // //       },
        // //     shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0))
        // // ),
        // // Container(
        // //   decoration: const BoxDecoration(
        // //       color: Color(0xff848DFF),
        // //       borderRadius: BorderRadius.all(Radius.circular(10.0)),
        // //      ),
        // //   child: Padding(
        // //     padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 5),
        // //     child: Icon(MdiIcons.accountEditOutline,size: 30,color: Color(0xff848DFF),)
        // //     // Text(
        // //     //   'Edit',
        // //     //   style: TextStyle(color: Color(0xffFFFFFF)),
        // //     // ),
        // //   ),
        // // )
        //   Icon(MdiIcons.accountEdit,size: 32,color: Color(0xff848DFF),),
        // ),
        // Positioned(
        //   right: 12,
        //   bottom:  10,
        //   child:
        // FlatButton(
        //
        //     // height: 60,
        //     // minWidth: Get.width-100,
        //     child: Text('details', style: kTextStyle.copyWith(fontSize: 13)),
        //     color: Color(0xffFF5673),
        //     textColor: Color(0xffFFFFFF),
        //     onPressed: () async {
        //
        //       },
        //     shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0))
        // ),)
      ],
    );
  }
}
