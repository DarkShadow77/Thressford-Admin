import 'dart:convert';

import '../../../../../core/utils/helpers.dart';
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
        token: parseString(json["token"]),
        email: parseString(json["email"]),
        status: AdminStatusExtension.fromString(parseString(json['status'])),
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
