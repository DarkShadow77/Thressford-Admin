// ─── Payment Type ──────────────────────────────────────────
enum PaymentType { withdrawal, withdrawalFee, commission }

extension PaymentTypeExtension on PaymentType {
  String get statusString => switch (this) {
    PaymentType.withdrawal => 'Withdrawal',
    PaymentType.withdrawalFee => 'Withdrawal Fee',
    PaymentType.commission => 'Commission',
  };

  static PaymentType fromString(String value) => switch (value.toLowerCase()) {
    'withdrawal' => PaymentType.withdrawal,
    'withdrawal_fee' => PaymentType.withdrawalFee,
    'commission' => PaymentType.commission,
    _ => PaymentType.withdrawal,
  };
}

// ─── Payment Status ────────────────────────────────────────
enum PaymentStatus { pending, approved, rejected }

extension PaymentStatusExtension on PaymentStatus {
  String get statusString => switch (this) {
    PaymentStatus.pending => 'pending',
    PaymentStatus.approved => 'approved',
    PaymentStatus.rejected => 'rejected',
  };

  static PaymentStatus fromString(String value) =>
      switch (value.toLowerCase()) {
        'pending' => PaymentStatus.pending,
        'approved' => PaymentStatus.approved,
        'rejected' => PaymentStatus.rejected,
        _ => PaymentStatus.pending,
      };
}
