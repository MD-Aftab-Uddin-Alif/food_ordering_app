import 'package:ePolli/app/core/helpers/app_size.dart';
import 'package:ePolli/app/core/theme/app_color.dart';
import 'package:ePolli/epolli_app_secret/secret.dart';
import 'package:flutter/material.dart';

class Constant {
  static var apiHeader = <String, String>{
    // 'Content-Type': 'application/json; charset=UTF-8',
    'APP-KEY': Secret.appKey,
    'EPOLLI-API-TOKEN': Secret.ePolliApiToken,
  };

  static var boxShadow = [
    BoxShadow(
      color: AppColor.shadow,
      spreadRadius: 3,
      blurRadius: 5,
      offset: const Offset(0, 3),
    ),
  ];

  static var sbHFive = SizedBox(
    height: AppSize.hFive,
  );

  static var sbHTen = SizedBox(
    height: AppSize.hTen,
  );

  static var sbHFifteen = SizedBox(
    height: AppSize.hFifteen,
  );

  static var sbHTwenty = SizedBox(
    height: AppSize.hTwenty,
  );

  static var sbWFive = SizedBox(
    width: AppSize.wFive,
  );

  static var sbWTen = SizedBox(
    width: AppSize.wTen,
  );

  static var sbWTwenty = SizedBox(
    width: AppSize.wTwenty,
  );

  static var sbWThirty = SizedBox(
    width: AppSize.wThirty,
  );

  static var sbWForty = SizedBox(
    width: AppSize.wForty,
  );
}
