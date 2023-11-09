// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

import 'dart:convert';

List<NewsModel> newsModelFromJson(String str) =>
    List<NewsModel>.from(json.decode(str).map((x) => NewsModel.fromJson(x)));

String newsModelToJson(List<NewsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewsModel {
  int id;
  String sourceAuthor;
  dynamic sourceAuthorBn;
  String image;
  String title;
  dynamic titleBn;
  dynamic source;
  dynamic createdAt;
  dynamic updatedAt;

  NewsModel({
    required this.id,
    required this.sourceAuthor,
    required this.sourceAuthorBn,
    required this.image,
    required this.title,
    required this.titleBn,
    required this.source,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        id: json["id"],
        sourceAuthor: json["source_author"],
        sourceAuthorBn: json["source_author_bn"],
        image: json["image"],
        title: json["title"],
        titleBn: json["title_bn"],
        source: json["source"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "source_author": sourceAuthor,
        "source_author_bn": sourceAuthorBn,
        "image": image,
        "title": title,
        "title_bn": titleBn,
        "source": source,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
