// To parse this JSON data, do
//
//     final appModel = appModelFromJson(jsonString);

import 'dart:convert';

AppModel appModelFromJson(String str) => AppModel.fromJson(json.decode(str));

String appModelToJson(AppModel data) => json.encode(data.toJson());

class AppModel {
  dynamic allowedAppVersion;
  dynamic agriInfoVersion;
  dynamic projectCategoryVersion;
  dynamic productCategoryVersion;
  dynamic blogVersion;
  dynamic newsVersion;
  dynamic aboutUsVersion;
  dynamic deliveryCharge;

  AppModel({
    required this.allowedAppVersion,
    required this.agriInfoVersion,
    required this.projectCategoryVersion,
    required this.productCategoryVersion,
    required this.blogVersion,
    required this.newsVersion,
    required this.aboutUsVersion,
    required this.deliveryCharge,
  });

  factory AppModel.fromJson(Map<String, dynamic> json) => AppModel(
        allowedAppVersion: json["allowed_app_version"],
        agriInfoVersion: json["agri_info_version"],
        projectCategoryVersion: json["project_category_version"],
        productCategoryVersion: json["product_category_version"],
        blogVersion: json["blog_version"],
        newsVersion: json["news_version"],
        aboutUsVersion: json["about_us_version"],
        deliveryCharge: json["delivery_charge"],
      );

  Map<String, dynamic> toJson() => {
        "allowed_app_version": allowedAppVersion,
        "agri_info_version": agriInfoVersion,
        "project_category_version": projectCategoryVersion,
        "product_category_version": productCategoryVersion,
        "blog_version": blogVersion,
        "news_version": newsVersion,
        "about_us_version": aboutUsVersion,
        "delivery_charge": deliveryCharge,
      };
}
