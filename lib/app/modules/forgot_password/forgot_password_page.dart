import 'dart:math';

import 'package:ePolli/app/core/helpers/app_size.dart';
import 'package:ePolli/app/core/theme/app_color.dart';
import 'package:ePolli/app/core/widgets/constant.dart';
import 'package:ePolli/app/core/widgets/custom_snackbar.dart';
import 'package:ePolli/app/modules/forgot_password/forgot_password_controller.dart';
import 'package:ePolli/app/routes/update_password_routes.dart';
import 'package:ePolli/app/routes/verification_routes.dart';
import 'package:ePolli/epolli_app_secret/secret.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailOrPhoneNumberController =
      TextEditingController();
  final ForgotPasswordController forgotPasswordController =
      Get.put(ForgotPasswordController());

  void onSubmit() async {
    if (_formKey.currentState!.validate()) {
      forgotPasswordController.isLoading.value = true;
      var verificationCode = (100000 + Random().nextInt(900000)).toString();
      if (_emailOrPhoneNumberController.text.contains('@')) {
        // * sending email to user
        final emailResponse = await http.post(
          Uri.parse(Secret.investorApiBaseURL + Secret.resetPassword),
          headers: Constant.apiHeader,
          body: {
            'email': _emailOrPhoneNumberController.text,
            'otp': verificationCode,
          },
        );

        if (emailResponse.statusCode != 200) {
          customSnackbar(
            'Sending Email Failed'.tr,
            emailResponse.toString(),
            'failure',
          );
        }
        Get.toNamed(VerificationRoutes.verification, arguments: {
          '_emailOrPhoneNumber': _emailOrPhoneNumberController.text,
          'method': 'email',
          'verificationCode': verificationCode,
          'route': UpdatePasswordRoutes.updatePassword,
        });
      } else {
        // * sending sms to user
        final smsResponse = await http.get(
          Uri.parse(
              '${Secret.smsApiWithKey}&msg=Your ePolli OTP is $verificationCode&to=${_emailOrPhoneNumberController.text}'),
        );

        if (smsResponse.statusCode != 200) {
          customSnackbar(
            'Sending SMS Failed'.tr,
            smsResponse.toString(),
            'failure',
          );
        }
        Get.toNamed(VerificationRoutes.verification, arguments: {
          'emailOrPhoneNumber': _emailOrPhoneNumberController.text,
          'method': 'sms',
          'verificationCode': verificationCode,
          'route': UpdatePasswordRoutes.updatePassword,
        });
      }
      forgotPasswordController.isLoading.value = false;
    }
  }

  @override
  void dispose() {
    _emailOrPhoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password Page"),
        centerTitle: true,
        backgroundColor: AppColor.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            SizedBox(
              height: 150,
              child: Image.asset('assets/images/logo/epolli.png',
                  fit: BoxFit.contain),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius: BorderRadius.circular(15),
                boxShadow: Constant.boxShadow,
              ),
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      'Have you forgotten your password?'.tr,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColor.bText,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Please recover your password".tr,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColor.bTextLight,
                      ),
                    ),
                    Constant.sbHTen,
                    /* ------------------------ Email/Phone Number Field ------------------------ */
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: _emailOrPhoneNumberController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "Email/Phone Number".tr,
                        icon: const Icon(Icons.email_outlined),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email or phone number'.tr;
                        } else if (!value.contains('@') && value.length != 11) {
                          return 'Please enter a 11 digit phone number'.tr;
                        }
                        return null;
                      },
                    ),
                    Constant.sbHTen,
                    /* ------------------------------- Submit Button ------------------------------ */
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(AppSize.pTen),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppSize.rTen,
                          ),
                        ),
                        backgroundColor: AppColor.secondary,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity - 50, 50),
                      ),
                      onPressed: onSubmit,
                      child: Obx(
                        () => forgotPasswordController.isLoading.value
                            ? const CircularProgressIndicator(
                                color: AppColor.primary,
                              )
                            : Text(
                                "Next".tr,
                                style: TextStyle(fontSize: AppSize.fTwentyTwo),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
