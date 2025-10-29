import 'package:mero_din_app/core/errors/no_internet_exception.dart';
import 'package:mero_din_app/core/network/network_info.dart';
import 'package:mero_din_app/features/currentTeamInfo/data/datasources/approve_team_remote_datasource.dart';
import 'package:mero_din_app/features/currentTeamInfo/domain/repositories/approve_repository.dart';

class ApproveRepositoryImpl implements ApproveRepository {
  final ApproveTeamRemoteDatasource approveTeamRemoteDatasource;
  final NetworkInfo networkInfo;

  ApproveRepositoryImpl(this.networkInfo, this.approveTeamRemoteDatasource);

  @override
  Future<void> approveTeamRequest(int teamId, int action) async {
    try {
      await approveTeamRemoteDatasource.approveTeam(teamId, action);
    } catch (e) {
      if (!await networkInfo.isConnected) {
        throw NoInternetException();
      }
      rethrow;
    }
  }
}
