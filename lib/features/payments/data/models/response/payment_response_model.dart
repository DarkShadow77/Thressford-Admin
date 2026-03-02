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
      id: json['id'] ?? "",
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      amount: json['amount'] ?? 0.0,
      course: json['course'] ?? '',
      country: json['country'] ?? '',
      referredBy: json['referred_by'] ?? '',
      status: json['status'] ?? "",
      createdAt: json['created_at'] ?? DateTime.now().toIso8601String(),
      updatedAt: json['updated_at'],
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
