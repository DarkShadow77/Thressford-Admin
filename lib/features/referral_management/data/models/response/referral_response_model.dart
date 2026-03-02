class ReferralModel {
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final double expectedCommission;
  final String course;
  final String country;
  final String additionalNotes;
  final String? additionalNoteSubmittedAt;
  final String referredBy;
  final String referrerEmail;
  final String status;
  final String createdAt;
  final String? updatedAt;

  ReferralModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.expectedCommission,
    required this.course,
    required this.country,
    required this.additionalNotes,
    this.additionalNoteSubmittedAt,
    required this.referredBy,
    required this.referrerEmail,
    required this.status,
    required this.createdAt,
    this.updatedAt,
  });

  factory ReferralModel.fromJson(Map<String, dynamic> json) {
    return ReferralModel(
      id: json['id'] ?? "",
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      expectedCommission: json['amount'] ?? 0.0,
      course: json['course'] ?? '',
      country: json['country'] ?? '',
      additionalNotes: json['reg_comm'] ?? '',
      additionalNoteSubmittedAt:
          json['reg_comms'] ?? DateTime.now().toIso8601String(),
      referredBy: json['referred_by'] ?? '',
      referrerEmail: json['referrer_email'] ?? '',
      status: json['status'] ?? "",
      createdAt: json['created_at'] ?? DateTime.now().toIso8601String(),
      updatedAt: json['updated_at'],
    );
  }

  factory ReferralModel.empty() {
    return ReferralModel(
      id: "",
      fullName: '',
      email: '',
      phone: '',
      expectedCommission: 0.0,
      course: '',
      country: '',
      additionalNotes: '',
      additionalNoteSubmittedAt: DateTime.now().toIso8601String(),
      referredBy: '',
      referrerEmail: '',
      status: "",
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: null,
    );
  }
}
