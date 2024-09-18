class StMeVideoList {
  var id;
  var title;
  var video;
  var stateId;
  var typeId;
  DateTime? createdOn;
  var createdById;

  StMeVideoList({
    this.id,
    this.title,
    this.video,
    this.stateId,
    this.typeId,
    this.createdOn,
    this.createdById,
  });

  factory StMeVideoList.fromJson(Map<String, dynamic> json) => StMeVideoList(
        id: json["id"],
        title: json["title"],
        video: json["video"],
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
        "video": video,
        "state_id": stateId,
        "type_id": typeId,
        "created_on": createdOn?.toIso8601String(),
        "created_by_id": createdById,
      };
}
