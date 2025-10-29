import 'package:mero_din_app/features/teamInfo/domain/entities/team_info_entities.dart';
import 'package:mero_din_app/features/teamInfo/domain/repositories/team_info_repository.dart';

class TeamInfoUseCase {
  final TeamInfoRepository repository;

  TeamInfoUseCase(this.repository);
  Future<List<TeamInfoEntity>> call() => repository.getTeamInfo();
}
