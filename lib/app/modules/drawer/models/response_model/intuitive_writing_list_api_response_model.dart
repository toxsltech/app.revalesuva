// To parse this JSON data, do
//
//     final intuitiveWritingListResponseModel = intuitiveWritingListResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:health_fitness/app/modules/authentication/model/question_list_Response.dart';

IntuitiveWritingListResponseModel intuitiveWritingListResponseModelFromJson(String str) =>
    IntuitiveWritingListResponseModel.fromJson(json.decode(str));

String intuitiveWritingListResponseModelToJson(IntuitiveWritingListResponseModel data) => json.encode(data.toJson());

class IntuitiveWritingListResponseModel {
  List<IntuitiveWritingListDataModel>? list;
  Links? links;
  Meta? meta;
  String? copyrights;

  IntuitiveWritingListResponseModel({
    this.list,
    this.links,
    this.meta,
    this.copyrights,
  });

  factory IntuitiveWritingListResponseModel.fromJson(Map<String, dynamic> json) => IntuitiveWritingListResponseModel(
        list:
            json["list"] == null ? [] : List<IntuitiveWritingListDataModel>.from(json["list"]!.map((x) => IntuitiveWritingListDataModel.fromJson(x))),
        links: json["_links"] == null ? null : Links.fromJson(json["_links"]),
        meta: json["_meta"] == null ? null : Meta.fromJson(json["_meta"]),
        copyrights: json["copyrights"],
      );

  Map<String, dynamic> toJson() => {
        "list": list == null ? [] : List<dynamic>.from(list!.map((x) => x.toJson())),
        "_links": links?.toJson(),
        "_meta": meta?.toJson(),
        "copyrights": copyrights,
      };
}

class IntuitiveWritingListDataModel {
  int? id;
  String? title;
  String? description;
  int? stateId;
  int? typeId;
  DateTime? createdOn;
  int? createdById;

  IntuitiveWritingListDataModel({
    this.id,
    this.title,
    this.description,
    this.stateId,
    this.typeId,
    this.createdOn,
    this.createdById,
  });

  factory IntuitiveWritingListDataModel.fromJson(Map<String, dynamic> json) => IntuitiveWritingListDataModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        stateId: json["state_id"],
        typeId: json["type_id"],
        createdOn: json["created_on"] == null ? null : DateTime.parse(json["created_on"]),
        createdById: json["created_by_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "state_id": stateId,
        "type_id": typeId,
        "created_on": createdOn?.toIso8601String(),
        "created_by_id": createdById,
      };
}
