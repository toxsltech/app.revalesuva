// To parse this JSON data, do
//
//     final articlesListResponseModel = articlesListResponseModelFromJson(jsonString);

import 'dart:convert';

import '../../../authentication/model/question_list_Response.dart';
import '../data_model/articles_data.dart';

ArticlesListResponseModel articlesListResponseModelFromJson(String str) =>
    ArticlesListResponseModel.fromJson(json.decode(str));

String articlesListResponseModelToJson(ArticlesListResponseModel data) =>
    json.encode(data.toJson());

class ArticlesListResponseModel {
  List<ArticleDataModel>? list;
  Links? links;
  Meta? meta;
  String? copyrights;

  ArticlesListResponseModel({
    this.list,
    this.links,
    this.meta,
    this.copyrights,
  });

  factory ArticlesListResponseModel.fromJson(Map<String, dynamic> json) =>
      ArticlesListResponseModel(
        list: json["list"] == null
            ? []
            : List<ArticleDataModel>.from(
                json["list"]!.map((x) => ArticleDataModel.fromJson(x))),
        links: json["_links"] == null ? null : Links.fromJson(json["_links"]),
        meta: json["_meta"] == null ? null : Meta.fromJson(json["_meta"]),
        copyrights: json["copyrights"],
      );

  Map<String, dynamic> toJson() => {
        "list": list == null
            ? []
            : List<dynamic>.from(list!.map((x) => x.toJson())),
        "_links": links?.toJson(),
        "_meta": meta?.toJson(),
        "copyrights": copyrights,
      };
}
