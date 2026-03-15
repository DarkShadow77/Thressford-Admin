import 'dart:ui';

import '../../../../../core/constants/app_colors.dart';
import '../users_management_status_enum.dart';

class UsersModel {
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final String createdAt;
  final String? updatedAt;
  final String bankName;
  final String acctNo;
  final String acctName;
  final String profilePic;
  final UsersStatus status;
  final String verifyStat;
  final int totalReferrals;
  final int totalEarnings;

  UsersModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.createdAt,
    this.updatedAt,
    required this.bankName,
    required this.acctNo,
    required this.acctName,
    required this.profilePic,
    required this.status,
    required this.verifyStat,
    required this.totalReferrals,
    required this.totalEarnings,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
      id: json['id'] ?? "",
      fullName: json['fullname'] ?? '',
      email: json['email'] ?? '',
      phone: json['number'] ?? '',
      createdAt: json['reg_date'] ?? DateTime.now().toIso8601String(),
      updatedAt: json['mod_date'],
      bankName: json['bank_name'] ?? "",
      acctNo: json['acc_no'] ?? "",
      acctName: json['acc_name'] ?? "",
      profilePic: json['profile_pic'] ?? "",
      status: UsersStatusExtension.fromString(json['status'] ?? "inactive"),
      verifyStat: json['verify_stat'] ?? "",
      totalReferrals: json['total_referrals'] ?? 0,
      totalEarnings: json['total_earnings'] ?? 0,
    );
  }

  factory UsersModel.empty() {
    return UsersModel(
      id: "",
      fullName: '',
      email: '',
      phone: '',
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: null,
      bankName: "",
      acctNo: "",
      acctName: "",
      profilePic: "",
      status: UsersStatus.inactive,
      verifyStat: "",
      totalReferrals: 0,
      totalEarnings: 0,
    );
  }

  Color getUsersStatusColor() {
    return switch (status) {
      UsersStatus.active => AppColors.green,
      UsersStatus.inactive => AppColors.dynamic,
      UsersStatus.suspended => AppColors.error,
    };
  }
}
