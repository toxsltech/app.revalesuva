class ArticleDataModel {
  int? id;
  String? title;
  String? description;
  String? thumbnailFile;
  String? videoFile;
  int? typeId;
  int? stateId;
  DateTime? createdOn;
  int? createdById;

  ArticleDataModel({
    this.id,
    this.title,
    this.description,
    this.thumbnailFile,
    this.videoFile,
    this.typeId,
    this.stateId,
    this.createdOn,
    this.createdById,
  });

  factory ArticleDataModel.fromJson(Map<String, dynamic> json) =>
      ArticleDataModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        thumbnailFile: json["thumbnail_file"],
        videoFile: json["video_file"],
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
        "description": description,
        "thumbnail_file": thumbnailFile,
        "video_file": videoFile,
        "type_id": typeId,
        "state_id": stateId,
        "created_on": createdOn?.toIso8601String(),
        "created_by_id": createdById,
      };
}
