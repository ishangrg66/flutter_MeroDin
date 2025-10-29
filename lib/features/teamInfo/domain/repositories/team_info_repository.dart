import 'package:mero_din_app/core/network/api_response.dart';
import 'package:mero_din_app/features/teamInfo/domain/entities/team_info_entities.dart';

abstract class TeamInfoRepository {
  Future<List<TeamInfoEntity>> getTeamInfo();
  Future<ApiResponse> addTeamInfo(TeamInfoEntity teamInfo);

  Future<ApiResponse> editTeamInfo(TeamInfoEntity data);
  Future<ApiResponse> deleteTeamInfo(int teamInfoID);
}
