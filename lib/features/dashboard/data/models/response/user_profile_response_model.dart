import '../../../../../core/utils/helpers.dart';
import '../../../../settings/data/models/admin_enum.dart';

class UserProfile {
  final String token;
  final String fullName;
  final String email;
  final AdminRole role;

  UserProfile({
    required this.token,
    required this.fullName,
    required this.email,
    required this.role,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      token: parseString(json['token']),
      fullName: parseString(json['fullname']),
      email: parseString(json['email']),
      role: AdminRoleExtension.fromString(parseString(json['role'])),
    );
  }

  factory UserProfile.empty() {
    return UserProfile(
      token: "",
      fullName: "",
      email: "",
      role: AdminRole.admin,
    );
  }
}
