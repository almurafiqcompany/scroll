
import 'package:al_murafiq/models/home_page.dart';
import 'package:al_murafiq/screens/home_page/company/resturant_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

import '../constants.dart';

class BuildCard extends StatelessWidget {
  final BannerData? bannerData;

  const BuildCard({Key? key, this.bannerData}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(ResturantPageScreen(flagBranch: false,compaine_id: bannerData!.company_id,ad_id:bannerData!.id! ,));
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
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration:  BoxDecoration(

                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.3),
                      width: 0.4,
                    ),

                  ),
                  child: CircleAvatar(

                    radius: 60,
                    backgroundImage: NetworkImage(
                      '$ImgUrl${bannerData!.image}',
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child:Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                // Container(
                                //   width:(Get.width / 3)-10,
                                //   child:
                                //   // Marquee(
                                //   //     text: "zacks",
                                //   //     style: const TextStyle(fontSize: 18.0)),
                                //   SingleChildScrollView(
                                //     scrollDirection: Axis.horizontal,
                                //     physics: BouncingScrollPhysics(),
                                //     child: Text(
                                //       bannerData.name,
                                //       style: const TextStyle(fontSize: 17.0),
                                //       //overflow: TextOverflow.ellipsis,
                                //     ),
                                //   ),
                                // ),
                                Expanded(
                                  child: Text(
                                    bannerData!.name!,
                                    style: const TextStyle(fontSize: 18.0),
                                    maxLines: 2,
                                    // overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(
                                  width: 1,
                                ),
                                const Icon(
                                  Icons.check_circle_outline,
                                  color: kPrimaryColor,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // RatingBar(

                              //   rating: bannerData!.total_rating.toDouble(),
                              //   icon: const Icon(
                              //     Icons.star,
                              //     size: 17,
                              //     color: Colors.grey,
                              //   ),
                              //   starCount: 5,
                              //   spacing: 1.0,
                              //   size: 12,
                              //   isIndicator: true,
                              //   allowHalfRating: true,

                              //   // onRatingCallback: (double value,ValueNotifier<bool> isIndicator){
                              //   //   print('Number of stars-->  $value');
                              //   //   isIndicator.value=true;
                              //   // },
                              //   color: Colors.amber,
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // const SizedBox(
                    //                     //   height: 3,
                    //                     // ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 10),
                    //   child: ReadMoreText(
                    //     '${bannerData.des}',
                    //     trimLines: 3,
                    //     colorClickableText: Colors.blue,
                    //     trimMode: TrimMode.Line,
                    //     trimCollapsedText: '▼ ',
                    //     trimExpandedText: '▲',
                    //     style: kTextStyle.copyWith(
                    //       fontSize: 12,
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        '${bannerData!.des}',
                        maxLines: 3,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),

                    // Row(بابا
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
        ),
      ),
    );
  }
}