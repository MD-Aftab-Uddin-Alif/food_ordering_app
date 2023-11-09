import 'package:ePolli/app/modules/home/home_controller.dart';
import 'package:get/get.dart';

dynamic getLocalizedText(dynamic eng, dynamic bn) {
  HomeController homeController = Get.put(HomeController());
  if (homeController.isUSLocale.value) {
    return eng == '' || eng == null ? bn : eng;
  } else {
    return bn == '' || bn == null ? eng : bn;
  }
}
