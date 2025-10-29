import 'package:mero_din_app/core/network/api_response.dart';
import 'package:mero_din_app/features/teamInfo/domain/entities/team_info_entities.dart';
import 'package:mero_din_app/features/teamInfo/domain/repositories/team_info_repository.dart';

class UpdatTeamInfoUseCase {
  final TeamInfoRepository repository;

  UpdatTeamInfoUseCase(this.repository);

  Future<ApiResponse> execute(TeamInfoEntity teamInfo) async {
    return await repository.editTeamInfo(teamInfo);
  }
}
