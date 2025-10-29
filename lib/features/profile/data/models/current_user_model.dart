import '../../domain/enitities/current_user_entity.dart';

class CurrentUserModel extends CurrentUserEntity {
  const CurrentUserModel({
    required super.userId,
    required super.username,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.userGroupId,
  });

  factory CurrentUserModel.fromJson(Map<String, dynamic> json) {
    return CurrentUserModel(
      userId: json["id"],
      username: json["username"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      userGroupId: json["userGroupId"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": userId,
      "username": username,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "userGroupId": userGroupId,
    };
  }
}
