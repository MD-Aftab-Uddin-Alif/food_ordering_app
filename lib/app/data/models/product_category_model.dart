// To parse this JSON data, do
//
//     final productCategoryModel = productCategoryModelFromJson(jsonString);

import 'dart:convert';

List<ProductCategoryModel> productCategoryModelFromJson(String str) =>
    List<ProductCategoryModel>.from(
        json.decode(str).map((x) => ProductCategoryModel.fromJson(x)));

String productCategoryModelToJson(List<ProductCategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductCategoryModel {
  final int id;
  final String name;
  final dynamic nameBn;
  final String imageLocation;

  ProductCategoryModel({
    required this.id,
    required this.name,
    required this.nameBn,
    required this.imageLocation,
  });

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) =>
      ProductCategoryModel(
        id: json["id"],
        name: json["name"],
        nameBn: json["name_bn"],
        imageLocation: json["image_location"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "name_bn": nameBn,
        "image_location": imageLocation,
      };
}
