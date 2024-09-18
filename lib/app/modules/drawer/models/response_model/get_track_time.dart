// To parse this JSON data, do
//
//     final getTrackTimeResponseModel = getTrackTimeResponseModelFromJson(jsonString);

import 'dart:convert';

GetTrackTimeResponseModel getTrackTimeResponseModelFromJson(String str) =>
    GetTrackTimeResponseModel.fromJson(json.decode(str));

String getTrackTimeResponseModelToJson(GetTrackTimeResponseModel data) =>
    json.encode(data.toJson());

class GetTrackTimeResponseModel {
  List<TrackTime>? list;
  Links? links;
  Meta? meta;
  String? copyrights;

  GetTrackTimeResponseModel({
    this.list,
    this.links,
    this.meta,
    this.copyrights,
  });

  factory GetTrackTimeResponseModel.fromJson(Map<String, dynamic> json) =>
      GetTrackTimeResponseModel(
        list: json["list"] == null
            ? []
            : List<TrackTime>.from(
                json["list"]!.map((x) => TrackTime.fromJson(x))),
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
  First? next;

  Links({
    this.self,
    this.first,
    this.last,
    this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: json["self"] == null ? null : First.fromJson(json["self"]),
        first: json["first"] == null ? null : First.fromJson(json["first"]),
        last: json["last"] == null ? null : First.fromJson(json["last"]),
        next: json["next"] == null ? null : First.fromJson(json["next"]),
      );

  Map<String, dynamic> toJson() => {
        "self": self?.toJson(),
        "first": first?.toJson(),
        "last": last?.toJson(),
        "next": next?.toJson(),
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

class TrackTime {
  int? id;
  int? fastId;
  int? differenceMinutes;
  int? nowDifference;
  String? totalTime;
  DateTime? date;
  int? stateId;
  int? typeId;
  DateTime? createdOn;
  int? createdById;
  Fasting? fasting;

  TrackTime({
    this.id,
    this.fastId,
    this.differenceMinutes,
    this.nowDifference,
    this.totalTime,
    this.date,
    this.stateId,
    this.typeId,
    this.createdOn,
    this.createdById,
    this.fasting,
  });

  factory TrackTime.fromJson(Map<String, dynamic> json) => TrackTime(
        id: json["id"],
        fastId: json["fast_id"],
        differenceMinutes: json["difference_minutes"],
        totalTime: json["total_time"],
        nowDifference: json["now_difference"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        stateId: json["state_id"],
        typeId: json["type_id"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        createdById: json["created_by_id"],
        fasting:
            json["fasting"] == null ? null : Fasting.fromJson(json["fasting"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fast_id": fastId,
        "difference_minutes": differenceMinutes,
        "total_time": totalTime,
        "now_difference": nowDifference,
        "date": date?.toIso8601String(),
        "state_id": stateId,
        "type_id": typeId,
        "created_on": createdOn?.toIso8601String(),
        "created_by_id": createdById,
        "fasting": fasting?.toJson(),
      };
}

class Fasting {
  int? id;
  String? title;
  int? stateId;
  int? typeId;
  DateTime? startTime;
  DateTime? endTime;
  String? totalTime;
  DateTime? createdOn;
  int? createdById;

  Fasting({
    this.id,
    this.title,
    this.stateId,
    this.typeId,
    this.startTime,
    this.endTime,
    this.totalTime,
    this.createdOn,
    this.createdById,
  });

  factory Fasting.fromJson(Map<String, dynamic> json) => Fasting(
        id: json["id"],
        title: json["title"],
        stateId: json["state_id"],
        typeId: json["type_id"],
        startTime: json["start_time"] == null
            ? null
            : DateTime.parse(json["start_time"]),
        endTime:
            json["end_time"] == null ? null : DateTime.parse(json["end_time"]),
        totalTime: json["total_time"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        createdById: json["created_by_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "state_id": stateId,
        "type_id": typeId,
        "start_time": startTime?.toIso8601String(),
        "end_time": endTime?.toIso8601String(),
        "total_time": totalTime,
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
