import 'dart:convert';

import '../../../../../core/utils/helpers.dart';
import '../referral_status_enum.dart';

UpdateEnrollStatusRequestModel updateEnrollStatusRequestModelFromJson(
  String str,
) => UpdateEnrollStatusRequestModel.fromJson(json.decode(str));

String updateEnrollStatusRequestModelToJson(
  UpdateEnrollStatusRequestModel data,
) => json.encode(data.toJson());

class UpdateEnrollStatusRequestModel {
  UpdateEnrollStatusRequestModel({
    required this.token,
    required this.email,
    required this.status,
    required this.comment,
    required this.enrollDate,
  });

  String token;
  String email;
  EnrollReferralStatus status;
  String comment;
  String enrollDate;

  factory UpdateEnrollStatusRequestModel.fromJson(Map<String, dynamic> json) =>
      UpdateEnrollStatusRequestModel(
        token: parseString(json["token"]),
        email: parseString(json["email"]),
        status: EnrollReferralStatusExtension.fromString(
          parseString(json['status']),
        ),
        comment: parseString(json["comment"]),
        enrollDate: parseString(json["enroll_date"]),
      );

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["token"] = token;
    data["email"] = email;
    data["status"] = status.statusString;
    data["comment"] = comment;
    data["enroll_date"] = enrollDate;
    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["token"] = token;
    data["email"] = email;
    data["status"] = status.statusString;
    data["comment"] = comment;
    data["enroll_date"] = enrollDate;

    return data;
  }
}
