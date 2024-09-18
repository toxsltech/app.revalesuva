// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:health_fitness/app/modules/authentication/model/login_data_model.dart';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel {
  String? accessToken;
  LoginDataModel? detail;
  String? message;
  String? copyrights;

  LoginResponseModel({
    this.accessToken,
    this.detail,
    this.message,
    this.copyrights,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        accessToken: json["access-token"],
        detail: json["detail"] == null
            ? null
            : LoginDataModel.fromJson(json["detail"]),
        message: json["message"],
        copyrights: json["copyrights"],
      );

  Map<String, dynamic> toJson() => {
        "access-token": accessToken,
        "detail": detail?.toJson(),
        "message": message,
        "copyrights": copyrights,
      };
}
