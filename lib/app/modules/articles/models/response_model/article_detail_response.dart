// To parse this JSON data, do
//
//     final articlesDetailsResponseModel = articlesDetailsResponseModelFromJson(jsonString);

import 'dart:convert';

import '../data_model/articles_data.dart';

ArticlesDetailsResponseModel articlesDetailsResponseModelFromJson(String str) =>
    ArticlesDetailsResponseModel.fromJson(json.decode(str));

String articlesDetailsResponseModelToJson(ArticlesDetailsResponseModel data) =>
    json.encode(data.toJson());

class ArticlesDetailsResponseModel {
  ArticleDataModel? detail;
  String? copyrights;

  ArticlesDetailsResponseModel({
    this.detail,
    this.copyrights,
  });

  factory ArticlesDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      ArticlesDetailsResponseModel(
        detail: json["detail"] == null
            ? null
            : ArticleDataModel.fromJson(json["detail"]),
        copyrights: json["copyrights"],
      );

  Map<String, dynamic> toJson() => {
        "detail": detail?.toJson(),
        "copyrights": copyrights,
      };
}
