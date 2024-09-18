// To parse this JSON data, do
//
//     final recipeListDetails = recipeListDetailsFromJson(jsonString);

import 'dart:convert';

import '../data_model/recipe_detail_data_model.dart';

RecipeListDetails recipeListDetailsFromJson(String str) =>
    RecipeListDetails.fromJson(json.decode(str));

String recipeListDetailsToJson(RecipeListDetails data) =>
    json.encode(data.toJson());

class RecipeListDetails {
  RecipeList? detail;
  String? copyrights;

  RecipeListDetails({
    this.detail,
    this.copyrights,
  });

  factory RecipeListDetails.fromJson(Map<String, dynamic> json) =>
      RecipeListDetails(
        detail:
            json["detail"] == null ? null : RecipeList.fromJson(json["detail"]),
        copyrights: json["copyrights"],
      );

  Map<String, dynamic> toJson() => {
        "detail": detail?.toJson(),
        "copyrights": copyrights,
      };
}
