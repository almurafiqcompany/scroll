import 'package:get/get.dart';
import 'ar.dart';
import 'de.dart';
import 'en.dart';
import 'es.dart';
import 'fr.dart';
import 'hi.dart';
import 'ja.dart';
import 'ru.dart';
import 'tr.dart';
import 'ur.dart';
import 'zh.dart';

class Translation extends Translations{
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    'en':en,
    'ar':ar,
    'de':de,
    'es':es,
    'fr':fr,
    'hi':hi,
    'ja':ja,
    'ru':ru,
    'tr':tr,
    'ur':ur,
    'zh':zh,
  };

}