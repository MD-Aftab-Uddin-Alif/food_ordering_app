import 'dart:io';

import 'package:ePolli/app/core/helpers/app_size.dart';
import 'package:ePolli/app/core/theme/app_color.dart';
import 'package:ePolli/app/modules/home/home_controller.dart';
import 'package:ePolli/app/modules/splash/splash_controller.dart';
import 'package:ePolli/app/routes/custom_navigation_bar_routes.dart';
import 'package:ePolli/app/routes/splash_routes.dart';
import 'package:ePolli/epolli_app_secret/secret.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = "splash";
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SplashController splashController = Get.put(SplashController());
  final HomeController homeController = Get.put(HomeController());

  initialChecking() async {
    splashController.retrieveIsFirstTime();
    // checking if internet is connected
    splashController.checkInternetConnection().then(
      (a) {
        if (a) {
          splashController.isAppUpToDate().then((b) {
            if (b) {
              if (!splashController.isFirstTime.value) {
                Get.offNamedUntil(CustomNavigationBarRoutes.customNavigationBar,
                    (route) => false);
              }
            } else {
              showUpdateDialog();
            }
          });

          // if connected then check if user is logged in
        } else {
          showNoInternetDialog();
        }
      },
    );
  }

  Future<dynamic> showNoInternetDialog() {
    return showDialog(
      barrierDismissible: false,
      barrierColor: Colors.black26,
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.red,
        icon: const Icon(
          Icons.wifi_off_outlined,
          color: Colors.white,
          size: 40,
        ),
        title: Text(
          "No Internet Connection".tr,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        content: Text(
          "Please connect to internet then retry".tr,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: AppSize.fFourteen,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.of(ctx).pop();
              initialChecking();
            },
            child: Text(
              "Retry".tr,
              style: TextStyle(
                fontSize: AppSize.fFourteen,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> showUpdateDialog() {
    return showDialog(
      barrierDismissible: false,
      barrierColor: Colors.black26,
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.red,
        icon: const Icon(
          Icons.system_security_update_outlined,
          color: Colors.white,
          size: 40,
        ),
        title: Text(
          "Update Available".tr,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        content: Text(
          "Please update the app".tr,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: AppSize.fFourteen,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
            ),
            onPressed: () {
              // open url in browser using the url_launcher package
              if (Platform.isAndroid || Platform.isIOS) {
                final appId = Platform.isAndroid
                    ? Secret.androidAppID
                    : Secret.appleAppID;
                final url = Uri.parse(
                  Platform.isAndroid
                      ? "market://details?id=$appId"
                      : "https://apps.apple.com/app/id$appId",
                );
                launchUrl(
                  url,
                  mode: LaunchMode.externalApplication,
                );
              }
            },
            child: Text(
              "Update".tr,
              style: TextStyle(
                fontSize: AppSize.fFourteen,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    initialChecking();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              child: Container(
                alignment: Alignment.center,
                child: const Center(
                  child: Image(
                    image: AssetImage("assets/images/logo/splash_epolli.png"),
                    width: 250,
                    // fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                color: Colors.white.withOpacity(0.5),
                child: Center(
                  child: FittedBox(
                    child: Text(
                      "Powered by ePolli Tech Solutions".tr,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: AppSize.fFourteen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            languageDialog(),
          ],
        ),
      ),
    );
  }

  languageDialog() {
    return Obx(
      () => splashController.isFirstTime.value
          ? Positioned(
              bottom: 30,
              right: 5,
              left: 5,
              child: AlertDialog(
                backgroundColor: Colors.white.withOpacity(0.8),
                title: Center(
                  child: Text(
                    /*cspell:disable-next-line*/
                    "Select Language / \nভাষা নির্বাচন করুন",
                    style: TextStyle(
                      fontSize: AppSize.fSixteen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                content: SizedBox(
                  height: 50,
                  child: Column(
                    children: [
                      Obx(
                        () => splashController.isEveryThingLoaded.value
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColor.secondary),
                                    onPressed: () {
                                      Get.updateLocale(
                                          const Locale("en", "US"));
                                      homeController.isUSLocale.value = true;
                                      homeController.storeIsUsLocale();
                                      splashController.storeIsFirstTime();
                                      Get.offNamedUntil(
                                          CustomNavigationBarRoutes
                                              .customNavigationBar,
                                          (route) => false);
                                      Get.toNamed(SplashRoutes.splash);
                                    },
                                    child: Text(
                                      "English".tr,
                                      style: TextStyle(
                                        fontSize: AppSize.fFourteen,
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColor.secondary),
                                    onPressed: () {
                                      Get.updateLocale(
                                          const Locale("bn", "BD"));
                                      homeController.isUSLocale.value = false;
                                      homeController.storeIsUsLocale();
                                      splashController.storeIsFirstTime();
                                      Get.offNamedUntil(
                                          CustomNavigationBarRoutes
                                              .customNavigationBar,
                                          (route) => false);
                                      Get.toNamed(SplashRoutes.splash);
                                    },
                                    child: Text(
                                      "বাংলা".tr,
                                      style: TextStyle(
                                        fontSize: AppSize.fFourteen,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : const Center(
                                child: Image(
                                  image:
                                      AssetImage('assets/images/loading.gif'),
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Container(),
    );
  }
}
