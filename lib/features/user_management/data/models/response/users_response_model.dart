import 'dart:ui';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/helpers.dart';
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
      id: parseString(json['id']),
      fullName: parseString(json['fullname']),
      email: parseString(json['email']),
      phone: parseString(json['number']),
      createdAt: parseString(
        json['reg_date'],
        fallback: DateTime.now().toIso8601String(),
      ),
      updatedAt: parseStringNullable(json['mod_date']),
      bankName: parseString(json['bank_name']),
      acctNo: parseString(json['acc_no']),
      acctName: parseString(json['acc_name']),
      profilePic: parseString(json['profile_pic']),
      status: UsersStatusExtension.fromString(
        parseString(json['status'], fallback: "inactive"),
      ),
      verifyStat: parseString(json['verify_stat']),
      totalReferrals: parseInt(json['total_referrals']),
      totalEarnings: parseInt(json['total_earnings']),
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
