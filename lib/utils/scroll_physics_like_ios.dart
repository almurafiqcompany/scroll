import 'dart:io';

import 'package:flutter/widgets.dart';

ScrollPhysics iosScrollPhysics() =>
    // (Platform.isIOS) ? null : const
    BouncingScrollPhysics();