import '../../../../core/constants/navigators/route_name.dart';

enum AdminStatus { active, inactive }

extension AdminStatusExtension on AdminStatus {
  String get statusString {
    switch (this) {
      case AdminStatus.active:
        return 'active';
      case AdminStatus.inactive:
        return 'inactive';
    }
  }

  static AdminStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return AdminStatus.active;
      case 'inactive':
        return AdminStatus.inactive;
      default:
        return AdminStatus.inactive;
    }
  }
}

enum AdminRole { admin, subAdmin, superAdmin, alphaAdmin }

extension AdminRoleExtension on AdminRole {
  String get statusString {
    switch (this) {
      case AdminRole.admin:
        return 'Admin';
      case AdminRole.subAdmin:
        return 'Sub Admin';
      case AdminRole.superAdmin:
        return 'Super Admin';
      case AdminRole.alphaAdmin:
        return 'Alpha Admin';
    }
  }

  static AdminRole fromString(String status) {
    switch (status.toLowerCase()) {
      case 'admin':
        return AdminRole.admin;
      case 'sub_admin':
        return AdminRole.subAdmin;
      case 'super_admin':
        return AdminRole.superAdmin;
      case 'alpha_admin':
        return AdminRole.alphaAdmin;
      default:
        return AdminRole.admin;
    }
  }
}

extension AdminRoleLevel on AdminRole {
  int get level => switch (this) {
    AdminRole.admin => 1,
    AdminRole.subAdmin => 2,
    AdminRole.superAdmin => 3,
    AdminRole.alphaAdmin => 4,
  };

  bool canAccess(String route) {
    if (level >= 3) return true; // superAdmin and alphaAdmin access everything
    if (level == 2) {
      return [
        RouteName.submissionPage,
        RouteName.settingsPage,
        RouteName.userManagementPage,
        RouteName.referralManagementPage,
      ].contains(route);
    }
    // admin (level 1)
    return [RouteName.submissionPage, RouteName.settingsPage].contains(route);
  }

  bool canManageAdmin(AdminRole targetRole) => level > targetRole.level;
}
