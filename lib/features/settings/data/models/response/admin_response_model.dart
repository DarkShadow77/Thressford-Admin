class AdminModel {
  final String id;
  final String fullName;
  final String email;
  final String role;
  final String status;
  final String createdAt;
  final String? statusDate;
  final String isDeleted;

  AdminModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
    required this.status,
    required this.createdAt,
    this.statusDate,
    required this.isDeleted,
  });

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      id: json['id'] ?? "",
      fullName: json['fullname'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      status: json['status'] ?? "",
      createdAt: json['create_date'] ?? DateTime.now().toIso8601String(),
      statusDate: json['status_date'],
      isDeleted: json['is_del'] ?? '',
    );
  }

  factory AdminModel.empty() {
    return AdminModel(
      id: "",
      fullName: '',
      email: '',
      role: '',
      status: "",
      createdAt: DateTime.now().toIso8601String(),
      statusDate: null,
      isDeleted: '0',
    );
  }
}
