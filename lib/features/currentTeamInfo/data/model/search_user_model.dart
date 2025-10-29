import 'package:mero_din_app/features/currentTeamInfo/domain/entities/search_user_entity.dart';

class SearchUserModel {
  final int id;
  final String email;
  final String firstName;
  final String lastName;

  SearchUserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  factory SearchUserModel.fromJson(Map<String, dynamic> json) {
    return SearchUserModel(
      id: json['id'],
      email: json['email'],
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
    );
  }

  SearchUserEntity toEntity() {
    return SearchUserEntity(
      id: id,
      email: email,
      firstName: firstName,
      lastName: lastName,
    );
  }
}
