// To parse this JSON data, do
//
//     final notificationListResponseModel = notificationListResponseModelFromJson(jsonString);

import 'dart:convert';

NotificationListResponseModel notificationListResponseModelFromJson(
        String str) =>
    NotificationListResponseModel.fromJson(json.decode(str));

String notificationListResponseModelToJson(
        NotificationListResponseModel data) =>
    json.encode(data.toJson());

class NotificationListResponseModel {
  List<NotificationList>? list;
  Links? links;
  Meta? meta;
  String? copyrights;

  NotificationListResponseModel({
    this.list,
    this.links,
    this.meta,
    this.copyrights,
  });

  factory NotificationListResponseModel.fromJson(Map<String, dynamic> json) =>
      NotificationListResponseModel(
        list: json["list"] == null
            ? []
            : List<NotificationList>.from(
                json["list"]!.map((x) => NotificationList.fromJson(x))),
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

class NotificationList {
  int? id;
  String? title;
  dynamic description;
  int? modelId;
  String? modelType;
  int? isRead;
  int? stateId;
  int? typeId;
  DateTime? createdOn;
  int? toUserId;
  int? createdById;
  int? activeMeterIndex;

  NotificationList({
    this.id,
    this.title,
    this.description,
    this.modelId,
    this.modelType,
    this.isRead,
    this.stateId,
    this.typeId,
    this.createdOn,
    this.toUserId,
    this.createdById,
    this.activeMeterIndex,
  });

  factory NotificationList.fromJson(Map<String, dynamic> json) =>
      NotificationList(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        modelId: json["model_id"],
        modelType: json["model_type"],
        isRead: json["is_read"],
        stateId: json["state_id"],
        typeId: json["type_id"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        toUserId: json["to_user_id"],
        createdById: json["created_by_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "model_id": modelId,
        "model_type": modelType,
        "is_read": isRead,
        "state_id": stateId,
        "type_id": typeId,
        "created_on": createdOn?.toIso8601String(),
        "to_user_id": toUserId,
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
