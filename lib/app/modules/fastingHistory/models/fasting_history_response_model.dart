// To parse this JSON data, do
//
//     final fastingHistoryListResponseModel = fastingHistoryListResponseModelFromJson(jsonString);

import 'dart:convert';

FastingHistoryListResponseModel fastingHistoryListResponseModelFromJson(
        String str) =>
    FastingHistoryListResponseModel.fromJson(json.decode(str));

String fastingHistoryListResponseModelToJson(
        FastingHistoryListResponseModel data) =>
    json.encode(data.toJson());

class FastingHistoryListResponseModel {
  List<FastingHistory>? list;
  String? copyrights;

  FastingHistoryListResponseModel({
    this.list,
    this.copyrights,
  });

  factory FastingHistoryListResponseModel.fromJson(Map<String, dynamic> json) =>
      FastingHistoryListResponseModel(
        list: json["list"] == null
            ? []
            : List<FastingHistory>.from(
                json["list"]!.map((x) => FastingHistory.fromJson(x))),
        copyrights: json["copyrights"],
      );

  Map<String, dynamic> toJson() => {
        "list": list == null
            ? []
            : List<dynamic>.from(list!.map((x) => x.toJson())),
        "copyrights": copyrights,
      };
}

class FastingHistory {
  int? id;
  String? title;
  int? stateId;
  int? typeId;
  DateTime? startTime;
  DateTime? endTime;
  String? totalTime;
  DateTime? createdOn;
  int? createdById;

  FastingHistory({
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

  factory FastingHistory.fromJson(Map<String, dynamic> json) => FastingHistory(
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
