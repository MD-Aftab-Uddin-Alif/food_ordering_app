// To parse this JSON data, do
//
//     final recommendedProductModel = recommendedProductModelFromJson(jsonString);

import 'dart:convert';

List<RecommendedProductModel> recommendedProductModelFromJson(String str) =>
    List<RecommendedProductModel>.from(
        json.decode(str).map((x) => RecommendedProductModel.fromJson(x)));

String recommendedProductModelToJson(List<RecommendedProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RecommendedProductModel {
  final int id;
  final int productId;
  final int recommendedProductId;

  RecommendedProductModel({
    required this.id,
    required this.productId,
    required this.recommendedProductId,
  });

  factory RecommendedProductModel.fromJson(Map<String, dynamic> json) =>
      RecommendedProductModel(
        id: json["id"],
        productId: int.parse(json["product_id"]),
        recommendedProductId: int.parse(json["recommended_product_id"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "recommended_product_id": recommendedProductId,
      };
}
