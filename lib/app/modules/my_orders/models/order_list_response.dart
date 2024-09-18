// To parse this JSON data, do
//
//     final orderListResponse = orderListResponseFromJson(jsonString);

import 'dart:convert';

OrderListResponse orderListResponseFromJson(String str) =>
    OrderListResponse.fromJson(json.decode(str));

String orderListResponseToJson(OrderListResponse data) =>
    json.encode(data.toJson());

class OrderListResponse {
  List<MyOrderList>? list;
  Links? links;
  Meta? meta;
  String? copyrights;

  OrderListResponse({
    this.list,
    this.links,
    this.meta,
    this.copyrights,
  });

  factory OrderListResponse.fromJson(Map<String, dynamic> json) =>
      OrderListResponse(
        list: json["list"] == null
            ? []
            : List<MyOrderList>.from(
                json["list"]!.map((x) => MyOrderList.fromJson(x))),
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

class MyOrderList {
  int? id;
  String? uniqueId;
  int? billingAddressId;
  int? itemCount;
  String? totalPrice;
  String? price;
  int? stateId;
  int? typeId;
  DateTime? createdOn;
  int? createdById;
  Address? address;

  MyOrderList({
    this.id,
    this.uniqueId,
    this.billingAddressId,
    this.itemCount,
    this.totalPrice,
    this.price,
    this.stateId,
    this.typeId,
    this.createdOn,
    this.createdById,
    this.address,
  });

  factory MyOrderList.fromJson(Map<String, dynamic> json) => MyOrderList(
        id: json["id"],
        uniqueId: json["unique_id"],
        billingAddressId: json["billing_address_id"],
        itemCount: json["item_count"],
        totalPrice: json["total_price"],
        price: json["price"],
        stateId: json["state_id"],
        typeId: json["type_id"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        createdById: json["created_by_id"],
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "unique_id": uniqueId,
        "billing_address_id": billingAddressId,
        "item_count": itemCount,
        "total_price": totalPrice,
        "price": price,
        "state_id": stateId,
        "type_id": typeId,
        "created_on": createdOn?.toIso8601String(),
        "created_by_id": createdById,
        "address": address?.toJson(),
      };
}

class Address {
  int? id;
  String? fullName;
  String? email;
  String? counrtyCode;
  String? contactNo;
  String? address;
  String? latitude;
  String? longitude;
  String? city;
  String? state;
  String? country;
  String? zipCode;
  int? stateId;
  int? typeId;
  DateTime? createdOn;
  int? createdById;

  Address({
    this.id,
    this.fullName,
    this.email,
    this.counrtyCode,
    this.contactNo,
    this.address,
    this.latitude,
    this.longitude,
    this.city,
    this.state,
    this.country,
    this.zipCode,
    this.stateId,
    this.typeId,
    this.createdOn,
    this.createdById,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        fullName: json["full_name"],
        email: json["email"],
        counrtyCode: json["counrty_code"],
        contactNo: json["contact_no"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        zipCode: json["zip_code"],
        stateId: json["state_id"],
        typeId: json["type_id"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        createdById: json["created_by_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "email": email,
        "counrty_code": counrtyCode,
        "contact_no": contactNo,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "city": city,
        "state": state,
        "country": country,
        "zip_code": zipCode,
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
