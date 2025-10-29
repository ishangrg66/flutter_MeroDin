import 'package:mero_din_app/features/currentTeamInfo/domain/repositories/approve_repository.dart';

class ApproveUsecase {
  final ApproveRepository repository;

  ApproveUsecase(this.repository);

  Future<void> call(int teamId, int action) async {
    return repository.approveTeamRequest(teamId, action);
  }
}
