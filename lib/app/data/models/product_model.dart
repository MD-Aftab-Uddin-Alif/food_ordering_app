// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  final int id;
  final String name;
  final dynamic nameBn;
  final String imageLocation;
  final int stock;
  final double regularPrice;
  final double discountedPrice;
  final double discountPercentage;
  final String details;
  final dynamic detailsBn;
  final int categoryId;
  final int minQuantity;
  final int maxQuantity;
  final String weight;
  final String shippingClass;
  dynamic deliveryDate;
  dynamic deadlineTime;

  ProductModel({
    required this.id,
    required this.name,
    required this.nameBn,
    required this.imageLocation,
    required this.stock,
    required this.regularPrice,
    required this.discountedPrice,
    required this.discountPercentage,
    required this.details,
    required this.detailsBn,
    required this.categoryId,
    required this.minQuantity,
    required this.maxQuantity,
    required this.weight,
    required this.shippingClass,
    required this.deliveryDate,
    required this.deadlineTime,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        nameBn: json["name_bn"],
        imageLocation: json["image_location"],
        stock: int.parse(json["stock"]),
        regularPrice: double.parse(json["regular_price"]),
        discountedPrice: double.parse(json["discounted_price"]),
        discountPercentage: double.parse(json["discount_percentage"]),
        details: json["details"],
        detailsBn: json["details_bn"],
        categoryId: int.parse(json["category_id"]),
        minQuantity: int.parse(json["min_quantity"]),
        maxQuantity: int.parse(json["max_quantity"]),
        weight: json["weight"],
        shippingClass: json["shipping_class"],
        deliveryDate: json["delivery_date"],
        deadlineTime: json["deadline_time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "name_bn": nameBn,
        "image_location": imageLocation,
        "stock": stock,
        "regular_price": regularPrice,
        "discounted_price": discountedPrice,
        "discount_percentage": discountPercentage,
        "details": details,
        "details_bn": detailsBn,
        "category_id": categoryId,
        "min_quantity": minQuantity,
        "max_quantity": maxQuantity,
        "weight": weight,
        "shipping_class": shippingClass,
        "delivery_date": deliveryDate,
        "deadline_time": deadlineTime,
      };
}
