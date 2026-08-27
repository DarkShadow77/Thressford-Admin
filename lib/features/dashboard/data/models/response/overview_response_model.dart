import '../../../../../core/utils/helpers.dart';

class OverviewModel {
  final int totalUsers;
  final int totalReferrals;
  final int pendingCommissions;
  final int paidCommissions;
  final double totalPaidSum;

  OverviewModel({
    required this.totalUsers,
    required this.totalReferrals,
    required this.pendingCommissions,
    required this.paidCommissions,
    required this.totalPaidSum,
  });

  factory OverviewModel.fromJson(Map<String, dynamic> json) {
    return OverviewModel(
      totalUsers: parseInt(json['total_users']),
      totalReferrals: parseInt(json['total_referrals']),
      pendingCommissions: parseInt(json['pending_commissions']),
      paidCommissions: parseInt(json['paid_commissions']),
      totalPaidSum: parseDouble(json['total_paid_sum']),
    );
  }

  factory OverviewModel.empty() {
    return OverviewModel(
      totalUsers: 0,
      totalReferrals: 0,
      pendingCommissions: 0,
      paidCommissions: 0,
      totalPaidSum: 0.0,
    );
  }
}
