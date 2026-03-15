import 'dart:convert';

DeleteUserRequestModel deleteUserRequestModelFromJson(String str) =>
    DeleteUserRequestModel.fromJson(json.decode(str));

String deleteUserRequestModelToJson(DeleteUserRequestModel data) =>
    json.encode(data.toJson());

class DeleteUserRequestModel {
  DeleteUserRequestModel({
    required this.token,
    required this.email,
    required this.isDelete,
    required this.delDate,
  });

  String token;
  String email;
  int isDelete;
  String delDate;

  factory DeleteUserRequestModel.fromJson(Map<String, dynamic> json) =>
      DeleteUserRequestModel(
        // Handle potential null values
        token: json["token"] ?? "",
        email: json["email"] ?? "",
        isDelete: json["is_delete"] ?? "",
        delDate: json["del_date"] ?? "",
      );

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["token"] = token;
    data["email"] = email;
    data["is_delete"] = isDelete;
    data["del_date"] = delDate;
    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["token"] = token;
    data["email"] = email;
    data["is_delete"] = isDelete;
    data["del_date"] = delDate;

    return data;
  }
}
