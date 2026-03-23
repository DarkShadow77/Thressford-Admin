import 'dart:convert';

import '../admin_enum.dart';

UpdateAdminStatusRequestModel updateAdminStatusRequestModelFromJson(
  String str,
) => UpdateAdminStatusRequestModel.fromJson(json.decode(str));

String updateAdminStatusRequestModelToJson(
  UpdateAdminStatusRequestModel data,
) => json.encode(data.toJson());

class UpdateAdminStatusRequestModel {
  UpdateAdminStatusRequestModel({
    required this.token,
    required this.email,
    required this.status,
  });

  String token;
  String email;
  AdminStatus status;

  factory UpdateAdminStatusRequestModel.fromJson(Map<String, dynamic> json) =>
      UpdateAdminStatusRequestModel(
        // Handle potential null values
        token: json["token"] ?? "",
        email: json["email"] ?? "",
        status: AdminStatusExtension.fromString(json['status'] ?? ""),
      );

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["token"] = token;
    data["email"] = email;
    data["status"] = status.statusString;
    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["token"] = token;
    data["email"] = email;
    data["status"] = status.statusString;

    return data;
  }
}
