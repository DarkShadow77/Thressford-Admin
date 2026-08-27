import '../../../../../core/utils/helpers.dart';

class PaymentModel {
  final String id;
  final String fullName;
  final String email;
  final double amount;
  final String course;
  final String country;
  final String referredBy;
  final String status;
  final String createdAt;
  final String? updatedAt;

  PaymentModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.amount,
    required this.course,
    required this.country,
    required this.referredBy,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: parseString(json['id']),
      fullName: parseString(json['fullName']),
      email: parseString(json['email']),
      amount: parseDouble(json['amount']),
      course: parseString(json['course']),
      country: parseString(json['country']),
      referredBy: parseString(json['referred_by']),
      status: parseString(json['status']),
      createdAt: parseString(
        json['created_at'],
        fallback: DateTime.now().toIso8601String(),
      ),
      updatedAt: parseStringNullable(json['updated_at']),
    );
  }

  factory PaymentModel.empty() {
    return PaymentModel(
      id: "",
      fullName: '',
      email: '',
      amount: 0.0,
      course: '',
      country: '',
      referredBy: '',
      status: "",
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: null,
    );
  }
}
