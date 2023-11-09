import 'package:ePolli/app/core/helpers/app_size.dart';
import 'package:ePolli/app/core/locale/get_localized_text.dart';
import 'package:ePolli/app/core/locale/translate_to_bangla_digit.dart';
import 'package:ePolli/app/core/theme/app_color.dart';
import 'package:ePolli/app/core/widgets/constant.dart';
import 'package:ePolli/app/modules/home/home_controller.dart';
import 'package:ePolli/app/modules/product/product_controller.dart';
import 'package:ePolli/app/routes/product_routes.dart';
import 'package:ePolli/epolli_app_secret/secret.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'order_history_controller.dart';

class OrderHistoryPage extends StatelessWidget {
  OrderHistoryPage({super.key});

  final OrderHistoryController orderHistoryController =
      Get.put(OrderHistoryController());
  final HomeController homeController = Get.put(HomeController());
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    // count the number of different invoice_id in orderList
    var invoiceIdList = orderHistoryController.orderList
        .map((e) => e.invoiceId)
        .toSet()
        .toList();
    // count the number of different order_id in orderList

    print(invoiceIdList.length);
    return Scaffold(
      appBar: AppBar(
        title: Text('Products Order History'.tr),
        centerTitle: true,
        backgroundColor: AppColor.secondary,
      ),
      body: Obx(
        () => orderHistoryController.isOrderHistoryLoading.value ||
                homeController.isProductsLoading.value
            ? const Center(
                child: Image(
                  image: AssetImage('assets/images/loading.gif'),
                ),
              )
            : orderHistoryController.orderList.isNotEmpty
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      // number of order in that invoice
                      var orderCount = orderHistoryController.orderList
                          .where((element) =>
                              element.invoiceId == invoiceIdList[index])
                          .length;
                      // get the product from the orderList
                      // new order list with same invoice_id
                      var newOrderList = orderHistoryController.orderList
                          .where((element) =>
                              element.invoiceId == invoiceIdList[index])
                          .toList();
                      double grandTotal = 0;
                      for (var i = 0; i < orderCount; i++) {
                        grandTotal += newOrderList[i].total;
                      }

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 5,
                          child: Column(
                            children: [
                              // invoice id
                              ListTile(
                                title: Text(
                                  '${'Invoice Id: '.tr}${getLocalizedText(newOrderList[0].invoiceId, translateToBanglaDigit(newOrderList[0].invoiceId)).toString()}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: Text(
                                  '${'Total: '.tr}${getLocalizedText(grandTotal, translateToBanglaDigit(grandTotal)).toString()}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: orderCount * 120,
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: orderCount,
                                  itemBuilder: (context, index) {
                                    var product =
                                        homeController.productList.firstWhere(
                                      (element) =>
                                          element.id.toString() ==
                                          newOrderList[index].productId,
                                    );

                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: Constant.boxShadow,
                                          color: AppColor.primary,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    '${'Status: '.tr}${getLocalizedText(newOrderList[index].orderStatus, newOrderList[index].orderStatusBn).toString()}',
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              ListTile(
                                                leading: Image(
                                                  image: NetworkImage(
                                                    Secret.baseURL +
                                                        product.imageLocation,
                                                  ),
                                                ),
                                                title: Text(
                                                  homeController
                                                          .isUSLocale.value
                                                      ? product.name
                                                      : product.nameBn ??
                                                          product.name,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                subtitle: FittedBox(
                                                  child: Row(
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
                                                        getLocalizedText(
                                                                newOrderList[
                                                                        index]
                                                                    .price,
                                                                translateToBanglaDigit(
                                                                    newOrderList[
                                                                            index]
                                                                        .price))
                                                            .toString(),
                                                        style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Constant.sbWTen,
                                                      Text(
                                                        'x',
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
                                                        getLocalizedText(
                                                                newOrderList[
                                                                        index]
                                                                    .quantity,
                                                                translateToBanglaDigit(
                                                                    newOrderList[
                                                                            index]
                                                                        .quantity))
                                                            .toString(),
                                                        style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                trailing: SizedBox(
                                                  width: 90,
                                                  child: Row(
                                                    children: [
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
                                                      FittedBox(
                                                        child: Text(
                                                          '${getLocalizedText(
                                                            newOrderList[index]
                                                                .total,
                                                            translateToBanglaDigit(
                                                                newOrderList[
                                                                        index]
                                                                    .total),
                                                          )}/-',
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: invoiceIdList.length)
                : Padding(
                    padding:
                        const EdgeInsets.only(top: 150, right: 10, left: 10),
                    child: ListView(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'No product has been ordered yet'.tr,
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
                          height: 20,
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
