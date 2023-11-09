import 'package:ePolli/app/core/helpers/app_size.dart';
import 'package:ePolli/app/core/locale/get_localized_text.dart';
import 'package:ePolli/app/core/locale/translate_to_bangla_digit.dart';
import 'package:ePolli/app/core/theme/app_color.dart';
import 'package:ePolli/app/core/widgets/constant.dart';
import 'package:ePolli/app/modules/cart/cart_controller.dart';
import 'package:ePolli/app/modules/home/home_controller.dart';
import 'package:ePolli/app/modules/product_details/product_details_controller.dart';
import 'package:ePolli/app/routes/cart_routes.dart';
import 'package:ePolli/app/routes/product_details_routes.dart';
import 'package:ePolli/app/routes/product_routes.dart';
import 'package:ePolli/epolli_app_secret/secret.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'product_controller.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ProductController productController = Get.put(ProductController());
  final ProductDetailsController productDetailsController =
      Get.put(ProductDetailsController());
  final CartController cartController = Get.put(CartController());
  final HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    productController.getCategorizedProductList(
      Get.arguments.toString(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            productController.title.value.toString(),
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColor.secondary,
      ),
      body: Padding(
        padding: EdgeInsets.all(AppSize.pTen),
        child: Obx(
          () => homeController.isProductsLoading.value
              ? const Center(
                  child: Image(
                    image: AssetImage('assets/images/loading.gif'),
                  ),
                )
              : productController.categorizedProductList.isNotEmpty
                  ? GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 220,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSize.hTen,
                        vertical: AppSize.hTen,
                      ),
                      scrollDirection: Axis.vertical,
                      itemCount:
                          productController.categorizedProductList.length,
                      itemBuilder: (BuildContext context, index) {
                        var productList =
                            productController.categorizedProductList;
                        return Container(
                          margin: EdgeInsets.only(right: AppSize.hTen),
                          width: AppSize.listConWidth,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSize.rTen),
                            color: AppColor.primary,
                            boxShadow: Constant.boxShadow,
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(0),
                            width: AppSize.listConWidth,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSize.rTen),
                              color: AppColor.primary,
                              boxShadow: Constant.boxShadow,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    print(productList.elementAt(index).id);
                                    Get.toNamed(
                                      ProductDetailsRoutes.productDetails,
                                      arguments: productList.elementAt(index),
                                    );
                                  },
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      // * Product Container Image
                                      Center(
                                        child: Container(
                                          margin: const EdgeInsets.all(0),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                AppSize.rTen),
                                          ),
                                          height: AppSize.listConImHeight,
                                          child: Stack(
                                            children: [
                                              SizedBox(
                                                height: AppSize.listConImHeight,
                                                child: Hero(
                                                  tag:
                                                      'product${productList.elementAt(index).id}',
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      AppSize.rTen,
                                                    ),
                                                    child: FadeInImage
                                                        .assetNetwork(
                                                      placeholder:
                                                          'assets/images/loading.gif',
                                                      image: Secret.baseURL +
                                                          productList
                                                              .elementAt(index)
                                                              .imageLocation,
                                                      fit: BoxFit.contain,
                                                      imageErrorBuilder:
                                                          (context, error,
                                                              stackTrace) {
                                                        return Image.asset(
                                                            'assets/images/logo/epolli.png');
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              productList
                                                          .elementAt(index)
                                                          .discountedPrice !=
                                                      0
                                                  ? ClipRect(
                                                      child: Banner(
                                                        message:
                                                            '${getLocalizedText(
                                                          productList
                                                              .elementAt(index)
                                                              .discountPercentage
                                                              .toInt(),
                                                          translateToBanglaDigit(
                                                              productList
                                                                  .elementAt(
                                                                      index)
                                                                  .discountPercentage
                                                                  .toInt()),
                                                        )}% ${'Off'.tr}',
                                                        location: BannerLocation
                                                            .topEnd,
                                                        color: Colors.red,
                                                        child: Container(
                                                          height: AppSize
                                                              .listConImHeight,
                                                        ),
                                                      ),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        ),
                                      ),

                                      // * Product's infos
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: AppSize.pFive,
                                          left: AppSize.pFive,
                                          right: AppSize.pFive,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              getLocalizedText(
                                                productList
                                                    .elementAt(index)
                                                    .name,
                                                productList
                                                    .elementAt(index)
                                                    .nameBn,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: AppSize.fFourteen,
                                                color: AppColor.bText,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
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
                                                  productList
                                                              .elementAt(index)
                                                              .discountedPrice !=
                                                          0
                                                      ? getLocalizedText(
                                                          productList
                                                              .elementAt(index)
                                                              .discountedPrice,
                                                          translateToBanglaDigit(
                                                            productList
                                                                .elementAt(
                                                                    index)
                                                                .discountedPrice,
                                                          ),
                                                        ).toString()
                                                      : getLocalizedText(
                                                          productList
                                                              .elementAt(index)
                                                              .regularPrice,
                                                          translateToBanglaDigit(
                                                              productList
                                                                  .elementAt(
                                                                      index)
                                                                  .regularPrice),
                                                        ).toString(),
                                                  style: TextStyle(
                                                    color: AppColor.secondary,
                                                    fontSize: AppSize.fTwelve,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            productList
                                                        .elementAt(index)
                                                        .discountedPrice !=
                                                    0
                                                ? Row(
                                                    children: [
                                                      Constant.sbWTen,
                                                      Text(
                                                        '৳ ${getLocalizedText(
                                                          productList
                                                              .elementAt(index)
                                                              .regularPrice,
                                                          translateToBanglaDigit(
                                                            productList
                                                                .elementAt(
                                                                    index)
                                                                .regularPrice
                                                                .toString(),
                                                          ),
                                                        )}',
                                                        style: TextStyle(
                                                          color: AppColor
                                                              .bTextLight,
                                                          fontSize:
                                                              AppSize.fTen,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                        ),
                                                      ),
                                                      Constant.sbWTen,
                                                      Constant.sbWTen,
                                                      Text(
                                                        '-${getLocalizedText(
                                                          productList
                                                              .elementAt(index)
                                                              .discountPercentage
                                                              .toInt(),
                                                          translateToBanglaDigit(
                                                            productList
                                                                .elementAt(
                                                                    index)
                                                                .discountPercentage
                                                                .toInt(),
                                                          ),
                                                        ).toString()}%',
                                                        style: TextStyle(
                                                          fontSize:
                                                              AppSize.fTwelve,
                                                          color: AppColor.bText,
                                                          backgroundColor:
                                                              AppColor.secondary[
                                                                  100],
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : Container(),
                                            // Constant.sbHFive,
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (cartController.cartProductList.any(
                                        (element) =>
                                            element.productId ==
                                            productList.elementAt(index).id)) {
                                      // Use regular Flutter navigation instead of Get.toNamed
                                      Get.toNamed(CartRoutes.cart);
                                    } else {
                                      cartController
                                          .addProductToCart(
                                              productList.elementAt(index).id,
                                              productList
                                                  .elementAt(index)
                                                  .minQuantity)
                                          .then(
                                            (_) =>
                                                productController.isItemInCart(
                                              productList.elementAt(index),
                                            ),
                                          );
                                      // productController.update();
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: AppSize.hTen),
                                    height: 50,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: AppColor.secondary,
                                      borderRadius:
                                          BorderRadius.circular(AppSize.rTen),
                                    ),
                                    child: GetBuilder<ProductController>(
                                        builder: (context) {
                                      return Center(
                                        child: Obx(
                                          () => productController.isItemInCart(
                                                  productList.elementAt(index))
                                              ? Text(
                                                  'View Cart'.tr,
                                                  style: TextStyle(
                                                    fontSize: AppSize.fEighteen,
                                                    color: AppColor.primary,
                                                  ),
                                                )
                                              : productController.isPreOrder(
                                                      productList
                                                          .elementAt(index))
                                                  ? Text(
                                                      'Pre-order'.tr,
                                                      style: TextStyle(
                                                        fontSize:
                                                            AppSize.fEighteen,
                                                        color: AppColor.primary,
                                                      ),
                                                    )
                                                  : Text(
                                                      'Add to cart'.tr,
                                                      style: TextStyle(
                                                        fontSize:
                                                            AppSize.fEighteen,
                                                        color: AppColor.primary,
                                                      ),
                                                    ),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        Text(
                          '${'Currently we don\'t have any'.tr} ${productController.title.value.toLowerCase()}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: AppColor.bText,
                              fontSize: 30,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Checkout our other products'.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColor.bTextLight,
                              fontSize: 26,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AppSize.rTen,
                              ),
                            ),
                            backgroundColor: AppColor.secondary,
                            foregroundColor: AppColor.primary,
                            minimumSize: const Size(double.infinity - 50, 50),
                          ),
                          onPressed: () {
                            Get.toNamed(ProductRoutes.product,
                                arguments: 'All');
                            productController.getCategorizedProductList('All');
                          },
                          child: Text(
                            'All Products'.tr.toUpperCase(),
                            style: TextStyle(fontSize: AppSize.fTwenty),
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
