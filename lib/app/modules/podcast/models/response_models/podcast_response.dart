// To parse this JSON data, do
//
//     final podcastListResponseModel = podcastListResponseModelFromJson(jsonString);

import 'dart:convert';

import '../../../authentication/model/question_list_Response.dart';

PodcastListResponseModel podcastListResponseModelFromJson(String str) =>
    PodcastListResponseModel.fromJson(json.decode(str));

String podcastListResponseModelToJson(PodcastListResponseModel data) =>
    json.encode(data.toJson());

class PodcastListResponseModel {
  List<PodcastList>? list;
  Links? links;
  Meta? meta;
  String? copyrights;

  PodcastListResponseModel({
    this.list,
    this.links,
    this.meta,
    this.copyrights,
  });

  factory PodcastListResponseModel.fromJson(Map<String, dynamic> json) =>
      PodcastListResponseModel(
        list: json["list"] == null
            ? []
            : List<PodcastList>.from(
                json["list"]!.map((x) => PodcastList.fromJson(x))),
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

class PodcastList {
  int? id;
  String? title;
  int? stateId;
  int? typeId;
  DateTime? createdOn;
  int? createdById;

  PodcastList({
    this.id,
    this.title,
    this.stateId,
    this.typeId,
    this.createdOn,
    this.createdById,
  });

  factory PodcastList.fromJson(Map<String, dynamic> json) => PodcastList(
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
