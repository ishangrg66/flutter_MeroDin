import '../../domain/entities/team_info_entities.dart';

abstract class TeamInfoEvent {}

class LoadTeamInfo extends TeamInfoEvent {}

class AddTeamInfo extends TeamInfoEvent {
  final TeamInfoEntity teamInfoData;

  AddTeamInfo(this.teamInfoData);
}

class UpdateTeamInfo extends TeamInfoEvent {
  final TeamInfoEntity teamInfoEntity;
  UpdateTeamInfo(this.teamInfoEntity);
}

class DeleteTeamInfo extends TeamInfoEvent {
  final int teamInfoID;
  DeleteTeamInfo(this.teamInfoID);
}
