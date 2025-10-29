import 'package:mero_din_app/features/currentTeamInfo/domain/entities/current_team_info_entity.dart';

abstract class CurrentTeamInfoState {}

class CurrentTeamInfoInitial extends CurrentTeamInfoState {}

class CurrentTeamInfoLoading extends CurrentTeamInfoState {}

class CurrentTeamInfoLoaded extends CurrentTeamInfoState {
  final List<CurrentTeamInfoEntity> teamInfo;

  CurrentTeamInfoLoaded(this.teamInfo);
}

class CurrentTeamInfoSuccess extends CurrentTeamInfoState {}

class CurrentTeamInfoError extends CurrentTeamInfoState {
  final String message;

  CurrentTeamInfoError(this.message);
}

class CurrentTeamInfoNoInternet extends CurrentTeamInfoState {
  final String message;
  CurrentTeamInfoNoInternet(this.message);
}
