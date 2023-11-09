import 'package:ePolli/app/core/locale/language.dart';
import 'package:ePolli/app/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/core/bindings/application_bindings.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ePolli',
      initialBinding: ApplicationBindings(),
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      translations: Language(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
    ),
  );
  Get.put(HomeController());
}
