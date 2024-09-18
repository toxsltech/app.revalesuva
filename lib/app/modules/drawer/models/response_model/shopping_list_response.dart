// To parse this JSON data, do
//
//     final shoppingListResponse = shoppingListResponseFromJson(jsonString);

import 'dart:convert';

import '../../../authentication/model/question_list_Response.dart';
import '../data_model/shopping_product_details.dart';

ShoppingListResponse shoppingListResponseFromJson(String str) =>
    ShoppingListResponse.fromJson(json.decode(str));

String shoppingListResponseToJson(ShoppingListResponse data) =>
    json.encode(data.toJson());

class ShoppingListResponse {
  List<ProductDetails>? list;
  Links? links;
  Meta? meta;
  String? copyrights;
  var totalPrice;

  ShoppingListResponse({
    this.list,
    this.links,
    this.meta,
    this.copyrights,
    this.totalPrice,
  });

  factory ShoppingListResponse.fromJson(Map<String, dynamic> json) =>
      ShoppingListResponse(
        list: json["list"] == null
            ? []
            : List<ProductDetails>.from(
                json["list"]!.map((x) => ProductDetails.fromJson(x))),
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
