import 'dart:convert';

import '../referral_status_enum.dart';

UpdateReferralAppStatusRequestModel updateReferralAppStatusRequestModelFromJson(
  String str,
) => UpdateReferralAppStatusRequestModel.fromJson(json.decode(str));

String updateReferralAppStatusRequestModelToJson(
  UpdateReferralAppStatusRequestModel data,
) => json.encode(data.toJson());

class UpdateReferralAppStatusRequestModel {
  UpdateReferralAppStatusRequestModel({
    required this.token,
    required this.email,
    required this.appStat,
    required this.comment,
    required this.appDate,
  });

  String token;
  String email;
  AppReferralStatus appStat;
  String comment;
  String appDate;

  factory UpdateReferralAppStatusRequestModel.fromJson(
    Map<String, dynamic> json,
  ) => UpdateReferralAppStatusRequestModel(
    // Handle potential null values
    token: json["token"] ?? "",
    email: json["email"] ?? "",
    appStat: AppReferralStatusExtension.fromString(json['app_stat'] ?? ""),
    comment: json["comment"] ?? "",
    appDate: json["app_date"] ?? "",
  );

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["token"] = token;
    data["email"] = email;
    data["app_stat"] = appStat.statusString;
    data["comment"] = comment;
    data["app_date"] = appDate;
    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["token"] = token;
    data["email"] = email;
    data["app_stat"] = appStat.statusString;
    data["comment"] = comment;
    data["app_date"] = appDate;

    return data;
  }
}
