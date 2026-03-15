import 'dart:convert';

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
        // Handle potential null values
        token: json["token"] ?? "",
        email: json["email"] ?? "",
        restore: json["restore"] ?? false,
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
