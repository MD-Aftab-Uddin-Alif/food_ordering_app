import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

customSnackbar(String title, String message, String contentType) {
  final context = Get.context as BuildContext;

  final materialBanner = MaterialBanner(
    elevation: 0,
    backgroundColor: Colors.transparent,
    forceActionsBelow: false,
    content: AwesomeSnackbarContent(
      title: title,
      message: message,
      contentType: contentType == 'success'
          ? ContentType.success
          : contentType == 'failure'
              ? ContentType.failure
              : contentType == 'warning'
                  ? ContentType.warning
                  : ContentType.help,
      inMaterialBanner: true,
    ),
    actions: const [SizedBox.shrink()],
  );

  final scaffoldMessenger = ScaffoldMessenger.of(context);

  scaffoldMessenger
    ..hideCurrentMaterialBanner()
    ..showMaterialBanner(materialBanner);

  Future.delayed(const Duration(seconds: 5), () {
    scaffoldMessenger.hideCurrentMaterialBanner();
  });
}
