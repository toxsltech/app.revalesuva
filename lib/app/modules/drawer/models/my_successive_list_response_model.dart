// To parse this JSON data, do
//
//     final mySuccessiveListApiResponseModel = mySuccessiveListApiResponseModelFromJson(jsonString);

import 'dart:convert';

MySuccessiveListApiResponseModel mySuccessiveListApiResponseModelFromJson(String str) => MySuccessiveListApiResponseModel.fromJson(json.decode(str));

String mySuccessiveListApiResponseModelToJson(MySuccessiveListApiResponseModel data) => json.encode(data.toJson());

class MySuccessiveListApiResponseModel {
  List<MySuccessiveListApiDataModel>? list;
  String? copyrights;

  MySuccessiveListApiResponseModel({
    this.list,
    this.copyrights,
  });

  factory MySuccessiveListApiResponseModel.fromJson(Map<String, dynamic> json) => MySuccessiveListApiResponseModel(
    list: json["list"] == null ? [] : List<MySuccessiveListApiDataModel>.from(json["list"]!.map((x) => MySuccessiveListApiDataModel.fromJson(x))),
    copyrights: json["copyrights"],
  );

  Map<String, dynamic> toJson() => {
    "list": list == null ? [] : List<dynamic>.from(list!.map((x) => x.toJson())),
    "copyrights": copyrights,
  };
}

class MySuccessiveListApiDataModel {
  int? id;
  String? title;
  int? stateId;
  int? typeId;
  DateTime? createdOn;
  int? createdById;
  bool? status;

  MySuccessiveListApiDataModel({
    this.id,
    this.title,
    this.stateId,
    this.typeId,
    this.createdOn,
    this.createdById,
    this.status,
  });

  factory MySuccessiveListApiDataModel.fromJson(Map<String, dynamic> json) => MySuccessiveListApiDataModel(
    id: json["id"],
    title: json["title"],
    stateId: json["state_id"],
    typeId: json["type_id"],
    createdOn: json["created_on"] == null ? null : DateTime.parse(json["created_on"]),
    createdById: json["created_by_id"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "state_id": stateId,
    "type_id": typeId,
    "created_on": createdOn?.toIso8601String(),
    "created_by_id": createdById,
    "status": status,
  };
}
