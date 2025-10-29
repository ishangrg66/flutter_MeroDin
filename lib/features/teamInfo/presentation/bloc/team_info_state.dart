import '../../domain/entities/team_info_entities.dart';

abstract class TeamInfoState {}

class TeamInfoInitial extends TeamInfoState {}

class TeamInfoLoading extends TeamInfoState {}

class TeamInfoLoaded extends TeamInfoState {
  final List<TeamInfoEntity> teamInfo;

  TeamInfoLoaded(this.teamInfo);
}

class TeamInfoSuccess extends TeamInfoState {}

class TeamInfoError extends TeamInfoState {
  final String message;

  TeamInfoError(this.message);
}

class TeamInfoNoInternet extends TeamInfoState {
  final String message;
  TeamInfoNoInternet(this.message);
}
