// To parse this JSON data, do
//
//     final checkUserApiResponseModel = checkUserApiResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:health_fitness/app/modules/authentication/model/login_data_model.dart';

CheckUserApiResponseModel checkUserApiResponseModelFromJson(String str) =>
    CheckUserApiResponseModel.fromJson(json.decode(str));

String checkUserApiResponseModelToJson(CheckUserApiResponseModel data) =>
    json.encode(data.toJson());

class CheckUserApiResponseModel {
  LoginDataModel? detail;
  String? copyrights;

  CheckUserApiResponseModel({
    this.detail,
    this.copyrights,
  });

  factory CheckUserApiResponseModel.fromJson(Map<String, dynamic> json) =>
      CheckUserApiResponseModel(
        detail: json["detail"] == null
            ? null
            : LoginDataModel.fromJson(json["detail"]),
        copyrights: json["copyrights"],
      );

  Map<String, dynamic> toJson() => {
        "detail": detail?.toJson(),
        "copyrights": copyrights,
      };
}
