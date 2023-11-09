import 'package:ePolli/app/core/helpers/app_size.dart';
import 'package:ePolli/app/core/theme/app_color.dart';
import 'package:ePolli/app/core/widgets/constant.dart';
import 'package:ePolli/app/core/widgets/custom_snackbar.dart';
import 'package:ePolli/app/routes/splash_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String verificationCode = Get.arguments['verificationCode'];

  final TextEditingController _userInputController = TextEditingController();

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      if (_userInputController.text == verificationCode) {
        if (Get.arguments['route'] == SplashRoutes.splash) {
          Get.offNamedUntil(Get.arguments['route'], (route) => false);
        } else {
          Get.offNamedUntil(Get.arguments['route'], (route) => false,
              arguments: {
                'emailOrPhoneNumber': Get.arguments['emailOrPhoneNumber'],
              });
        }
      } else {
        customSnackbar(
          'Verification Failed'.tr,
          'Verification does not match'.tr,
          'failure',
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var msg = Get.arguments['method'] == 'sms'
        ? 'Please enter the verification code sent to your phone'.tr
        : 'Please enter the verification code sent to your email'.tr;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verification Page"),
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
                      msg,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColor.bTextLight,
                      ),
                    ),
                    Constant.sbHTen,
                    /* ------------------------ Verification code Field ------------------------ */
                    TextFormField(
                      controller: _userInputController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "Enter Verification Code".tr,
                        icon: const Icon(Icons.email_outlined),
                      ),
                    ),
                    Constant.sbHTen,
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
                      child: Text(
                        "Submit".tr,
                        style: TextStyle(fontSize: AppSize.fTwentyTwo),
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
