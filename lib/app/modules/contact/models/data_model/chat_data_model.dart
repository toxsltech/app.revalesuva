class ChatDataModel {
  var id;
  var message;
  var fromId;
  var toId;
  var fromName;
  var toName;
  var readers;
  dynamic requestId;
  var createdOn;
  var isRead;
  var stateId;
  var fromUserProfileFile;
  var toUserProfileFile;
  bool? messageStatus;
  var typeId;
  dynamic notifiedUsers;
  DateTime? sendOn;

  ChatDataModel({
    this.id,
    this.message,
    this.fromId,
    this.toId,
    this.fromName,
    this.toName,
    this.readers,
    this.requestId,
    this.createdOn,
    this.isRead,
    this.stateId,
    this.fromUserProfileFile,
    this.toUserProfileFile,
    this.messageStatus,
    this.typeId,
    this.notifiedUsers,
    this.sendOn,
  });

  factory ChatDataModel.fromJson(Map<String, dynamic> json) => ChatDataModel(
        id: json["id"],
        message: json["message"],
        fromId: json["from_id"],
        toId: json["to_id"],
        fromName: json["from_name"],
        toName: json["to_name"],
        readers: json["readers"],
        requestId: json["request_id"],
        createdOn: json["created_on"],
        isRead: json["is_read"],
        stateId: json["state_id"],
        fromUserProfileFile: json["from_user_profile_file"],
        toUserProfileFile: json["to_user_profile_file"],
        messageStatus: json["message_status"],
        typeId: json["type_id"],
        notifiedUsers: json["notified_users"],
        sendOn:
            json["send_on"] == null ? null : DateTime.parse(json["send_on"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
        "from_id": fromId,
        "to_id": toId,
        "from_name": fromName,
        "to_name": toName,
        "readers": readers,
        "request_id": requestId,
        "created_on": createdOn,
        "is_read": isRead,
        "state_id": stateId,
        "from_user_profile_file": fromUserProfileFile,
        "to_user_profile_file": toUserProfileFile,
        "message_status": messageStatus,
        "type_id": typeId,
        "notified_users": notifiedUsers,
        "send_on": sendOn?.toIso8601String(),
      };
}
