import 'dart:ui';

import '../../../../../core/constants/app_colors.dart';
import '../transaction_enums.dart';

class TransactionModel {
  final String id;
  final String userId;
  final PaymentType type;
  final double amount;
  final PaymentStatus status;
  final String? referenceId;
  final String description;
  final String createdAt;
  final String? updatedAt;

  TransactionModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.amount,
    required this.status,
    this.referenceId,
    required this.description,
    required this.createdAt,
    this.updatedAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      type: PaymentTypeExtension.fromString(json['type'] ?? ''),
      amount: double.tryParse(json['amount'].toString()) ?? 0.0,
      status: PaymentStatusExtension.fromString(json['status'] ?? ''),
      referenceId: json['reference_id'],
      description: json['description'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'],
    );
  }

  factory TransactionModel.empty() {
    return TransactionModel(
      id: '',
      userId: '',
      type: PaymentType.withdrawal,
      amount: 0.0,
      status: PaymentStatus.pending,
      referenceId: null,
      description: '',
      createdAt: '',
      updatedAt: null,
    );
  }

  bool get isCredit => amount > 0;
  bool get isDebit => amount < 0;
  double get absAmount => amount.abs();

  Color getTransactionStatusColor() {
    return switch (status) {
      PaymentStatus.approved => AppColors.green,
      PaymentStatus.pending => AppColors.orange,
      PaymentStatus.rejected => AppColors.error,
    };
  }
}
