import 'package:mero_din_app/features/profile/domain/enitities/current_user_entity.dart';

abstract class CurrentUserState {}

class CurrentUserInitial extends CurrentUserState {}

class CurrentUserLoading extends CurrentUserState {}

class CurrentUserLoaded extends CurrentUserState {
  final CurrentUserEntity userEntity;

  CurrentUserLoaded(this.userEntity);
}

class CurrentUserError extends CurrentUserState {
  final String message;
  CurrentUserError(this.message);
}

class CurrentUserNoInternet extends CurrentUserState {
  final String message;
  CurrentUserNoInternet(this.message);
}
