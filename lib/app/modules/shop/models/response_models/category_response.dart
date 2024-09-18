// To parse this JSON data, do
//
//     final ShopCategoryListResponseModel = ShopCategoryListResponseModelFromJson(jsonString);

import 'dart:convert';

import '../../../authentication/model/question_list_Response.dart';

ShopCategoryListResponseModel shopCategoryListResponseModelFromJson(
        String str) =>
    ShopCategoryListResponseModel.fromJson(json.decode(str));

String shopCategoryListResponseModelToJson(
        ShopCategoryListResponseModel data) =>
    json.encode(data.toJson());

class ShopCategoryListResponseModel {
  List<CategoryList>? list;
  Links? links;
  Meta? meta;
  String? copyrights;

  ShopCategoryListResponseModel({
    this.list,
    this.links,
    this.meta,
    this.copyrights,
  });

  factory ShopCategoryListResponseModel.fromJson(Map<String, dynamic> json) =>
      ShopCategoryListResponseModel(
        list: json["list"] == null
            ? []
            : List<CategoryList>.from(
                json["list"]!.map((x) => CategoryList.fromJson(x))),
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

class CategoryList {
  int? id;
  String? title;
  String? imageFile;
  int? typeId;
  int? stateId;
  DateTime? createdOn;
  int? createdById;

  CategoryList({
    this.id,
    this.title,
    this.imageFile,
    this.typeId,
    this.stateId,
    this.createdOn,
    this.createdById,
  });

  factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
        id: json["id"],
        title: json["title"],
        imageFile: json["image_file"],
        typeId: json["type_id"],
        stateId: json["state_id"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        createdById: json["created_by_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image_file": imageFile,
        "type_id": typeId,
        "state_id": stateId,
        "created_on": createdOn?.toIso8601String(),
        "created_by_id": createdById,
      };
}
