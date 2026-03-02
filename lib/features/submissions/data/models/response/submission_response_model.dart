class SubmissionModel {
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final String course;
  final String country;
  final String referredBy;
  final String referrerEmail;
  final String status;
  final String createdAt;
  final String? updatedAt;

  SubmissionModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.course,
    required this.country,
    required this.referredBy,
    required this.referrerEmail,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SubmissionModel.fromJson(Map<String, dynamic> json) {
    return SubmissionModel(
      id: json['id'] ?? "",
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      phone: json['email'] ?? '',
      course: json['course'] ?? '',
      country: json['country'] ?? '',
      referredBy: json['referred_by'] ?? '',
      referrerEmail: json['referrer_email'] ?? '',
      status: json['status'] ?? "",
      createdAt: json['created_at'] ?? DateTime.now().toIso8601String(),
      updatedAt: json['updated_at'],
    );
  }

  factory SubmissionModel.empty() {
    return SubmissionModel(
      id: "",
      fullName: '',
      email: '',
      phone: '',
      course: '',
      country: '',
      referredBy: '',
      referrerEmail: '',
      status: "",
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: null,
    );
  }
}
