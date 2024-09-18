// To parse this JSON data, do
//
//     final getMeasurementResponse = getMeasurementResponseFromJson(jsonString);

import 'dart:convert';

import '../../../authentication/model/question_list_Response.dart';

MeasurementResponse measurementResponseFromJson(String str) =>
    MeasurementResponse.fromJson(json.decode(str));

String measurementResponseToJson(MeasurementResponse data) =>
    json.encode(data.toJson());

class MeasurementResponse {
  List<MeasurementList>? list;
  Links? links;
  Meta? meta;
  String? copyrights;

  MeasurementResponse({
    this.list,
    this.links,
    this.meta,
    this.copyrights,
  });

  factory MeasurementResponse.fromJson(Map<String, dynamic> json) =>
      MeasurementResponse(
        list: json["list"] == null
            ? []
            : List<MeasurementList>.from(
                json["list"]!.map((x) => MeasurementList.fromJson(x))),
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

class MeasurementList {
  int? id;
  int? stateId;
  String? typeId;
  DateTime? createdOn;
  int? createdById;
  int? isSelected;
  bool groupValue;

  MeasurementList({
    this.id,
    this.stateId,
    this.typeId,
    this.createdOn,
    this.createdById,
    required this.isSelected,
    required this.groupValue,
  });

  factory MeasurementList.fromJson(Map<String, dynamic> json) =>
      MeasurementList(
        id: json["id"],
        stateId: json["state_id"],
        typeId: json["type_id"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        createdById: json["created_by_id"],
        isSelected: json["isSelected"] ?? 1,
        groupValue: false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "state_id": stateId,
        "type_id": typeId,
        "created_on": createdOn?.toIso8601String(),
        "created_by_id": createdById,
        "isSelected": isSelected,
        "groupValue": groupValue,
      };
}
