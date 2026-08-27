import 'dart:convert';

import '../../../../../core/utils/helpers.dart';

ChangePasswordRequestModel loginRequestModelFromJson(String str) =>
    ChangePasswordRequestModel.fromJson(json.decode(str));

String loginRequestModelToJson(ChangePasswordRequestModel data) =>
    json.encode(data.toJson());

class ChangePasswordRequestModel {
  ChangePasswordRequestModel({
    required this.token,
    required this.oldPass,
    required this.newPass,
    required this.confirmNewPass,
  });

  String token;
  String oldPass;
  String newPass;
  String confirmNewPass;

  factory ChangePasswordRequestModel.fromJson(Map<String, dynamic> json) =>
      ChangePasswordRequestModel(
        token: parseString(json["token"]),
        oldPass: parseString(json["old_pass"]),
        newPass: parseString(json["new_pass"]),
        confirmNewPass: parseString(json["confirm_new_pass"]),
      );

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["token"] = token;
    data["old_pass"] = oldPass;
    data["new_pass"] = newPass;
    data["confirm_new_pass"] = confirmNewPass;
    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["token"] = token;
    data["old_pass"] = oldPass;
    data["new_pass"] = newPass;
    data["confirm_new_pass"] = confirmNewPass;

    return data;
  }
}
