import 'dart:convert';

import 'package:ePolli/app/core/widgets/constant.dart';
import 'package:ePolli/app/core/widgets/custom_snackbar.dart';
import 'package:ePolli/app/modules/home/home_controller.dart';
import 'package:ePolli/app/modules/profile/profile_controller.dart';
import 'package:ePolli/app/routes/splash_routes.dart';
import 'package:ePolli/epolli_app_secret/secret.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UpdatePasswordController extends GetxController {
  RxBool isLoading = false.obs;
  Future<void> updatePassword(
    emailOrPhoneNumber,
    password,
  ) async {
    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse(Secret.investorApiBaseURL + Secret.updatePassword),
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
          customSnackbar(
            'Password Updated'.tr,
            'Password updated successfully'.tr,
            'success',
          );

          final ProfileController profileController =
              Get.put(ProfileController());

          // * saving fetched data investor data to local storage
          profileController.saveInvestorDataToSecureStorage(
            jsonDecode(response.body)['data'],
          );

          Get.offNamedUntil(SplashRoutes.splash, (route) => false);
        } else {
          // showing snackbar for error
          customSnackbar(
            'Update Password Failed'.tr,
            msg.toString(),
            'failure',
          );
        }
      } else {
        customSnackbar(
          'Update Password Failed'.tr,
          'Failed to update Password'.tr,
          'success',
        );
      }
    } catch (e) {
      print('${e.toString()} in updatePassword');
    } finally {
      isLoading.value = false;
    }
  }
}
