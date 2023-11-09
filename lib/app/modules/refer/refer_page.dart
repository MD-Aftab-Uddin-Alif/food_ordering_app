import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ePolli/app/core/helpers/app_size.dart';
import 'package:ePolli/app/core/locale/get_localized_text.dart';
import 'package:ePolli/app/core/locale/translate_to_bangla_digit.dart';
import 'package:ePolli/app/core/theme/app_color.dart';
import 'package:ePolli/app/core/widgets/constant.dart';
import 'package:ePolli/app/modules/home/home_controller.dart';
import 'package:ePolli/app/modules/profile/profile_controller.dart';
import 'package:ePolli/epolli_app_secret/secret.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import 'refer_controller.dart';

class ReferPage extends GetView<ReferController> {
  const ReferPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.put(ProfileController());
    final HomeController homeController = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: Text("Referrals".tr),
        centerTitle: true,
        backgroundColor: AppColor.secondary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text('Refer a Friends'.tr,
                          style: TextStyle(
                            fontSize: AppSize.fTwelve,
                            fontWeight: FontWeight.w600,
                          )),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColor.secondary[200],
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 5.0,
                              ),
                              AnimatedTextKit(
                                animatedTexts: [
                                  ColorizeAnimatedText(
                                    'Earn up to 500 + 500*'.tr,
                                    textStyle: const TextStyle(
                                      fontSize: 25.0,
                                    ),
                                    colors: [
                                      Colors.black,
                                      Colors.black12,
                                      Colors.black26,
                                      Colors.black38,
                                      Colors.black45,
                                      Colors.black54,
                                      Colors.black87,
                                    ],
                                    speed: const Duration(milliseconds: 500),
                                  ),
                                ],
                                isRepeatingAnimation: true,
                                repeatForever: true,
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                'For each project'.tr,
                                style: TextStyle(
                                  fontSize: AppSize.fTwelve,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Constant.sbHTen,
                      SizedBox(
                        height: 105,
                        child: Row(
                          children: [
                            SizedBox(
                              height: 105,
                              width: Get.context!.width * .23,
                              child: Column(
                                children: [
                                  Image.asset('assets/images/refer/1-min.png',
                                      fit: BoxFit.contain),
                                ],
                              ),
                            ),
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Colors.green,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 105,
                              width: Get.context!.width * .23,
                              child: Column(
                                children: [
                                  Image.asset('assets/images/refer/2-min.png',
                                      fit: BoxFit.contain),
                                ],
                              ),
                            ),
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Colors.green,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 105,
                              width: Get.context!.width * .23,
                              child: Column(
                                children: [
                                  Image.asset('assets/images/refer/3-min.png',
                                      fit: BoxFit.contain),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 90,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: Get.context!.width * .23,
                              child: Column(
                                children: [
                                  Text(
                                    'Share your referral code with friends'.tr,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 10.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Column(
                              children: [
                                Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Colors.green,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: Get.context!.width * .23,
                              child: Column(
                                children: [
                                  Text(
                                    'Enter the code on the sign up page'.tr,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 10.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Column(
                              children: [
                                Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Colors.green,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: Get.context!.width * .23,
                              child: Column(
                                children: [
                                  Text(
                                    'If you buy the project from the app, both of you will get up to 500 + 500 Taka in each project.'
                                        .tr,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 10.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColor.secondary,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  profileController
                                      .investorInfo.value.referralId,
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.copy,
                                    color: Colors.green,
                                  ),
                                  onPressed: homeController.isSigned.value
                                      ? () {
                                          Clipboard.setData(
                                            ClipboardData(
                                              text: profileController
                                                  .investorInfo
                                                  .value
                                                  .referralId,
                                            ),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'Number Copied to Clipboard'),
                                            ),
                                          );
                                        }
                                      : () {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Please login to get refer code'
                                                      .tr),
                                            ),
                                          );
                                        },
                                ),
                              ],
                            ),
                          ),
                          Obx(
                            () => ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.secondary,
                              ),
                              onPressed: homeController.isSigned.value
                                  ? () {
                                      Share.share(
                                          '${'Install & use this ref code: '.tr}${profileController.investorInfo.value.referralId}${' in sign up page and earn up to 500Tk in every project purchase. Hurry up install the app: '.tr}${Secret.ePolliPlayStoreURL}');
                                    }
                                  : () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content:
                                              Text('Please login to refer'.tr),
                                        ),
                                      );
                                    },
                              child: Text(
                                'Refer Now'.tr,
                                style: TextStyle(
                                  fontSize: AppSize.fFourteen,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Referral Status'.tr,
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColor.secondary,
                                  ),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Column(
                                    children: [
                                      Text(
                                        getLocalizedText(
                                          profileController.investorInfo.value
                                              .totalRegistered,
                                          translateToBanglaDigit(
                                              profileController.investorInfo
                                                  .value.totalRegistered),
                                        ).toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Total\nRegistration'.tr,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColor.secondary,
                                  ),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Column(
                                    children: [
                                      Text(
                                        getLocalizedText(
                                          profileController.investorInfo.value
                                              .referredPoints,
                                          translateToBanglaDigit(
                                              profileController.investorInfo
                                                  .value.referredPoints),
                                        ).toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Points\nReceived'.tr,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
