import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class SideMenuContainer extends StatelessWidget {
  SharedPreferenceHelper helper = GetIt.instance.get<SharedPreferenceHelper>();
  SideMenuContainer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height*0.17,
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
      child: Column(
        children: <Widget>[
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 10),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     // ignore: prefer_const_literals_to_create_immutables
          //     children: <Widget>[
          //       const Text(
          //         'Side Menu',
          //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          //       ),
          //       const SizedBox(width: 40),
          //       const Icon(Icons.close_rounded, color: Colors.grey, size: 25),
          //     ],
          //   ).addPaddingOnly( bottom: 20, top: 20),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
                 // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const SizedBox(width: 20),
                  StreamBuilder<String>(
                      stream: Stream.fromFuture(getAvatar()),
                      builder: (context, snapshotAvatar) {
                        // Image.asset(Assets.LAYLA),
                        if (snapshotAvatar.hasData) {
                          if (snapshotAvatar.data != null) {
                            return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.3),
                                    width: 0.4,
                                  ),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                                ),
                                child: CircleAvatar(
                                  radius: 45,
                                  backgroundImage: NetworkImage(
                                    '$ImgUrl${snapshotAvatar.data}',
                                  ),
                                ));
                          }else{
                            return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.3),
                                    width: 0.4,
                                  ),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                                ),
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: AssetImage(
                                    'assets/images/userImg.jpeg',
                                  ),
                                ));
                          }
                        } else if (!snapshotAvatar.hasData) {
                          return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.3),
                                  width: 0.4,
                                ),
                                borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                              ),
                              child: CircleAvatar(
                                radius: 45,
                                backgroundImage: AssetImage(
                                  'assets/images/userImg.jpeg',
                                ),
                              ));
                        }else {
                          return SizedBox(
                              child: Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: kPrimaryColor,
                                  )));
                        }
                      }),
                  const SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: <Widget>[
                        StreamBuilder<String>(
                            stream: Stream.fromFuture(getNameUser()),
                            builder: (context, snapshotNameUser) {
                              if (snapshotNameUser.hasData) {
                                return Row(
                                  children: [
                                    Container(
                                      width: Get.width*0.55 ,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        physics: BouncingScrollPhysics(),
                                        child: Text(
                                          '${snapshotNameUser.data}',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                      ),
                                    ),

                                    StreamBuilder<String>(
                                        stream: Stream.fromFuture(getTypeMarketer()),
                                        builder: (context, snapshotTypeUser) {
                                          print('we ${snapshotTypeUser.data}');
                                          if (snapshotTypeUser.hasData) {
                                            if (snapshotTypeUser.data == 'Marketer') {
                                              return
                                                StreamBuilder<int>(
                                                    stream: Stream.fromFuture(getActive()),
                                                    builder: (context, snapshotActive) {
                                                      if(snapshotActive.hasData){
                                                        if(snapshotActive.data !=0) {
                                                          return const Icon(
                                                            Icons.check_circle_outline,
                                                            color: Colors.green,
                                                            size: 16,
                                                          );
                                                        }
                                                      }

                                                      return  const Icon(
                                                        Icons.check_circle_outline,
                                                        color: Colors.grey,
                                                        size: 16,
                                                      );
                                                    }
                                                );
                                            } else {
                                              return SizedBox();
                                            }
                                          } else {
                                            return SizedBox();
                                          }
                                        }),

                                  ],
                                );
                              } else {
                                return SizedBox();
                              }
                            }),
                        const SizedBox(height: 5),
                        StreamBuilder<String>(
                            stream: Stream.fromFuture(getCode()),
                            builder: (context, snapshotCode) {
                              if (snapshotCode.hasData) {
                                return Text(
                                  'ID : ${snapshotCode.data}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: Colors.grey),
                                );
                              } else {
                                return SizedBox();
                              }
                            }),
                        StreamBuilder<String>(
                            stream: Stream.fromFuture(getTypeOfUser()),
                            builder: (context, snapshotTypeUser) {
                              if (snapshotTypeUser.hasData) {
                                if (snapshotTypeUser.data == 'Marketer') {
                                  return
                                  Row(
                                    // ignore: prefer_const_literals_to_create_immutables
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      StreamBuilder<String>(
                                          stream: Stream.fromFuture(getMarketer()),
                                          builder: (context, snapshotCode) {
                                            if (snapshotCode.hasData) {
                                              return Text(
                                                '${snapshotCode.data}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13,
                                                    color: Colors.green),
                                              );
                                            } else {
                                              return SizedBox();
                                            }
                                          }),

                                      const SizedBox(width: 10),

                                      StreamBuilder<String>(

                                        stream: Stream.fromFuture(getShareMessageMarketer()),
                                          builder: (context, snapshotShareMessage) {

                                          return  StreamBuilder<String>(

                                              stream: Stream.fromFuture(getMarketer()),
                                              builder: (context, snapshotCode) {
                                                return GestureDetector(
                                                  onTap:() async {
                                                    await FlutterShare.share(
                                                        title: 'ID  Marketer',
                                                        text: '${snapshotShareMessage.data}',
                                                        // ignore: unnecessary_string_interpolations
                                                        linkUrl: '${snapshotCode.data}',
                                                        chooserTitle: 'Choose To share ID  Marketer'
                                                    );
                                                  },
                                                  child: const CircleAvatar(
                                                    radius: 15,
                                                    backgroundColor: Colors.green,
                                                    child: Icon(
                                                      Icons.share,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                );
                                              }
                                          );
                                        }
                                      )
                                    ],
                                  );
                                } else {
                                  return SizedBox();
                                }
                              } else {
                                return SizedBox();
                              }
                            }),
                      ],
                    ),
                  ),



                  // Padding(
                  //   padding: EdgeInsets.only(left: 5, right: 5),
                  //   child: Container(
                  //     width: 110,
                  //     height: 110,
                  //     decoration:  BoxDecoration(
                  //
                  //       borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  //       border: Border.all(
                  //         color: Colors.grey.withOpacity(0.3),
                  //         width: 0.4,
                  //       ),
                  //
                  //     ),
                  //     child: CircleAvatar(
                  //       radius: 70,
                  //       backgroundImage: NetworkImage(
                  //         'https://cdn.pixabay.com/photo/2017/02/03/03/54/burger-2034433__480.jpg',
                  //
                  //         //'$ImgUrl${reviewsData.user.avatar}',
                  //
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ]),
          ),
        ],
      ),
    );
  }

  Future<String> getTypeOfUser() async {
    int active=await helper.getActive();
    String type=await helper.getType();
    if(active==1&&type=='Marketer'){
      return 'Marketer';
    }
    // return await helper.getType();
    return '';
  }

  Future<String> getNameUser() async {
    return await helper.getName();
  }
  Future<String> getShareMessageMarketer() async {
    return await helper.getShareMessage();
  }
  Future<String> getTypeMarketer() async {
    return await helper.getType();
  }

  Future<String> getCode() async {
    return await helper.getCode();
  }
  Future<String> getMarketer() async {
    return await helper.getMarketer();
  }

  Future<String> getAvatar() async {
    return await helper.getAvatar();
  }
  Future<int> getActive() async {
    return await helper.getActive();
  }
}
