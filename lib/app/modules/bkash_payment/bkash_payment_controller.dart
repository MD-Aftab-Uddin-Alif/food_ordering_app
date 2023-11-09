import 'dart:convert';

import 'package:ePolli/app/core/widgets/constant.dart';
import 'package:ePolli/app/core/widgets/custom_snackbar.dart';
import 'package:ePolli/app/modules/order_history/order_history_controller.dart';
import 'package:ePolli/app/modules/order_placed/order_placed_controller.dart';
import 'package:ePolli/epolli_app_secret/secret.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bkash/flutter_bkash.dart';
import 'package:get/get.dart';
import 'dart:developer' as dev;
import 'package:http/http.dart' as http;

class BkashPaymentController extends GetxController {
  RxBool isBkashPaymentLoading = false.obs;
  Future<void> bKashPayment(
    BuildContext context,
    String invoiceId,
    double totalAmount,
  ) async {
    try {
      isBkashPaymentLoading.value = true;

      /// create an instance of FlutterBkash
      final flutterBkash = FlutterBkash(
        bkashCredentials: const BkashCredentials(
          appKey: Secret.bKashAppKey,
          appSecret: Secret.bKashAppSecret,
          username: Secret.bKashUsername,
          password: Secret.bKashPassword,
          isSandbox: false,
        ),
      );

      /// remove focus from TextField to hide keyboard
      FocusManager.instance.primaryFocus?.unfocus();

      /// Goto BkashPayment page & pass the params
      try {
        /// call pay method to pay without agreement as parameter pass the context, amount, merchantInvoiceNumber
        final result = await flutterBkash.pay(
          context: context,
          amount: totalAmount,
          // need it double type
          merchantInvoiceNumber: "INV-$invoiceId",
        );

        /// if the payment is success then show the log
        dev.log(result.toString());

        /// if the payment is success then show the snack-bar
        customSnackbar("Payment Successful",
            "Your transaction id is: ${result.trxId}", "success");

        final OrderPlacedController orderPlacedController =
            Get.put(OrderPlacedController());
        orderPlacedController.isCashOnDelivery.value = false;
        updatePaymentStatus(invoiceId, "bKash", result.trxId);
        Get.back();
      } on BkashFailure catch (e, st) {
        /// if something went wrong then show the log
        dev.log(e.message, error: e, stackTrace: st);

        /// if something went wrong then show the snack-bar
        customSnackbar("Payment Unsuccessful", e.message, "failure");
      } catch (e, st) {
        /// if something went wrong then show the log
        dev.log("Something went wrong", error: e, stackTrace: st);

        /// if something went wrong then show the snack-bar
        customSnackbar("Something went wrong", e.toString(), "failure");
      }

      isBkashPaymentLoading.value = false;

      /// show snack-bar with message
    } catch (e) {
      print('${e.toString()} in bKashPayment');
    }
  }

  Future<void> updatePaymentStatus(
    String invoiceId,
    String paymentMethod,
    String transactionId,
  ) async {
    try {
      isBkashPaymentLoading.value = true;
      final response = await http.post(
        Uri.parse(
          Secret.investorApiBaseURL +
              Secret.updateOrderPaymentStatus +
              invoiceId,
        ),
        headers: Constant.apiHeader,
        body: {
          "payment_method": paymentMethod,
          "payment_status": "Paid",
          "transaction_id": transactionId,
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == "success") {
          // update those order status to "Paid"
          final OrderHistoryController orderHistoryController =
              Get.put(OrderHistoryController());
          orderHistoryController.orderList
              .where((element) => element.invoiceId == invoiceId)
              .forEach((element) {
            element.paymentMethod = paymentMethod;
            element.paymentStatus = "Paid";
          });
          customSnackbar(
            "Payment status updated successfully",
            "Your payment status has been updated successfully",
            "success",
          );
        } else {
          updatePaymentStatus(invoiceId, paymentMethod, transactionId);
        }
      } else {
        updatePaymentStatus(invoiceId, paymentMethod, transactionId);
      }
    } catch (e) {
      print('${e.toString()} in updatePaymentStatus');
    }
    isBkashPaymentLoading.value = false;
  }
}
