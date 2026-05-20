import 'dart:ui';

import '../../../../../core/constants/app_colors.dart';
import '../referral_status_enum.dart';

class ReferralModel {
  final String id;
  final String referer;
  final String fullName;
  final String email;
  final String phone;
  final String expectedCommission;
  final String course;
  final String country;
  final String adminAppNote;
  final String adminEnrollNote;
  final String additionalNotes;
  final String commissionNote;
  final String? additionalNoteSubmittedAt;
  final String referredBy;
  final String referrerEmail;
  final EnrollReferralStatus enrollStatus;
  final AppReferralStatus appStatus;
  final CommissionStatus commissionStatus;
  final String createdAt;
  final String? updatedAt;
  final String? enrollModDate;

  ReferralModel({
    required this.id,
    required this.referer,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.expectedCommission,
    required this.course,
    required this.country,
    required this.adminAppNote,
    required this.adminEnrollNote,
    required this.additionalNotes,
    required this.commissionNote,
    this.additionalNoteSubmittedAt,
    required this.referredBy,
    required this.referrerEmail,
    required this.enrollStatus,
    required this.appStatus,
    required this.commissionStatus,
    required this.createdAt,
    this.updatedAt,
    this.enrollModDate,
  });

  factory ReferralModel.fromJson(Map<String, dynamic> json) {
    return ReferralModel(
      id: json['id'] ?? "",
      referer: json['referer'] ?? "",
      fullName: json['fullname'] ?? '',
      email: json['email'] ?? '',
      phone: json['number'] ?? '',
      expectedCommission: json['comm'] ?? "0",
      course: json['course'] ?? '',
      country: json['country'] ?? '',
      adminAppNote: json['app_com'] ?? "",
      adminEnrollNote: json['enroll_com'] ?? "",
      additionalNotes: json['reg_comm'] ?? '',
      commissionNote: json['note'] ?? '',
      additionalNoteSubmittedAt:
          json['reg_date'] ?? DateTime.now().toIso8601String(),
      referredBy: json['referer_name'] ?? '',
      referrerEmail: json['referer_email'] ?? '',
      enrollStatus: EnrollReferralStatusExtension.fromString(
        json['enroll_stat'] ?? "",
      ),
      appStatus: AppReferralStatusExtension.fromString(json['app_stat'] ?? ""),
      commissionStatus: CommissionStatusExtension.fromString(
        json['comm_stat'] ?? "",
      ),
      createdAt: json['reg_date'] ?? DateTime.now().toIso8601String(),
      updatedAt: json['mod_date'],
      enrollModDate: json['enroll_mod_date'],
    );
  }

  factory ReferralModel.empty() {
    return ReferralModel(
      id: "",
      referer: "",
      fullName: '',
      email: '',
      phone: '',
      expectedCommission: "0.0",
      course: '',
      country: '',
      adminAppNote: "",
      adminEnrollNote: "",
      additionalNotes: '',
      commissionNote: '',
      additionalNoteSubmittedAt: DateTime.now().toIso8601String(),
      referredBy: '',
      referrerEmail: '',
      enrollStatus: EnrollReferralStatus.referred,
      appStatus: AppReferralStatus.pending,
      commissionStatus: CommissionStatus.pending,
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: null,
      enrollModDate: null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'referer': referer,
      'fullname': fullName,
      'email': email,
      'number': phone,
      'comm': expectedCommission,
      'course': course,
      'country': country,
      'app_com': adminAppNote,
      'enroll_com': adminEnrollNote,
      'reg_comm': additionalNotes,
      'note': commissionNote,
      'reg_date': additionalNoteSubmittedAt,
      'referer_name': referredBy,
      'referer_email': referrerEmail,
      'enroll_stat': enrollStatus.statusString,
      'app_stat': appStatus.statusString,
      'comm_stat': commissionStatus.statusString,
      'mod_date': updatedAt,
      'enroll_mod_date': enrollModDate,
    };
  }

  static Color getEnrollStatusColor(EnrollReferralStatus status) {
    return switch (status) {
      EnrollReferralStatus.referred => AppColors.dynamic,
      EnrollReferralStatus.contacted => AppColors.green,
      EnrollReferralStatus.documentSubmitted => AppColors.dynamic,
      EnrollReferralStatus.applicationStarted => AppColors.orange,
      EnrollReferralStatus.offerIssued => AppColors.green,
      EnrollReferralStatus.visaProcessing => AppColors.orange,
      EnrollReferralStatus.visaApproved => AppColors.green,
      EnrollReferralStatus.visaRejected => AppColors.error,
      EnrollReferralStatus.enrolled => AppColors.dynamic,
      EnrollReferralStatus.cancelled => AppColors.dynamic,
      EnrollReferralStatus.paid => AppColors.primary,
    };
  }

  Color getAppStatusColor() {
    return switch (appStatus) {
      AppReferralStatus.pending => AppColors.orange,
      AppReferralStatus.approved => AppColors.green,
      AppReferralStatus.denied => AppColors.error,
    };
  }

  Color getCommissionStatusColor() {
    return switch (commissionStatus) {
      CommissionStatus.pending => AppColors.orange,
      CommissionStatus.paid => AppColors.primary,
      CommissionStatus.cancelled => AppColors.dynamic,
      CommissionStatus.reversed => AppColors.blue,
    };
  }

  static List<String> getEnrollStatuses() {
    return EnrollReferralStatus.values
        .map((status) => status.statusString)
        .toList();
  }
}
