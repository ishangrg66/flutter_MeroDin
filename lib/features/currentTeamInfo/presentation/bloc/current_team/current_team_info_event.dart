import 'package:mero_din_app/features/currentTeamInfo/domain/entities/current_team_info_entity.dart';

abstract class CurrentTeamInfoEvent {}

class LoadCurrentTeamInfo extends CurrentTeamInfoEvent {}

class AddCurrentTeamInfo extends CurrentTeamInfoEvent {
  final CurrentTeamInfoEntity teamInfoData;

  AddCurrentTeamInfo(this.teamInfoData);
}

class UpdateCurrentTeamInfo extends CurrentTeamInfoEvent {
  final CurrentTeamInfoEntity updateTeamInfo;
  UpdateCurrentTeamInfo(this.updateTeamInfo);
}

class DeleteCurrentTeamInfo extends CurrentTeamInfoEvent {
  final int currentteamInfoID;
  DeleteCurrentTeamInfo(this.currentteamInfoID);
}
