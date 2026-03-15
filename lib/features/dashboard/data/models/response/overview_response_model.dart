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
      totalUsers: json['total_users'] ?? 0,
      totalReferrals: json['total_referrals'] ?? 0,
      pendingCommissions: json['pending_commissions'] ?? 0,
      paidCommissions: json['paid_commissions'] ?? 0,
      totalPaidSum: double.parse((json['total_paid_sum'] ?? 0.0).toString()),
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
