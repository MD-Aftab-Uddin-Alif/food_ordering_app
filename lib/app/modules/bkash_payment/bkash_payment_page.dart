import 'package:ePolli/app/modules/bkash_payment/bkash_payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BkashPaymentPage extends StatelessWidget {
  const BkashPaymentPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String invoiceId = Get.arguments['invoice_id'];
    double totalAmount = Get.arguments['total_amount'];
    double advanceAmount = Get.arguments['advance_amount'];
    final BkashPaymentController bkashPaymentController =
        Get.put(BkashPaymentController());
    return Obx(
      () => bkashPaymentController.isBkashPaymentLoading.value
          ? Scaffold(
              body: MaterialApp(
                theme: ThemeData(
                  primarySwatch: Colors.pink,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                debugShowCheckedModeBanner: false,
                home: BkashPaymentBody(
                  invoiceId: invoiceId,
                  totalAmount: totalAmount,
                  advanceAmount: advanceAmount,
                ),
              ),
            )
          : Scaffold(
              appBar: AppBar(
                title: Text('Bkash Payment'.tr),
                centerTitle: true,
                backgroundColor: Colors.pink,
              ),
              body: MaterialApp(
                theme: ThemeData(
                  primarySwatch: Colors.pink,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                debugShowCheckedModeBanner: false,
                home: BkashPaymentBody(
                  invoiceId: invoiceId,
                  totalAmount: totalAmount,
                  advanceAmount: advanceAmount,
                ),
              ),
            ),
    );
  }
}

class BkashPaymentBody extends StatefulWidget {
  final String invoiceId;
  final double totalAmount;
  final double advanceAmount;
  const BkashPaymentBody({
    Key? key,
    required this.invoiceId,
    required this.totalAmount,
    required this.advanceAmount,
  }) : super(key: key);

  @override
  BkashPaymentBodyState createState() => BkashPaymentBodyState();
}

class BkashPaymentBodyState extends State<BkashPaymentBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final BkashPaymentController bkashPaymentController =
      Get.put(BkashPaymentController());
  @override
  Widget build(BuildContext context) {
    final double paymentAmount;
    if (widget.advanceAmount != 0.0) {
      paymentAmount = widget.advanceAmount;
    } else {
      paymentAmount = widget.totalAmount;
    }
    return Scaffold(
      key: _scaffoldKey,
      body: Obx(
        () => Stack(
          children: [
            bkashPaymentController.isBkashPaymentLoading.value
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.pink,
                    ),
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: TextButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3.0),
                                ),
                                backgroundColor: Colors.pink),
                            child: Text(
                              "Proceed to Payment".tr,
                              style: const TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              bkashPaymentController.bKashPayment(
                                  context, widget.invoiceId, paymentAmount);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
