import 'dart:convert';

import '../transaction_enums.dart';

UpdateTransactionStatusRequestModel updateTransactionStatusRequestModelFromJson(
  String str,
) => UpdateTransactionStatusRequestModel.fromJson(json.decode(str));

String updateTransactionStatusRequestModelToJson(
  UpdateTransactionStatusRequestModel data,
) => json.encode(data.toJson());

class UpdateTransactionStatusRequestModel {
  UpdateTransactionStatusRequestModel({
    required this.token,
    required this.transactionId,
    required this.status,
  });

  String token;
  String transactionId;
  PaymentStatus status;

  factory UpdateTransactionStatusRequestModel.fromJson(
    Map<String, dynamic> json,
  ) => UpdateTransactionStatusRequestModel(
    // Handle potential null values
    token: json["token"] ?? "",
    transactionId: json["transaction_id"] ?? "",
    status: PaymentStatusExtension.fromString(json['status'] ?? ""),
  );

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["token"] = token;
    data["transaction_id"] = transactionId;
    data["status"] = status.statusString;
    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["token"] = token;
    data["transaction_id"] = transactionId;
    data["status"] = status.statusString;

    return data;
  }
}
