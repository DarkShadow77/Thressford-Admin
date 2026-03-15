enum UsersStatus { active, inactive, suspended }

extension UsersStatusExtension on UsersStatus {
  String get statusString {
    switch (this) {
      case UsersStatus.active:
        return 'active';
      case UsersStatus.inactive:
        return 'inactive';
      case UsersStatus.suspended:
        return 'suspended';
    }
  }

  static UsersStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return UsersStatus.active;
      case 'inactive':
        return UsersStatus.inactive;
      case 'suspended':
        return UsersStatus.suspended;
      default:
        throw ArgumentError('Unknown status: $status');
    }
  }
}
