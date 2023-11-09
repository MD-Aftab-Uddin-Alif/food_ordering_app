import 'package:ePolli/app/core/helpers/app_size.dart';
import 'package:ePolli/app/core/locale/get_localized_text.dart';
import 'package:ePolli/app/core/locale/translate_to_bangla_digit.dart';
import 'package:ePolli/app/core/theme/app_color.dart';
import 'package:ePolli/app/core/widgets/constant.dart';
import 'package:ePolli/app/core/widgets/custom_snackbar.dart';
import 'package:ePolli/app/data/models/product_model.dart';
import 'package:ePolli/app/modules/home/home_controller.dart';
import 'package:ePolli/app/modules/product/product_controller.dart';
import 'package:ePolli/app/routes/checkout_routes.dart';
import 'package:ePolli/app/routes/product_details_routes.dart';
import 'package:ePolli/app/routes/product_routes.dart';
import 'package:ePolli/app/routes/sign_in_routes.dart';
import 'package:ePolli/epolli_app_secret/secret.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'cart_controller.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartController cartController = Get.put(CartController());
  final HomeController homeController = Get.put(HomeController());
  ProductController productController = Get.put(ProductController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Cart'.tr),
        centerTitle: true,
        backgroundColor: AppColor.secondary,
      ),
      //
      body: Obx(() => cartController.isCartLoading.value ||
              homeController.isProductsLoading.value
          ? const Center(
              child: Image(
                image: AssetImage('assets/images/loading.gif'),
              ),
            )
          : Stack(
              children: [
                Container(
                  height: AppSize.screenHeight * .7,
                  padding: EdgeInsets.all(AppSize.pTen),
                  child: cartController.cartProductList.isEmpty
                      ? ListView(
                          children: [
                            const SizedBox(
                              height: 100,
                            ),
                            Text(
                              'No product Added to Cart'.tr,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: AppColor.bText,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Checkout our products'.tr,
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
                                minimumSize:
                                    const Size(double.infinity - 50, 50),
                              ),
                              onPressed: () {
                                Get.toNamed(ProductRoutes.product,
                                    arguments: 'All');
                                productController
                                    .getCategorizedProductList('All');
                              },
                              child: Text(
                                'All Products'.tr.toUpperCase(),
                                style: TextStyle(fontSize: AppSize.fTwenty),
                              ),
                            ),
                          ],
                        )
                      : ListView.builder(
                          itemCount: cartController.cartProductList.length,
                          itemBuilder: (context, index) {
                            if (cartController.cartProductList.isNotEmpty) {
                              double price = 0;
                              ProductModel product = homeController.productList
                                  .firstWhere((element) =>
                                      element.id ==
                                      cartController
                                          .cartProductList[index].productId);
                              if (product.discountPercentage == 0) {
                                price = product.regularPrice;
                              } else {
                                price = product.discountedPrice;
                              }
                              cartController.subTotalPrice.value += price *
                                  cartController
                                      .cartProductList[index].quantity;

                              return Container(
                                height: 165,
                                padding: EdgeInsets.all(AppSize.pTen),
                                margin: EdgeInsets.only(bottom: AppSize.pTen),
                                color: AppColor.primary,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                          ProductDetailsRoutes.productDetails,
                                          arguments: product,
                                        );
                                      },
                                      child: Container(
                                        height: 90,
                                        width: 90,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              AppSize.pTen),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              Secret.baseURL +
                                                  product.imageLocation,
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                          color: AppColor.secondary[200],
                                        ),
                                        child: Hero(
                                          tag: 'product${product.id}',
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              AppSize.rTen,
                                            ),
                                            child: FadeInImage.assetNetwork(
                                              placeholder:
                                                  'assets/images/loading.gif',
                                              image: Secret.baseURL +
                                                  product.imageLocation,
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
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: AppSize.pTen,
                                            ),
                                            Container(
                                              height: 90,
                                              margin: const EdgeInsets.all(0),
                                              padding: const EdgeInsets.only(
                                                  bottom: 5),
                                              decoration: const BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: AppColor.secondary,
                                                  ),
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Get.toNamed(
                                                        ProductDetailsRoutes
                                                            .productDetails,
                                                        arguments: product,
                                                      );
                                                    },
                                                    child: SizedBox(
                                                      width:
                                                          AppSize.screenWidth *
                                                              0.6,
                                                      child: Text(
                                                        getLocalizedText(
                                                            product.name,
                                                            product.nameBn),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize:
                                                                AppSize.pTwenty,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Constant.sbWTen,
                                                      Text(
                                                        '৳',
                                                        style: TextStyle(
                                                          color: AppColor
                                                              .secondary,
                                                          fontSize:
                                                              AppSize.fSixteen,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Constant.sbWTen,
                                                      Text(
                                                        product.discountedPrice !=
                                                                0
                                                            ? getLocalizedText(
                                                                    product
                                                                        .discountedPrice,
                                                                    translateToBanglaDigit(
                                                                        product
                                                                            .discountedPrice))
                                                                .toString()
                                                            : getLocalizedText(
                                                                    product
                                                                        .regularPrice,
                                                                    translateToBanglaDigit(
                                                                        product
                                                                            .regularPrice))
                                                                .toString(),
                                                      ),
                                                      Constant.sbWTen,
                                                      product.discountedPrice !=
                                                              0
                                                          ? Row(
                                                              children: [
                                                                Constant.sbWTen,
                                                                Text(
                                                                  getLocalizedText(
                                                                          product
                                                                              .regularPrice,
                                                                          translateToBanglaDigit(
                                                                              product.regularPrice))
                                                                      .toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    color: AppColor
                                                                        .bTextLight,
                                                                    fontSize:
                                                                        AppSize
                                                                            .fTen,
                                                                    decoration:
                                                                        TextDecoration
                                                                            .lineThrough,
                                                                  ),
                                                                ),
                                                                Constant.sbWTen,
                                                                Constant.sbWTen,
                                                                Text(
                                                                  '-${getLocalizedText(product.discountPercentage.toInt(), translateToBanglaDigit(product.discountPercentage.toInt()))}%',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        AppSize
                                                                            .fTwelve,
                                                                    color: AppColor
                                                                        .bText,
                                                                    backgroundColor:
                                                                        AppColor
                                                                            .secondary[100],
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : Container(),
                                                      Constant.sbWTen,
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: AppSize.screenWidth *
                                                        0.6,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Spacer(),
                                                        GestureDetector(
                                                          onTap: () {
                                                            final cartItem = cartController
                                                                .cartProductList
                                                                .where((element) =>
                                                                    element
                                                                        .productId ==
                                                                    product.id)
                                                                .toList()
                                                                .first;
                                                            if (cartItem
                                                                    .quantity ==
                                                                product
                                                                    .minQuantity) {
                                                              cartController
                                                                  .removeProductFromCart(
                                                                      cartItem
                                                                          .productId);
                                                            } else {
                                                              cartController
                                                                  .decreaseProductQuantity(
                                                                      cartItem
                                                                          .productId,
                                                                      cartItem
                                                                          .quantity);
                                                            }
                                                          },
                                                          child: Container(
                                                            height: 30,
                                                            width: 30,
                                                            margin:
                                                                const EdgeInsets
                                                                    .all(0),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          AppSize
                                                                              .pTen),
                                                              color: AppColor
                                                                      .secondary[
                                                                  100],
                                                            ),
                                                            child: const Icon(
                                                              Icons
                                                                  .remove_outlined,
                                                              size: 20,
                                                              color: AppColor
                                                                  .secondary,
                                                            ),
                                                          ),
                                                        ),
                                                        Constant.sbWTwenty,
                                                        Obx(
                                                          () => Text(
                                                            getLocalizedText(
                                                              cartController
                                                                  .cartProductList
                                                                  .firstWhere((element) =>
                                                                      element
                                                                          .productId ==
                                                                      product
                                                                          .id)
                                                                  .quantity
                                                                  .toString(),
                                                              translateToBanglaDigit(
                                                                cartController
                                                                    .cartProductList
                                                                    .firstWhere((element) =>
                                                                        element
                                                                            .productId ==
                                                                        product
                                                                            .id)
                                                                    .quantity
                                                                    .toString(),
                                                              ),
                                                            ),
                                                            style: TextStyle(
                                                                fontSize: AppSize
                                                                    .fTwenty),
                                                          ),
                                                        ),
                                                        Constant.sbWTwenty,
                                                        GestureDetector(
                                                          onTap: () {
                                                            final cartItem = cartController
                                                                .cartProductList
                                                                .where((element) =>
                                                                    element
                                                                        .productId ==
                                                                    product.id)
                                                                .toList()
                                                                .first;
                                                            if (cartItem
                                                                    .quantity ==
                                                                product.stock) {
                                                              customSnackbar(
                                                                'Error'.tr,
                                                                'Maximum stock reached'
                                                                    .tr,
                                                                'warning'.tr,
                                                              );
                                                            } else {
                                                              cartController
                                                                  .increaseProductQuantity(
                                                                      cartItem
                                                                          .productId,
                                                                      cartItem
                                                                          .quantity);
                                                            }
                                                          },
                                                          child: Container(
                                                            height: 30,
                                                            width: 30,
                                                            margin:
                                                                const EdgeInsets
                                                                    .all(0),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          AppSize
                                                                              .pTen),
                                                              color: AppColor
                                                                  .secondary,
                                                            ),
                                                            child: const Icon(
                                                              Icons
                                                                  .add_outlined,
                                                              size: 20,
                                                              color: AppColor
                                                                  .primary,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: AppSize.screenWidth * 0.6,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Constant.sbWTwenty,
                                              TextButton(
                                                onPressed: () {
                                                  cartController
                                                      .removeProductFromCart(
                                                          cartController
                                                              .cartProductList
                                                              .where((element) =>
                                                                  element
                                                                      .productId ==
                                                                  product.id)
                                                              .toList()
                                                              .first
                                                              .productId);
                                                },
                                                child: Text(
                                                  'Remove'.tr,
                                                  style: const TextStyle(
                                                      color: Colors.red),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }
                            return null;
                          },
                        ),
                ),
                DraggableScrollableSheet(
                  initialChildSize: 0.2,
                  minChildSize: 0.15,
                  maxChildSize: 0.3,
                  builder: (context, scrollController) {
                    return StatefulBuilder(builder: (context, setState) {
                      return Container(
                        decoration: BoxDecoration(
                          color: AppColor.secondary[100],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(AppSize.rTwenty),
                            topRight: Radius.circular(AppSize.rTwenty),
                          ),
                        ),
                        child: Scrollbar(
                          child: ListView.builder(
                            controller: scrollController,
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              cartController.subTotalPriceCal();
                              return Column(
                                children: [
                                  const Divider(
                                    indent: 50,
                                    endIndent: 50,
                                    thickness: 5,
                                    color: AppColor.secondary,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: AppSize.pTwenty),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    Text(
                                                      'Total Price: '.tr,
                                                      style: const TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      '${getLocalizedText(
                                                        cartController
                                                            .subTotalPrice
                                                            .value,
                                                        translateToBanglaDigit(
                                                            cartController
                                                                .subTotalPrice
                                                                .value),
                                                      )}/-',
                                                      style: const TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    AppColor.secondary,
                                              ),
                                              onPressed: cartController
                                                      .cartProductList.isEmpty
                                                  ? null
                                                  : () => homeController
                                                          .isSigned.value
                                                      ? Get.toNamed(
                                                          CheckoutRoutes
                                                              .checkout)
                                                      : Get.toNamed(
                                                          SignInRoutes.signIn),
                                              child: Text('Check out'.tr),
                                            )
                                          ],
                                        ),
                                        Center(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Spacer(),
                                              Text('*Scroll for Details'.tr),
                                              const Icon(Icons
                                                  .arrow_downward_outlined),
                                              const Spacer(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                      );
                    });
                  },
                ),
              ],
            )),
    );
  }
}
