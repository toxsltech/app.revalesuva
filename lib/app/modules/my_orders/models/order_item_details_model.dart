// To parse this JSON data, do
//
//     final orderItemDetailsResponse = orderItemDetailsResponseFromJson(jsonString);

import 'dart:convert';

import 'order_item_data_model.dart';

OrderItemDetailsResponse orderItemDetailsResponseFromJson(String str) =>
    OrderItemDetailsResponse.fromJson(json.decode(str));

String orderItemDetailsResponseToJson(OrderItemDetailsResponse data) =>
    json.encode(data.toJson());

class OrderItemDetailsResponse {
  OrderItemDetails? detail;
  var copyrights;

  OrderItemDetailsResponse({
    this.detail,
    this.copyrights,
  });

  factory OrderItemDetailsResponse.fromJson(Map<String, dynamic> json) =>
      OrderItemDetailsResponse(
        detail: json["detail"] == null
            ? null
            : OrderItemDetails.fromJson(json["detail"]),
        copyrights: json["copyrights"],
      );

  Map<String, dynamic> toJson() => {
        "detail": detail?.toJson(),
        "copyrights": copyrights,
      };
}
