// To parse this JSON data, do
//
//     final orderItemListResponse = orderItemListResponseFromJson(jsonString);

import 'dart:convert';

OrderItemListResponse orderItemListResponseFromJson(String str) =>
    OrderItemListResponse.fromJson(json.decode(str));

String orderItemListResponseToJson(OrderItemListResponse data) =>
    json.encode(data.toJson());

class OrderItemListResponse {
  List<OrderItemList>? list;
  Links? links;
  Meta? meta;
  String? copyrights;

  OrderItemListResponse({
    this.list,
    this.links,
    this.meta,
    this.copyrights,
  });

  factory OrderItemListResponse.fromJson(Map<String, dynamic> json) =>
      OrderItemListResponse(
        list: json["list"] == null
            ? []
            : List<OrderItemList>.from(
                json["list"]!.map((x) => OrderItemList.fromJson(x))),
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

class Links {
  First? self;
  First? first;
  First? last;

  Links({
    this.self,
    this.first,
    this.last,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: json["self"] == null ? null : First.fromJson(json["self"]),
        first: json["first"] == null ? null : First.fromJson(json["first"]),
        last: json["last"] == null ? null : First.fromJson(json["last"]),
      );

  Map<String, dynamic> toJson() => {
        "self": self?.toJson(),
        "first": first?.toJson(),
        "last": last?.toJson(),
      };
}

class First {
  String? href;

  First({
    this.href,
  });

  factory First.fromJson(Map<String, dynamic> json) => First(
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
      };
}

class OrderItemList {
  int? id;
  String? orderId;
  String? productName;
  String? productImage;
  String? discountAmount;
  int? couponId;
  String? price;
  String? totalPrice;
  int? quantity;
  int? stateId;
  int? typeId;
  DateTime? createdOn;
  int? createdById;

  OrderItemList({
    this.id,
    this.orderId,
    this.productName,
    this.productImage,
    this.discountAmount,
    this.couponId,
    this.price,
    this.totalPrice,
    this.quantity,
    this.stateId,
    this.typeId,
    this.createdOn,
    this.createdById,
  });

  factory OrderItemList.fromJson(Map<String, dynamic> json) => OrderItemList(
        id: json["id"],
        orderId: json["order_id"],
        productName: json["product_name"],
        productImage: json["product_image"],
        discountAmount: json["discount_amount"],
        couponId: json["coupon_id"],
        price: json["price"],
        totalPrice: json["total_price"],
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
        "order_id": orderId,
        "product_name": productName,
        "product_image": productImage,
        "discount_amount": discountAmount,
        "coupon_id": couponId,
        "price": price,
        "total_price": totalPrice,
        "quantity": quantity,
        "state_id": stateId,
        "type_id": typeId,
        "created_on": createdOn?.toIso8601String(),
        "created_by_id": createdById,
      };
}

class Meta {
  int? totalCount;
  int? pageCount;
  int? currentPage;
  int? perPage;

  Meta({
    this.totalCount,
    this.pageCount,
    this.currentPage,
    this.perPage,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        totalCount: json["totalCount"],
        pageCount: json["pageCount"],
        currentPage: json["currentPage"],
        perPage: json["perPage"],
      );

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "pageCount": pageCount,
        "currentPage": currentPage,
        "perPage": perPage,
      };
}
