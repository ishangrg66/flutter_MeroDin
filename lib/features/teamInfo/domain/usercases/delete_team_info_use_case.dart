import 'package:mero_din_app/core/network/api_response.dart';
import 'package:mero_din_app/features/teamInfo/domain/repositories/team_info_repository.dart';

class DeleteTeamInfoUseCase {
  final TeamInfoRepository repository;

  DeleteTeamInfoUseCase(this.repository);

  Future<ApiResponse> execute(int teamInfoID) async {
    return await repository.deleteTeamInfo(teamInfoID);
  }
}
