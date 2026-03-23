enum EnrollReferralStatus {
  referred,
  contacted,
  applicationStarted,
  documentSubmitted,
  offerIssued,
  visaProcessing,
  visaApproved,
  enrolled,
  paid,
  cancelled,
}

extension EnrollReferralStatusExtension on EnrollReferralStatus {
  String get statusString {
    switch (this) {
      case EnrollReferralStatus.referred:
        return 'referred';
      case EnrollReferralStatus.contacted:
        return 'contacted';
      case EnrollReferralStatus.applicationStarted:
        return 'application started';
      case EnrollReferralStatus.documentSubmitted:
        return 'document submitted';
      case EnrollReferralStatus.offerIssued:
        return 'offer issued';
      case EnrollReferralStatus.visaProcessing:
        return 'visa processing';
      case EnrollReferralStatus.visaApproved:
        return 'visa approved';
      case EnrollReferralStatus.enrolled:
        return 'enrolled';
      case EnrollReferralStatus.paid:
        return 'paid';
      case EnrollReferralStatus.cancelled:
        return 'cancelled';
    }
  }

  static EnrollReferralStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'referred':
        return EnrollReferralStatus.referred;
      case 'contacted':
        return EnrollReferralStatus.contacted;
      case 'application started':
        return EnrollReferralStatus.applicationStarted;
      case 'document submitted':
        return EnrollReferralStatus.documentSubmitted;
      case 'offer issued':
        return EnrollReferralStatus.offerIssued;
      case 'visa processing':
        return EnrollReferralStatus.visaProcessing;
      case 'visa approved':
        return EnrollReferralStatus.visaApproved;
      case 'enrolled':
        return EnrollReferralStatus.enrolled;
      case 'cancelled':
        return EnrollReferralStatus.cancelled;
      case 'paid':
        return EnrollReferralStatus.paid;
      default:
        return EnrollReferralStatus.referred;
    }
  }
}

enum AppReferralStatus { pending, rejected, approved }

extension AppReferralStatusExtension on AppReferralStatus {
  String get statusString {
    switch (this) {
      case AppReferralStatus.pending:
        return 'pending';
      case AppReferralStatus.rejected:
        return 'rejected';
      case AppReferralStatus.approved:
        return 'approved';
    }
  }

  static AppReferralStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return AppReferralStatus.pending;
      case 'rejected':
        return AppReferralStatus.rejected;
      case 'approved':
        return AppReferralStatus.approved;
      default:
        return AppReferralStatus.pending;
    }
  }
}

enum CommissionStatus { pending, cancelled, paid }

extension CommissionStatusExtension on CommissionStatus {
  String get statusString {
    switch (this) {
      case CommissionStatus.pending:
        return 'pending';
      case CommissionStatus.cancelled:
        return 'cancelled';
      case CommissionStatus.paid:
        return 'paid';
    }
  }

  static CommissionStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return CommissionStatus.pending;
      case 'cancelled':
        return CommissionStatus.cancelled;
      case 'paid':
        return CommissionStatus.paid;
      default:
        return CommissionStatus.pending;
    }
  }
}
