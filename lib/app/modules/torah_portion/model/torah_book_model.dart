// To parse this JSON data, do
//
//     final torahListResponseModel = torahListResponseModelFromJson(jsonString);

import 'dart:convert';

TorahListResponseModel torahListResponseModelFromJson(String str) =>
    TorahListResponseModel.fromJson(json.decode(str));

String torahListResponseModelToJson(TorahListResponseModel data) =>
    json.encode(data.toJson());

class TorahListResponseModel {
  List<TorahBookList>? list;
  String? copyrights;

  TorahListResponseModel({
    this.list,
    this.copyrights,
  });

  factory TorahListResponseModel.fromJson(Map<String, dynamic> json) =>
      TorahListResponseModel(
        list: json["list"] == null
            ? []
            : List<TorahBookList>.from(
                json["list"]!.map((x) => TorahBookList.fromJson(x))),
        copyrights: json["copyrights"],
      );

  Map<String, dynamic> toJson() => {
        "list": list == null
            ? []
            : List<dynamic>.from(list!.map((x) => x.toJson())),
        "copyrights": copyrights,
      };
}

class TorahBookList {
  int? id;
  String? title;
  String? description;
  DateTime? verse;
  int? stateId;
  bool expand;
  int? typeId;
  DateTime? createdOn;
  int? activeMeterIndex;
  int? createdById;

  TorahBookList({
    this.id,
    this.title,
    this.description,
    required this.expand,
    this.activeMeterIndex,
    this.verse,
    this.stateId,
    this.typeId,
    this.createdOn,
    this.createdById,
  });

  factory TorahBookList.fromJson(Map<String, dynamic> json) => TorahBookList(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        expand: json["expand"] ?? false,
        verse: json["verse"] == null ? null : DateTime.parse(json["verse"]),
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
        "description": description,
        "verse":
            "${verse!.year.toString().padLeft(4, '0')}-${verse!.month.toString().padLeft(2, '0')}-${verse!.day.toString().padLeft(2, '0')}",
        "state_id": stateId,
        "type_id": typeId,
        "created_on": createdOn?.toIso8601String(),
        "created_by_id": createdById,
      };
}
