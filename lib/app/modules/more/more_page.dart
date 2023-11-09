import 'package:ePolli/app/core/helpers/app_size.dart';
import 'package:ePolli/app/core/theme/app_color.dart';
import 'package:ePolli/app/core/widgets/constant.dart';
import 'package:ePolli/app/core/widgets/language_switch_widget.dart';
import 'package:ePolli/app/modules/home/home_controller.dart';
import 'package:ePolli/app/modules/more/more_controller.dart';
import 'package:ePolli/app/modules/profile/profile_controller.dart';
import 'package:ePolli/app/modules/sign_in/sign_in_controller.dart';
import 'package:ePolli/app/modules/sign_in/sign_in_page.dart';
import 'package:ePolli/app/modules/splash/splash_controller.dart';
import 'package:ePolli/app/routes/order_history_routes.dart';
import 'package:ePolli/app/routes/profile_routes.dart';
import 'package:ePolli/app/routes/terms_conditions_routes.dart';
import 'package:ePolli/epolli_app_secret/secret.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  final ProfileController profileController = Get.put(ProfileController());
  final HomeController homeController = Get.put(HomeController());
  final MoreController moreController = Get.put(MoreController());
  SplashController splashController = Get.put(SplashController());

  GestureDetector imageLabelNavigate(
      String routeName, String imageUrl, String label) {
    return GestureDetector(
      onTap: () {
        if (routeName != '/sign-out') {
          Get.toNamed(routeName);
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
          left: AppSize.pTen,
          right: AppSize.pTen,
          bottom: AppSize.pTen,
        ),
        child: Card(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSize.pTen,
              vertical: AppSize.pTen,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: AppColor.primary,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            AppSize.rTwenty,
                          ),
                        ),
                      ),
                      width: 40,
                      height: 40,
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: Image(image: AssetImage(imageUrl)),
                      ),
                    ),
                    Constant.sbWTwenty,
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: AppSize.fSixteen,
                        color: AppColor.bText,
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.keyboard_arrow_right,
                  color: AppColor.bText,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    profileController.getInvestorFromSecureStorage().then((value) {
      moreController.isPersonalDetailsComplete();
      moreController.isBankDetailsComplete();
      moreController.isNomineeDetailsComplete();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: homeController.isSigned.value ? 100 : 40,
                margin: EdgeInsets.symmetric(
                  horizontal: AppSize.pTen,
                  vertical: AppSize.pTen,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Obx(
                      () => homeController.isSigned.value &&
                              profileController
                                      .investorInfo.value.imageLocation !=
                                  null &&
                              profileController
                                      .investorInfo.value.imageLocation !=
                                  ''
                          ? Center(
                              child: Hero(
                                tag: 'profileImage',
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    AppSize.rTen,
                                  ),
                                  child: Obx(
                                    () => FadeInImage.assetNetwork(
                                      placeholder: 'assets/images/loading.gif',
                                      image: profileController.investorInfo
                                                  .value.imageLocation.length >
                                              50
                                          ? profileController
                                              .investorInfo.value.imageLocation
                                          : Secret.baseURL +
                                              profileController.investorInfo
                                                  .value.imageLocation,
                                      fit: BoxFit.cover,
                                      imageErrorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                            'assets/images/logo/epolli.png');
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ),
                    Constant.sbWTwenty,
                    Container(
                      margin: const EdgeInsets.all(0),
                      padding: const EdgeInsets.all(0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: AppSize.screenWidth / 1.8,
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Spacer(),
                                LanguageSwitchWidget(),
                              ],
                            ),
                          ),
                          Obx(
                            () => homeController.isSigned.value
                                ? SizedBox(
                                    width: AppSize.screenWidth / 1.8,
                                    child: Row(
                                      children: [
                                        Text(
                                          profileController
                                              .investorInfo.value.fullName,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: const TextStyle(
                                            fontSize: 17,
                                            color: AppColor.bText,
                                          ),
                                        ),
                                        const Spacer(),
                                      ],
                                    ),
                                  )
                                : const SizedBox(),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Obx(
                () => homeController.isSigned.value
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              top: AppSize.pTwelve,
                              left: AppSize.pTen,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: AppSize.pTen,
                              ),
                              child: Text(
                                'Profile'.tr,
                                style: TextStyle(
                                  fontSize: AppSize.fTwenty,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Constant.sbHTen,
                          Column(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(ProfileRoutes.profile);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: AppSize.pTen,
                                    right: AppSize.pTen,
                                    bottom: AppSize.pTen,
                                  ),
                                  child: Card(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: AppSize.pTen,
                                        vertical: AppSize.pTen,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: AppColor.primary,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(
                                                      AppSize.rTwenty,
                                                    ),
                                                  ),
                                                ),
                                                width: 40,
                                                height: 40,
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: const Center(
                                                  child: Image(
                                                      image: AssetImage(
                                                          'assets/images/logo/Personal.png')),
                                                ),
                                              ),
                                              Constant.sbWTwenty,
                                              Text(
                                                'Personal Details'.tr,
                                                style: TextStyle(
                                                  fontSize: AppSize.fSixteen,
                                                  color: AppColor.bText,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Obx(
                                                () {
                                                  return Container(
                                                    padding: EdgeInsets.all(
                                                        AppSize.pFive - 3),
                                                    decoration: BoxDecoration(
                                                      color: moreController
                                                              .isPersonalDetailsCompleted
                                                              .value
                                                          ? AppColor.secondary
                                                          : Colors.yellow,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(
                                                          AppSize.rTwenty,
                                                        ),
                                                      ),
                                                    ),
                                                    child: Icon(
                                                      moreController
                                                              .isPersonalDetailsCompleted
                                                              .value
                                                          ? Icons.done_outlined
                                                          : Icons
                                                              .close_outlined,
                                                      color: AppColor.primary,
                                                    ),
                                                  );
                                                },
                                              ),
                                              Constant.sbWTwenty,
                                              const Icon(
                                                Icons.keyboard_arrow_right,
                                                color: AppColor.bText,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : Container(),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: AppSize.pTwelve,
                  left: AppSize.pTen,
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: AppSize.pTen,
                  ),
                  child: Text(
                    'Settings'.tr,
                    style: TextStyle(
                      fontSize: AppSize.fTwenty,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Column(
                children: <Widget>[
                  homeController.isSigned.value
                      ? imageLabelNavigate(
                          OrderHistoryRoutes.orderHistory,
                          'assets/images/logo/Order.png',
                          'Order History'.tr,
                        )
                      : Container(),
                  
                  // imageLabelNavigate(
                  //   NewsRoutes.news,
                  //   'assets/images/logo/News.png',
                  //   'News'.tr,
                  // ),
                  
                  imageLabelNavigate(
                    TermsConditionsRoutes.termsConditions,
                    'assets/images/logo/Terms.png',
                    'Terms & Conditions'.tr,
                  ),
                  Obx(
                    () => homeController.isSigned.value
                        ? GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Are you sure?'.tr),
                                    content:
                                        Text('Do you want to sign out?'.tr),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text('No'.tr),
                                      ),
                                      TextButton(
                                        onPressed: moreController.signOutMethod,
                                        child: Text('Yes'.tr),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: AppSize.pTen,
                                right: AppSize.pTen,
                                bottom: AppSize.pTen,
                              ),
                              child: Card(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: AppSize.pTen,
                                    vertical: AppSize.pTen,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                              color: AppColor.primary,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                  AppSize.rTwenty,
                                                ),
                                              ),
                                            ),
                                            width: 40,
                                            height: 40,
                                            padding: const EdgeInsets.all(10),
                                            child: const Center(
                                              child: Image(
                                                  image: AssetImage(
                                                      'assets/images/logo/Logout.png')),
                                            ),
                                          ),
                                          Constant.sbWTwenty,
                                          Text(
                                            'Sign Out'.tr,
                                            style: TextStyle(
                                              fontSize: AppSize.fSixteen,
                                              color: AppColor.bText,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Icon(
                                        Icons.keyboard_arrow_right,
                                        color: AppColor.bText,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onLongPress: () async {
                              final googleSignIn = GoogleSignIn();
                              googleSignIn.signIn().then(
                                (value) {
                                  SignInController signInController =
                                      SignInController();
                                  signInController.signInWithGoogle(
                                    value!.displayName as String,
                                    value.email,
                                    value.photoUrl!,
                                  );
                                },
                              );
                            },
                            onTap: () {
                              Get.toNamed(SignInPage.routeName);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: AppSize.pTen,
                                right: AppSize.pTen,
                                bottom: AppSize.pTen,
                              ),
                              child: Card(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: AppSize.pTen,
                                    vertical: AppSize.pTen,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                              color: AppColor.primary,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                  AppSize.rTwenty,
                                                ),
                                              ),
                                            ),
                                            width: 40,
                                            height: 40,
                                            padding: const EdgeInsets.all(10),
                                            child: const Center(
                                              child: Image(
                                                  image: AssetImage(
                                                      'assets/images/logo/Login.png')),
                                            ),
                                          ),
                                          Constant.sbWTwenty,
                                          Text(
                                            'Sign In'.tr,
                                            style: TextStyle(
                                              fontSize: AppSize.fSixteen,
                                              color: AppColor.bText,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Icon(
                                        Icons.keyboard_arrow_right,
                                        color: AppColor.bText,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
