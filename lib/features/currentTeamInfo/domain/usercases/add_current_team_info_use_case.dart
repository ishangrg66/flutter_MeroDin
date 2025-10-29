import 'package:mero_din_app/core/network/api_response.dart';
import 'package:mero_din_app/features/currentTeamInfo/domain/entities/current_team_info_entity.dart';
import 'package:mero_din_app/features/currentTeamInfo/domain/repositories/current_team_info_repository.dart';


class AddCurrentTeamInfoUseCase {
  final CurrentTeamInfoRepository repository;

  AddCurrentTeamInfoUseCase(this.repository);

  Future<ApiResponse> execute(CurrentTeamInfoEntity teamInfo) async {
    return await repository.addCurrentTeamInfo(teamInfo);
  }
}
