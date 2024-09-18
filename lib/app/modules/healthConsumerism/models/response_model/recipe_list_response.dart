// To parse this JSON data, do
//
//     final recipeListResponse = recipeListResponseFromJson(jsonString);

import 'dart:convert';

import '../../../authentication/model/question_list_Response.dart';
import '../data_model/recipe_detail_data_model.dart';

RecipeListResponse recipeListResponseFromJson(String str) =>
    RecipeListResponse.fromJson(json.decode(str));

String recipeListResponseToJson(RecipeListResponse data) =>
    json.encode(data.toJson());

class RecipeListResponse {
  List<RecipeList>? list;
  Links? links;
  Meta? meta;
  String? copyrights;

  RecipeListResponse({
    this.list,
    this.links,
    this.meta,
    this.copyrights,
  });

  factory RecipeListResponse.fromJson(Map<String, dynamic> json) =>
      RecipeListResponse(
        list: json["list"] == null
            ? []
            : List<RecipeList>.from(
                json["list"]!.map((x) => RecipeList.fromJson(x))),
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
