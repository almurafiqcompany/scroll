import 'package:al_murafiq/models/profile_compaine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage_2/provider.dart';
import 'package:get/route_manager.dart';
import 'package:get/utils.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import '../constants.dart';

class FullImageViewer extends StatefulWidget {
  final List<Files>? urls;

  FullImageViewer({Key? key, @required this.urls}) : super(key: key);

  @override
  _FullImageViewerState createState() => _FullImageViewerState();
}

class _FullImageViewerState extends State<FullImageViewer> {
  SwiperController controller = SwiperController();
  @override
  Widget build(BuildContext context) {
    print('imgaexx');
    return Scaffold(
      body: Stack(
        children: [
          Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: PhotoView(
                  maxScale: 2.5,
                  minScale: 0.0,
                  // initialScale: 0.7,

                  imageProvider: AdvancedNetworkImage(
                    '$ImgUrl${widget.urls![index].source}',
                    useDiskCache: true,
                    retryDuration: Duration(seconds: 5),
                    cacheRule: CacheRule(maxAge: Duration(days: 1)),
                  ),
                ),
              );
            },
            itemCount: widget.urls!.length,
            controller: controller,
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Get.locale!.languageCode == 'ar'
                      ? MdiIcons.chevronRight
                      : MdiIcons.chevronLeft,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            left: 5,
            right: 5,
            bottom: 10,
            child: SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.urls!.length, (index) {
                  return SmallImage(
                    url: '$ImgUrl${widget.urls![index].source}',
                    onTap: () {
                      controller.move(index);
                    },
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SmallImage extends StatelessWidget {
  final String? url;
  final Function? onTap;

  SmallImage({Key? key, this.url, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(3),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5),
          ),
          width: 40,
          height: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image(
              image: AdvancedNetworkImage(
                url!,
                useDiskCache: true,
                retryDuration: Duration(seconds: 5),
                cacheRule: CacheRule(maxAge: Duration(days: 1)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
