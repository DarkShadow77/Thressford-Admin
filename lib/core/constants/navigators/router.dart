import 'package:flutter/material.dart';
import 'package:thressford_admin/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:thressford_admin/features/payments/presentation/pages/payment_page.dart';
import 'package:thressford_admin/features/settings/presentation/pages/create_admin_page.dart';
import 'package:thressford_admin/features/settings/presentation/pages/manage_admin_page.dart';

import '../../../app/view/pages/successful_page.dart';
import '../../../features/auth/presentation/pages/login_page.dart';
import '../../../features/onboarding/presentation/pages/splash_screen_page.dart';
import '../../../features/referral_management/presentation/pages/referral_management_details_page.dart';
import '../../../features/referral_management/presentation/pages/referral_management_page.dart';
import '../../../features/report/presentation/pages/report_page.dart';
import '../../../features/settings/presentation/pages/change_password_page.dart';
import '../../../features/settings/presentation/pages/create_admin_successful_page.dart';
import '../../../features/settings/presentation/pages/settings_page.dart';
import '../../../features/settings/presentation/widgets/logout_page.dart';
import '../../../features/submissions/presentation/pages/submission_details_page.dart';
import '../../../features/submissions/presentation/pages/submissions_page.dart';
import '../../../features/user_management/presentation/pages/user_management_details_page.dart';
import '../../../features/user_management/presentation/pages/user_management_page.dart';
import '../../../features/user_management/presentation/pages/user_referrals_page.dart';
import '../../../features/withdrawal_request/presentation/pages/withdrawal_request_page.dart';
import '../../shells/authenticated_shell.dart';
import 'route_name.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RouteName.splashPage:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const SplashScreenPage(),
      );
    case RouteName.loginPage:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const LoginPage(),
      );

    //DASHBOARD PAGE
    case RouteName.dashboardPage:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: AuthenticatedShell(child: const DashboardPage()),
      );

    //USERS MANAGEMENT PAGE
    case RouteName.userManagementPage:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: AuthenticatedShell(child: const UserManagementPage()),
      );
    case RouteName.userManagementDetailsPage:
      final args = settings.arguments! as UserManagementDetailsPageParam;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: AuthenticatedShell(
          child: UserManagementDetailsPage(param: args),
        ),
      );
    case RouteName.userReferralsPage:
      final args = settings.arguments! as UserReferralsPageParam;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: AuthenticatedShell(child: UserReferralsPage(param: args)),
      );

    //REFERRAL MANAGEMENT PAGE
    case RouteName.referralManagementPage:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: AuthenticatedShell(child: const ReferralManagementPage()),
      );
    case RouteName.referralManagementDetailsPage:
      final args = settings.arguments! as ReferralManagementDetailsPageParam;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: AuthenticatedShell(
          child: ReferralManagementDetailsPage(param: args),
        ),
      );

    //SUBMISSION PAGE
    case RouteName.submissionPage:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: AuthenticatedShell(child: const SubmissionPage()),
      );
    case RouteName.submissionDetailsPage:
      final args = settings.arguments! as SubmissionDetailsPageParam;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: AuthenticatedShell(
          child: SubmissionDetailsPage(param: args),
        ),
      );

    //PAYMENT PAGE
    case RouteName.paymentPage:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: AuthenticatedShell(child: const PaymentPage()),
      );

    //REPORT PAGE
    case RouteName.reportPage:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: AuthenticatedShell(child: const ReportPage()),
      );

    //SETTINGS PAGE
    case RouteName.settingsPage:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: AuthenticatedShell(child: const SettingsPage()),
      );
    case RouteName.changePasswordPage:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: AuthenticatedShell(child: ChangePasswordPage()),
      );
    case RouteName.manageAdminPage:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: AuthenticatedShell(child: ManageAdminPage()),
      );
    case RouteName.createAdminPage:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: AuthenticatedShell(child: CreateAdminPage()),
      );
    case RouteName.createAdminSuccessPage:
      final args = settings.arguments! as CreateAdminSuccessPageParam;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: AuthenticatedShell(
          child: CreateAdminSuccessPage(param: args),
        ),
      );
    case RouteName.logoutPage:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: AuthenticatedShell(child: LogoutPage()),
      );

    //WITHDRAWAL REQUEST PAGE
    case RouteName.withdrawalRequestPage:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: AuthenticatedShell(child: const WithdrawalRequestPage()),
      );

    ///Universal Success Page
    case RouteName.successfulPage:
      final args = settings.arguments! as SuccessfulPageParam;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: SuccessfulPage(param: args),
      );

    default:
      return MaterialPageRoute<dynamic>(
        builder: (_) => Scaffold(
          body: Center(child: Text('No route defined for ${settings.name}')),
        ),
      );
  }
}

Route<dynamic> _getPageRoute({
  required String routeName,
  required Widget viewToShow,
}) {
  return MaterialPageRoute(
    settings: RouteSettings(name: routeName),
    builder: (_) => viewToShow,
  );
}
