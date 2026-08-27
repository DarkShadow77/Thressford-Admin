import 'dart:convert';

import '../../../../../core/utils/helpers.dart';

LoginRequestModel loginRequestModelFromJson(String str) =>
    LoginRequestModel.fromJson(json.decode(str));

String loginRequestModelToJson(LoginRequestModel data) =>
    json.encode(data.toJson());

class LoginRequestModel {
  LoginRequestModel({required this.email, required this.password});

  String email;
  String password;

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      LoginRequestModel(
        email: parseString(json["email"]),
        password: parseString(json["password"]),
      );

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["email"] = email;
    data["password"] = password;
    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["email"] = email;
    data["password"] = password;

    return data;
  }
}
