import 'dart:convert';

import 'package:ePolli/app/core/widgets/constant.dart';
import 'package:ePolli/app/core/widgets/custom_snackbar.dart';
import 'package:ePolli/app/modules/home/home_controller.dart';
import 'package:ePolli/app/modules/profile/profile_controller.dart';
import 'package:ePolli/app/routes/splash_routes.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:ePolli/epolli_app_secret/secret.dart';
import 'package:http/http.dart' as http;

class SignInController extends GetxController {
  RxBool isLoading = false.obs;

  // Sign up post request
  Future<void> signIn(
    emailOrPhoneNumber,
    password,
  ) async {
    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse(Secret.investorApiBaseURL + Secret.signIn),
        headers: Constant.apiHeader,
        body: {
          'email_or_phone_number': emailOrPhoneNumber,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        var msg = jsonDecode(response.body)['message'];
        if (msg == 'success') {
          final HomeController homeController = Get.put(HomeController());
          homeController.isSigned.value = true;
          const storage = FlutterSecureStorage();
          await storage.write(key: 'isSignedIn', value: 'true');
          // showing snackbar for success
          final ProfileController profileController =
              Get.put(ProfileController());

          // * saving fetched data investor data to local storage
          profileController.saveInvestorDataToSecureStorage(
            jsonDecode(response.body)['data'],
          );
          Get.offNamedUntil(SplashRoutes.splash, (route) => false);
        } else {
          // showing snackbar for error
          customSnackbar('Signed In Failed'.tr, msg.toString(), 'failure');
        }
      } else {
        customSnackbar(
          'Signed In Failed'.tr,
          'Something went wrong'.tr,
          'failure',
        );
      }
    } catch (e) {
      customSnackbar(
        'Signed Up Failed'.tr,
        e.toString(),
        'failure',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle(String name, String email, String image) async {
    try {
      isLoading.value = true;
      final response = await http.post(
        Uri.parse(Secret.investorApiBaseURL + Secret.signInWithGoogle),
        headers: Constant.apiHeader,
        body: {
          'name': name,
          'email': email,
          'image': image,
        },
      );

      if (response.statusCode == 200) {
        var msg = jsonDecode(response.body)['message'];
        if (msg == 'success') {
          // showing snackbar for success
          final ProfileController profileController =
              Get.put(ProfileController());

          // * saving fetched data investor data to local storage
          profileController.saveInvestorDataToSecureStorage(
            jsonDecode(response.body)['data'],
          );
          // home page route
          Get.offNamedUntil(SplashRoutes.splash, (route) => false);
        } else {
          // showing snackbar for error
          customSnackbar('Signed In Failed'.tr, msg.toString(), 'failure');
        }
      } else {
        customSnackbar(
          'Signed In Failed'.tr,
          'Something went wrong'.tr,
          'failure',
        );
      }
    } catch (e) {
      customSnackbar(
        'Signed Up Failed'.tr,
        e.toString(),
        'failure',
      );
    } finally {
      isLoading.value = false;
    }
  }
}
