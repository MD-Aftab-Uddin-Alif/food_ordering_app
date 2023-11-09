import 'package:ePolli/app/core/helpers/app_size.dart';
import 'package:ePolli/app/core/theme/app_color.dart';
import 'package:ePolli/app/core/widgets/constant.dart';
import 'package:ePolli/app/core/widgets/language_switch_widget.dart';
import 'package:ePolli/app/modules/sign_up/sign_up_controller.dart';
import 'package:ePolli/app/routes/sign_in_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = "sign-up";
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _obscureText = true;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final SignUpController signUpController = Get.put(SignUpController());

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _referralCodeController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const LanguageSwitchWidget(),
                ElevatedButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSize.rTen),
                    ),
                    foregroundColor: AppColor.secondary,
                    backgroundColor: AppColor.primary,
                    textStyle: TextStyle(
                      fontSize: AppSize.fFourteen,
                    ),
                  ),
                  onPressed: () async {
                    Get.back();
                  },
                  child: Row(
                    children: [
                      Text(
                        "Skip".tr,
                        style: const TextStyle(
                          color: AppColor.secondary,
                          fontSize: 18,
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_right_outlined,
                        color: AppColor.secondary,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          /* ------------------------------- ePolli Logo ------------------------------ */
          SizedBox(
            height: 150,
            child: Image.asset('assets/images/logo/epolli.png',
                fit: BoxFit.contain),
          ),
          Container(
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: Constant.boxShadow,
            ),
            padding: EdgeInsets.all(AppSize.pTwenty),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Welcome back'.tr,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: AppColor.bText,
                    ),
                  ),
                  FittedBox(
                    child: Text(
                      "Sign Up for your account".tr,
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColor.bTextLight,
                      ),
                    ),
                  ),
                  Constant.sbHTen,
                  /* ----------------------------- Full Name Field ---------------------------- */
                  TextFormField(
                    controller: _fullNameController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "Full Name".tr,
                      icon: const Icon(Icons.person_outline),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter full name'.tr;
                      }
                      return null;
                    },
                  ),
                  Constant.sbHTen,
                  /* ------------------------------ Email/Number Field ------------------------------ */
                  TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "Email Address".tr,
                        icon: const Icon(Icons.email_outlined),
                      ),
                      validator: (value) {
                        if (value!.isNotEmpty) {
                          if (!value.contains('@')) {
                            return 'Please enter a valid email address'.tr;
                          }
                        }
                        return null;
                      }),
                  Constant.sbHTen,
                  /* ------------------------------ Phone Number Field ------------------------------ */
                  TextFormField(
                    controller: _phoneNumberController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "Phone Number".tr,
                      icon: const Icon(Icons.phone_outlined),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number'.tr;
                      } else if (value.length != 11) {
                        return 'Please enter a 11 digit phone number'.tr;
                      }
                      return null;
                    },
                  ),
                  Constant.sbHTen,
                  /* ------------------------------ Password Field ------------------------------ */
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      icon: const Icon(Icons.lock_outline),
                      labelText: 'Password'.tr,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password'.tr;
                      }
                      return null;
                    },
                  ),
                  Constant.sbHTen,
                  /* ------------------------------ Confirm Password Field ------------------------------ */
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      icon: const Icon(Icons.lock_outline),
                      labelText: 'Confirm Password'.tr,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter confirm password'.tr;
                      }
                      if (value != _passwordController.text) {
                        return 'Password does not match'.tr;
                      }
                      return null;
                    },
                  ),
                  Constant.sbHTen,
                  TextFormField(
                    controller: _referralCodeController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      icon: const Image(
                        image: AssetImage(
                          'assets/images/logo/referral-min.png',
                        ),
                        height: 20,
                      ),
                      labelText: 'Referral Code'.tr,
                    ),
                  ),
                  Constant.sbHTen,
                  Obx(
                    () => signUpController.isLoading.value
                        ? const Image(
                            image: AssetImage('assets/images/loading.gif'),
                          )
                        : ElevatedButton(
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
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await signUpController.signUp(
                                  _fullNameController.text,
                                  _phoneNumberController.text,
                                  _emailController.text,
                                  _passwordController.text,
                                  _referralCodeController.text,
                                );
                              }
                            },
                            child: Text(
                              "Sign Up".tr,
                              style: TextStyle(fontSize: AppSize.fTwentyTwo),
                            ),
                          ),
                  )
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Already Have an account?".tr,
                style: TextStyle(
                  color: AppColor.bText,
                  fontSize: AppSize.fSixteen,
                ),
              ),
              Constant.sbHTen,
              TextButton(
                child: Text(
                  "Sign In".tr,
                  style: TextStyle(
                    color: AppColor.secondary,
                    fontSize: AppSize.fEighteen,
                  ),
                ),
                onPressed: () {
                  Get.back();
                  Get.toNamed(SignInRoutes.signIn);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
