// To parse this JSON data, do
//
//     final sendMessageResponse = sendMessageResponseFromJson(jsonString);

import 'dart:convert';

import 'package:health_fitness/app/modules/contact/models/data_model/chat_data_model.dart';

SendMessageResponse sendMessageResponseFromJson(String str) =>
    SendMessageResponse.fromJson(json.decode(str));

String sendMessageResponseToJson(SendMessageResponse data) =>
    json.encode(data.toJson());

class SendMessageResponse {
  ChatDataModel? detail;
  String? message;
  String? copyrights;

  SendMessageResponse({
    this.detail,
    this.message,
    this.copyrights,
  });

  factory SendMessageResponse.fromJson(Map<String, dynamic> json) =>
      SendMessageResponse(
        detail: json["detail"] == null
            ? null
            : ChatDataModel.fromJson(json["detail"]),
        message: json["message"],
        copyrights: json["copyrights"],
      );

  Map<String, dynamic> toJson() => {
        "detail": detail?.toJson(),
        "message": message,
        "copyrights": copyrights,
      };
}
