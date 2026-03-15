import 'dart:convert';

import 'package:thressford_admin/features/user_management/data/models/users_management_status_enum.dart';

UpdateUserStatusRequestModel updateUserStatusRequestModelFromJson(String str) =>
    UpdateUserStatusRequestModel.fromJson(json.decode(str));

String updateUserStatusRequestModelToJson(UpdateUserStatusRequestModel data) =>
    json.encode(data.toJson());

class UpdateUserStatusRequestModel {
  UpdateUserStatusRequestModel({
    required this.token,
    required this.email,
    required this.status,
    required this.modDate,
  });

  String token;
  String email;
  UsersStatus status;
  String modDate;

  factory UpdateUserStatusRequestModel.fromJson(Map<String, dynamic> json) =>
      UpdateUserStatusRequestModel(
        // Handle potential null values
        token: json["token"] ?? "",
        email: json["email"] ?? "",
        status: UsersStatusExtension.fromString(json['status'] ?? ""),
        modDate: json["mod_date"] ?? "",
      );

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["token"] = token;
    data["email"] = email;
    data["status"] = status.statusString;
    data["mod_date"] = modDate;
    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["token"] = token;
    data["email"] = email;
    data["status"] = status.statusString;
    data["mod_date"] = modDate;

    return data;
  }
}
