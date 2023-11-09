import 'package:ePolli/app/core/helpers/app_size.dart';
import 'package:ePolli/app/core/theme/app_color.dart';
import 'package:ePolli/app/core/widgets/constant.dart';
import 'package:ePolli/app/modules/update_password/update_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({super.key});

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  bool _obscureText = true;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      final UpdatePasswordController updatePasswordController =
          Get.put(UpdatePasswordController());
      updatePasswordController.updatePassword(
        Get.arguments['emailOrPhoneNumber'],
        _passwordController.text,
        // Pass the currentContext here
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Password Page"),
        centerTitle: true,
        backgroundColor: AppColor.secondary,
      ),
      body: ListView(
        children: [
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
                    "Please update your password",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      color: AppColor.bTextLight,
                      fontWeight: FontWeight.bold,
                    ),
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
                      "Update".tr,
                      style: TextStyle(fontSize: AppSize.fTwentyTwo),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
