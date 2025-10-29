import 'package:mero_din_app/core/network/api_response.dart';
import 'package:mero_din_app/features/currentTeamInfo/domain/repositories/current_team_info_repository.dart';

class DeleteCurrentTeamInfoUseCase {
  final CurrentTeamInfoRepository repository;

  DeleteCurrentTeamInfoUseCase(this.repository);

  Future<ApiResponse> execute(int teamInfoID) async {
    return await repository.deleteCurrentTeamInfo(teamInfoID);
  }
}
