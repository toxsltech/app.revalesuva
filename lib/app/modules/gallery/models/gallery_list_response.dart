// To parse this JSON data, do
//
//     final galleryListResponseModel = galleryListResponseModelFromJson(jsonString);

import 'dart:convert';

import '../../authentication/model/question_list_Response.dart';

GalleryListResponseModel galleryListResponseModelFromJson(String str) =>
    GalleryListResponseModel.fromJson(json.decode(str));

String galleryListResponseModelToJson(GalleryListResponseModel data) =>
    json.encode(data.toJson());

class GalleryListResponseModel {
  List<GalleryList>? list;
  Links? links;
  Meta? meta;
  String? copyrights;

  GalleryListResponseModel({
    this.list,
    this.links,
    this.meta,
    this.copyrights,
  });

  factory GalleryListResponseModel.fromJson(Map<String, dynamic> json) =>
      GalleryListResponseModel(
        list: json["list"] == null
            ? []
            : List<GalleryList>.from(
                json["list"]!.map((x) => GalleryList.fromJson(x))),
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

class GalleryList {
  int? id;
  String? title;
  String? thumbnailFile;
  int? typeId;
  int? stateId;
  DateTime? createdOn;
  int? createdById;

  GalleryList({
    this.id,
    this.title,
    this.thumbnailFile,
    this.typeId,
    this.stateId,
    this.createdOn,
    this.createdById,
  });

  factory GalleryList.fromJson(Map<String, dynamic> json) => GalleryList(
        id: json["id"],
        title: json["title"],
        thumbnailFile: json["thumbnail_file"],
        typeId: json["type_id"],
        stateId: json["state_id"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        createdById: json["created_by_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "thumbnail_file": thumbnailFile,
        "type_id": typeId,
        "state_id": stateId,
        "created_on": createdOn?.toIso8601String(),
        "created_by_id": createdById,
      };
}
