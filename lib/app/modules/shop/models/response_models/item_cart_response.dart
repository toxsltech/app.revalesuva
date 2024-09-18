// To parse this JSON data, do
//
//     final itemCartListResponseModel = itemCartListResponseModelFromJson(jsonString);

import 'dart:convert';

import '../../../authentication/model/question_list_Response.dart';

ItemCartListResponseModel itemCartListResponseModelFromJson(String str) =>
    ItemCartListResponseModel.fromJson(json.decode(str));

String itemCartListResponseModelToJson(ItemCartListResponseModel data) =>
    json.encode(data.toJson());

class ItemCartListResponseModel {
  List<ItemCartList>? list;
  Links? links;
  Meta? meta;
  var copyrights;
  var totalPrice;

  ItemCartListResponseModel({
    this.list,
    this.links,
    this.meta,
    this.copyrights,
    this.totalPrice,
  });

  factory ItemCartListResponseModel.fromJson(Map<String, dynamic> json) =>
      ItemCartListResponseModel(
        list: json["list"] == null
            ? []
            : List<ItemCartList>.from(
                json["list"]!.map((x) => ItemCartList.fromJson(x))),
        links: json["_links"] == null ? null : Links.fromJson(json["_links"]),
        meta: json["_meta"] == null ? null : Meta.fromJson(json["_meta"]),
        copyrights: json["copyrights"],
        totalPrice: json["total_price"],
      );

  Map<String, dynamic> toJson() => {
        "list": list == null
            ? []
            : List<dynamic>.from(list!.map((x) => x.toJson())),
        "_links": links?.toJson(),
        "_meta": meta?.toJson(),
        "copyrights": copyrights,
        "total_price": totalPrice,
      };
}

class ItemCartList {
  var id;
  var productId;
  var productName;
  var productImage;
  var price;
  var quantity;
  var totalPrice;
  var stateId;
  var typeId;
  DateTime? createdOn;
  var createdById;

  ItemCartList({
    this.id,
    this.productId,
    this.productName,
    this.productImage,
    this.price,
    this.quantity,
    this.totalPrice,
    this.stateId,
    this.typeId,
    this.createdOn,
    this.createdById,
  });

  factory ItemCartList.fromJson(Map<String, dynamic> json) => ItemCartList(
        id: json["id"],
        productId: json["product_id"],
        productName: json["product_name"],
        productImage: json["product_image"],
        price: json["price"],
        quantity: json["quantity"],
        totalPrice: json["total_price"],
        stateId: json["state_id"],
        typeId: json["type_id"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        createdById: json["created_by_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "product_name": productName,
        "product_image": productImage,
        "price": price,
        "quantity": quantity,
        "total_price": totalPrice,
        "state_id": stateId,
        "type_id": typeId,
        "created_on": createdOn?.toIso8601String(),
        "created_by_id": createdById,
      };
}
