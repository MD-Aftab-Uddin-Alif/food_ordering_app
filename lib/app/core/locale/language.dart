import 'package:ePolli/app/core/locale/bn_bd_map.dart';
import 'package:ePolli/app/core/locale/en_us_map.dart';
import 'package:get/get.dart';

class Language extends Translations {
  @override
  Map<String, Map<String, String>> get keys {
    return {
      'en_US': enUSMap,
      'bn_BD': bnBdMap,
    };
  }
}
