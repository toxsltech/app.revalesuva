// To parse this JSON data, do
//
//     final allDetailsResponse = allDetailsResponseFromJson(jsonString);

import 'dart:convert';

AllDetailsResponse allDetailsResponseFromJson(String str) =>
    AllDetailsResponse.fromJson(json.decode(str));

String allDetailsResponseToJson(AllDetailsResponse data) =>
    json.encode(data.toJson());

class AllDetailsResponse {
  List<AllDetailsList>? list;
  String? copyrights;

  AllDetailsResponse({
    this.list,
    this.copyrights,
  });

  factory AllDetailsResponse.fromJson(Map<String, dynamic> json) =>
      AllDetailsResponse(
        list: json["list"] == null
            ? []
            : List<AllDetailsList>.from(
                json["list"]!.map((x) => AllDetailsList.fromJson(x))),
        copyrights: json["copyrights"],
      );

  Map<String, dynamic> toJson() => {
        "list": list == null
            ? []
            : List<dynamic>.from(list!.map((x) => x.toJson())),
        "copyrights": copyrights,
      };
}

class AllDetailsList {
  int? id;
  int? measurementId;
  String? measurementType;
  String? weight;
  String? hipline;
  String? bellyline;
  String? chestine;
  DateTime? dataEntryDate;
  DateTime? weightDate;
  int? weeklyWeighConts;
  int? goodProgressConts;
  int? stateId;
  int? typeId;
  DateTime? createdOn;
  int? createdById;

  AllDetailsList({
    this.id,
    this.measurementId,
    this.measurementType,
    this.weight,
    this.hipline,
    this.bellyline,
    this.chestine,
    this.dataEntryDate,
    this.weightDate,
    this.weeklyWeighConts,
    this.goodProgressConts,
    this.stateId,
    this.typeId,
    this.createdOn,
    this.createdById,
  });

  factory AllDetailsList.fromJson(Map<String, dynamic> json) => AllDetailsList(
        id: json["id"],
        measurementId: json["measurement_id"],
        measurementType: json["measurement_type"],
        weight: json["Weight"],
        hipline: json["hipline"],
        bellyline: json["bellyline"],
        chestine: json["chestine"],
        dataEntryDate: json["data_entry_date"] == null
            ? null
            : DateTime.parse(json["data_entry_date"]),
        weightDate: json["weight_date"] == null
            ? null
            : DateTime.parse(json["weight_date"]),
        weeklyWeighConts: json["weekly_weigh_conts"],
        goodProgressConts: json["good_progress_conts"],
        stateId: json["state_id"],
        typeId: json["type_id"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        createdById: json["created_by_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "measurement_id": measurementId,
        "measurement_type": measurementType,
        "Weight": weight,
        "hipline": hipline,
        "bellyline": bellyline,
        "chestine": chestine,
        "data_entry_date":
            "${dataEntryDate!.year.toString().padLeft(4, '0')}-${dataEntryDate!.month.toString().padLeft(2, '0')}-${dataEntryDate!.day.toString().padLeft(2, '0')}",
        "weight_date":
            "${weightDate!.year.toString().padLeft(4, '0')}-${weightDate!.month.toString().padLeft(2, '0')}-${weightDate!.day.toString().padLeft(2, '0')}",
        "weekly_weigh_conts": weeklyWeighConts,
        "good_progress_conts": goodProgressConts,
        "state_id": stateId,
        "type_id": typeId,
        "created_on": createdOn?.toIso8601String(),
        "created_by_id": createdById,
      };
}
