import 'package:ePolli/app/core/helpers/app_size.dart';
import 'package:ePolli/app/core/theme/app_color.dart';
import 'package:ePolli/app/core/widgets/constant.dart';
import 'package:ePolli/app/modules/order_placed/order_placed_controller.dart';
import 'package:ePolli/app/routes/bkash_payment_routes.dart';
import 'package:ePolli/app/routes/custom_navigation_bar_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderPlacedPage extends StatefulWidget {
  const OrderPlacedPage({super.key});

  @override
  State<OrderPlacedPage> createState() => _OrderPlacedPageState();
}

class _OrderPlacedPageState extends State<OrderPlacedPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final OrderPlacedController _orderPlacedController =
      Get.put(OrderPlacedController());
  @override
  Widget build(BuildContext context) {
    String invoiceId = Get.arguments['invoice_id'].toString();
    double totalAmount = double.parse(Get.arguments['total_price']);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Order Placed'.tr),
        centerTitle: true,
        backgroundColor: AppColor.secondary,
      ),
      body: ListView(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order Placed Successfully".tr,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 2,
                ),
                Card(
                  elevation: 5,
                  child: ListTile(
                    leading: const Icon(
                      Icons.check_circle_outline_outlined,
                      color: Colors.green,
                      size: 80,
                    ),
                    title: Row(
                      children: [
                        Text(
                          "Invoice Number: ".tr,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          invoiceId,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Obx(
                      () => _orderPlacedController.isCashOnDelivery.value
                          ? RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[800],
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        '\nYour order is currently Confirmed as '
                                            .tr,
                                  ),
                                  TextSpan(
                                    text: 'Cash on Delivery'.tr,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '. You can also '.tr,
                                  ),
                                  TextSpan(
                                    text: 'pay Now.'.tr,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.secondary,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        ' Soon our representative will contact you.\n'
                                            .tr,
                                  ),
                                ],
                              ),
                            )
                          : RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[800],
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        '\nYour order is currently Confirmed as '
                                            .tr,
                                  ),
                                  TextSpan(
                                    text: 'Online Payment.\n'.tr,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          /* -------------------------------------------------------------------------- */
          /*                               Payment Method with radio button                               */
          /* -------------------------------------------------------------------------- */

          Obx(
            () {
              return _orderPlacedController.isCashOnDelivery.value
                  ? Container(
                      width: AppSize.screenWidth - 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColor.primary,
                        boxShadow: Constant.boxShadow,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              'Payment Method'.tr,
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
                            GestureDetector(
                              /* ------------------------- BKash Payment Function ------------------------- */
                              onTap: () {
                                Get.toNamed(BkashPaymentRoutes.bkashPayment,
                                    arguments: {
                                      'invoice_id': invoiceId,
                                      'total_amount': totalAmount,
                                      'advance_amount': 0.0,
                                    });
                              },
                              child: Row(
                                children: [
                                  Constant.sbWTen,
                                  const Image(
                                    image: AssetImage(
                                        'assets/images/logo/Bkash.png'),
                                    height: 25,
                                  ),
                                  Constant.sbWTwenty,
                                  Text(
                                    'Bkash'.tr,
                                    style: const TextStyle(
                                      color: AppColor.bText,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      Get.toNamed(
                                          BkashPaymentRoutes.bkashPayment,
                                          arguments: {
                                            'invoice_id': invoiceId,
                                            'total_amount': totalAmount,
                                            'advance_amount': 0.0,
                                          });
                                    },
                                    icon: const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: AppColor.bText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text(
                                            'Mutual Trust Bank Ltd.'),
                                        content: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text('Account Name: EPOLLI'),
                                            const Text(
                                                'Account No.: 9991520000267'),
                                            const Text('Account Type: Current'),
                                            const Text(
                                                'Routing Number: 145270816'),
                                            const Text(
                                                'Branch Name: Islami Banking Window'),
                                            const Text(''),
                                            Text(
                                                'Pay your total amount to this account and upload your payment slip to our email: info@epolli.com.bd'
                                                    .tr),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: const Text('Okay')),
                                        ],
                                      );
                                    });
                              },
                              child: Row(
                                children: [
                                  Constant.sbWTen,
                                  const Image(
                                    image: AssetImage(
                                        'assets/images/logo/mutual-trust-bank-logo.png'),
                                    height: 25,
                                  ),
                                  Constant.sbWTwenty,
                                  Text(
                                    'Mutual Trust Bank Ltd.'.tr,
                                    style: const TextStyle(
                                      color: AppColor.bText,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text(
                                                'Mutual Trust Bank Ltd.'),
                                            content: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Text(
                                                    'Account Name: EPOLLI'),
                                                const Text(
                                                    'Account No.: 9991520000267'),
                                                const Text(
                                                    'Account Type: Current'),
                                                const Text(
                                                    'Routing Number: 145270816'),
                                                const Text(
                                                    'Branch Name: Islami Banking Window'),
                                                const Text(''),
                                                Text(
                                                    'Pay your total amount to this account and upload your payment slip to our email: info@epolli.com.bd'
                                                        .tr),
                                              ],
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  child: Text('Okay'.tr)),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: AppColor.bText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Bank Asia Ltd.'),
                                        content: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text('Account Name: EPOLLI'),
                                            const Text(
                                                'Account No.: 01233054947'),
                                            const Text('Account Type: Current'),
                                            const Text(
                                                'Routing Number: 070274037'),
                                            const Text(
                                                'Branch Name: MCB Banani Branch'),
                                            const Text(''),
                                            Text(
                                                'Pay your total amount to this account and upload your payment slip to our email: info@epolli.com.bd'
                                                    .tr),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: Text('Okay'.tr)),
                                        ],
                                      );
                                    });
                              },
                              child: Row(
                                children: [
                                  Constant.sbWTen,
                                  const Image(
                                    image: AssetImage(
                                        'assets/images/logo/Bank_Asia_Limited.png'),
                                    height: 25,
                                  ),
                                  Constant.sbWTwenty,
                                  Text(
                                    'Bank Asia Ltd.'.tr,
                                    style: const TextStyle(
                                      color: AppColor.bText,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text('Bank Asia Ltd.'),
                                            content: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Text(
                                                    'Account Name: EPOLLI'),
                                                const Text(
                                                    'Account No.: 01233054947'),
                                                const Text(
                                                    'Account Type: Current'),
                                                const Text(
                                                    'Routing Number: 070274037'),
                                                const Text(
                                                    'Branch Name: MCB Banani Branch'),
                                                const Text(''),
                                                Text(
                                                    'Pay your total amount to this account and upload your payment slip to our email: info@epolli.com.bd'
                                                        .tr),
                                              ],
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  child: Text('Okay'.tr)),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: AppColor.bText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox();
            },
          ),
          Constant.sbHFifteen,
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.secondary,
            ),
            onPressed: () {
              Get.offNamed(
                CustomNavigationBarRoutes.customNavigationBar,
              );
            },
            child: Text(
              'Back to Home'.tr,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
