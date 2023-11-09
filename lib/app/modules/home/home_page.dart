import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ePolli/app/core/helpers/app_size.dart';
import 'package:ePolli/app/core/locale/get_localized_text.dart';
import 'package:ePolli/app/core/theme/app_color.dart';
import 'package:ePolli/app/core/widgets/agri_info_card_widget.dart';
import 'package:ePolli/app/core/widgets/constant.dart';
import 'package:ePolli/app/core/widgets/floating_contact_widget.dart';
import 'package:ePolli/app/core/widgets/image_label_card_widget.dart';
import 'package:ePolli/app/modules/cart/cart_controller.dart';
import 'package:ePolli/app/modules/home/home_controller.dart';
import 'package:ePolli/app/modules/news/news_controller.dart';
import 'package:ePolli/app/modules/order_history/order_history_controller.dart';
import 'package:ePolli/app/modules/profile/profile_controller.dart';
import 'package:ePolli/app/modules/splash/splash_controller.dart';
import 'package:ePolli/app/routes/news_routes.dart';
import 'package:ePolli/app/routes/product_routes.dart';
import 'package:ePolli/app/routes/refer_routes.dart';
import 'package:ePolli/epolli_app_secret/secret.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  DateTime? currentBackPressTime;
  CarouselSliderController? _sliderController;
  final HomeController homeController = Get.put(HomeController());
  final CartController cartController = Get.put(CartController());
  final ProfileController profileController = Get.put(ProfileController());
  final OrderHistoryController orderHistoryController =
      Get.put(OrderHistoryController());
  NewsController newsController = Get.put(NewsController());
  final SplashController splashController = Get.put(SplashController());

  @override
  void initState() {
    super.initState();
    profileController.getInvestorFromSecureStorage().then((a) {
      return profileController.isProfileComplete().then((b) {
          return homeController.getProducts().then((g) {
              return homeController.getRecommendedProducts().then((i) {
                  return cartController.retrieveCartList().then((k) {
                    return orderHistoryController.getOrders().then((l) {
                      return profileController
                          .fetchInvestorInfoFromServer()
                          .then((m) {
                        return homeController.isFirstLoading.value = false;
                      });
                    });
                  });
                
              });
          
          });
        
      });
    });

    _sliderController = CarouselSliderController();
  }

  @override
  void dispose() {
    _sliderController!.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Press again to exit'),
          duration: Duration(seconds: 2),
        ),
      );
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
        child: Scaffold(
          /* -------------------------------------------------------------------------- */
          /*                                   App Bar                                  */
          /* -------------------------------------------------------------------------- */
          appBar: appBarSection(),
          extendBodyBehindAppBar: true,

          /* -------------------------------------------------------------------------- */
          /*                                    Body                                    */
          /* -------------------------------------------------------------------------- */
          body: ListView(
            padding: const EdgeInsets.only(top: 0),
            children: <Widget>[
              /* -------------------------------------------------------------------------- */
              /*                         Image slider and Agri Info                         */
              /* -------------------------------------------------------------------------- */
              Stack(
                children: [
                  /* ------------------------------ Image Slider ------------------------------ */
                  imageSliderSection(),
                  /* --------------------------- Agri Info Container -------------------------- */
                  agriInfoContainer(),
                ],
              ),
              
              /* -------------------------------------------------------------------------- */
              /*                             Shop By Category                            */
              /* -------------------------------------------------------------------------- */
              shopByCategorySection(),
              Constant.sbHTwenty,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    /* -------------------------------------------------------------------------- */
                    /*                               Refer a Friend                               */
                    /* -------------------------------------------------------------------------- */
                    referAFriendSection(),
                    Constant.sbHTwenty,
                    /* -------------------------------------------------------------------------- */
                    /*                                    News                                    */
                    /* -------------------------------------------------------------------------- */
                    newsSection(),
                    Constant.sbHTwenty,
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
          floatingActionButton: const FloatingContactWidget(),
        ),
      ),
    );
  }

  AppBar appBarSection() {
    return AppBar(
      backgroundColor: const Color.fromARGB(117, 122, 179, 150),
      leading: Obx(
        () => homeController.isSigned.value &&
                profileController.investorInfo.value.imageLocation != null &&
                profileController.investorInfo.value.imageLocation != ''
            ? Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      AppSize.rTen,
                    ),
                    child: Obx(
                      () => FadeInImage.assetNetwork(
                        placeholder: 'assets/images/loading.gif',
                        image: profileController
                                    .investorInfo.value.imageLocation.length >
                                50
                            ? profileController.investorInfo.value.imageLocation
                            : Secret.baseURL +
                                profileController
                                    .investorInfo.value.imageLocation,
                        fit: BoxFit.cover,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset('assets/images/logo/epolli.png');
                        },
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox(),
      ),
      leadingWidth: 50,
      title: Obx(
        () => homeController.isSigned.value
            ? Text(
                '${'Hello,'.tr} ${profileController.investorInfo.value.fullName.split(' ')[0]}',
                style: TextStyle(
                  fontSize: AppSize.fTwenty,
                  color: AppColor.wText,
                ),
              )
            : const SizedBox(),
      ),
      elevation: 0,
    );
  }

  SizedBox imageSliderSection() {
    return SizedBox(
      width: double.infinity,
      height: AppSize.headerHeight,
      child: CarouselSlider.builder(
        unlimitedMode: true,
        controller: _sliderController,
        slideBuilder: (index) {
          return Container(
            margin: const EdgeInsets.all(0),
            padding: const EdgeInsets.all(0),
            alignment: Alignment.topCenter,
            child: Obx(
              () => homeController.isAgriInfoLoading.value
                  ? const Center(
                      child: Image(
                      image: AssetImage('assets/images/loading.gif'),
                    ))
                  : Image.network(
                      Secret.baseURL +
                          homeController
                              .agriInfoList[index].sliderImageLocation,
                      fit: BoxFit.cover,
                      height: AppSize.iSliderHeight,
                      width: double.infinity,
                    ),
            ),
          );
        },
        slideTransform: const DefaultTransform(),
        itemCount: 4,
        initialPage: 0,
        enableAutoSlider: true,
      ),
    );
  }

  
  Padding shopByCategorySection() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Shop By Category'.tr,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Get.toNamed(
                    ProductRoutes.product,
                    arguments: 'All',
                  );
                },
                child: Text(
                  'View all'.tr,
                  style: TextStyle(
                    fontSize: AppSize.fFourteen,
                    color: AppColor.secondary,
                  ),
                ),
              ),
            ],
          ),
          Constant.sbHTwenty,
          Obx(() {
            if (homeController.isProductCategoriesLoading.value) {
              return Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  shariahInvestmentShimmer(),
                  shariahInvestmentShimmer(),
                  shariahInvestmentShimmer(),
                ],
              ));
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /* ------------------------- Shop By Category (Healthy) ------------------------ */
                  ImageLabelCardWidget(
                    image: homeController.productCategoryList[0].imageLocation
                        .toString(),
                    label: homeController.isUSLocale.value
                        ? homeController.productCategoryList[0].name.toString()
                        : homeController.productCategoryList[0].nameBn != null
                            ? homeController.productCategoryList[0].nameBn
                                .toString()
                            : homeController.productCategoryList[0].name,
                    routeName: ProductRoutes.product,
                    typeId: homeController.productCategoryList[0].id.toInt(),
                  ),
                  /* ---------------------- Shop By Category (Seasonal) --------------------- */
                  ImageLabelCardWidget(
                    image: homeController.productCategoryList[1].imageLocation
                        .toString(),
                    label: homeController.isUSLocale.value
                        ? homeController.productCategoryList[1].name.toString()
                        : homeController.productCategoryList[1].nameBn != null
                            ? homeController.productCategoryList[1].nameBn
                                .toString()
                            : homeController.productCategoryList[1].name,
                    routeName: ProductRoutes.product,
                    typeId: homeController.productCategoryList[1].id.toInt(),
                  ),
                  /* --------------------------- Shop By Category (Festive) --------------------------- */
                  ImageLabelCardWidget(
                    image: homeController.productCategoryList[2].imageLocation
                        .toString(),
                    label: homeController.isUSLocale.value
                        ? homeController.productCategoryList[2].name.toString()
                        : homeController.productCategoryList[2].nameBn != null
                            ? homeController.productCategoryList[2].nameBn
                                .toString()
                            : homeController.productCategoryList[2].name,
                    routeName: ProductRoutes.product,
                    typeId: homeController.productCategoryList[2].id.toInt(),
                  ),
                ],
              );
            }
          }),
        ],
      ),
    );
  }

  
  Column newsSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'News'.tr,
              style: TextStyle(
                fontSize: AppSize.fTwenty,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: () {
                Get.toNamed(NewsRoutes.news);
              },
              child: Text(
                'View all'.tr,
                style: TextStyle(
                  fontSize: AppSize.fFourteen,
                  color: AppColor.secondary,
                ),
              ),
            ),
          ],
        ),
        Obx(() {
          if (!newsController.isNewsLoading.value) {
            return Container(
              height: newsController.newsList.length > 4
                  ? 450
                  : newsController.newsList.length * 112,
              width: double.infinity,
              margin: const EdgeInsets.all(0),
              child: ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSize.hTen,
                  vertical: AppSize.hTen,
                ),
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5.0,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        // open default browser to show news
                        setState(() {
                          // open linkedin profile in external browser or linkedin app
                          launchUrl(
                            mode: LaunchMode.externalApplication,
                            Uri(
                              scheme: 'http',
                              path: newsController.newsList[index].source,
                            ),
                          );
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.secondary[200],
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Hero(
                                tag: 'news${newsController.newsList[index].id}',
                                child: FadeInImage.assetNetwork(
                                  placeholder: 'assets/images/loading.gif',
                                  width: 80,
                                  image:
                                      '${Secret.baseURL}${newsController.newsList[index].image}',
                                  fit: BoxFit.contain,
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
                                    return Image.asset(
                                        'assets/images/logo/epolli.png');
                                  },
                                ),
                              ),
                              title: Text(
                                homeController.isUSLocale.value
                                    ? newsController.newsList[index].title
                                        .toString()
                                    : newsController.newsList[index].titleBn !=
                                                null &&
                                            newsController
                                                    .newsList[index].titleBn !=
                                                ''
                                        ? newsController.newsList[index].titleBn
                                            .toString()
                                        : newsController.newsList[index].title
                                            .toString(),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Divider(
                              thickness: 1,
                              color: AppColor.primary,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.edit_note_outlined,
                                      color: AppColor.secondary,
                                    ),
                                    Constant.sbWTen,
                                    Text(
                                      homeController.isUSLocale.value
                                          ? newsController
                                              .newsList[index].sourceAuthor
                                              .toString()
                                          : newsController.newsList[index]
                                                          .sourceAuthorBn !=
                                                      null &&
                                                  newsController.newsList[index]
                                                          .sourceAuthorBn !=
                                                      ''
                                              ? newsController.newsList[index]
                                                  .sourceAuthorBn
                                                  .toString()
                                              : newsController
                                                  .newsList[index].sourceAuthor
                                                  .toString(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: AppColor.bText,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: newsController.newsList.length > 4
                    ? 4
                    : newsController.newsList.length,
              ),
            );
          } else {
            return const Center(
              child: Image(
                image: AssetImage('assets/images/loading.gif'),
              ),
            );
          }
        }),
      ],
    );
  }

  Card referAFriendSection() {
    return Card(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
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
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please login to refer'.tr),
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
                ElevatedButton(
                  // style: ElevatedButton.styleFrom(
                  //   backgroundColor: AppColor.secondary,
                  // ),
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                      width: 2,
                      color: AppColor.secondary,
                    ),
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Get.toNamed(
                      ReferRoutes.refer,
                    );
                  },
                  child: Text(
                    'Learn More'.tr,
                    style: TextStyle(
                      fontSize: AppSize.fFourteen,
                      color: AppColor.secondary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Positioned agriInfoContainer() {
    return Positioned(
      top: AppSize.headerContainerTopGap,
      left: AppSize.headerContainerSideGap,
      right: AppSize.headerContainerSideGap,
      height: AppSize.headerInfoHeight,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.rTwenty),
          color: AppColor.primary,
          boxShadow: Constant.boxShadow,
        ),
        padding: EdgeInsets.all(AppSize.pFive),

        /* -------------------------------------------------------------------------- */
        /*                                    here                                    */
        /* -------------------------------------------------------------------------- */
        child: Obx(
          () => homeController.isAgriInfoLoading.value
              ? getShimmerLoading()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AgriInfoCardWidget(
                      imageLocation:
                          homeController.agriInfoList[0].imageLocation,
                      number: getLocalizedText(
                        homeController.agriInfoList[0].number,
                        homeController.agriInfoList[0].numberBn,
                      ).toString(),
                      name: getLocalizedText(
                        homeController.agriInfoList[0].name,
                        homeController.agriInfoList[0].nameBn,
                      ).toString(),
                    ),
                    const VerticalDivider(
                      thickness: 2,
                    ),
                    AgriInfoCardWidget(
                      imageLocation:
                          homeController.agriInfoList[1].imageLocation,
                      number: getLocalizedText(
                              homeController.agriInfoList[1].number,
                              homeController.agriInfoList[1].numberBn)
                          .toString(),
                      name: getLocalizedText(
                        homeController.agriInfoList[1].name,
                        homeController.agriInfoList[1].nameBn,
                      ).toString(),
                    ),
                    const VerticalDivider(
                      thickness: 2,
                    ),
                    AgriInfoCardWidget(
                      imageLocation:
                          homeController.agriInfoList[2].imageLocation,
                      number: getLocalizedText(
                              homeController.agriInfoList[2].number,
                              homeController.agriInfoList[2].numberBn)
                          .toString(),
                      name: getLocalizedText(
                        homeController.agriInfoList[2].name,
                        homeController.agriInfoList[2].nameBn,
                      ).toString(),
                    ),
                    const VerticalDivider(
                      thickness: 2,
                    ),
                    AgriInfoCardWidget(
                      imageLocation:
                          homeController.agriInfoList[3].imageLocation,
                      number: getLocalizedText(
                              homeController.agriInfoList[3].number,
                              homeController.agriInfoList[3].numberBn)
                          .toString(),
                      name: getLocalizedText(
                        homeController.agriInfoList[3].name,
                        homeController.agriInfoList[3].nameBn,
                      ).toString(),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Shimmer getShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(color: Colors.white, width: 50, height: 50),
              const SizedBox(height: 5),
              Container(color: Colors.white, width: 50, height: 10),
              const SizedBox(height: 5),
              Container(color: Colors.white, width: 50, height: 10),
            ],
          ),
          const VerticalDivider(
            thickness: 2,
            color: Colors.black,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(color: Colors.white, width: 50, height: 50),
              const SizedBox(height: 5),
              Container(color: Colors.white, width: 50, height: 10),
              const SizedBox(height: 5),
              Container(color: Colors.white, width: 50, height: 10),
            ],
          ),
          const VerticalDivider(
            thickness: 2,
            color: Colors.black,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(color: Colors.white, width: 50, height: 50),
              const SizedBox(height: 5),
              Container(color: Colors.white, width: 50, height: 10),
              const SizedBox(height: 5),
              Container(color: Colors.white, width: 50, height: 10),
            ],
          ),
          const VerticalDivider(
            thickness: 2,
            color: Colors.black,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(color: Colors.white, width: 50, height: 50),
              const SizedBox(height: 5),
              Container(color: Colors.white, width: 50, height: 10),
              const SizedBox(height: 5),
              Container(color: Colors.white, width: 50, height: 10),
            ],
          ),
        ],
      ),
    );
  }

  Shimmer shariahInvestmentShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(color: Colors.white, width: 50, height: 50),
              const SizedBox(height: 5),
              Container(color: Colors.white, width: 50, height: 10),
            ],
          ),
        ],
      ),
    );
  }

  Shimmer bestOffersShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  width: 100,
                  height: 100),
              const SizedBox(height: 5),
              Container(color: Colors.white, width: 100, height: 10),
              const SizedBox(height: 5),
              Container(color: Colors.white, width: 100, height: 10),
              const SizedBox(height: 5),
              Container(color: Colors.white, width: 100, height: 10),
              const SizedBox(height: 5),
              Container(color: Colors.white, width: 100, height: 10),
              const SizedBox(height: 5),
              Container(color: Colors.white, width: 100, height: 10),
            ],
          ),
        ],
      ),
    );
  }
}
