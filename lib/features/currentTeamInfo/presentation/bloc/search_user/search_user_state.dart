import 'package:mero_din_app/features/currentTeamInfo/domain/entities/search_user_entity.dart';

abstract class UserSearchState {}

class UserSearchInitial extends UserSearchState {}

class UserSearchLoading extends UserSearchState {}

class UserSearchSuccess extends UserSearchState {
  final List<SearchUserEntity> users;
  UserSearchSuccess(this.users);
}

class UserSearchError extends UserSearchState {
  final String message;
  UserSearchError(this.message);
}
