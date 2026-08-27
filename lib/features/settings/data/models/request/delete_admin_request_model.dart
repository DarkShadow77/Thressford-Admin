import 'dart:convert';

import '../../../../../core/utils/helpers.dart';

DeleteAdminRequestModel deleteAdminRequestModelFromJson(String str) =>
    DeleteAdminRequestModel.fromJson(json.decode(str));

String deleteAdminRequestModelToJson(DeleteAdminRequestModel data) =>
    json.encode(data.toJson());

class DeleteAdminRequestModel {
  DeleteAdminRequestModel({
    required this.token,
    required this.email,
    required this.restore,
  });

  String token;
  String email;
  bool restore;

  factory DeleteAdminRequestModel.fromJson(Map<String, dynamic> json) =>
      DeleteAdminRequestModel(
        token: parseString(json["token"]),
        email: parseString(json["email"]),
        restore: parseBool(json["restore"]),
      );

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["token"] = token;
    data["email"] = email;
    data["restore"] = restore;
    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["token"] = token;
    data["email"] = email;
    data["restore"] = restore;

    return data;
  }
}
