// To parse this JSON data, do
//
//     final weightDetailsResponse = weightDetailsResponseFromJson(jsonString);

import 'dart:convert';

DataEntryDetailsResponse dataEntryDetailsResponseFromJson(String str) =>
    DataEntryDetailsResponse.fromJson(json.decode(str));

String dataEntryDetailsResponseToJson(DataEntryDetailsResponse data) =>
    json.encode(data.toJson());

class DataEntryDetailsResponse {
  WeightDetail? detail;
  var message;
  var copyrights;

  DataEntryDetailsResponse({
    this.detail,
    this.message,
    this.copyrights,
  });

  factory DataEntryDetailsResponse.fromJson(Map<String, dynamic> json) =>
      DataEntryDetailsResponse(
        detail: json["detail"] == null
            ? null
            : WeightDetail.fromJson(json["detail"]),
        message: json["message"],
        copyrights: json["copyrights"],
      );

  Map<String, dynamic> toJson() => {
        "detail": detail?.toJson(),
        "message": message,
        "copyrights": copyrights,
      };
}

class WeightDetail {
  var id;
  var measurementId;
  var measurementType;
  var weight;
  var hipline;
  var bellyline;
  var chestine;
  var dataEntryDate;
  var weightDate;
  var weeklyWeighConts;
  var goodProgressConts;
  var stateId;
  var typeId;
  var createdOn;
  var createdById;

  WeightDetail({
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

  factory WeightDetail.fromJson(Map<String, dynamic> json) => WeightDetail(
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
        weightDate: json["weight_date"],
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
        "weight_date": weightDate,
        "weekly_weigh_conts": weeklyWeighConts,
        "good_progress_conts": goodProgressConts,
        "state_id": stateId,
        "type_id": typeId,
        "created_on": createdOn?.toIso8601String(),
        "created_by_id": createdById,
      };
}
