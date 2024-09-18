// To parse this JSON data, do
//
//     final dropdownListResponseModel = dropdownListResponseModelFromJson(jsonString);

import 'dart:convert';

import '../../authentication/model/question_list_Response.dart';

DropdownListResponseModel dropdownListResponseModelFromJson(String str) =>
    DropdownListResponseModel.fromJson(json.decode(str));

String dropdownListResponseModelToJson(DropdownListResponseModel data) =>
    json.encode(data.toJson());

class DropdownListResponseModel {
  List<DropdownList>? list;
  Links? links;
  Meta? meta;
  String? copyrights;

  DropdownListResponseModel({
    this.list,
    this.links,
    this.meta,
    this.copyrights,
  });

  factory DropdownListResponseModel.fromJson(Map<String, dynamic> json) =>
      DropdownListResponseModel(
        list: json["list"] == null
            ? []
            : List<DropdownList>.from(
                json["list"]!.map(
                  (x) => DropdownList.fromJson(x),
                ),
              ),
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

class DropdownList {
  int? id;
  String? title;
  int? stateId;
  int? typeId;
  DateTime? createdOn;
  int? createdById;

  DropdownList({
    this.id,
    this.title,
    this.stateId,
    this.typeId,
    this.createdOn,
    this.createdById,
  });

  factory DropdownList.fromJson(Map<String, dynamic> json) => DropdownList(
        id: json["id"],
        title: json["title"],
        stateId: json["state_id"],
        typeId: json["type_id"],
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
        "created_on": createdOn?.toIso8601String(),
        "created_by_id": createdById,
      };
}
