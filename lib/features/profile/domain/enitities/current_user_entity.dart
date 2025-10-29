class CurrentUserEntity {
  final int userId;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final int userGroupId;

  const CurrentUserEntity({
    required this.userId,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.userGroupId,
  });

  String get fullName => "$firstName $lastName";
}
