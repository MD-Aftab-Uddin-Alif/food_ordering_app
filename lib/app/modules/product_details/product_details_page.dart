import 'package:ePolli/app/core/locale/get_localized_text.dart';
import 'package:ePolli/app/core/locale/translate_to_bangla_digit.dart';
import 'package:ePolli/app/data/models/product_model.dart';
import 'package:ePolli/app/modules/cart/cart_controller.dart';
import 'package:ePolli/app/modules/home/home_controller.dart';
import 'package:ePolli/app/modules/product_details/product_details_controller.dart';
import 'package:ePolli/app/modules/profile/profile_controller.dart';
import 'package:ePolli/app/routes/cart_routes.dart';
import 'package:ePolli/epolli_app_secret/secret.dart';
import 'package:flutter/material.dart';
import 'package:ePolli/app/core/helpers/app_size.dart';
import 'package:ePolli/app/core/theme/app_color.dart';
import 'package:ePolli/app/core/widgets/constant.dart';
import 'package:ePolli/app/core/widgets/floating_contact_widget.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  List<ProductModel> recommendedProductsForCurrentProductList = [];
  final ProductDetailsController productDetailsController =
      Get.put(ProductDetailsController());
  final ProfileController profileController = Get.put(ProfileController());

  final CartController cartController = Get.put(CartController());
  final HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    // check if product is added to cart
    for (int i = 0; i < cartController.cartProductList.length; i++) {
      if (cartController.cartProductList[i].productId ==
          int.parse(Get.arguments.id.toString())) {
        productDetailsController.isProductAddedToCart.value = true;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductModel product = Get.arguments;
    recommendedProductsForCurrentProductList.clear();
    recommendedProductsForCurrentProductList.addAll(
      homeController.productList.where(
        (element) {
          return element.categoryId == product.categoryId &&
              element.id != product.id &&
              element.stock > 0;
        },
      ),
    );

    // for (int i = 0; i < homeController.recommendedProductList.length; i++) {
    //   if (product.id == homeController.recommendedProductList[i].productId) {
    //     recommendedProductsForCurrentProductList.add(
    //       homeController.productList[
    //           homeController.recommendedProductList[i].recommendedProductId],
    //     );
    //   }
    // }

    return Scaffold(
      // backgroundColor: Colors.grey.withOpacity(0.999),
      body: Stack(
        children: [
          NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  title: Text('Product Details'.tr),
                  centerTitle: true,
                  pinned: true,
                  floating: true,
                  backgroundColor: AppColor.secondary,
                ),
              ];
            },
            body: SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          /* ------------------------------ Product Image ----------------------------- */
                          SizedBox(
                            height: AppSize.screenHeight * 0.3,
                            width: double.infinity,
                            child: Hero(
                              tag: 'product${product.id}',
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/images/loading.gif',
                                image: Secret.baseURL + product.imageLocation,
                                fit: BoxFit.contain,
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return Image.asset(
                                      'assets/images/logo/epolli.png');
                                },
                              ),
                            ),
                          ),
                          /* ------------------------------- Share Icon ------------------------------- */
                          Positioned(
                            right: AppSize.wTwentyFive,
                            bottom: 0,
                            child: Container(
                              height: 50,
                              width: 50,
                              padding: const EdgeInsets.all(
                                5,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.secondary,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  Share.share(
                                      '${'Install & use this ref code: '.tr}${profileController.investorInfo.value.referralId}${' in sign up page and earn up to 500Tk in every project purchase. Hurry up install the app: '.tr}${Secret.ePolliPlayStoreURL}');
                                },
                                icon: const Icon(
                                  Icons.share,
                                  color: AppColor.primary,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(
                          AppSize.hTwenty,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            /* --------------------- Product Name, fee, availability --------------------- */
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: AppSize.screenWidth * 0.7,
                                      child: Text(
                                        homeController.isUSLocale.value
                                            ? product.name
                                            : product.nameBn ?? product.name,
                                        style: TextStyle(
                                          fontSize: AppSize.fTwenty,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Constant.sbWTen,
                                        Text(
                                          '৳',
                                          style: TextStyle(
                                            color: AppColor.secondary,
                                            fontSize: AppSize.fSixteen,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Constant.sbWTen,
                                        Text(
                                          product.discountedPrice != 0
                                              ? getLocalizedText(
                                                      product.discountedPrice,
                                                      translateToBanglaDigit(
                                                          product
                                                              .discountedPrice))
                                                  .toString()
                                              : getLocalizedText(
                                                  product.regularPrice,
                                                  translateToBanglaDigit(
                                                      product.regularPrice),
                                                ).toString(),
                                          style: TextStyle(
                                              fontSize: AppSize.fSixteen),
                                        ),
                                        Constant.sbWTen,
                                        product.discountedPrice != 0
                                            ? Row(
                                                children: [
                                                  Text(
                                                    getLocalizedText(
                                                      product.regularPrice,
                                                      translateToBanglaDigit(
                                                          product.regularPrice),
                                                    ).toString(),
                                                    style: TextStyle(
                                                      fontSize: AppSize.fTwelve,
                                                      color:
                                                          AppColor.bTextLight,
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                    ),
                                                  ),
                                                  Constant.sbWTen,
                                                  Constant.sbWTen,
                                                  Text(
                                                    '-${getLocalizedText(
                                                      product.discountPercentage
                                                          .toInt(),
                                                      translateToBanglaDigit(
                                                          product
                                                              .discountPercentage
                                                              .toInt()),
                                                    ).toString()}%',
                                                    style: TextStyle(
                                                      fontSize: AppSize.fTwelve,
                                                      color: AppColor.bText,
                                                      backgroundColor: AppColor
                                                          .secondary[100],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  children: [
                                    Text(
                                      'Stock'.tr,
                                      style: TextStyle(
                                        fontSize: AppSize.fSixteen,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      getLocalizedText(
                                        product.stock,
                                        translateToBanglaDigit(product.stock),
                                      ).toString(),
                                      style: TextStyle(
                                        fontSize: AppSize.fSixteen,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Constant.sbHTen,
                            product.deliveryDate != null &&
                                    product.deliveryDate != ''
                                ? Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Delivery Date: '.tr,
                                          style: TextStyle(
                                            fontSize: AppSize.fSixteen,
                                          ),
                                        ),
                                        Text(
                                          getLocalizedText(
                                            '${product.deliveryDate}',
                                            translateToBanglaDigit(
                                                product.deliveryDate),
                                          ).toString(),
                                          style: TextStyle(
                                            fontSize: AppSize.fSixteen,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox(),
                            Constant.sbHTen,
                            /* ----------------------------- Product Details ---------------------------- */
                            Container(
                              padding: EdgeInsets.all(
                                AppSize.wTwenty,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.secondary,
                                borderRadius: BorderRadius.circular(
                                  AppSize.rTen,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Product Details'.tr,
                                    style: TextStyle(
                                      fontSize: AppSize.fTwenty,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Constant.sbHTwenty,
                                  Text(
                                    homeController.isUSLocale.value
                                        ? product.details
                                        : product.detailsBn ?? product.details,
                                    style: TextStyle(
                                      fontSize: AppSize.fFourteen,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Constant.sbHTwenty,
                            /* -------------------------------------------------------------------------- */
                            /*                                 Recommended by Seller                           */
                            /* -------------------------------------------------------------------------- */
                            recommendedProductsForCurrentProductList.isNotEmpty
                                ? Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Recommended by Seller'.tr,
                                            style: TextStyle(
                                              fontSize: AppSize.fTwenty,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Constant.sbHTwenty,
                                      /* --------------------------- Recommended by Seller -------------------------- */

                                      Container(
                                        height: AppSize.hPConHeight + 20,
                                        width: double.infinity,
                                        margin: const EdgeInsets.all(0),
                                        child: ListView.builder(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: AppSize.hTen,
                                            vertical: AppSize.hTen,
                                          ),
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              recommendedProductsForCurrentProductList
                                                  .length,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            return Container(
                                              margin: EdgeInsets.only(
                                                  right: AppSize.hTen),
                                              width: AppSize.listConWidth - 50,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppSize.rTen),
                                                color: AppColor.primary,
                                                boxShadow: Constant.boxShadow,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const ProductDetailsPage(),
                                                          settings:
                                                              RouteSettings(
                                                            arguments:
                                                                recommendedProductsForCurrentProductList[
                                                                    index],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        // * Product Container Image
                                                        Center(
                                                          child: Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .all(0),
                                                            decoration:
                                                                BoxDecoration(
                                                              image:
                                                                  DecorationImage(
                                                                image: NetworkImage(Secret
                                                                        .baseURL +
                                                                    recommendedProductsForCurrentProductList[
                                                                            index]
                                                                        .imageLocation),
                                                                fit: BoxFit
                                                                    .contain,
                                                              ),
                                                            ),
                                                            height: AppSize
                                                                .listConImHeight,
                                                            child: recommendedProductsForCurrentProductList[
                                                                            index]
                                                                        .discountedPrice !=
                                                                    0
                                                                ? Stack(
                                                                    children: [
                                                                      Container(
                                                                          height:
                                                                              AppSize.listConImHeight),
                                                                      ClipRect(
                                                                        child:
                                                                            Banner(
                                                                          message:
                                                                              '${getLocalizedText(
                                                                            recommendedProductsForCurrentProductList[index].discountPercentage.toInt(),
                                                                            translateToBanglaDigit(recommendedProductsForCurrentProductList[index].discountPercentage.toInt()),
                                                                          ).toString()}% ${'Off'.tr}',
                                                                          location:
                                                                              BannerLocation.topEnd,
                                                                          color:
                                                                              Colors.red,
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                AppSize.listConImHeight,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                                                : null,
                                                          ),
                                                        ),

                                                        // * Product's infos
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            top: AppSize.pFive,
                                                            left: AppSize.pFive,
                                                            right:
                                                                AppSize.pFive,
                                                          ),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                getLocalizedText(
                                                                    recommendedProductsForCurrentProductList[
                                                                            index]
                                                                        .name,
                                                                    recommendedProductsForCurrentProductList[
                                                                            index]
                                                                        .nameBn),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: AppSize
                                                                      .fFourteen,
                                                                  color: AppColor
                                                                      .bText,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              Constant.sbHFive,
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: <Widget>[
                                                                  Constant
                                                                      .sbWTen,
                                                                  Text(
                                                                    '৳',
                                                                    style:
                                                                        TextStyle(
                                                                      color: AppColor
                                                                          .secondary,
                                                                      fontSize:
                                                                          AppSize
                                                                              .fSixteen,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                  Constant
                                                                      .sbWTen,
                                                                  Text(
                                                                    recommendedProductsForCurrentProductList[index].discountedPrice !=
                                                                            0
                                                                        ? getLocalizedText(
                                                                            recommendedProductsForCurrentProductList[index].discountedPrice,
                                                                            translateToBanglaDigit(recommendedProductsForCurrentProductList[index].discountedPrice),
                                                                          ).toString()
                                                                        : getLocalizedText(
                                                                            recommendedProductsForCurrentProductList[index].regularPrice,
                                                                            translateToBanglaDigit(recommendedProductsForCurrentProductList[index].regularPrice),
                                                                          ).toString(),
                                                                    style:
                                                                        TextStyle(
                                                                      color: AppColor
                                                                          .secondary,
                                                                      fontSize:
                                                                          AppSize
                                                                              .fTwelve,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              recommendedProductsForCurrentProductList[
                                                                              index]
                                                                          .discountedPrice !=
                                                                      0
                                                                  ? Row(
                                                                      children: [
                                                                        Constant
                                                                            .sbWTen,
                                                                        Text(
                                                                          '৳ ${getLocalizedText(
                                                                            recommendedProductsForCurrentProductList[index].regularPrice,
                                                                            translateToBanglaDigit(recommendedProductsForCurrentProductList[index].regularPrice),
                                                                          ).toString()}',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                AppColor.bTextLight,
                                                                            fontSize:
                                                                                AppSize.fTen,
                                                                            decoration:
                                                                                TextDecoration.lineThrough,
                                                                          ),
                                                                        ),
                                                                        Constant
                                                                            .sbWTen,
                                                                        Constant
                                                                            .sbWTen,
                                                                        Text(
                                                                          '-${getLocalizedText(
                                                                            recommendedProductsForCurrentProductList[index].discountPercentage.toInt(),
                                                                            translateToBanglaDigit(
                                                                              recommendedProductsForCurrentProductList[index].discountPercentage.toInt(),
                                                                            ),
                                                                          ).toString()}%',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                AppSize.fTwelve,
                                                                            color:
                                                                                AppColor.bText,
                                                                            backgroundColor:
                                                                                AppColor.secondary[100],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  : Container(),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  /* --------------------------- Add to Cart Button --------------------------- */
                                                  GestureDetector(
                                                    onTap: () {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            'Product Added to Cart'
                                                                .tr,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        vertical: AppSize.hTen,
                                                      ),
                                                      height: 40,
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            AppColor.secondary,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          AppSize.rTen,
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'Add to cart'.tr,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            color: AppColor
                                                                .primary,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Constant.sbHTwenty,
                                      Constant.sbHTwenty,
                                      Constant.sbHTwenty,
                                      Constant.sbHTwenty,
                                      Constant.sbHTwenty,
                                    ],
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          /* ----------------------------- Floating Buttons ---------------------------- */
          Padding(
            padding: EdgeInsets.only(
              bottom: AppSize.hTen,
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: AppSize.screenHeight / 15,
                width: AppSize.screenWidth / 2,
                child: FloatingActionButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppSize.rTen,
                    ),
                  ),
                  hoverElevation: 10,
                  isExtended: true,
                  onPressed: () {
                    cartController.cartProductList.any((element) {
                      return element.productId == product.id;
                    })
                        ? Get.toNamed(CartRoutes.cart)
                        : cartController.addProductToCart(
                            product.id, product.minQuantity);
                  },
                  backgroundColor: AppColor.secondary,
                  child: Obx(
                    () {
                      productDetailsController
                          .isThisProductAddedToCart(product.id);
                      return Text(
                        productDetailsController.isProductAddedToCart.value
                            ? 'View Cart'.tr
                            : productDetailsController
                                    .isThisProductPreOrder(product.deliveryDate)
                                ? "Pre-order".tr
                                : 'Add to cart'.tr,
                        style: TextStyle(
                          fontSize: AppSize.fTwenty,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      /* ------------------------- Floating Contact Button ------------------------ */
      floatingActionButton:
          FloatingContactWidget(msg: 'I have a query on ${product.name}'),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class BorderedContainer extends StatelessWidget {
  final String? title;
  final Widget? child;
  final double? height;
  final double width;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? color;
  final double elevation;

  const BorderedContainer({
    Key? key,
    this.title,
    this.child,
    this.height,
    this.padding,
    this.margin,
    this.color,
    this.width = double.infinity,
    this.elevation = 0.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      color: color,
      margin: margin ?? const EdgeInsets.all(0),
      child: Container(
        padding: padding ?? const EdgeInsets.all(16.0),
        width: width,
        height: height,
        child: title == null
            ? child
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 28.0),
                  ),
                  if (child != null) ...[
                    const SizedBox(height: 10.0),
                    child!,
                  ]
                ],
              ),
      ),
    );
  }
}

class SpecsBlock extends StatelessWidget {
  const SpecsBlock({
    Key? key,
    this.icon,
    this.label,
    this.value,
  }) : super(key: key);

  final Widget? icon;
  final String? label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            if (icon != null) icon!,
            const SizedBox(height: 2.0),
            Text(
              label!,
              style: TextStyle(
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              value!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
