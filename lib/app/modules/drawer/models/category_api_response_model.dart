// To parse this JSON data, do
//
//     final dailyNutritionCategoryResponseModel = dailyNutritionCategoryResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:health_fitness/app/modules/drawer/models/sub_category_api_response_model.dart';

DailyNutritionCategoryResponseModel dailyNutritionCategoryResponseModelFromJson(String str) =>
    DailyNutritionCategoryResponseModel.fromJson(json.decode(str));

String dailyNutritionCategoryResponseModelToJson(DailyNutritionCategoryResponseModel data) => json.encode(data.toJson());

class DailyNutritionCategoryResponseModel {
  List<DailyNutritionCategoryDataModel>? list;
  String? copyrights;

  DailyNutritionCategoryResponseModel({
    this.list,
    this.copyrights,
  });

  factory DailyNutritionCategoryResponseModel.fromJson(Map<String, dynamic> json) => DailyNutritionCategoryResponseModel(
        list: json["list"] == null
            ? []
            : List<DailyNutritionCategoryDataModel>.from(json["list"]!.map((x) => DailyNutritionCategoryDataModel.fromJson(x))),
        copyrights: json["copyrights"],
      );

  Map<String, dynamic> toJson() => {
        "list": list == null ? [] : List<dynamic>.from(list!.map((x) => x.toJson())),
        "copyrights": copyrights,
      };
}

class DailyNutritionCategoryDataModel {
  int? id;
  String? title;
  String? description;
  int? stateId;
  int? typeId;
  DateTime? createdOn;
  int? createdById;
  bool isCheck = false;
  List<DailyNutritionSubCategoryDataModel>? items = [];

  DailyNutritionCategoryDataModel({
    this.id,
    this.title,
    this.description,
    this.stateId,
    this.typeId,
    this.createdOn,
    this.createdById,
    this.isCheck = false,
    this.items,
  });

  factory DailyNutritionCategoryDataModel.fromJson(Map<String, dynamic> json) => DailyNutritionCategoryDataModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        stateId: json["state_id"],
        typeId: json["type_id"],
        createdOn: json["created_on"] == null ? null : DateTime.parse(json["created_on"]),
        createdById: json["created_by_id"],
        items: [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "state_id": stateId,
        "type_id": typeId,
        "created_on": createdOn?.toIso8601String(),
        "created_by_id": createdById,
        "items": items,
      };
}
