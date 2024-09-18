// To parse this JSON data, do
//
//     final planLIstApiResponseModel = planLIstApiResponseModelFromJson(jsonString);

import 'dart:convert';

PlanListApiResponseModel planListApiResponseModelFromJson(String str) =>
    PlanListApiResponseModel.fromJson(json.decode(str));

String planListApiResponseModelToJson(PlanListApiResponseModel data) =>
    json.encode(data.toJson());

class PlanListApiResponseModel {
  List<PlanListDataModel>? list;
  Links? links;
  Meta? meta;
  String? copyrights;

  PlanListApiResponseModel({
    this.list,
    this.links,
    this.meta,
    this.copyrights,
  });

  factory PlanListApiResponseModel.fromJson(Map<String, dynamic> json) =>
      PlanListApiResponseModel(
        list: json["list"] == null
            ? []
            : List<PlanListDataModel>.from(
                json["list"]!.map((x) => PlanListDataModel.fromJson(x))),
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

class PlanListDataModel {
  int? id;
  int? planId;
  String? planTitle;
  String? title;
  String? description;
  var host;
  DateTime? dateTime;
  int? noAllowPerson;
  int? stateId;
  String? typeId;
  DateTime? createdOn;
  int? createdById;
  var applyCount;
  var registerUser;
  var isApplied;

  PlanListDataModel({
    this.id,
    this.planId,
    this.planTitle,
    this.title,
    this.description,
    this.host,
    this.dateTime,
    this.noAllowPerson,
    this.stateId,
    this.typeId,
    this.createdOn,
    this.createdById,
    this.applyCount,
    this.registerUser,
    this.isApplied,
  });

  factory PlanListDataModel.fromJson(Map<String, dynamic> json) =>
      PlanListDataModel(
        id: json["id"],
        planId: json["plan_id"],
        planTitle: json["plan_title"],
        title: json["title"],
        description: json["description"],
        host: json["host"],
        dateTime: json["date_time"] == null
            ? null
            : DateTime.parse(json["date_time"]),
        noAllowPerson: json["no_allow_person"],
        stateId: json["state_id"],
        typeId: json["type_id"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        createdById: json["created_by_id"],
        applyCount: json["apply_count"],
        registerUser: json["register_user"],
        isApplied: json["is_applied"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "plan_id": planId,
        "plan_title": planTitle,
        "title": title,
        "description": description,
        "host": host,
        "date_time": dateTime?.toIso8601String(),
        "no_allow_person": noAllowPerson,
        "state_id": stateId,
        "type_id": typeId,
        "created_on": createdOn?.toIso8601String(),
        "created_by_id": createdById,
        "apply_count": applyCount,
        "register_user": registerUser,
        "is_applied": isApplied,
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
