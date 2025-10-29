import 'package:mero_din_app/core/network/api_response.dart';
import 'package:mero_din_app/features/currentTeamInfo/domain/entities/current_team_info_entity.dart';

abstract class CurrentTeamInfoRepository {
  Future<List<CurrentTeamInfoEntity>> getCurrentTeamInfo();
  Future<ApiResponse> addCurrentTeamInfo(CurrentTeamInfoEntity teamInfo);

  Future<ApiResponse> editCurrentTeamInfo(CurrentTeamInfoEntity data);
  Future<ApiResponse> deleteCurrentTeamInfo(int teamInfoID);
}
