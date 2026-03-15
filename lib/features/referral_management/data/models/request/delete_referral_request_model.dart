import 'dart:convert';

DeleteReferralRequestModel deleteReferralRequestModelFromJson(String str) =>
    DeleteReferralRequestModel.fromJson(json.decode(str));

String deleteReferralRequestModelToJson(DeleteReferralRequestModel data) =>
    json.encode(data.toJson());

class DeleteReferralRequestModel {
  DeleteReferralRequestModel({
    required this.token,
    required this.email,
    required this.isDelete,
    required this.delDate,
  });

  String token;
  String email;
  int isDelete;
  String delDate;

  factory DeleteReferralRequestModel.fromJson(Map<String, dynamic> json) =>
      DeleteReferralRequestModel(
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
