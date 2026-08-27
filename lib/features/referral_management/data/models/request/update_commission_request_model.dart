import 'dart:convert';

import '../../../../../core/utils/helpers.dart';

UpdateCommissionRequestModel updateCommissionRequestModelFromJson(String str) =>
    UpdateCommissionRequestModel.fromJson(json.decode(str));

String updateCommissionRequestModelToJson(UpdateCommissionRequestModel data) =>
    json.encode(data.toJson());

class UpdateCommissionRequestModel {
  UpdateCommissionRequestModel({
    required this.token,
    required this.email,
    required this.comm,
    required this.commDate,
  });

  String token;
  String email;
  int comm;
  String commDate;

  factory UpdateCommissionRequestModel.fromJson(Map<String, dynamic> json) =>
      UpdateCommissionRequestModel(
        token: parseString(json["token"]),
        email: parseString(json["email"]),
        comm: parseInt(json["comm"]),
        commDate: parseString(json["comm_date"]),
      );

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["token"] = token;
    data["email"] = email;
    data["comm"] = comm;
    data["comm_date"] = commDate;
    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["token"] = token;
    data["email"] = email;
    data["comm"] = comm;
    data["comm_date"] = commDate;

    return data;
  }
}
