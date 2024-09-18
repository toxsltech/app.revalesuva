// To parse this JSON data, do
//
//     final chatMessageResponse = chatMessageResponseFromJson(jsonString);

import 'dart:convert';

import 'data_model/chat_data_model.dart';

ChatMessageResponse chatMessageResponseFromJson(String str) =>
    ChatMessageResponse.fromJson(json.decode(str));

String chatMessageResponseToJson(ChatMessageResponse data) =>
    json.encode(data.toJson());

class ChatMessageResponse {
  List<ChatDataModel>? list;
  String? copyrights;

  ChatMessageResponse({
    this.list,
    this.copyrights,
  });

  factory ChatMessageResponse.fromJson(Map<String, dynamic> json) =>
      ChatMessageResponse(
        list: json["list"] == null
            ? []
            : List<ChatDataModel>.from(
                json["list"]!.map((x) => ChatDataModel.fromJson(x))),
        copyrights: json["copyrights"],
      );

  Map<String, dynamic> toJson() => {
        "list": list == null
            ? []
            : List<dynamic>.from(list!.map((x) => x.toJson())),
        "copyrights": copyrights,
      };
}
