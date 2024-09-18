// To parse this JSON data, do
//
//     final shopListByCategoryResponseModel = shopListByCategoryResponseModelFromJson(jsonString);

import 'dart:convert';

import '../../../authentication/model/question_list_Response.dart';

ShopListByCategoryResponseModel shopListByCategoryResponseModelFromJson(
        String str) =>
    ShopListByCategoryResponseModel.fromJson(json.decode(str));

String shopListByCategoryResponseModelToJson(
        ShopListByCategoryResponseModel data) =>
    json.encode(
      data.toJson(),
    );

class ShopListByCategoryResponseModel {
  List<WorkshopList>? list;
  Links? links;
  Meta? meta;
  String? copyrights;

  ShopListByCategoryResponseModel({
    this.list,
    this.links,
    this.meta,
    this.copyrights,
  });

  factory ShopListByCategoryResponseModel.fromJson(Map<String, dynamic> json) =>
      ShopListByCategoryResponseModel(
        list: json["list"] == null
            ? []
            : List<WorkshopList>.from(
                json["list"]!.map((x) => WorkshopList.fromJson(x))),
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

class WorkshopList {
  int? id;
  int? categoryId;
  String? title;
  String? description;
  String? imageFile;
  int? price;
  int? quantity;
  int? stateId;
  int? typeId;
  DateTime? createdOn;
  int? createdById;

  WorkshopList({
    this.id,
    this.categoryId,
    this.title,
    this.description,
    this.imageFile,
    this.price,
    this.quantity,
    this.stateId,
    this.typeId,
    this.createdOn,
    this.createdById,
  });

  factory WorkshopList.fromJson(Map<String, dynamic> json) => WorkshopList(
        id: json["id"],
        categoryId: json["category_id"],
        title: json["title"],
        description: json["description"],
        imageFile: json["image_file"],
        price: json["price"],
        quantity: json["quantity"],
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
        "title": title,
        "description": description,
        "image_file": imageFile,
        "price": price,
        "quantity": quantity,
        "state_id": stateId,
        "type_id": typeId,
        "created_on": createdOn?.toIso8601String(),
        "created_by_id": createdById,
      };
}
