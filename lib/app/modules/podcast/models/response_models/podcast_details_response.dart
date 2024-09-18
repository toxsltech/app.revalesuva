// To parse this JSON data, do
//
//     final podcastListDetailsResponseModel = podcastListDetailsResponseModelFromJson(jsonString);

import 'dart:convert';

import '../../../authentication/model/question_list_Response.dart';

PodcastListDetailsResponseModel podcastListDetailsResponseModelFromJson(
        String str) =>
    PodcastListDetailsResponseModel.fromJson(json.decode(str));

String podcastListDetailsResponseModelToJson(
        PodcastListDetailsResponseModel data) =>
    json.encode(data.toJson());

class PodcastListDetailsResponseModel {
  List<PodcastDetails>? list;
  Links? links;
  Meta? meta;
  var copyrights;

  PodcastListDetailsResponseModel({
    this.list,
    this.links,
    this.meta,
    this.copyrights,
  });

  factory PodcastListDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      PodcastListDetailsResponseModel(
        list: json["list"] == null
            ? []
            : List<PodcastDetails>.from(
                json["list"]!.map((x) => PodcastDetails.fromJson(x))),
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

class PodcastDetails {
  var id;
  var title;
  var productId;
  var productName;
  var description;
  var audioFile;
  bool? isPlaying;
  var stateId;
  var typeId;
  DateTime? createdOn;
  var createdById;

  PodcastDetails({
    this.id,
    this.title,
    this.productId,
    this.productName,
    this.description,
    this.audioFile,
    this.isPlaying,
    this.stateId,
    this.typeId,
    this.createdOn,
    this.createdById,
  });

  factory PodcastDetails.fromJson(Map<String, dynamic> json) => PodcastDetails(
        id: json["id"],
        title: json["title"],
        productId: json["product_id"],
        productName: json["product_name"],
        description: json["description"],
        audioFile: json["audio_file"],
        isPlaying: json["isPlaying"] ?? false,
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
        "product_id": productId,
        "product_name": productName,
        "description": description,
        "audio_file": audioFile,
        "isPlaying": isPlaying,
        "state_id": stateId,
        "type_id": typeId,
        "created_on": createdOn?.toIso8601String(),
        "created_by_id": createdById,
      };
}
