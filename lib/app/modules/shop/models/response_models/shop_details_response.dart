// To parse this JSON data, do
//
//     final shopLDetailsResponseModel = shopLDetailsResponseModelFromJson(jsonString);

import 'dart:convert';

ShopLDetailsResponseModel shopLDetailsResponseModelFromJson(String str) =>
    ShopLDetailsResponseModel.fromJson(json.decode(str));

String shopLDetailsResponseModelToJson(ShopLDetailsResponseModel data) =>
    json.encode(data.toJson());

class ShopLDetailsResponseModel {
  Product? product;
  String? message;
  String? copyrights;

  ShopLDetailsResponseModel({
    this.product,
    this.message,
    this.copyrights,
  });

  factory ShopLDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      ShopLDetailsResponseModel(
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
        message: json["message"],
        copyrights: json["copyrights"],
      );

  Map<String, dynamic> toJson() => {
        "product": product?.toJson(),
        "message": message,
        "copyrights": copyrights,
      };
}

class Product {
  int? id;
  int? categoryId;
  String? title;
  String? description;
  String? imageFile;
  int? price;
  int? quantity;
  bool? isCartAdded;
  int? stateId;
  int? typeId;
  DateTime? createdOn;
  int? createdById;

  Product({
    this.id,
    this.categoryId,
    this.title,
    this.description,
    this.imageFile,
    this.price,
    this.quantity,
    this.isCartAdded,
    this.stateId,
    this.typeId,
    this.createdOn,
    this.createdById,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        categoryId: json["category_id"],
        title: json["title"],
        description: json["description"],
        imageFile: json["image_file"],
        price: json["price"],
        quantity: json["quantity"],
        isCartAdded: json["is_cart_item_added"],
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
        "is_cart_item_added": isCartAdded,
        "state_id": stateId,
        "type_id": typeId,
        "created_on": createdOn?.toIso8601String(),
        "created_by_id": createdById,
      };
}
