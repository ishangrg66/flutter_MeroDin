import 'package:mero_din_app/features/currentTeamInfo/domain/entities/current_team_info_entity.dart';
import 'package:mero_din_app/features/currentTeamInfo/domain/repositories/current_team_info_repository.dart';

class CurrentTeamInfoUseCase {
  final CurrentTeamInfoRepository repository;

  CurrentTeamInfoUseCase(this.repository);
  Future<List<CurrentTeamInfoEntity>> call() => repository.getCurrentTeamInfo();
}
