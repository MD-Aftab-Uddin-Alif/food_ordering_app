// To parse this JSON data, do
//
//     final aboutUsModel = aboutUsModelFromJson(jsonString);

import 'dart:convert';

List<AboutUsModel> aboutUsModelFromJson(String str) => List<AboutUsModel>.from(
    json.decode(str).map((x) => AboutUsModel.fromJson(x)));

String aboutUsModelToJson(List<AboutUsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AboutUsModel {
  int id;
  String imageLocation;
  String name;
  String nameBn;
  String designation;
  String designationBn;
  String phoneNumber;
  String email;
  String linkedIn;
  String description;
  String descriptionBn;
  DateTime createdAt;
  DateTime updatedAt;

  AboutUsModel({
    required this.id,
    required this.imageLocation,
    required this.name,
    required this.nameBn,
    required this.designation,
    required this.designationBn,
    required this.phoneNumber,
    required this.email,
    required this.linkedIn,
    required this.description,
    required this.descriptionBn,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AboutUsModel.fromJson(Map<String, dynamic> json) => AboutUsModel(
        id: json["id"],
        imageLocation: json["image_location"],
        name: json["name"],
        nameBn: json["name_bn"],
        designation: json["designation"],
        designationBn: json["designation_bn"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        linkedIn: json["linked_in"],
        description: json["description"],
        descriptionBn: json["description_bn"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image_location": imageLocation,
        "name": name,
        "name_bn": nameBn,
        "designation": designation,
        "designation_bn": designationBn,
        "phone_number": phoneNumber,
        "email": email,
        "linked_in": linkedIn,
        "description": description,
        "description_bn": descriptionBn,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
