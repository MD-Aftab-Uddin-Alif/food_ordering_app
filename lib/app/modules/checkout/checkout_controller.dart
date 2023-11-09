import 'dart:convert';

import 'package:ePolli/app/core/widgets/constant.dart';
import 'package:ePolli/app/core/widgets/custom_snackbar.dart';
import 'package:ePolli/app/data/models/order_model.dart';
import 'package:ePolli/app/modules/cart/cart_controller.dart';
import 'package:ePolli/app/modules/order_history/order_history_controller.dart';
import 'package:ePolli/app/modules/profile/profile_controller.dart';
import 'package:ePolli/app/modules/splash/splash_controller.dart';
import 'package:ePolli/app/routes/order_placed_routes.dart';
import 'package:ePolli/epolli_app_secret/secret.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class CheckoutController extends GetxController {
  RxInt discountAmount = 0.obs;
  RxBool isShippingInfoUpdateButtonLoading = false.obs;
  RxBool isConfirmOrderLoading = false.obs;
  RxBool isDiscountApplyLoading = false.obs;
  RxInt deliveryCharge = 0.obs;
  final ProfileController profileController = Get.put(ProfileController());

  void getDeliveryCharge() {
    try {
      SplashController splashController = Get.put(SplashController());
      splashController.getAppInfoFromSecureStorage().then((_) {
        deliveryCharge.value =
            int.parse(splashController.appInfo.value.deliveryCharge);
      });
    } catch (e) {
      print('${e.toString()} in getDeliveryCharge');
    }
  }

  Future<void> applyDiscount(
    String couponCode,
    String giftVoucher,
    String ePolliPoints,
  ) async {
    try {
      isDiscountApplyLoading.value = true;
      if (couponCode == '' && giftVoucher == '' && ePolliPoints == '') {
        customSnackbar('Failed'.tr, 'Discount Code Not Found'.tr, 'warning');
      }
      isDiscountApplyLoading.value = false;
    } catch (e) {
      print('${e.toString()} in applyDiscount');
    }
  }

  Future<void> confirmOrder() async {
    try {
      isConfirmOrderLoading.value = true;
      final CartController cartController = Get.put(CartController());
      int id = profileController.investorInfo.value.id;

      final response = await http.post(
        Uri.parse('${Secret.investorApiBaseURL}${Secret.order}$id'),
        headers: Constant.apiHeader,
        body: {
          'order': jsonEncode(cartController.cartProductList),
        },
      );
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['message'] == 'Success') {
          final CartController cartController = Get.put(CartController());
          cartController.cartProductList.clear();

          final OrderHistoryController orderHistoryController =
              Get.put(OrderHistoryController());

          final orderData = jsonDecode(response.body)['data'];
          final invoiceId = jsonDecode(response.body)['invoice_id'];
          final totalPrice = cartController.subTotalPrice.value.toString();

          orderHistoryController.orderList.clear();
          orderData.forEach((order) {
            orderHistoryController.orderList.add(OrderModel.fromJson(order));
          });

          // delete cart data from GetStorage
          GetStorage().remove('cartList');
          // * sending sms to user
          String phoneNumber = profileController.investorInfo.value.phoneNumber;
          final smsResponse = await http.get(
            Uri.parse(
                '${Secret.smsApiWithKey}&msg=আপনার অর্ডারটি সফলভাবে প্লেস হয়েছে। অর্ডার আইডি: $invoiceId &to=$phoneNumber'),
          );

          if (smsResponse.statusCode != 200) {
            customSnackbar(
              'Sending SMS Failed'.tr,
              smsResponse.toString(),
              'failure',
            );
          }
          // Get.back();
          Get.offAndToNamed(OrderPlacedRoutes.orderPlaced, arguments: {
            'invoice_id': invoiceId,
            'total_price': totalPrice,
          });
        } else {
          customSnackbar('Error'.tr, 'Order Not Placed'.tr, 'warning');
        }
      }
      isConfirmOrderLoading.value = false;
    } catch (e) {
      print('${e.toString()} in confirmOrder');
    }
  }
}
