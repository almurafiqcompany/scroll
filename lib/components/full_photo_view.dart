import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:photo_view/photo_view.dart';

import '../constants.dart';

class FullPhotoView extends StatelessWidget {
  final String? path;
  final PhotoType? type;

  FullPhotoView({Key? key, @required this.path, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            MdiIcons.chevronLeftCircle,
            size: 36,
            color: Get.isDarkMode ? Colors.black : Colors.white,
          ),
        ),
        title: Text(
          'show_photo'.tr,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: PhotoView(
        maxScale: 2.5,
        minScale: 0.5,
        imageProvider: getImageProviderByType(path!, type!),
      ),
    );
  }

  ImageProvider getImageProviderByType(String path, PhotoType type) {
    switch (type) {
      case PhotoType.Network:
        return NetworkImage(path);
      case PhotoType.File:
        return FileImage(File(path));
      case PhotoType.Asset:
        return AssetImage(path);
      default:
        return NetworkImage(path);
    }
  }
}
