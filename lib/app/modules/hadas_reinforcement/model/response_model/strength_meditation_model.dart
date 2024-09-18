// To parse this JSON data, do
//
//     final strengthMeditationResponseModel = strengthMeditationResponseModelFromJson(jsonString);

import 'dart:convert';

import '../../../authentication/model/question_list_Response.dart';
import '../data_model/video_list_data.dart';

StrengthMeditationResponseModel strengthMeditationResponseModelFromJson(
        String str) =>
    StrengthMeditationResponseModel.fromJson(json.decode(str));

String strengthMeditationResponseModelToJson(
        StrengthMeditationResponseModel data) =>
    json.encode(data.toJson());

class StrengthMeditationResponseModel {
  List<StMeVideoList>? list;
  Links? links;
  Meta? meta;
  String? copyrights;

  StrengthMeditationResponseModel({
    this.list,
    this.links,
    this.meta,
    this.copyrights,
  });

  factory StrengthMeditationResponseModel.fromJson(Map<String, dynamic> json) =>
      StrengthMeditationResponseModel(
        list: json["list"] == null
            ? []
            : List<StMeVideoList>.from(
                json["list"]!.map((x) => StMeVideoList.fromJson(x))),
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
