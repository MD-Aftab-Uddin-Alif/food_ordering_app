// To parse this JSON data, do
//
//     final cartProductModel = cartProductModelFromJson(jsonString);

import 'dart:convert';

List<CartProductModel> cartProductModelFromJson(String str) =>
    List<CartProductModel>.from(
        json.decode(str).map((x) => CartProductModel.fromJson(x)));

String cartProductModelToJson(List<CartProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartProductModel {
  int productId;
  int quantity;

  CartProductModel({
    required this.productId,
    required this.quantity,
  });

  factory CartProductModel.fromJson(Map<String, dynamic> json) =>
      CartProductModel(
        productId: json["product_id"] as int,
        quantity: json["quantity"] as int,
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "quantity": quantity,
      };
}
