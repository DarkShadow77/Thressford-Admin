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
      token: json['token'] ?? '',
      fullName: json['fullname'] ?? '',
      email: json['email'] ?? '',
      role: AdminRoleExtension.fromString(json['role'] ?? ""),
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
