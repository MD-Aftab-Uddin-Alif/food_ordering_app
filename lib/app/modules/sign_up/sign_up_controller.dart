import 'dart:convert';
import 'dart:math';
import 'package:ePolli/app/core/widgets/constant.dart';
import 'package:ePolli/app/core/widgets/custom_snackbar.dart';
import 'package:ePolli/app/modules/home/home_controller.dart';
import 'package:ePolli/app/modules/profile/profile_controller.dart';
import 'package:ePolli/app/routes/splash_routes.dart';
import 'package:ePolli/app/routes/verification_routes.dart';

import 'package:ePolli/epolli_app_secret/secret.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignUpController extends GetxController {
  RxBool isLoading = false.obs;

  // Sign up post request
  Future<void> signUp(
    fullName,
    phoneNumber,
    email,
    password,
    referCode,
  ) async {
    try {
      isLoading.value = true;
      final response = await http.post(
        Uri.parse(Secret.investorApiBaseURL + Secret.signUP),
        headers: Constant.apiHeader,
        body: {
          'full_name': fullName,
          'phone_number': phoneNumber,
          'email': email,
          'password': password,
          'refer_code': referCode,
        },
      );

      if (response.statusCode == 200) {
        var msg = jsonDecode(response.body)['message'];
        if (msg == 'success') {
          HomeController homeController = Get.put(HomeController());
          homeController.isSigned.value = true;
          const storage = FlutterSecureStorage();
          await storage.write(key: 'isSignedIn', value: 'true');

          final ProfileController profileController =
              Get.put(ProfileController());

          // * saving fetched data investor data to local storage
          profileController.saveInvestorDataToSecureStorage(
            jsonDecode(response.body)['data'],
          );
          var verificationCode = (100000 + Random().nextInt(900000)).toString();

          if (email != null && email != '') {
            // * sending email to user
            final emailResponse = await http.post(
              Uri.parse(Secret.investorApiBaseURL + Secret.sendEmailForOTP),
              headers: Constant.apiHeader,
              body: {
                'email': email,
                'otp': verificationCode,
              },
            );

            if (emailResponse.statusCode != 200) {
              customSnackbar(
                'Sending Email Failed'.tr,
                msg.toString(),
                'failure',
              );
            }
          }

          // * sending sms to user
          final smsResponse = await http.get(
            Uri.parse(
                '${Secret.smsApiWithKey}&msg=Your ePolli OTP is $verificationCode&to=$phoneNumber'),
          );

          if (smsResponse.statusCode != 200) {
            customSnackbar(
              'Sending SMS Failed'.tr,
              msg.toString(),
              'failure',
            );
          }

          Get.toNamed(VerificationRoutes.verification, arguments: {
            'method': 'sms',
            'verificationCode': verificationCode,
            'route': SplashRoutes.splash,
          });
        } else {
          // showing snackbar for error
          customSnackbar(
            'Signed Up Failed'.tr,
            msg.toString(),
            'failure',
          );
        }
      } else {
        customSnackbar(
          'Signed Up Failed'.tr,
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
