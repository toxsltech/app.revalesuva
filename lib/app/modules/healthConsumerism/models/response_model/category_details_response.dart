// To parse this JSON data, do
//
//     final categoryDetailsResponse = categoryDetailsResponseFromJson(jsonString);

import 'dart:convert';

import '../../../authentication/model/question_list_Response.dart';

CategoryDetailsResponse categoryDetailsResponseFromJson(String str) =>
    CategoryDetailsResponse.fromJson(json.decode(str));

String categoryDetailsResponseToJson(CategoryDetailsResponse data) =>
    json.encode(data.toJson());

class CategoryDetailsResponse {
  List<CategoryDetailList>? list;
  Links? links;
  Meta? meta;
  String? copyrights;

  CategoryDetailsResponse({
    this.list,
    this.links,
    this.meta,
    this.copyrights,
  });

  factory CategoryDetailsResponse.fromJson(Map<String, dynamic> json) =>
      CategoryDetailsResponse(
        list: json["list"] == null
            ? []
            : List<CategoryDetailList>.from(
                json["list"]!.map((x) => CategoryDetailList.fromJson(x))),
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

class CategoryDetailList {
  int? id;
  int? categoryId;
  String? title;
  String? image;
  int? quantity;
  int? productQuantity;
  int? stateId;
  int? typeId;
  DateTime? createdOn;
  bool? status;
  int? createdById;

  CategoryDetailList({
    this.id,
    this.categoryId,
    this.title,
    this.image,
    this.quantity,
    this.stateId,
    this.typeId,
    this.createdOn,
    this.createdById,
    this.productQuantity,
    this.status,
  });

  factory CategoryDetailList.fromJson(Map<String, dynamic> json) =>
      CategoryDetailList(
        id: json["id"],
        categoryId: json["category_id"],
        title: json["title"],
        image: json["image"],
        quantity: json["quantity"],
        stateId: json["state_id"],
        typeId: json["type_id"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        createdById: json["created_by_id"],
        status: json["status"],
        productQuantity: json["productQuantity"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "title": title,
        "image": image,
        "quantity": quantity,
        "state_id": stateId,
        "type_id": typeId,
        "created_on": createdOn?.toIso8601String(),
        "created_by_id": createdById,
        "status": status,
      };
}
