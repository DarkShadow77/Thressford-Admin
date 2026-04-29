import 'dart:convert';

import 'package:thressford_admin/features/referral_management/data/models/referral_status_enum.dart';

UpdateCommissionStatusRequestModel updateCommissionStatusRequestModelFromJson(
  String str,
) => UpdateCommissionStatusRequestModel.fromJson(json.decode(str));

String updateCommissionStatusRequestModelToJson(
  UpdateCommissionStatusRequestModel data,
) => json.encode(data.toJson());

class UpdateCommissionStatusRequestModel {
  UpdateCommissionStatusRequestModel({
    required this.token,
    required this.email,
    required this.status,
    required this.note,
  });

  String token;
  String email;
  CommissionStatus status;
  String note;

  factory UpdateCommissionStatusRequestModel.fromJson(
    Map<String, dynamic> json,
  ) => UpdateCommissionStatusRequestModel(
    // Handle potential null values
    token: json["token"] ?? "",
    email: json["email"] ?? "",
    status: CommissionStatusExtension.fromString(json['status'] ?? ""),
    note: json["note"] ?? "",
  );

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["token"] = token;
    data["email"] = email;
    data["status"] = status.statusString;
    data["note"] = note;
    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["token"] = token;
    data["email"] = email;
    data["status"] = status.statusString;
    data["note"] = note;
    return data;
  }
}
