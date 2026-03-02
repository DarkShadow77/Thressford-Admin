import 'package:flutter/material.dart';
import 'package:thressford_admin/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:thressford_admin/features/payments/presentation/pages/payment_page.dart';
import 'package:thressford_admin/features/settings/presentation/pages/create_admin_page.dart';
import 'package:thressford_admin/features/settings/presentation/pages/manage_admin_page.dart';

import '../../../app/view/pages/successful_page.dart';
import '../../../features/auth/presentation/pages/login_page.dart';
import '../../../features/onboarding/presentation/pages/splash_screen_page.dart';
import '../../../features/referral_management/presentation/pages/referral_details_page.dart';
import '../../../features/referral_management/presentation/pages/referral_management_page.dart';
import '../../../features/settings/presentation/pages/change_password_page.dart';
import '../../../features/settings/presentation/pages/settings_page.dart';
import '../../../features/submissions/presentation/pages/submissions_page.dart';
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
    case RouteName.dashboardPage:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const DashboardPage(),
      );
    case RouteName.paymentPage:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const PaymentPage(),
      );

    //REFERRAL MANAGEMENT PAGE
    case RouteName.referralManagementPage:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const ReferralManagementPage(),
      );
    case RouteName.referralManagementDetailsPage:
      final args = settings.arguments! as ReferralManagementDetailsPageParam;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: ReferralManagementDetailsPage(param: args),
      );

    //SUBMISSION PAGE
    case RouteName.submissionPage:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const SubmissionPage(),
      );

    //SETTINGS PAGE
    case RouteName.settingsPage:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const SettingsPage(),
      );
    case RouteName.changePasswordPage:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: ChangePasswordPage(),
      );
    case RouteName.manageAdminPage:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: ManageAdminPage(),
      );
    case RouteName.createAdminPage:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: CreateAdminPage(),
      );

    //HOME PAGE
    /*case RouteName.homePage:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: DashboardPage(param: DashboardPageParam(index: 0)),
      );
    case RouteName.submitReferralPage:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: SubmitReferralPage(),
      );

    //REFERRAL PAGE
    case RouteName.referralPage:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: DashboardPage(param: DashboardPageParam(index: 1)),
      );
    case RouteName.referralDetailsPage:
      final args = settings.arguments! as ReferralDetailsPageParam;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: ReferralDetailsPage(param: args),
      );

    //WALLET PAGE
    case RouteName.walletPage:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: DashboardPage(param: DashboardPageParam(index: 2)),
      );
    case RouteName.requestWithdrawalPage:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: RequestWithdrawalPage(),
      );

    //PROFILE PAGE
    case RouteName.profilePage:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: DashboardPage(param: DashboardPageParam(index: 3)),
      );
    case RouteName.editProfilePage:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: EditProfilePage(),
      );
    case RouteName.bankDetailsPage:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: BankDetailsPage(),
      );
    case RouteName.notificationPage:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: NotificationPage(),
      );
    case RouteName.changePasswordPage:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: ChangePasswordPage(),
      );
    case RouteName.logoutPage:
      return _getPageRoute(routeName: settings.name!, viewToShow: LogoutPage());*/

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
