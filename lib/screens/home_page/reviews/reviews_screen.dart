import 'package:al_murafiq/constants.dart';
import 'package:al_murafiq/models/profile_compaine.dart';
import 'package:al_murafiq/screens/home_page/company/profile_company_bloc.dart';
import 'package:al_murafiq/screens/notification/notification_screen.dart';
import 'package:al_murafiq/widgets/show_check_login_dialog.dart';
import 'package:animate_do/animate_do.dart';

import 'package:flutter/material.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';
import 'package:al_murafiq/extensions/extensions.dart';
import 'package:get_it/get_it.dart';
import 'package:al_murafiq/core/shared_pref_helper.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
class ReviewsScreen extends StatefulWidget {
  final List<Reviews> reviews;

  final ProfileCompanyBloc profileCompaineBloc;
  final ProfileCompany profileCompany;
  ReviewsScreen(
      {Key key, this.reviews, this.profileCompaineBloc, this.profileCompany})
      : super(key: key);

  @override
  _ReviewsScreenState createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Text('text_resturant'.tr),
        actions: [
          StreamBuilder<String>(
              stream: Stream.fromFuture(
                  getIsLogIn()),
              builder: (context,
                  snapshotToken) {

                if (snapshotToken
                    .hasData ) {

                  return  GestureDetector(
                    onTap: () {

                      Get.to(NotificationScreen());
                    },
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                          child: const Icon(
                            Icons.notifications,
                            size: 30,
                          ),
                        ),
                        StreamBuilder<int>(
                            stream: Stream.fromFuture(
                                getNumberOfNotfiction()),
                            builder: (context, snapshotNumNotif) {
                              if(snapshotNumNotif.hasData && snapshotNumNotif.data != 0){
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 2),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal:3,vertical: 0),
                                      child: Text('${snapshotNumNotif.data}',style: TextStyle(fontSize: 12),textAlign: TextAlign.center,),
                                    ),
                                  ),
                                );
                              }
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                                child: Container(),
                              );
                            }
                        ),
                      ],
                    ),
                  );
                } else {
                  return GestureDetector(
                    onTap: () async {
                      await showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return ShowCheckLoginDialog();
                        },
                      );
                    },
                    child: const Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 8),
                      child:  Icon(
                        Icons.notifications,
                        size: 30,
                      ),
                    ),
                  );

                }
              }),

        ],
        elevation: 0,
        flexibleSpace: Column(
          children: <Widget>[
            Flexible(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xFF03317C),
                      Color(0xFF05B3D6),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.maxFinite,
              height: 6,
              color: Colors.lime,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
              child: Container(
                  //   margin: EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Container(
                          width: 100,
                          height: 100,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(
                              widget.profileCompany.image != null
                                  ? '$ImgUrl${widget.profileCompany.image}'
                                  : defaultImgUrl,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    physics: BouncingScrollPhysics(),
                                    child: Text(
                                      widget.profileCompany.name,
                                      style: TextStyle(fontSize: 17.0),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  const Icon(
                                    Icons.check_circle_outline,
                                    color: kPrimaryColor,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                // const Padding(
                                //   padding:
                                //       EdgeInsets.symmetric(horizontal: 8),
                                //   child: Icon(Icons.location_on),
                                // ),

                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  physics: BouncingScrollPhysics(),
                                  child: Text(
                                    widget.profileCompany.address,
                                    style: const TextStyle(
                                        fontSize: 13, color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                //crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.end,
                                      children: [
                                        RatingBar(
                                          rating: widget
                                              .profileCompany.total_rating
                                              .toDouble(),
                                          icon: const Icon(
                                            Icons.star,
                                            size: 17,
                                            color: Colors.grey,
                                          ),
                                          starCount: 5,
                                          spacing: 1.0,
                                          size: 12,
                                          isIndicator: true,
                                          allowHalfRating: true,

                                          // onRatingCallback: (double value,ValueNotifier<bool> isIndicator){

                                          //   isIndicator.value=true;
                                          // },
                                          color: Color(0xffFFAC41),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    physics: BouncingScrollPhysics(),
                                    child: Text(
                                      // '${widget.profileCompany.visit_count}',
                                      widget.profileCompany.visit_count>999?'${widget.profileCompany.visit_count/1000}K':widget.profileCompany.visit_count>999999?'${widget.profileCompany.visit_count/1000000}M':'${widget.profileCompany.visit_count}',

                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xffFFAC41)),
                                    ),
                                  ),
                                  StreamBuilder<String>(
                                      stream: Stream.fromFuture(getIsLogIn()),
                                      builder: (context, snapshotToken) {
                                        if (snapshotToken.hasData) {

                                          //  if(snapshot.data.fav == 0){
                                          //   return Icon(Icons.favorite,color: Colors.grey[600],);
                                          // }else if(snapshot.data.fav == 1){
                                          //   return Icon(Icons.favorite,color: Color(0xffEB1346),);
                                          // }
                                          return StreamBuilder<int>(
                                              stream: widget
                                                  .profileCompaineBloc
                                                  .favCompanySubject
                                                  .stream,
                                              initialData: widget
                                                  .profileCompaineBloc
                                                  .dataOfProfileCompanySubject
                                                  .value
                                                  .fav,
                                              builder:
                                                  (context, snapshotfav) {
                                                if (snapshotfav.data == 0) {
                                                  return GestureDetector(
                                                      onTap: () async {
                                                        await widget
                                                            .profileCompaineBloc
                                                            .favCompany(widget
                                                                .profileCompany
                                                                .id,context);

                                                      },
                                                      child: Icon(
                                                        Icons.favorite,
                                                        color:
                                                            Colors.grey[600],
                                                      ));
                                                } else if (snapshotfav.data ==
                                                    1) {
                                                  return GestureDetector(
                                                      onTap: () async {
                                                        await widget
                                                            .profileCompaineBloc
                                                            .favDesCompany(widget
                                                                .profileCompany
                                                                .id,context);

                                                      },
                                                      child: Icon(
                                                        Icons.favorite,
                                                        color:
                                                            Color(0xffEB1346),
                                                      ));
                                                }
                                                return Icon(
                                                  Icons.favorite,
                                                  color: Colors.grey[600],
                                                );
                                              });
                                        } else {
                                          return GestureDetector(
                                            onTap: () async {
                                              await showModalBottomSheet<void>(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return ShowCheckLoginDialog();
                                                },
                                              );
                                            },
                                            child: Icon(
                                              Icons.favorite,
                                              color: Colors.grey[600],
                                            ),
                                          );
                                        }
                                      }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
            const SizedBox(
              height: 10,
            ),

            ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: widget.reviews.length,
              itemBuilder: (BuildContext context, int index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: ZoomIn(
                  duration: Duration(milliseconds: 600),
                  delay: Duration(
                      milliseconds:
                      index * 100 > 1000 ? 600 : index * 120),
                  child: BuildComment(
                    textDirection: TextDirection.rtl,
                    reviews: widget.reviews[index],
                    profileCompaineBloc: widget.profileCompaineBloc,
                    like_init: widget.reviews[index].comment_likes != null?1:0,
                    dis_like_init:widget.reviews[index].comment_dis_likes != null?1:0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SharedPreferenceHelper helper = GetIt.instance.get<SharedPreferenceHelper>();
  Future<String> getIsLogIn() async {
    return await helper.getToken();
  }
  Future<int> getNumberOfNotfiction() async {
    return await helper.getNumberOfNotfiction();
  }
}

class BuildComment extends StatefulWidget {
  final Reviews reviews;
  final TextDirection textDirection;
  final ProfileCompanyBloc profileCompaineBloc;
  final int like_init;
  final int dis_like_init;

   BuildComment({Key key, this.reviews, this.textDirection, this.profileCompaineBloc, this.like_init, this.dis_like_init}) : super(key: key);

  @override
  _BuildCommentState createState() => _BuildCommentState();
}

class _BuildCommentState extends State<BuildComment> {
  final likeCommentSubject = BehaviorSubject<int>();

  final dislikeCommentSubject = BehaviorSubject<int>();

  final numberOfLikeSubject = BehaviorSubject<int>();

  final numberOfdislikeSubject = BehaviorSubject<int>();

  @override
  void initState() {
    numberOfLikeSubject.sink.add(widget.reviews.likes_count);
    numberOfdislikeSubject.sink.add(widget.reviews.dislikens_count);
    // TODO: implement initState
    super.initState();
  }
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
                        left:  15,
                        top: 15,
                        child: Container(
                          width: 70,
                          height: 30,
                          decoration: const BoxDecoration(
                            //color: Colors.redAccent,
                            borderRadius: BorderRadius.all(Radius.circular(3.0)),
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
                                '${widget.reviews.rate}',
                                style:
                                const TextStyle(fontSize: 12, color: Colors.black),
                              ),
                            ],
                          ),
                        ));
                  }else{
                    return Positioned(
                        right: 15,
                        top: 15,
                        child: Container(
                          width: 70,
                          height: 30,
                          decoration: const BoxDecoration(
                            //color: Colors.redAccent,
                            borderRadius: BorderRadius.all(Radius.circular(3.0)),
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
                                '${widget.reviews.rate}',
                                style:
                                const TextStyle(fontSize: 12, color: Colors.black),
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
              mainAxisAlignment: MainAxisAlignment.center,
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
                          height: 65,
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
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(
                              widget.reviews.user.avatar != null
                                  ? '$ImgUrl${widget.reviews.user.avatar}'
                                  : defaultImgUrl,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 13,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              widget.reviews.user.name,
                              style: const TextStyle(fontSize: 17.0),
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              widget.reviews.comment !=null ?widget.reviews.comment:"",
                              maxLines: 3,
                              style: kTextStyle.copyWith(
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (widget.reviews.created_at != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          child: Text(
                            // ignore: unnecessary_string_interpolations
                            '${widget.reviews.created_at.split('T')[0].trim()}',
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black),
                          ),
                        ),
                      )
                    else
                      SizedBox(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        Row(
                          children: [
                            StreamBuilder<int>(
                              stream: numberOfdislikeSubject.stream,
                              initialData: widget.reviews.dislikens_count,
                              builder: (context, snapshot) {
                                return Text(
                                '${snapshot.data}',
                                style:
                                const TextStyle(fontSize: 11, color: Colors.black),
                          );
                              }
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            StreamBuilder<String>(
                                stream: Stream.fromFuture(getIsLogIn()),
                                builder: (context, snapshotToken) {
                                  if (snapshotToken.hasData) {

                                    //  if(snapshot.data.fav == 0){
                                    //   return Icon(Icons.favorite,color: Colors.grey[600],);
                                    // }else if(snapshot.data.fav == 1){
                                    //   return Icon(Icons.favorite,color: Color(0xffEB1346),);
                                    // }
                                    return StreamBuilder<int>(
                                        stream: dislikeCommentSubject
                                            .stream,
                                        initialData: widget.dis_like_init,
                                        builder:
                                            (context, snapshotfav) {
                                          if (snapshotfav.data == 0) {
                                            return GestureDetector(
                                                onTap: () async {

                                                    bool co =
                                                    await widget.profileCompaineBloc
                                                        .dislikeComment(widget.reviews.id,context);
                                                    if (co) {
                                                      // await Get.back();
                                                      widget.profileCompaineBloc
                                                          .commentController
                                                          .text = '';
                                                      dislikeCommentSubject
                                                          .sink
                                                          .add(1);
                                                      numberOfdislikeSubject
                                                          .sink.add(
                                                          numberOfdislikeSubject
                                                              .value + 1);
                                                    }
                                                  // widget.profileCompaineBloc.commentController.text = '';
                                                  // await showModalBottomSheet<void>(
                                                  //   context: context,
                                                  //   isScrollControlled: true,
                                                  //   builder: (BuildContext context) {
                                                  //     return Padding(
                                                  //       padding: MediaQuery.of(context).viewInsets,
                                                  //       child: Container(
                                                  //         height: 250,
                                                  //         child: Center(
                                                  //           child: SingleChildScrollView(
                                                  //             child: Column(
                                                  //               mainAxisAlignment: MainAxisAlignment.center,
                                                  //               mainAxisSize: MainAxisSize.min,
                                                  //               children: <Widget>[
                                                  //                 const SizedBox(
                                                  //                   height: 5,
                                                  //                 ),
                                                  //                 Padding(
                                                  //                   padding: const EdgeInsets.symmetric(
                                                  //                       horizontal: 15, vertical: 5),
                                                  //                   child: StreamBuilder<bool>(
                                                  //                       stream: widget.profileCompaineBloc.reportSubject.stream,
                                                  //                       initialData: true,
                                                  //                       builder: (context, snapshot) {
                                                  //                         return TextField(
                                                  //                           controller:
                                                  //                           widget.profileCompaineBloc.reportController,
                                                  //                           onChanged:
                                                  //                               (val) =>
                                                  //                                   widget.profileCompaineBloc.changeReport(val),
                                                  //                           style: TextStyle(
                                                  //                               fontSize:
                                                  //                               18),
                                                  //                           decoration:
                                                  //                           InputDecoration(
                                                  //                             filled:
                                                  //                             true,
                                                  //                             fillColor:
                                                  //                             Colors.white,
                                                  //                             focusedBorder:
                                                  //                             OutlineInputBorder(
                                                  //                               borderRadius:
                                                  //                               const BorderRadius.all(Radius.circular(6)),
                                                  //                               borderSide: BorderSide(
                                                  //                                   width: 1,
                                                  //                                   color: Colors.grey),
                                                  //                             ),
                                                  //                             disabledBorder:
                                                  //                             const OutlineInputBorder(
                                                  //                               borderRadius:
                                                  //                               BorderRadius.all(Radius.circular(10)),
                                                  //                               borderSide: BorderSide(
                                                  //                                   width: 1,
                                                  //                                   color: Colors.black54),
                                                  //                             ),
                                                  //                             enabledBorder:
                                                  //                             const OutlineInputBorder(
                                                  //                               borderRadius:
                                                  //                               BorderRadius.all(Radius.circular(10)),
                                                  //                               borderSide: BorderSide(
                                                  //                                   width: 1,
                                                  //                                   color: Colors.grey),
                                                  //                             ),
                                                  //                             border: const OutlineInputBorder(
                                                  //                                 borderRadius:
                                                  //                                 BorderRadius.all(Radius.circular(6)),
                                                  //                                 borderSide: BorderSide(width: 1,color: Colors.grey)),
                                                  //                             errorBorder: const OutlineInputBorder(
                                                  //                                 borderRadius:
                                                  //                                 BorderRadius.all(Radius.circular(6)),
                                                  //                                 borderSide: BorderSide(width: 1, color: Colors.red)),
                                                  //                             focusedErrorBorder: OutlineInputBorder(
                                                  //                                 borderRadius:
                                                  //                                 const BorderRadius.all(Radius.circular(6)),
                                                  //                                 borderSide: BorderSide(width: 1, color: Colors.red.shade800)),
                                                  //                             hintText:
                                                  //                             'bt_leave_review'.tr,
                                                  //
                                                  //                             errorText: snapshot.data
                                                  //                                 ? null
                                                  //                                 : 'bt_leave_review_error'.tr,
                                                  //                             hintStyle: const TextStyle(
                                                  //                                 fontSize:
                                                  //                                 15,
                                                  //                                 color:
                                                  //                                 Color(0xFF9797AD)),
                                                  //                             //errorText: snapshot.data ? null : 'name is not empty',
                                                  //                           ),
                                                  //                           keyboardType:
                                                  //                           TextInputType
                                                  //                               .text,
                                                  //                           maxLines:
                                                  //                           3,
                                                  //                           //onChanged: (val) => widget.bloc.changeName(val),
                                                  //                           //controller: widget.bloc.nameController,
                                                  //                         );
                                                  //
                                                  //                       }),
                                                  //                 ),
                                                  //                 const SizedBox(
                                                  //                   height: 5,
                                                  //                 ),
                                                  //                 Padding(
                                                  //                   padding: const EdgeInsets.symmetric(horizontal: 15),
                                                  //                   child: FlatButton(
                                                  //                       shape:
                                                  //                       RoundedRectangleBorder(
                                                  //                         borderRadius:
                                                  //                         BorderRadius.circular(
                                                  //                             5.0),
                                                  //                       ),
                                                  //                       height: 50,
                                                  //                       minWidth:
                                                  //                       Get.width,
                                                  //                       color: Color(
                                                  //                           0xff2E5BFF),
                                                  //                       child:  Text('bt_leave_report'.tr,style: TextStyle(color: Colors.white)),
                                                  //                       onPressed: () async {
                                                  //
                                                  //                         bool co =
                                                  //                         await widget.profileCompaineBloc
                                                  //                             .dislikeComment(widget.reviews.id,context);
                                                  //                         if (co) {
                                                  //                           // await Get.back();
                                                  //                           widget.profileCompaineBloc.commentController.text = '';
                                                  //                           dislikeCommentSubject
                                                  //                               .sink
                                                  //                               .add(1);
                                                  //                           numberOfdislikeSubject.sink.add(numberOfdislikeSubject.value + 1);
                                                  //                         }
                                                  //                       }),
                                                  //                 )
                                                  //               ],
                                                  //             ),
                                                  //           ),
                                                  //         ),
                                                  //       ),
                                                  //     );
                                                  //   },
                                                  // );

                                                },
                                                child: Icon(
                                                  Icons.thumb_down,
                                                  color:
                                                  Colors.grey[600],
                                                ));
                                          } else if (snapshotfav.data == 1) {
                                            return GestureDetector(
                                                onTap: () async {


                                                  // await profileCompaineBloc
                                                  //     .likeComment(reviews.id);
                                                  bool co = await widget.profileCompaineBloc
                                                      .dislikeComment(widget.reviews.id,context);
                                                      if (co) {
                                                        dislikeCommentSubject
                                                            .sink
                                                            .add(0);
                                                        numberOfdislikeSubject.sink.add(numberOfdislikeSubject.value-1);
                                                        // Get.back();

                                                      }
                                                   },
                                                child: Icon(
                                                  Icons.thumb_down,
                                                  color:
                                                  Color(0xffEB1346),
                                                ));
                                          }
                                          return Icon(
                                            Icons.thumb_down,
                                            color: Colors.grey[600],
                                          );
                                        });
                                  } else {
                                    return GestureDetector(
                                      onTap: () async {
                                        await showModalBottomSheet<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return ShowCheckLoginDialog();
                                          },
                                        );
                                      },
                                      child: Icon(
                                        Icons.thumb_down,
                                        color: Colors.grey[600],
                                      ),
                                    );
                                  }
                                }),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Row(
                          children: [
                            StreamBuilder<int>(
                                stream: numberOfLikeSubject.stream,
                                initialData: widget.reviews.likes_count,
                              builder: (context, snapshot) {
                                return Text(
                                  '${snapshot.data}',
                                  style:
                                  const TextStyle(fontSize: 12, color: Colors.black),
                                );
                              }
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            StreamBuilder<String>(
                                stream: Stream.fromFuture(getIsLogIn()),
                                builder: (context, snapshotToken) {
                                  if (snapshotToken.hasData) {
                                    return StreamBuilder<int>(
                                      stream: likeCommentSubject
                                          .stream,
                                      initialData: widget.like_init,
                                      // initialData: 0,
                                        builder:
                                            (context, snapshotfav) {
                                          if (snapshotfav.data == 0) {
                                            return GestureDetector(
                                                onTap: () async {
                                                  bool co =  await widget.profileCompaineBloc
                                                      .likeComment(widget.reviews.id,context);
                                                  if (co) {
                                                    likeCommentSubject.sink.add(1);
                                                    numberOfLikeSubject.sink.add(numberOfLikeSubject.value + 1);
                                                  }

                                                },
                                                child: Icon(
                                                  Icons.thumb_up,
                                                  color:
                                                  Colors.grey[600],
                                                ));
                                          } else if (snapshotfav.data ==
                                              1) {
                                            return GestureDetector(
                                                onTap: () async {
                                                  bool co =  await widget.profileCompaineBloc
                                                      .likeComment(widget.reviews.id,context);
                                                  if (co) {
                                                    likeCommentSubject
                                                        .sink
                                                        .add(0);
                                                    numberOfLikeSubject.sink.add(numberOfLikeSubject.value - 1);
                                                  }

                                                },
                                                child: Icon(
                                                  Icons.thumb_up,
                                                  color:
                                                  Colors.blueAccent,
                                                ));
                                          }
                                          return Icon(
                                            Icons.thumb_up,
                                            color: Colors.grey[600],
                                          );
                                        });
                                  } else {
                                    return GestureDetector(
                                      onTap: () async {
                                        await showModalBottomSheet<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return ShowCheckLoginDialog();
                                          },
                                        );
                                      },
                                      child: Icon(
                                        Icons.thumb_up,
                                        color: Colors.grey[600],
                                      ),
                                    );
                                  }
                                }),
                          ],
                        ),

                      ],
                    ),



                  ],
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }

  SharedPreferenceHelper helper = GetIt.instance.get<SharedPreferenceHelper>();

  Future<String> getIsLogIn() async {
    return await helper.getToken();
  }
  Future<String> getLangCode() async {
    return await helper.getCodeLang();
  }
}
