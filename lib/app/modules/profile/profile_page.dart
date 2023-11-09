import 'dart:io';

import 'package:ePolli/app/core/helpers/app_size.dart';
import 'package:ePolli/app/core/theme/app_color.dart';
import 'package:ePolli/app/core/widgets/constant.dart';
import 'package:ePolli/app/modules/profile/profile_controller.dart';
import 'package:ePolli/epolli_app_secret/secret.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _obscureText = true;
  final ProfileController profileController = Get.put(ProfileController());

  final GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nidController = TextEditingController();

  @override
  void initState() {
    profileController.getInvestorFromSecureStorage().then((value) {
      fullNameController.text =
          profileController.investorInfo.value.fullName ?? '';
      phoneNumberController.text =
          profileController.investorInfo.value.phoneNumber ?? '';
      emailController.text = profileController.investorInfo.value.email ?? '';
      addressController.text =
          profileController.investorInfo.value.address ?? '';
      passwordController.text =
          profileController.investorInfo.value.password ?? '';
      nidController.text = profileController.investorInfo.value.nidNumber ?? '';
      return null;
    });
    super.initState();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    addressController.dispose();
    passwordController.dispose();
    nidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.secondary,
        elevation: 5,
        title: Text(
          "Edit Profile".tr,
        ),
        centerTitle: true,
      ),
      //
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppSize.pFifteen, vertical: AppSize.pTen),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    Obx(
                      () => Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: const Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image:
                              profileController.profileImageLocation.value != ''
                                  ? DecorationImage(
                                      fit: BoxFit.contain,
                                      image: FileImage(File(profileController
                                          .profileImageLocation.value)),
                                    )
                                  : profileController.investorInfo.value
                                              .imageLocation !=
                                          null
                                      ? DecorationImage(
                                          fit: BoxFit.contain,
                                          image: NetworkImage(
                                            // Secret.baseURL +
                                            //     profileController.investorInfo
                                            //         .value.imageLocation,
                                            profileController.investorInfo.value
                                                        .imageLocation.length >
                                                    50
                                                ? profileController.investorInfo
                                                    .value.imageLocation
                                                : Secret.baseURL +
                                                    profileController
                                                        .investorInfo
                                                        .value
                                                        .imageLocation,
                                          ),
                                        )
                                      : null,
                        ),
                        child: Center(
                          child: profileController
                                          .investorInfo.value.imageLocation ==
                                      null &&
                                  profileController
                                          .profileImageLocation.value ==
                                      ''
                              ? Text(
                                  'Add Profile Image'.tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: AppSize.fFourteen,
                                    color: AppColor.bTextLight,
                                  ),
                                )
                              : null,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          color: Colors.green,
                        ),
                        child: IconButton(
                          onPressed: () {
                            showImagePicker(context,
                                profileController.profileImageLocation);
                          },
                          icon: Obx(
                            () => Icon(
                              profileController.investorInfo.value
                                              .imageLocation ==
                                          null &&
                                      profileController
                                              .profileImageLocation.value ==
                                          ''
                                  ? Icons.add_a_photo_outlined
                                  : Icons.edit_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Constant.sbHTwenty,
              Constant.sbHTwenty,
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: fullNameController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Full Name'.tr,
                  hintText: 'Enter your name'.tr,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name'.tr;
                  }
                  return null;
                },
              ),
              Constant.sbHFifteen,
              TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                controller: phoneNumberController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Phone Number'.tr,
                  hintText: 'Enter your phone number'.tr,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number'.tr;
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              Constant.sbHFifteen,
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Email'.tr,
                  hintText: 'Enter your email'.tr,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email'.tr;
                  }
                  return null;
                },
              ),
              Constant.sbHFifteen,
              TextFormField(
                controller: passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Password'.tr,
                  hintText: 'Enter your password'.tr,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
              ),
              Constant.sbHFifteen,
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Address'.tr,
                  hintText: 'Enter your address'.tr,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address'.tr;
                  }
                  return null;
                },
              ),
              Constant.sbHFifteen,
              TextFormField(
                controller: nidController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'NID Number'.tr,
                  hintText: 'Enter NID Number'.tr,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter NID number'.tr;
                  }
                  return null;
                },
              ),
              Constant.sbHFifteen,
              FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Obx(
                                () => Container(
                                  width: AppSize.screenWidth * 0.44,
                                  height: AppSize.screenWidth * 0.29,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 4,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor),
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius: 2,
                                          blurRadius: 10,
                                          color: Colors.black.withOpacity(0.1),
                                          offset: const Offset(0, 10))
                                    ],
                                    shape: BoxShape.rectangle,
                                    image: profileController
                                                .nidFrontImageLocation.value !=
                                            ''
                                        ? DecorationImage(
                                            fit: BoxFit.contain,
                                            image: FileImage(File(
                                                profileController
                                                    .nidFrontImageLocation
                                                    .value)),
                                          )
                                        : profileController.investorInfo.value
                                                    .nidFrontImageLocation !=
                                                null
                                            ? DecorationImage(
                                                fit: BoxFit.contain,
                                                image: NetworkImage(
                                                  Secret.baseURL +
                                                      profileController
                                                          .investorInfo
                                                          .value
                                                          .nidFrontImageLocation,
                                                ),
                                              )
                                            : null,
                                  ),
                                  child: Center(
                                    child: profileController.investorInfo.value
                                                    .nidFrontImageLocation ==
                                                null &&
                                            profileController
                                                    .nidFrontImageLocation
                                                    .value ==
                                                ''
                                        ? Text(
                                            'Add NID Front Image'.tr,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: AppSize.fFourteen,
                                              color: AppColor.bTextLight,
                                            ),
                                          )
                                        : null,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 4,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                    ),
                                    color: Colors.green,
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      showImagePicker(
                                          context,
                                          profileController
                                              .nidFrontImageLocation);
                                    },
                                    icon: Obx(
                                      () => Icon(
                                        profileController.investorInfo.value
                                                        .nidFrontImageLocation ==
                                                    null &&
                                                profileController
                                                        .nidFrontImageLocation
                                                        .value ==
                                                    ''
                                            ? Icons.add_a_photo_outlined
                                            : Icons.edit_outlined,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Constant.sbHTen,
                          Text(
                            'NID Front Image'.tr,
                            style: TextStyle(
                              fontSize: AppSize.fFourteen,
                              color: AppColor.bTextLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Constant.sbWTen,
                    Center(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Obx(
                                () => Container(
                                  width: AppSize.screenWidth * 0.44,
                                  height: AppSize.screenWidth * 0.29,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 4,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor),
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius: 2,
                                          blurRadius: 10,
                                          color: Colors.black.withOpacity(0.1),
                                          offset: const Offset(0, 10))
                                    ],
                                    shape: BoxShape.rectangle,
                                    image: profileController
                                                .nidBackImageLocation.value !=
                                            ''
                                        ? DecorationImage(
                                            fit: BoxFit.contain,
                                            image: FileImage(File(
                                                profileController
                                                    .nidBackImageLocation
                                                    .value)),
                                          )
                                        : profileController.investorInfo.value
                                                    .nidBackImageLocation !=
                                                null
                                            ? DecorationImage(
                                                fit: BoxFit.contain,
                                                image: NetworkImage(
                                                  Secret.baseURL +
                                                      profileController
                                                          .investorInfo
                                                          .value
                                                          .nidBackImageLocation,
                                                ),
                                              )
                                            : null,
                                  ),
                                  child: Center(
                                    child: profileController.investorInfo.value
                                                    .nidBackImageLocation ==
                                                null &&
                                            profileController
                                                    .nidBackImageLocation
                                                    .value ==
                                                ''
                                        ? Text(
                                            'Add NID Back Image'.tr,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: AppSize.fFourteen,
                                              color: AppColor.bTextLight,
                                            ),
                                          )
                                        : null,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 4,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                    ),
                                    color: Colors.green,
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      showImagePicker(
                                          context,
                                          profileController
                                              .nidBackImageLocation);
                                    },
                                    icon: Obx(
                                      () => Icon(
                                        profileController.investorInfo.value
                                                        .nidBackImageLocation ==
                                                    null &&
                                                profileController
                                                        .nidBackImageLocation
                                                        .value ==
                                                    ''
                                            ? Icons.add_a_photo_outlined
                                            : Icons.edit_outlined,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Constant.sbHTen,
                          Text(
                            'NID Back Image'.tr,
                            style: TextStyle(
                              fontSize: AppSize.fFourteen,
                              color: AppColor.bTextLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Constant.sbHFifteen,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("CANCEL".tr,
                        style: const TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        profileController.updateInvestorPersonalInfo(
                          name: fullNameController.text,
                          phoneNumber: phoneNumberController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          address: addressController.text,
                          nidNUmber: nidController.text,
                          nidBackImageLocation:
                              profileController.nidBackImageLocation.value,
                        );
                      }
                      if (profileController.profileImageLocation.value != '') {
                        profileController.uploadProfileImage();
                      }
                      if (profileController.nidFrontImageLocation.value != '') {
                        profileController.uploadNidFrontImage();
                      }
                      if (profileController.nidBackImageLocation.value != '') {
                        profileController.uploadNidBackImage();
                      }
                    },
                    child: Obx(
                      () => profileController.isProfileUploading.value
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "Update".tr,
                              style: const TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 2.2,
                                  color: Colors.white),
                            ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  showImagePicker(BuildContext context, RxString imageLocation) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Choose an option'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  onTap: () async {
                    final picker = ImagePicker();
                    XFile? image =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      imageLocation.value = image.path;
                    }
                    Get.back();
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.photo),
                      Constant.sbWTen,
                      const Text('Gallery'),
                      // show that image in image container
                    ],
                  ),
                ),
                Constant.sbHTen,
                Constant.sbHTen,
                Constant.sbHTen,
                GestureDetector(
                  onTap: () async {
                    final picker = ImagePicker();
                    XFile? image =
                        await picker.pickImage(source: ImageSource.camera);
                    if (image != null) {
                      imageLocation.value = image.path;
                    }
                    Get.back();
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.camera),
                      Constant.sbWTen,
                      const Text('Camera'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
