// To parse this JSON data, do
//
//     final ovulationCycleListResponseModel = ovulationCycleListResponseModelFromJson(jsonString);

import 'dart:convert';

OvulationCycleListResponseModel ovulationCycleListResponseModelFromJson(
        String str) =>
    OvulationCycleListResponseModel.fromJson(json.decode(str));

String ovulationCycleListResponseModelToJson(
        OvulationCycleListResponseModel data) =>
    json.encode(data.toJson());

class OvulationCycleListResponseModel {
  List<ListElement>? list;
  String? copyrights;

  OvulationCycleListResponseModel({
    this.list,
    this.copyrights,
  });

  factory OvulationCycleListResponseModel.fromJson(Map<String, dynamic> json) =>
      OvulationCycleListResponseModel(
        list: json["list"] == null
            ? []
            : List<ListElement>.from(
                json["list"]!.map((x) => ListElement.fromJson(x))),
        copyrights: json["copyrights"],
      );

  Map<String, dynamic> toJson() => {
        "list": list == null
            ? []
            : List<dynamic>.from(list!.map((x) => x.toJson())),
        "copyrights": copyrights,
      };
}

class ListElement {
  int? id;
  DateTime? date;
  DateTime? nextDate;
  DateTime? harmonalStartDate;
  DateTime? harmonalEndDate;
  DateTime? ovalutionDate;
  int? avgCycle;
  int? stateId;
  int? typeId;
  DateTime? createdOn;
  int? createdById;

  ListElement({
    this.id,
    this.date,
    this.nextDate,
    this.harmonalStartDate,
    this.harmonalEndDate,
    this.ovalutionDate,
    this.avgCycle,
    this.stateId,
    this.typeId,
    this.createdOn,
    this.createdById,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        nextDate: json["next_date"] == null
            ? null
            : DateTime.parse(json["next_date"]),
        harmonalStartDate: json["harmonal_start_date"] == null
            ? null
            : DateTime.parse(json["harmonal_start_date"]),
        harmonalEndDate: json["harmonal_end_date"] == null
            ? null
            : DateTime.parse(json["harmonal_end_date"]),
        ovalutionDate: json["ovalution_date"] == null
            ? null
            : DateTime.parse(json["ovalution_date"]),
        avgCycle: json["avg_cycle"],
        stateId: json["state_id"],
        typeId: json["type_id"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        createdById: json["created_by_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "next_date":
            "${nextDate!.year.toString().padLeft(4, '0')}-${nextDate!.month.toString().padLeft(2, '0')}-${nextDate!.day.toString().padLeft(2, '0')}",
        "harmonal_start_date":
            "${harmonalStartDate!.year.toString().padLeft(4, '0')}-${harmonalStartDate!.month.toString().padLeft(2, '0')}-${harmonalStartDate!.day.toString().padLeft(2, '0')}",
        "harmonal_end_date":
            "${harmonalEndDate!.year.toString().padLeft(4, '0')}-${harmonalEndDate!.month.toString().padLeft(2, '0')}-${harmonalEndDate!.day.toString().padLeft(2, '0')}",
        "ovalution_date":
            "${ovalutionDate!.year.toString().padLeft(4, '0')}-${ovalutionDate!.month.toString().padLeft(2, '0')}-${ovalutionDate!.day.toString().padLeft(2, '0')}",
        "avg_cycle": avgCycle,
        "state_id": stateId,
        "type_id": typeId,
        "created_on": createdOn?.toIso8601String(),
        "created_by_id": createdById,
      };
}
