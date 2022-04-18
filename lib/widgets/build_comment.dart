import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:al_murafiq/models/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart' as intl;
import 'package:get/get.dart';

class BuildComment extends StatelessWidget {
  final ReviewsData reviewsData;
  final TextDirection textDirection;

  BuildComment({Key key, this.reviewsData, this.textDirection})
      : super(key: key);

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
      child: Stack(
        children: [
          StreamBuilder<String>(
              stream: Stream.fromFuture(getLangCode()),
              builder: (context, snapshotCode) {

                if (snapshotCode.hasData) {
                  if(snapshotCode.data=='ar'){
                    return Positioned(
                        left: 15,
                        top: 15,
                        child: Container(
                          width: 70,
                          height: 30,
                          decoration: BoxDecoration(
                            //color: Colors.redAccent,
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.3),
                              width: 0.4,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${reviewsData.rate}',
                                style:
                                TextStyle(fontSize: 12, color: Colors.black),
                              ),
                            ],
                          ),
                        ));
                  }else{
                    return Positioned(
                        right:  15,
                        top: 15,
                        child: Container(
                          width: 70,
                          height: 30,
                          decoration: BoxDecoration(
                            //color: Colors.redAccent,
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.3),
                              width: 0.4,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${reviewsData.rate}',
                                style:
                                TextStyle(fontSize: 12, color: Colors.black),
                              ),
                            ],
                          ),
                        ));
                  }

                } else {
                  return SizedBox();
                }
              }),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: SizedBox(
                        width: 5,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(left: 7, right: 7),
                        child: Container(
                          width: 5,
                          height: Get.height * 0.1,
                          decoration: const BoxDecoration(
                            color: Color(0xff09BBCF),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: Container(
                          width: 80,
                          height: 80,
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
                            backgroundImage: NetworkImage(
                              reviewsData.company.image != null
                                  ? '$ImgUrl${reviewsData.company.image}'
                                  :  defaultImgUrl,
                              //'$ImgUrl${reviewsData.user.avatar}',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 13,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              reviewsData.user.name,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 15.0),
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          reviewsData.comment != null
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    reviewsData.comment,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          const SizedBox(
                            height: 7,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            '${reviewsData.company.name}',
                            style: const TextStyle(
                                fontSize: 10, color: Colors.black),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          '${reviewsData.created_at}',
                          style: const TextStyle(
                              fontSize: 11, color: Colors.black),
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
    );
  }

  SharedPreferenceHelper helper = GetIt.instance.get<SharedPreferenceHelper>();
  Future<String> getLangCode() async {
    return await helper.getCodeLang();
  }
}
