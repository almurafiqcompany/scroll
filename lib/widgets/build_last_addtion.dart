import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/models/home_page.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:get/get.dart';
class BuildLastAddtion extends StatelessWidget {
  final LatestCompaniesData? latestCompaniesData;
  final TextDirection? textDirection;

  const BuildLastAddtion({Key? key, this.latestCompaniesData, this.textDirection}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
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
                          //'$ImgUrl${latestCompaniesData.image?}',
                          latestCompaniesData!.image != null?'$ImgUrl${latestCompaniesData!.image}':defaultImgUrl,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                children: [
                                  // Container(
                                  //   width:(Get.width / 2)-30,
                                  //   child:
                                  //   // Marquee(
                                  //   //     text: "zacks",
                                  //   //     style: const TextStyle(fontSize: 18.0)),
                                  //   SingleChildScrollView(
                                  //     scrollDirection: Axis.horizontal,
                                  //     physics: BouncingScrollPhysics(),
                                  //     child: Text(
                                  //       latestCompaniesData.name,
                                  //       style: const TextStyle(fontSize: 17.0),
                                  //       //overflow: TextOverflow.ellipsis,
                                  //     ),
                                  //   ),
                                  // ),
                                  Expanded(
                                    child: Text(
                                      latestCompaniesData!.name!,
                                      style: const TextStyle(fontSize: 18.0),
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
                                ],
                              ),
                            ),
                          ),


                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          latestCompaniesData!.desc!,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),
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
                                  if (latestCompaniesData!.distance != null)
                                    Container(
                                      width: 50,
                                      height: 20,
                                      decoration: const BoxDecoration(
                                        color: Color(0xff848DFF),
                                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                      ),
                                      child: Center(
                                          child: Text(
                                            latestCompaniesData!.distance!,
                                            style: TextStyle(fontSize: 10, color: Colors.white),
                                          )),
                                    ) else SizedBox(),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  if (latestCompaniesData!.city != null)
                                  Container(
                                    width: 50,
                                    height: 20,
                                    decoration: const BoxDecoration(
                                      gradient: kAdsHomeGradient,
                                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                    ),
                                    child:  Center(
                                        child: Text(
                                          latestCompaniesData!.city!.name!,
                                          style: TextStyle(fontSize: 10, color: Colors.white),
                                        )),
                                  )else SizedBox(),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // RatingBar(
                                  //   rating: latestCompaniesData.total_rating.toDouble(),
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

                                  //   color: Colors.amber,
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }
}