import 'package:ePolli/app/core/theme/app_color.dart';
import 'package:ePolli/app/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

class LanguageSwitchWidget extends StatefulWidget {
  const LanguageSwitchWidget({super.key});

  @override
  State<LanguageSwitchWidget> createState() => _LanguageSwitchWidgetState();
}

class _LanguageSwitchWidgetState extends State<LanguageSwitchWidget> {
  final HomeController homeController = Get.put(HomeController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      activeColor: AppColor.secondary[300]!,
      inactiveColor: AppColor.primary,
      toggleColor: AppColor.secondary,
      activeToggleColor: AppColor.primary,
      inactiveToggleColor: AppColor.secondary[300]!,
      activeText: "English",
      inactiveText: "বাংলা",
      inactiveIcon: const Text(
        'EN',
        style: TextStyle(
          color: AppColor.primary,
        ),
      ),
      activeIcon: Text(
        'বাং',
        style: TextStyle(
          color: AppColor.secondary[300]!,
        ),
      ),
      inactiveTextColor: AppColor.secondary[300]!,
      activeTextColor: AppColor.primary,
      value: homeController.isUSLocale.value,
      valueFontSize: 15.0,
      width: 90,
      borderRadius: 30.0,
      showOnOff: true,
      onToggle: (_) {
        setState(() {
          if (homeController.isUSLocale.value == false) {
            Get.updateLocale(const Locale('en', 'US'));
            homeController.isUSLocale.value = true;
          } else {
            Get.updateLocale(const Locale('bn', 'BD'));
            homeController.isUSLocale.value = false;
          }
          homeController.storeIsUsLocale();
        });
      },
    );
  }
}
