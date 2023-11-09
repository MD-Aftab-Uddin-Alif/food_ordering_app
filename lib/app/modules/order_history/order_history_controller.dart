import 'dart:convert';

import 'package:ePolli/app/core/widgets/constant.dart';
import 'package:ePolli/app/data/models/order_model.dart';
import 'package:ePolli/app/modules/profile/profile_controller.dart';
import 'package:ePolli/epolli_app_secret/secret.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OrderHistoryController extends GetxController {
  RxBool isOrderHistoryLoading = true.obs;
  RxList<OrderModel> orderList = <OrderModel>[].obs;
  final ProfileController profileController = Get.put(ProfileController());

  Future<void> getOrders() async {
    try {
      isOrderHistoryLoading.value = true;
      int id = profileController.investorInfo.value.id;
      final response = await http.get(
        Uri.parse('${Secret.investorApiBaseURL}${Secret.order}$id'),
        headers: Constant.apiHeader,
      );
      if (response.statusCode == 200) {
        final orderItems = jsonDecode(response.body)['data'];
        orderList.clear();
        if (orderItems.isNotEmpty) {
          for (final orderItem in orderItems) {
            orderList.add(OrderModel.fromJson(orderItem));
          }
        }
      } else {
        print('Error');
      }
      isOrderHistoryLoading.value = false;
    } catch (e) {
      print('${e.toString()} in getOrders');
    }
  }
}
