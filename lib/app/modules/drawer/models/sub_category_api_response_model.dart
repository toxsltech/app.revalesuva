// To parse this JSON data, do
//
//     final dailyNutritionSubCategoryResponseModel = dailyNutritionSubCategoryResponseModelFromJson(jsonString);

import 'dart:convert';

DailyNutritionSubCategoryResponseModel
    dailyNutritionSubCategoryResponseModelFromJson(String str) =>
        DailyNutritionSubCategoryResponseModel.fromJson(json.decode(str));

String dailyNutritionSubCategoryResponseModelToJson(
        DailyNutritionSubCategoryResponseModel data) =>
    json.encode(data.toJson());

class DailyNutritionSubCategoryResponseModel {
  List<DailyNutritionSubCategoryDataModel>? list;
  String? copyrights;

  DailyNutritionSubCategoryResponseModel({
    this.list,
    this.copyrights,
  });

  factory DailyNutritionSubCategoryResponseModel.fromJson(
          Map<String, dynamic> json) =>
      DailyNutritionSubCategoryResponseModel(
        list: json["list"] == null
            ? []
            : List<DailyNutritionSubCategoryDataModel>.from(json["list"]!
                .map((x) => DailyNutritionSubCategoryDataModel.fromJson(x))),
        copyrights: json["copyrights"],
      );

  Map<String, dynamic> toJson() => {
        "list": list == null
            ? []
            : List<dynamic>.from(list!.map((x) => x.toJson())),
        "copyrights": copyrights,
      };
}

class DailyNutritionSubCategoryDataModel {
  int? id;
  int? categoryId;
  String? categoryName;
  String? categoryType;
  String? title;
  int? stateId;
  int? typeId;
  DateTime? createdOn;
  int? createdById;
  bool isSelected;

  DailyNutritionSubCategoryDataModel({
    this.id,
    this.categoryId,
    this.categoryName,
    this.categoryType,
    this.title,
    this.stateId,
    this.typeId,
    this.createdOn,
    this.createdById,
    this.isSelected = false,
  });

  factory DailyNutritionSubCategoryDataModel.fromJson(
          Map<String, dynamic> json) =>
      DailyNutritionSubCategoryDataModel(
        id: json["id"],
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        categoryType: json["category_type"],
        title: json["title"],
        stateId: json["state_id"],
        typeId: json["type_id"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        createdById: json["created_by_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "category_name": categoryName,
        "category_type": categoryType,
        "title": title,
        "state_id": stateId,
        "type_id": typeId,
        "created_on": createdOn?.toIso8601String(),
        "created_by_id": createdById,
      };
}
