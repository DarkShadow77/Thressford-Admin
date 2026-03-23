import 'dart:ui';

import 'package:thressford_admin/features/settings/data/models/admin_enum.dart';

import '../../../../../core/constants/app_colors.dart';

class AdminModel {
  final String id;
  final String fullName;
  final String email;
  final AdminRole role;
  final AdminStatus status;
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
      role: AdminRoleExtension.fromString(json['role'] ?? ""),
      status: AdminStatusExtension.fromString(json['status'] ?? ""),
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
      role: AdminRole.admin,
      status: AdminStatus.active,
      createdAt: DateTime.now().toIso8601String(),
      statusDate: null,
      isDeleted: '0',
    );
  }

  Color getAdminStatusColor() {
    return switch (status) {
      AdminStatus.active => AppColors.green,
      AdminStatus.inactive => AppColors.orange,
    };
  }
}
