// To parse this JSON data, do
//
//     final questionListResponseModel = questionListResponseModelFromJson(jsonString);

import 'dart:convert';

QuestionListResponseModel questionListResponseModelFromJson(String str) =>
    QuestionListResponseModel.fromJson(json.decode(str));

String questionListResponseModelToJson(QuestionListResponseModel data) =>
    json.encode(data.toJson());

class QuestionListResponseModel {
  List<QuestionList>? list;
  Links? links;
  Meta? meta;
  String? copyrights;

  QuestionListResponseModel({
    this.list,
    this.links,
    this.meta,
    this.copyrights,
  });

  factory QuestionListResponseModel.fromJson(Map<String, dynamic> json) =>
      QuestionListResponseModel(
        list: json["list"] == null
            ? []
            : List<QuestionList>.from(
                json["list"]!.map((x) => QuestionList.fromJson(x))),
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

class Links {
  First? self;
  First? first;
  First? last;

  Links({
    this.self,
    this.first,
    this.last,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: json["self"] == null ? null : First.fromJson(json["self"]),
        first: json["first"] == null ? null : First.fromJson(json["first"]),
        last: json["last"] == null ? null : First.fromJson(json["last"]),
      );

  Map<String, dynamic> toJson() => {
        "self": self?.toJson(),
        "first": first?.toJson(),
        "last": last?.toJson(),
      };
}

class First {
  String? href;

  First({
    this.href,
  });

  factory First.fromJson(Map<String, dynamic> json) => First(
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
      };
}

class QuestionList {
  int? id;
  String? title;
  int? stateId;
  int? typeId;
  DateTime? createdOn;
  int? createdById;

  QuestionList({
    this.id,
    this.title,
    this.stateId,
    this.typeId,
    this.createdOn,
    this.createdById,
  });

  factory QuestionList.fromJson(Map<String, dynamic> json) => QuestionList(
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

class Meta {
  int? totalCount;
  int? pageCount;
  int? currentPage;
  int? perPage;

  Meta({
    this.totalCount,
    this.pageCount,
    this.currentPage,
    this.perPage,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        totalCount: json["totalCount"],
        pageCount: json["pageCount"],
        currentPage: json["currentPage"],
        perPage: json["perPage"],
      );

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "pageCount": pageCount,
        "currentPage": currentPage,
        "perPage": perPage,
      };
}
