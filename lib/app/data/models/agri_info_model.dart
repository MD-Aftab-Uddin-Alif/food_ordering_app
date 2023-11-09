// To parse this JSON data, do
//
//     final agriInfoModel = agriInfoModelFromJson(jsonString);

import 'dart:convert';

List<AgriInfoModel> agriInfoModelFromJson(String str) =>
    List<AgriInfoModel>.from(
        json.decode(str).map((x) => AgriInfoModel.fromJson(x)));

String agriInfoModelToJson(List<AgriInfoModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AgriInfoModel {
  int id;
  String number;
  String numberBn;
  String imageLocation;
  String name;
  String nameBn;
  String sliderImageLocation;
  DateTime createdAt;
  DateTime updatedAt;

  AgriInfoModel({
    required this.id,
    required this.number,
    required this.numberBn,
    required this.imageLocation,
    required this.name,
    required this.nameBn,
    required this.sliderImageLocation,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AgriInfoModel.fromJson(Map<String, dynamic> json) => AgriInfoModel(
        id: json["id"],
        number: json["number"],
        numberBn: json["number_bn"],
        imageLocation: json["image_location"],
        name: json["name"],
        nameBn: json["name_bn"],
        sliderImageLocation: json["slider_image_location"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "number": number,
        "number_bn": numberBn,
        "image_location": imageLocation,
        "name": name,
        "name_bn": nameBn,
        "slider_image_location": sliderImageLocation,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
