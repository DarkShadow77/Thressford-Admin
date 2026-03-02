class AuthUrl {
  static const String login = "public/login.php";
  static const String register = "public/register.php";
  static const String resendOtp = "public/resend-otp.php";
  static const String verifyOtp = "public/verify-otp.php";
  static const String forgotPassword = "public/forgot-password-otp.php";
  static const String verifyForgotPassword = "public/verify-forgot-otp.php";
  static const String resetPassword = "public/reset-password.php";
}

class HomeUrl {
  static const String getNotifications = "public/all-notifications.php";
}

class ProfileUrl {
  static const String getProfile = "public/profile.php";
  static const String updateProfile = "public/update-profile.php";
  static const String addBankDetails = "public/add-bank-details.php";
  static const String changePassword = "public/change-password.php";
}

class ReferralUrl {
  static const String getReferrals = "public/all-referals.php";
  static const String addReferrals = "public/add-referal.php";
}

class WalletUrl {
  static const String getSummary = "public/wallet/summary.php";
  static const String requestWithdrawal =
      "public/wallet/request-withdrawal.php";
  static const String getTransactionHistory = "public/wallet/transactions.php";
}

class NotificationUrl {
  static const String getNotification = "public/all-notifications.php";
}
