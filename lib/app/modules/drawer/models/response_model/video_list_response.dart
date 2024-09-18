// To parse this JSON data, do
//
//     final videoListResponseModel = videoListResponseModelFromJson(jsonString);

import 'dart:convert';

import '../../../authentication/model/question_list_Response.dart';

VideoListResponseModel videoListResponseModelFromJson(String str) =>
    VideoListResponseModel.fromJson(json.decode(str));

String videoListResponseModelToJson(VideoListResponseModel data) =>
    json.encode(data.toJson());

class VideoListResponseModel {
  List<VideoList>? list;
  Links? links;
  Meta? meta;
  String? copyrights;

  VideoListResponseModel({
    this.list,
    this.links,
    this.meta,
    this.copyrights,
  });

  factory VideoListResponseModel.fromJson(Map<String, dynamic> json) =>
      VideoListResponseModel(
        list: json["list"] == null
            ? []
            : List<VideoList>.from(
                json["list"]!.map((x) => VideoList.fromJson(x))),
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

class VideoList {
  int? id;
  String? title;
  int? planId;
  int? videoId;
  String? thumbnailFile;
  String? videoFile;
  String? description;
  int? thumbnailId;
  int? stateId;
  int? typeId;
  DateTime? createdOn;
  bool? expanded;
  var isLock;
  int? createdById;
  Review? review;

  VideoList({
    this.id,
    this.title,
    this.planId,
    this.videoId,
    this.thumbnailFile,
    this.videoFile,
    this.description,
    this.expanded,
    this.isLock,
    this.thumbnailId,
    this.stateId,
    this.typeId,
    this.createdOn,
    this.createdById,
    this.review,
  });

  factory VideoList.fromJson(Map<String, dynamic> json) => VideoList(
        id: json["id"],
        title: json["title"],
        planId: json["plan_id"],
        videoId: json["video_id"],
        thumbnailFile: json["thumbnail_file"],
        videoFile: json["video_file"],
        description: json["description"],
        expanded: json["expanded"] ?? false,
        isLock: json["is_lock"],
        thumbnailId: json["thumbnail_id"],
        stateId: json["state_id"],
        typeId: json["type_id"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(
                json["created_on"],
              ),
        createdById: json["created_by_id"],
        review: json["review"] == null ? null : Review.fromJson(json["review"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "plan_id": planId,
        "video_id": videoId,
        "thumbnail_file": thumbnailFile,
        "video_file": videoFile,
        "expanded": expanded,
        "is_lock": isLock,
        "description": description,
        "thumbnail_id": thumbnailId,
        "state_id": stateId,
        "type_id": typeId,
        "created_on": createdOn?.toIso8601String(),
        "created_by_id": createdById,
        "review": review?.toJson(),
      };
}

class Review {
  int? id;
  int? videoId;
  int? userId;
  String? startTime;
  String? endTime;
  String? remainingTime;
  String? totalTime;
  int? stateId;
  int? typeId;
  DateTime? createdOn;
  int? createdById;

  Review({
    this.id,
    this.videoId,
    this.userId,
    this.startTime,
    this.endTime,
    this.remainingTime,
    this.totalTime,
    this.stateId,
    this.typeId,
    this.createdOn,
    this.createdById,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        videoId: json["video_id"],
        userId: json["user_id"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        remainingTime: json["remaining_time"],
        totalTime: json["total_time"],
        stateId: json["state_id"],
        typeId: json["type_id"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        createdById: json["created_by_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "video_id": videoId,
        "user_id": userId,
        "start_time": startTime,
        "end_time": endTime,
        "remaining_time": remainingTime,
        "total_time": totalTime,
        "state_id": stateId,
        "type_id": typeId,
        "created_on": createdOn?.toIso8601String(),
        "created_by_id": createdById,
      };
}
