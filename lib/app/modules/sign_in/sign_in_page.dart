import 'package:ePolli/app/core/helpers/app_size.dart';
import 'package:ePolli/app/core/theme/app_color.dart';
import 'package:ePolli/app/core/widgets/constant.dart';
import 'package:ePolli/app/core/widgets/language_switch_widget.dart';
import 'package:ePolli/app/modules/sign_in/sign_in_controller.dart';
import 'package:ePolli/app/routes/forgot_password_routes.dart';
import 'package:ePolli/app/routes/sign_up_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInPage extends StatefulWidget {
  static const String routeName = "sign-in";

  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _obscureText = true;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailOrPhoneNumberController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final SignInController signInController = Get.put(SignInController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailOrPhoneNumberController.dispose();
    _passwordController.dispose();
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
                    'Welcome'.tr,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: AppColor.bText,
                    ),
                  ),
                  FittedBox(
                    child: Text(
                      "Sign in your account".tr,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        fontSize: 23,
                        color: AppColor.bTextLight,
                      ),
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
                  /* ------------------------------- Password Field ------------------------------ */
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    onEditingComplete: onSubmit,
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
                        return 'Please enter your password'.tr;
                      }
                      return null;
                    },
                  ),
                  Constant.sbHTen,
                  /* ------------------------------- Forgot Password ------------------------------ */
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      child: Text(
                        "Forgot your Password?".tr,
                        style: TextStyle(
                          color: AppColor.secondary,
                          fontSize: AppSize.fFourteen,
                        ),
                      ),
                      onPressed: () {
                        Get.toNamed(
                          ForgotPasswordRoutes.forgotPassword,
                        );
                      },
                    ),
                  ),
                  Constant.sbHTen,
                  /* ------------------------------- Sign In Button ------------------------------ */
                  Obx(
                    () => signInController.isLoading.value
                        ? const Image(
                            image: AssetImage('assets/images/loading.gif'),
                            height: 50,
                            width: 50,
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
                            onPressed: onSubmit,
                            child: Text(
                              "Sign In".tr,
                              style: TextStyle(fontSize: AppSize.fTwentyTwo),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
          // todo add Google SignIn logic
          // Column(
          //   children: [
          //     Text(
          //       "Or Sign In using".tr,
          //       style: TextStyle(
          //         fontSize: AppSize.fEighteen,
          //         color: AppColor.bText,
          //       ),
          //     ),
          //     Constant.sbHTen,
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         ElevatedButton.icon(
          //           onPressed: () async {
          //             final googleSignIn = GoogleSignIn();
          //             googleSignIn.signIn().then(
          //               (value) {
          //                 signInController.signInWithGoogle(
          //                   value!.displayName as String,
          //                   value.email,
          //                   value.photoUrl!,
          //                 );
          //               },
          //             );
          //           },
          //           icon: Image.asset(
          //             'assets/images/logo/google.png',
          //             height: AppSize.imThirty,
          //           ),
          //           label: Text(
          //             'Google'.tr,
          //             style: TextStyle(
          //               fontSize: AppSize.fEighteen,
          //             ),
          //           ),
          //           style: ElevatedButton.styleFrom(
          //             foregroundColor: Colors.black,
          //             backgroundColor: Colors.white,
          //             minimumSize: Size(AppSize.screenWidth / 2 - 50, 50),
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.all(
          //                 Radius.circular(AppSize.rTen),
          //               ),
          //               side: const BorderSide(color: AppColor.secondary),
          //             ),
          //           ),
          //         ),
          //         // Constant.sbWTwenty,
          //         // ElevatedButton.icon(
          //         //   onPressed: () {
          //         //     // todo add Facebook SignIn logic
          //         //     // showDialog(
          //         //     //   context: context,
          //         //     //   builder: (context) => AlertDialog(
          //         //     //     title: Text(
          //         //     //       'Continue with',
          //         //     //       style: TextStyle(
          //         //     //         fontSize: AppSize.fTwenty,
          //         //     //         fontWeight: FontWeight.bold,
          //         //     //       ),
          //         //     //     ),
          //         //     //     content: Column(
          //         //     //       mainAxisSize: MainAxisSize.min,
          //         //     //       children: [
          //         //     //         GestureDetector(
          //         //     //           onTap: () {
          //         //     //             // _mobileNumber = '0123456789';
          //         //     //             _googleSignIn
          //         //     //                 .signIn()
          //         //     //                 .then((value) => print(value));
          //         //     //           },
          //         //     //           child: Row(
          //         //     //             children: [
          //         //     //               Icon(
          //         //     //                 Icons.call,
          //         //     //                 size: AppSize.iTwentyFour,
          //         //     //               ),
          //         //     //               Constant.sbWTwenty,
          //         //     //               Text(
          //         //     //                 'Google',
          //         //     //                 style: TextStyle(
          //         //     //                     fontSize: AppSize.fSixteen,
          //         //     //                     color: AppColor.bText),
          //         //     //               ),
          //         //     //             ],
          //         //     //           ),
          //         //     //         ),
          //         //     //         Constant.sbHTwenty,
          //         //     //         GestureDetector(
          //         //     //           onTap: () {
          //         //     //             // _mobileNumber = '0123456789';
          //         //     //           },
          //         //     //           child: Row(
          //         //     //             children: [
          //         //     //               Icon(
          //         //     //                 Icons.call,
          //         //     //                 size: AppSize.iTwentyFour,
          //         //     //               ),
          //         //     //               Constant.sbWTwenty,
          //         //     //               Text(
          //         //     //                 'Google',
          //         //     //                 style: TextStyle(
          //         //     //                     fontSize: AppSize.fSixteen,
          //         //     //                     color: AppColor.bText),
          //         //     //               ),
          //         //     //             ],
          //         //     //           ),
          //         //     //         ),
          //         //     //       ],
          //         //     //     ),
          //         //     //     actions: [
          //         //     //       TextButton(
          //         //     //         onPressed: () {
          //         //     //           Navigator.pop(context);
          //         //     //         },
          //         //     //         child: const Row(
          //         //     //           children: [
          //         //     //             Text('NONE OF THE ABOVE'),
          //         //     //           ],
          //         //     //         ),
          //         //     //       ),
          //         //     //     ],
          //         //     //   ),
          //         //     // );
          //         //   },
          //         //   icon: Image.asset(
          //         //     'assets/images/logo/facebook.png',
          //         //     height: AppSize.imThirty,
          //         //   ),
          //         //   label: Text(
          //         //     'Facebook',
          //         //     style: TextStyle(
          //         //       fontSize: AppSize.fEighteen,
          //         //     ),
          //         //   ),
          //         //   style: ElevatedButton.styleFrom(
          //         //     foregroundColor: Colors.black,
          //         //     backgroundColor: Colors.white,
          //         //     minimumSize: Size(
          //         //       AppSize.screenWidth / 2 - 50,
          //         //       50,
          //         //     ),
          //         //     shape: RoundedRectangleBorder(
          //         //       borderRadius: BorderRadius.all(
          //         //         Radius.circular(AppSize.rTen),
          //         //       ),
          //         //       side: const BorderSide(color: AppColor.secondary),
          //         //     ),
          //         //   ),
          //         // ),
          //       ],
          //     ),
          //   ],
          // ),
          Constant.sbHTen,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Don't have an account?".tr,
                style: TextStyle(
                  color: AppColor.bText,
                  fontSize: AppSize.fSixteen,
                ),
              ),
              Constant.sbWTen,
              TextButton(
                child: Text(
                  "Sign Up Now".tr,
                  style: TextStyle(
                    color: AppColor.secondary,
                    fontSize: AppSize.fEighteen,
                  ),
                ),
                onPressed: () {
                  Get.back();
                  Get.toNamed(SignUpRoutes.signUp);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void onSubmit() async {
    if (_formKey.currentState!.validate()) {
      await signInController.signIn(
        _emailOrPhoneNumberController.text,
        _passwordController.text,
      );
    }
  }
}
