// To parse this JSON data, do
//
//     final weightDetailsResponse = weightDetailsResponseFromJson(jsonString);

import 'dart:convert';

WeightDetailsResponse weightDetailsResponseFromJson(String str) =>
    WeightDetailsResponse.fromJson(json.decode(str));

String weightDetailsResponseToJson(WeightDetailsResponse data) =>
    json.encode(data.toJson());

class WeightDetailsResponse {
  List<WeightList>? list;
  String? copyrights;

  WeightDetailsResponse({
    this.list,
    this.copyrights,
  });

  factory WeightDetailsResponse.fromJson(Map<String, dynamic> json) =>
      WeightDetailsResponse(
        list: json["list"] == null
            ? []
            : List<WeightList>.from(
                json["list"]!.map((x) => WeightList.fromJson(x))),
        copyrights: json["copyrights"],
      );

  Map<String, dynamic> toJson() => {
        "list": list == null
            ? []
            : List<dynamic>.from(list!.map((x) => x.toJson())),
        "copyrights": copyrights,
      };
}

class WeightList {
  int? id;
  String? title;
  int? stateId;
  int? typeId;
  DateTime? date;
  DateTime? createdOn;
  int? createdById;

  WeightList({
    this.id,
    this.title,
    this.stateId,
    this.typeId,
    this.date,
    this.createdOn,
    this.createdById,
  });

  factory WeightList.fromJson(Map<String, dynamic> json) => WeightList(
        id: json["id"],
        title: json["title"],
        stateId: json["state_id"],
        typeId: json["type_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
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
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "created_on": createdOn?.toIso8601String(),
        "created_by_id": createdById,
      };
}
