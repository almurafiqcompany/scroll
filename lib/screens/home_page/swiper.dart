import 'package:al_murafiq/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';

class Swiperr extends StatefulWidget {
  final String title;

  const Swiperr({Key key, this.title}) : super(key: key);

  @override
  _SwiperrState createState() => new _SwiperrState();
}

class _SwiperrState extends State<Swiperr> {
  final imageList = [
    'https://cdn.pixabay.com/photo/2016/03/05/19/02/hamburger-1238246__480.jpg',
    'https://cdn.pixabay.com/photo/2016/11/20/09/06/bowl-1842294__480.jpg',
    defaultImgUrl,
    'https://cdn.pixabay.com/photo/2017/02/03/03/54/burger-2034433__480.jpg',
  ];
  List<String> titles = [
    "Zacks",
    "Zackss",
    "Zacksss",
    "Zackssss",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //flutter Swipper default
                    Container(
                      height: 260,
                      width: (MediaQuery.of(context).size.width / 2) - 10,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Swiper(
                          // pagination:  SwiperPagination(margin: EdgeInsets.symmetric(vertical: 1)),
                          pagination: SwiperPagination(
                              margin: const EdgeInsets.symmetric(vertical: 1),
                              alignment: Alignment.bottomCenter,
                              builder: SwiperCustomPagination(builder:
                                  (BuildContext context,
                                      SwiperPluginConfig config) {
                                return ConstrainedBox(
                                  child: Container(
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Row(
                                              children: [
                                                Text(
                                                  '${titles[config.activeIndex]} ',
                                                  style: const TextStyle(
                                                      fontSize: 18.0),
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
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                RatingBar(
                                                  rating: 4,
                                                  icon: Icon(
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
                                                  //   print('Number of stars-->  $value');
                                                  //   isIndicator.value=true;
                                                  // },
                                                  color: Colors.amber,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Text(
                                            'القاهره الجديده -القاهره -مصر',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    print('القاهره');
                                                  },
                                                  child: Container(
                                                    width: 50,
                                                    height: 20,
                                                    decoration:
                                                        const BoxDecoration(
                                                      gradient:
                                                          kAdsHomeGradient,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  15.0)),
                                                    ),
                                                    child: const Center(
                                                        child: Text(
                                                      'القاهره',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white),
                                                    )),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    print('15km');
                                                  },
                                                  child: Container(
                                                    width: 50,
                                                    height: 20,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Color(0xff848DFF),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  15.0)),
                                                    ),
                                                    child: const Center(
                                                        child: Text(
                                                      '15Km',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white),
                                                    )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child:
                                                  const DotSwiperPaginationBuilder(
                                                          color: Colors.grey,
                                                          activeColor:
                                                              kPrimaryColor,
                                                          size: 6.0,
                                                          activeSize: 10.0)
                                                      .build(context, config),
                                            ),
                                          )
                                        ],
                                      )),
                                  constraints:
                                      BoxConstraints.expand(height: 100.0),
                                );
                              })),

                          autoplay: true,

                          itemBuilder: (BuildContext context, int index) {
                            return Stack(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15.0),
                                      bottomRight: Radius.circular(15.0),
                                      topRight: Radius.circular(15.0),
                                      bottomLeft: Radius.circular(15.0),
                                    ),
                                    child: Image.network(
                                      imageList[index],
                                      fit: BoxFit.fill,
                                      height: 140,
                                    ),
                                  ),
                                ),
                                Positioned(
                                    right: 15,
                                    top: 15,
                                    child: Container(
                                      width: 55,
                                      height: 30,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)),
                                      ),
                                      child: Row(
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          const Text(
                                            '4.5',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    )),
                              ],
                            );
                          },
                          itemCount: imageList.length,
                          //itemWidth: 100.0,
                          //autoplayDelay: 2500,
                          onTap: (int index) {
                            print('enter $index');
                          },

                          loop: true,
                          layout: SwiperLayout.DEFAULT,
                        ),
                      ),
                    ),
                    //flutter Swipper Stack
                    Container(
                      height: 260,
                      width: (MediaQuery.of(context).size.width / 2) - 10,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Swiper(
                          // pagination:  SwiperPagination(margin: EdgeInsets.symmetric(vertical: 1)),
                          pagination: SwiperPagination(
                              margin: const EdgeInsets.symmetric(vertical: 1),
                              alignment: Alignment.bottomCenter,
                              builder: SwiperCustomPagination(builder:
                                  (BuildContext context,
                                      SwiperPluginConfig config) {
                                return ConstrainedBox(
                                  child: Container(
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Row(
                                              children: [
                                                Text(
                                                  '${titles[config.activeIndex]} ',
                                                  style: const TextStyle(
                                                      fontSize: 18.0),
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
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                RatingBar(
                                                  rating: 4,
                                                  icon: Icon(
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
                                                  //   print('Number of stars-->  $value');
                                                  //   isIndicator.value=true;
                                                  // },
                                                  color: Colors.amber,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Text(
                                            'القاهره الجديده -القاهره -مصر',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    print('القاهره');
                                                  },
                                                  child: Container(
                                                    width: 50,
                                                    height: 20,
                                                    decoration:
                                                        const BoxDecoration(
                                                      gradient:
                                                          kAdsHomeGradient,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  15.0)),
                                                    ),
                                                    child: const Center(
                                                        child: Text(
                                                      'القاهره',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white),
                                                    )),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    print('15km');
                                                  },
                                                  child: Container(
                                                    width: 50,
                                                    height: 20,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Color(0xff848DFF),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  15.0)),
                                                    ),
                                                    child: const Center(
                                                        child: Text(
                                                      '15Km',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white),
                                                    )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child:
                                                  const DotSwiperPaginationBuilder(
                                                          color: Colors.grey,
                                                          activeColor:
                                                              kPrimaryColor,
                                                          size: 6.0,
                                                          activeSize: 10.0)
                                                      .build(context, config),
                                            ),
                                          )
                                        ],
                                      )),
                                  constraints:
                                      BoxConstraints.expand(height: 100.0),
                                );
                              })),

                          autoplay: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15.0),
                                      bottomRight: Radius.circular(15.0),
                                      topRight: Radius.circular(15.0),
                                      bottomLeft: Radius.circular(15.0),
                                    ),
                                    child: Image.network(
                                      imageList[index],
                                      fit: BoxFit.fill,
                                      height: 140,
                                    ),
                                  ),
                                ),
                                Positioned(
                                    right: 15,
                                    top: 15,
                                    child: Container(
                                      width: 55,
                                      height: 30,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)),
                                      ),
                                      child: Row(
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          const Text(
                                            '4.5',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    )),
                              ],
                            );
                          },
                          itemCount: imageList.length,
                          //itemWidth: 100.0,
                          autoplayDelay: 2000,
                          onTap: (int index) {
                            print('enter $index');
                          },

                          loop: true,
                          layout: SwiperLayout.DEFAULT,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 55,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                  gradient: kAdsHomeGradient,
                  image: DecorationImage(
                    image: NetworkImage(imageList[1]),
                    fit: BoxFit.cover,
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.3), BlendMode.dstATop),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'طعام',
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 7,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                  ),
                ],
              ),
            ),
            // ListView.builder(
            //   scrollDirection: Axis.horizontal,
            //   itemCount: 3,
            //   itemBuilder: (BuildContext context, int index) =>
            //       Container(
            //         height: 55,
            //         width: 200,
            //
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.all(Radius.circular(40.0)),
            //             gradient: kAdsHomeGradient,
            //             image: DecorationImage(
            //               image: NetworkImage(imageList[1]), fit: BoxFit.cover,
            //               colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.3)
            //                   , BlendMode.dstATop),)
            //
            //         ),
            //         child: Row(
            //
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             const Text(
            //               'طعام',
            //               style: TextStyle(fontSize: 25, color: Colors.black),
            //             ),
            //             const SizedBox(
            //               width: 5,
            //             ),
            //             Container(
            //               width: 7,
            //               height: 40,
            //
            //               decoration: BoxDecoration(
            //                 color: Colors.white.withOpacity(0.5),
            //                 borderRadius: BorderRadius.all(Radius.circular(20.0)),
            //
            //
            //               ),
            //             ),
            //
            //
            //           ],
            //         ),
            //
            //
            //       ),
            // ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 55.0,
              child:
              ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 15,
                itemBuilder: (BuildContext context, int index) => Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    height: 55,
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                        gradient: kAdsHomeGradient,
                        image: DecorationImage(
                          image: NetworkImage(imageList[1]),
                          fit: BoxFit.cover,
                          colorFilter: new ColorFilter.mode(
                              Colors.black.withOpacity(0.3), BlendMode.dstATop),
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'طعام',
                          style: TextStyle(fontSize: 25, color: Colors.black),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 7,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
