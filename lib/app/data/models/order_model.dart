// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

List<OrderModel> orderModelFromJson(String str) =>
    List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromJson(x)));

String orderModelToJson(List<OrderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderModel {
  int id;
  String invoiceId;
  String orderId;
  String userType;
  String userId;
  String productId;
  int quantity;
  double price;
  String paymentStatus;
  String paymentMethod;
  String orderStatus;
  String orderStatusBn;
  double total;
  DateTime createdAt;
  DateTime updatedAt;

  OrderModel({
    required this.id,
    required this.invoiceId,
    required this.orderId,
    required this.userType,
    required this.userId,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.orderStatus,
    required this.orderStatusBn,
    required this.total,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        invoiceId: json["invoice_id"],
        orderId: json["order_id"],
        userType: json["user_type"],
        userId: json["user_id"],
        productId: json["product_id"],
        quantity: int.parse(json["quantity"]),
        price: double.parse(json["price"]),
        paymentStatus: json["payment_status"],
        paymentMethod: json["payment_method"],
        orderStatus: json["order_status"],
        orderStatusBn: json["order_status_bn"],
        total: double.parse(json["total"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "invoice_id": invoiceId,
        "order_id": orderId,
        "user_type": userType,
        "user_id": userId,
        "product_id": productId,
        "quantity": quantity,
        "price": price,
        "payment_status": paymentStatus,
        "payment_method": paymentMethod,
        "order_status": orderStatus,
        "order_status_bn": orderStatusBn,
        "total": total,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
