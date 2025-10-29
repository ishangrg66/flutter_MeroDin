import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.token,
    required super.userGroup,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      token: json['accessToken'],
      userGroup: json['userGroupCode'],
    );
  }
}
