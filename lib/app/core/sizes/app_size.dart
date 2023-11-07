import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSize {
  static final double screenHeight = Get.context!.height;
  static final double screenWidth = Get.context!.width;

  // * home page
  static final double homePageConWidth = screenWidth / 2 - 30;
  static final double homePageConHeight = homePageConWidth * 1.5;
  static final double homePageConImageWidth = homePageConWidth - 40;

    // Radius for the container
  static double rTen = screenWidth * 0.03;
  static double rTwenty = screenWidth * 0.055;

  //* Text size
  static double bigText = 30;
  static double mediumText = 20;
  static double smallText = 15;
  static double extraSmallText = 12;

  static double fTen = screenWidth * 0.03;
  static double fTwelve = screenWidth * 0.035;
  static double fFourteen = screenWidth * 0.04;
  static double fSixteen = screenWidth * 0.045;
  static double fEighteen = screenWidth * 0.05;
  static double fTwenty = screenWidth * 0.055;
  static double fTwentyTwo = screenWidth * 0.06;
  static double fTwentyFour = screenWidth * 0.065;
  static double fTwentySix = screenWidth * 0.07;
  static double fTwentyEight = screenWidth * 0.075;
  static double fThirty = screenWidth * 0.08;  

    // * padding sizes
  static double pFive = 5;
  static double pTen = 10;
  static double pTwelve = 12;
  static double pFifteen = 15;
  static double pTwenty = 20;

    // * height size
  static double hFive = 5;
  static double hTen = 10;
  static double hFifteen = 15;
  static double hTwenty = 20;
  static double hFifty=50;

  // * width size
  static double wFive = 5;
  static double wTen = 10;
  static double wFifteen = 15;
  static double wTwenty = 20;
  static double wTwentyFive = 25;
  static double wThirty = 30;
  static double wThirtyFive = 35;
  static double wForty = 40;

  static var sbHTwenty = SizedBox(
    height: AppSize.hTwenty,
  );
  static var sbWTen = SizedBox(
    width: AppSize.wTen,
  );
  static var sbHTen = SizedBox(
    height: AppSize.hTen,
  );
}
