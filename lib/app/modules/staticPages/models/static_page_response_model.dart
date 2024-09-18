import 'dart:convert';

StaticPageResponseModel staticPageResponseModelFromJson(String str) =>
    StaticPageResponseModel.fromJson(json.decode(str));

String staticPageResponseModelToJson(StaticPageResponseModel data) =>
    json.encode(data.toJson());

class StaticPageResponseModel {
  Detail? detail;
  String? copyrights;

  StaticPageResponseModel({
    this.detail,
    this.copyrights,
  });

  factory StaticPageResponseModel.fromJson(Map<String, dynamic> json) =>
      StaticPageResponseModel(
        detail:
            json["details"] == null ? null : Detail.fromJson(json["details"]),
        copyrights: json["copyrights"],
      );

  Map<String, dynamic> toJson() => {
        "details": detail?.toJson(),
        "copyrights": copyrights,
      };
}

class Detail {
  int? id;
  String? title;
  String? url;
  String? description;
  int? stateId;
  DateTime? createdOn;
  int? createdById;

  Detail({
    this.id,
    this.title,
    this.url,
    this.description,
    this.stateId,
    this.createdOn,
    this.createdById,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        title: json["title"],
        url: json["url"],
        description: json["description"],
        stateId: json["state_id"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        createdById: json["created_by_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "url": url,
        "description": description,
        "state_id": stateId,
        "created_on": createdOn?.toIso8601String(),
        "created_by_id": createdById,
      };
}
