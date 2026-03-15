import 'dart:convert';

AddAdminRequestModel addAdminRequestModelFromJson(String str) =>
    AddAdminRequestModel.fromJson(json.decode(str));

String addAdminRequestModelToJson(AddAdminRequestModel data) =>
    json.encode(data.toJson());

class AddAdminRequestModel {
  AddAdminRequestModel({
    required this.token,
    required this.email,
    required this.password,
    required this.fullName,
    required this.role,
  });

  String token;
  String email;
  String password;
  String fullName;
  String role;

  factory AddAdminRequestModel.fromJson(Map<String, dynamic> json) =>
      AddAdminRequestModel(
        // Handle potential null values
        token: json["token"] ?? "",
        email: json["email"] ?? "",
        password: json["password"] ?? "",
        fullName: json["fullname"] ?? "",
        role: json["role"] ?? "",
      );

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["token"] = token;
    data["email"] = email;
    data["password"] = password;
    data["fullname"] = fullName;
    data["role"] = role;
    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["token"] = token;
    data["email"] = email;
    data["password"] = password;
    data["fullname"] = fullName;
    data["role"] = role;

    return data;
  }
}
