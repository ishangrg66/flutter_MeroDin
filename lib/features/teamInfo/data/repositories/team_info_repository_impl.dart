import 'package:mero_din_app/core/network/api_response.dart';
import 'package:mero_din_app/features/teamInfo/data/datasources/team_info_remote_datasource.dart';
import 'package:mero_din_app/features/teamInfo/domain/entities/team_info_entities.dart';
import 'package:mero_din_app/features/teamInfo/domain/repositories/team_info_repository.dart';

import '../../../../core/errors/no_internet_exception.dart';
import '../../../../core/network/network_info.dart';
import '../models/team_info_model.dart';

class TeamInfoRepositoryImpl implements TeamInfoRepository {
  final TeamInfoRemoteDataSource teamInfoRemoteDataSource;
  final NetworkInfo networkInfo;

  TeamInfoRepositoryImpl(this.teamInfoRemoteDataSource, this.networkInfo);
  @override
  Future<List<TeamInfoEntity>> getTeamInfo() async {
    try {
      return teamInfoRemoteDataSource.getTeamInfoData();
    } catch (e) {
      if (!await networkInfo.isConnected) {
        throw NoInternetException();
      }
      rethrow;
    }
  }

  @override
  Future<ApiResponse> addTeamInfo(TeamInfoEntity teamInfos) async {
    try {
      final finalteamInfo = TeamInfoModel(
        teamInfoId: teamInfos.teamInfoId,
        teamInfoName: teamInfos.teamInfoName,
        teamInfoCode: teamInfos.teamInfoCode,
        teamInfoimage: teamInfos.teamInfoimage,
        updateKey: teamInfos.updateKey,
        recordStatus: teamInfos.recordStatus,
      );
      return teamInfoRemoteDataSource.addTeamInfoData(finalteamInfo);
    } catch (e) {
      if (!await networkInfo.isConnected) {
        throw NoInternetException();
      }
      rethrow;
    }
  }

  @override
  Future<ApiResponse> deleteTeamInfo(int userGroupID) async {
    try {
      return await teamInfoRemoteDataSource.deleteTeamInfo(userGroupID);
    } catch (e) {
      if (!await networkInfo.isConnected) {
        throw NoInternetException();
      }
      rethrow;
    }
  }

  @override
  Future<ApiResponse> editTeamInfo(TeamInfoEntity data) async {
    final finalTeamInfo = TeamInfoModel(
      teamInfoId: data.teamInfoId,
      teamInfoName: data.teamInfoName,
      teamInfoCode: data.teamInfoCode,
      teamInfoimage: data.teamInfoimage,
      updateKey: data.updateKey,
      recordStatus: data.recordStatus,
    );
    try {
      return await teamInfoRemoteDataSource.updateTeamInfo(finalTeamInfo);
    } catch (e) {
      if (!await networkInfo.isConnected) {
        throw NoInternetException();
      }
      rethrow;
    }
  }
}
