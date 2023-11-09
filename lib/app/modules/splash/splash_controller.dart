import 'dart:convert';

import 'package:ePolli/app/core/widgets/constant.dart';
import 'package:ePolli/app/data/models/app_model.dart';
import 'package:ePolli/app/modules/about_us/about_us_controller.dart';
import 'package:ePolli/app/modules/home/home_controller.dart';
import 'package:ePolli/app/modules/news/news_controller.dart';
import 'package:ePolli/epolli_app_secret/secret.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:http/http.dart' as http;

class SplashController extends GetxController {
  final agriInfoKey = 'agriInfoKey';
  final storage = const FlutterSecureStorage();
  final RxBool isFirstTime = false.obs;
  final RxBool isEveryThingLoaded = false.obs;

  Rx<AppModel> appInfo = AppModel(
    agriInfoVersion: '',
    projectCategoryVersion: '',
    productCategoryVersion: '',
    blogVersion: '',
    newsVersion: '',
    allowedAppVersion: 0,
    aboutUsVersion: '',
    deliveryCharge: 0,
  ).obs;

  // * checking if internet is connected
  Future<bool> checkInternetConnection() async {
    try {
      if (await InternetConnectionChecker().hasConnection) {
        print('Internet Connected');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('${e.toString()} in checkInternetConnection');
      return false;
    }
  }

  Future<bool> isAppUpToDate() async {
    try {
      final response = await http.get(
        Uri.parse(Secret.investorApiBaseURL + Secret.appVersion),
        headers: Constant.apiHeader,
      );
      if (response.statusCode == 200) {
        AppModel fetchedAppInfo =
            AppModel.fromJson(jsonDecode(response.body)['data']);

        getAppInfoFromSecureStorage().then(
          (a) async {
            await isSignedIn();
            appInfo.value.deliveryCharge = fetchedAppInfo.deliveryCharge;
            storage.write(key: 'appInfoKey', value: jsonEncode(appInfo.value));
            // * checking if agri info is up to date
            if (fetchedAppInfo.agriInfoVersion !=
                appInfo.value.agriInfoVersion) {
              print('Agri Info is not up to date');
              final HomeController homeController = Get.put(HomeController());
              homeController.retrieveIsUsLocale();
              homeController.fetchAgriInfo().then(
                (b) {
                  if (b) {
                    appInfo.value.agriInfoVersion =
                        fetchedAppInfo.agriInfoVersion;
                    storage.write(
                        key: 'appInfoKey', value: jsonEncode(appInfo.value));
                  }
                },
              );
            } else {
              print('Agri Info is up to date');
              final HomeController homeController = Get.put(HomeController());
              homeController.retrieveIsUsLocale();
              homeController.retrieveAgriInfoList();
            }

            

            if (fetchedAppInfo.productCategoryVersion !=
                appInfo.value.productCategoryVersion) {
              print('Product Category is not up to date');
              final HomeController homeController = Get.put(HomeController());
              homeController.fetchProductCategories().then((b) {
                if (b) {
                  appInfo.value.productCategoryVersion =
                      fetchedAppInfo.productCategoryVersion;
                  storage.write(
                      key: 'appInfoKey', value: jsonEncode(appInfo.value));
                }
              });
            } else {
              print('Product Category is up to date');
              final HomeController homeController = Get.put(HomeController());
              homeController.retrieveProductCategoryList();
            }

  

            if (fetchedAppInfo.newsVersion != appInfo.value.newsVersion) {
              print('News is not up to date');
              final NewsController newsController = Get.put(NewsController());
              newsController.fetchNews().then((b) {
                if (b) {
                  appInfo.value.newsVersion = fetchedAppInfo.newsVersion;
                  storage.write(
                      key: 'appInfoKey', value: jsonEncode(appInfo.value));
                }
              });
            } else {
              print('News is up to date');
              final NewsController newsController = Get.put(NewsController());
              newsController.retrieveNewsList();
            }

            if (fetchedAppInfo.aboutUsVersion != appInfo.value.aboutUsVersion) {
              print('About Us is not up to date');
              final AboutUsController aboutUsController =
                  Get.put(AboutUsController());
              aboutUsController.fetchAboutUs().then((b) {
                if (b) {
                  appInfo.value.aboutUsVersion = fetchedAppInfo.aboutUsVersion;
                  storage.write(
                      key: 'appInfoKey', value: jsonEncode(appInfo.value));
                }
              });
            } else {
              print('About Us is up to date');
              final AboutUsController aboutUsController =
                  Get.put(AboutUsController());
              aboutUsController.retrieveAboutUsList();
            }
          },
        );
        storage.write(key: 'appInfoKey', value: jsonEncode(appInfo.value));
        if (int.parse(fetchedAppInfo.allowedAppVersion) <=
            Secret.coreAppVersion) {
          print('App is up to date');
          isEveryThingLoaded.value = true;
          return true;
        } else {
          print('App is not up to date');
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      print('${e.toString()} in isAppUpToDate');
    }
    return true;
  }

  // checking if user is signed in or not
  Future<bool> isSignedIn() async {
    try {
      HomeController homeController = Get.put(HomeController());
      homeController.isSigned.value =
          await storage.read(key: 'isSignedIn') == 'true' ? true : false;
      return homeController.isSigned.value;
    } catch (e) {
      return false;
    }
  }

  Future<void> getAppInfoFromSecureStorage() async {
    try {
      // Retrieve the JSON string from secure storage
      final appInfoJson = await storage.read(key: 'appInfoKey');

      if (appInfoJson != null) {
        // Convert the JSON string back to InvestorModel and store it in investorInfo variable
        appInfo.value = AppModel.fromJson(json.decode(appInfoJson));
        print('App Info Fetched from Secure Storage');
      }
    } catch (e) {
      print('${e.toString()} in getAppInfoFromSecureStorage');
    }
  }

  Future<void> storeIsFirstTime() async {
    try {
      await storage.write(key: 'isFirstTime', value: 'false');
    } catch (e) {
      print('${e.toString()} in storeIsFirstTime');
    }
  }

  Future<void> retrieveIsFirstTime() async {
    try {
      isFirstTime.value =
          await storage.read(key: 'isFirstTime') == 'false' ? false : true;
    } catch (e) {
      print('${e.toString()} in retrieveIsFirstTime');
    }
  }
}
