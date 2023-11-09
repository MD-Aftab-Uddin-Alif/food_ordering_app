import 'package:ePolli/app/core/helpers/app_size.dart';
import 'package:ePolli/app/core/locale/get_localized_text.dart';
import 'package:ePolli/app/core/locale/translate_to_bangla_digit.dart';
import 'package:ePolli/app/core/theme/app_color.dart';
import 'package:ePolli/app/core/widgets/constant.dart';
import 'package:ePolli/app/modules/cart/cart_controller.dart';
import 'package:ePolli/app/modules/checkout/checkout_controller.dart';
import 'package:ePolli/app/modules/home/home_controller.dart';
import 'package:ePolli/app/modules/product/product_controller.dart';
import 'package:ePolli/app/modules/profile/profile_controller.dart';
import 'package:ePolli/app/modules/splash/splash_controller.dart';
import 'package:ePolli/epolli_app_secret/secret.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ProfileController profileController = Get.put(ProfileController());
  final CartController cartController = Get.put(CartController());
  final ProductController productController = Get.put(ProductController());
  final HomeController homeController = Get.put(HomeController());
  final CheckoutController checkoutController = Get.put(CheckoutController());
  final SplashController splashController = Get.put(SplashController());

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _couponCodeController = TextEditingController();
  final TextEditingController _giftVoucherController = TextEditingController();
  final TextEditingController _ePolliPointsController = TextEditingController();

  @override
  void initState() {
    _addressController.text =
        profileController.investorInfo.value.address ?? '';
    _phoneController.text =
        profileController.investorInfo.value.phoneNumber ?? '';
    _emailController.text = profileController.investorInfo.value.email ?? '';
    super.initState();
    checkoutController.getDeliveryCharge();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Checkout'.tr),
          centerTitle: true,
          backgroundColor: AppColor.secondary,
        ),
        backgroundColor: AppColor.secondary[100],
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(10),
            children: [
              Container(
                width: AppSize.screenWidth - 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.primary,
                  boxShadow: Constant.boxShadow,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Shipping Info'.tr,
                        style: const TextStyle(
                          color: AppColor.bText,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(
                        color: AppColor.bText,
                        thickness: 1,
                        endIndent: 0,
                        indent: 0,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined,
                              color: AppColor.bText, size: 30),
                          Constant.sbWTwenty,
                          Expanded(
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              controller: _addressController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
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
                          ),
                          Constant.sbHFifteen,
                        ],
                      ),
                      const Divider(
                        color: AppColor.bText,
                        thickness: 1,
                        endIndent: 0,
                        indent: 0,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.phone_outlined,
                              color: AppColor.bText, size: 30),
                          Constant.sbWTwenty,
                          Expanded(
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              controller: _phoneController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Phone Number'.tr,
                                hintText: 'Enter your phone number'.tr,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your phone number'.tr;
                                }
                                return null;
                              },
                            ),
                          ),
                          Constant.sbHFifteen,
                        ],
                      ),
                      const Divider(
                        color: AppColor.bText,
                        thickness: 1,
                        endIndent: 0,
                        indent: 0,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.email_outlined,
                              color: AppColor.bText, size: 30),
                          Constant.sbWTwenty,
                          Expanded(
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              controller: _emailController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Email'.tr,
                                hintText: 'Enter your email'.tr,
                              ),
                              // validator: (value) {
                              //   if (value == null || value.isEmpty) {
                              //     return 'Please enter your email';
                              //   }
                              //   return null;
                              // },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Obx(
                            () => ElevatedButton(
                              onPressed: () {
                                checkoutController
                                        .isShippingInfoUpdateButtonLoading.value
                                    ? null
                                    : [
                                        if (_formKey.currentState!.validate())
                                          {
                                            profileController
                                                .updateShippingInfo(
                                              address: _addressController.text,
                                              newPhoneNumber:
                                                  _phoneController.text,
                                              email: _emailController.text,
                                            )
                                          }
                                      ];
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.secondary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: checkoutController
                                      .isShippingInfoUpdateButtonLoading.value
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                      color: AppColor.primary,
                                    ))
                                  : Text(
                                      'Update'.tr,
                                      style: const TextStyle(
                                        color: AppColor.primary,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Constant.sbHFifteen,
              /* -------------------------------------------------------------------------- */
              /*                  Coupon Code, Gift Voucher, ePolli Points                               */
              /* -------------------------------------------------------------------------- */
              Container(
                width: AppSize.screenWidth - 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.primary,
                  boxShadow: Constant.boxShadow,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Text(
                          'Coupon Code, Gift Voucher, ePolli Points'.tr,
                          style: const TextStyle(
                            color: AppColor.bText,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Divider(
                        color: AppColor.bText,
                        thickness: 1,
                        endIndent: 0,
                        indent: 0,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.local_offer_outlined,
                              color: AppColor.bText, size: 30),
                          Constant.sbWTwenty,
                          Expanded(
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              controller: _couponCodeController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Coupon Code'.tr,
                                hintText: 'Enter your Coupon Code'.tr,
                              ),
                            ),
                          ),
                          Constant.sbHFifteen,
                        ],
                      ),
                      const Divider(
                        color: AppColor.bText,
                        thickness: 1,
                        endIndent: 0,
                        indent: 0,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.card_giftcard_outlined,
                              color: AppColor.bText, size: 30),
                          Constant.sbWTwenty,
                          Expanded(
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              controller: _giftVoucherController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Gift Voucher'.tr,
                                hintText: 'Enter your Gift Voucher code'.tr,
                              ),
                            ),
                          ),
                          Constant.sbHFifteen,
                        ],
                      ),
                      const Divider(
                        color: AppColor.bText,
                        thickness: 1,
                        endIndent: 0,
                        indent: 0,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.stars_outlined,
                              color: AppColor.bText, size: 30),
                          Constant.sbWTwenty,
                          Expanded(
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              controller: _ePolliPointsController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'ePolli Points'.tr,
                                hintText: 'Enter your ePolli Points Amount'.tr,
                              ),
                            ),
                          ),
                          Constant.sbHFifteen,
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Obx(
                            () => ElevatedButton(
                              onPressed: () {
                                checkoutController.isDiscountApplyLoading.value
                                    ? null
                                    : checkoutController.applyDiscount(
                                        _couponCodeController.text,
                                        _giftVoucherController.text,
                                        _ePolliPointsController.text,
                                      );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.secondary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: checkoutController
                                      .isDiscountApplyLoading.value
                                  ? const Center(
                                      child: SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          color: AppColor.primary,
                                        ),
                                      ),
                                    )
                                  : Text(
                                      'Apply'.tr,
                                      style: const TextStyle(
                                        color: AppColor.primary,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
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
              Constant.sbHFifteen,
              /* -------------------------------------------------------------------------- */
              /*                               Order Overview                               */
              /* -------------------------------------------------------------------------- */
              Container(
                width: AppSize.screenWidth - 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.primary,
                  boxShadow: Constant.boxShadow,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Text(
                          'Order Overview'.tr,
                          style: const TextStyle(
                            color: AppColor.bText,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Divider(
                        color: AppColor.bText,
                        thickness: 1,
                        endIndent: 0,
                        indent: 0,
                      ),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            var product = homeController.productList
                                .where((p0) =>
                                    p0.id ==
                                    cartController
                                        .cartProductList[index].productId)
                                .first;
                            int price = 0;
                            if (product.discountPercentage == 0) {
                              price = product.regularPrice.toInt();
                            } else {
                              price = product.discountedPrice.toInt();
                            }
                            return ListTile(
                              leading: Hero(
                                tag: 'product${product.id}',
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    AppSize.rTen,
                                  ),
                                  child: FadeInImage.assetNetwork(
                                    placeholder: 'assets/images/loading.gif',
                                    image:
                                        Secret.baseURL + product.imageLocation,
                                    fit: BoxFit.cover,
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
                                      return Image.asset(
                                          'assets/images/logo/epolli.png');
                                    },
                                  ),
                                ),
                              ),
                              title: Text(
                                homeController.isUSLocale.value
                                    ? product.name
                                    : product.nameBn,
                                style: const TextStyle(
                                  color: AppColor.bText,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                '৳ ${getLocalizedText(
                                  price,
                                  translateToBanglaDigit(price),
                                )} x ${getLocalizedText(
                                  cartController
                                      .cartProductList[index].quantity,
                                  translateToBanglaDigit(cartController
                                      .cartProductList[index].quantity),
                                )}',
                                style: const TextStyle(
                                  color: AppColor.bText,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: Text(
                                '৳ ${getLocalizedText(
                                  price *
                                      cartController
                                          .cartProductList[index].quantity,
                                  translateToBanglaDigit(price *
                                      cartController
                                          .cartProductList[index].quantity),
                                )}',
                                style: const TextStyle(
                                  color: AppColor.bText,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                          itemCount: cartController.cartProductList.length,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Subtotal'.tr,
                            style: const TextStyle(
                              color: AppColor.bText,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '৳ ${getLocalizedText(
                              cartController.subTotalPrice,
                              translateToBanglaDigit(
                                  cartController.subTotalPrice),
                            )}',
                            style: const TextStyle(
                              color: AppColor.bText,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Discount'.tr,
                            style: const TextStyle(
                              color: AppColor.bText,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '৳ ${getLocalizedText(
                              checkoutController.discountAmount,
                              translateToBanglaDigit(
                                  checkoutController.discountAmount),
                            )}',
                            style: const TextStyle(
                              color: AppColor.bText,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Delivery Charge'.tr,
                            style: const TextStyle(
                              color: AppColor.bText,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Obx(
                            () => Text(
                              '৳ ${getLocalizedText(
                                checkoutController.deliveryCharge.value,
                                translateToBanglaDigit(
                                    checkoutController.deliveryCharge.value),
                              )}',
                              style: const TextStyle(
                                color: AppColor.bText,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '*Delivery is applicable only for Dhaka Metro*'.tr,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total'.tr,
                            style: const TextStyle(
                              color: AppColor.bText,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Obx(
                            () {
                              return Text(
                                '৳ ${getLocalizedText(
                                  cartController.subTotalPrice -
                                      checkoutController.discountAmount.value +
                                      checkoutController.deliveryCharge.value /
                                          2,
                                  translateToBanglaDigit(cartController
                                          .subTotalPrice -
                                      checkoutController.discountAmount.value +
                                      checkoutController.deliveryCharge.value /
                                          2),
                                )}',
                                style: const TextStyle(
                                  color: AppColor.bText,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Obx(
                            () => ElevatedButton(
                              onPressed: () {
                                checkoutController.isConfirmOrderLoading.value
                                    ? null
                                    : [
                                        if (_formKey.currentState!.validate())
                                          {
                                            checkoutController.confirmOrder(),
                                          }
                                      ];
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.secondary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child:
                                  checkoutController.isConfirmOrderLoading.value
                                      ? const Center(
                                          child: SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              color: AppColor.primary,
                                            ),
                                          ),
                                        )
                                      : Text(
                                          'Confirm Order'.tr,
                                          style: const TextStyle(
                                            color: AppColor.primary,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
