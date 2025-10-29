import 'package:mero_din_app/core/network/api_response.dart';
import 'package:mero_din_app/features/currentTeamInfo/data/datasources/curreent_team_info_remote_datasource.dart';
import 'package:mero_din_app/features/currentTeamInfo/data/model/current_team_info_model.dart';
import 'package:mero_din_app/features/currentTeamInfo/domain/entities/current_team_info_entity.dart';
import 'package:mero_din_app/features/currentTeamInfo/domain/repositories/current_team_info_repository.dart';

import '../../../../core/errors/no_internet_exception.dart';
import '../../../../core/network/network_info.dart';

class CurrentTeamInfoRepositoryImpl implements CurrentTeamInfoRepository {
  final CurrentTeamInfoRemoteDatasource curreentTeamInfoRemoteDatasource;
  final NetworkInfo networkInfo;

  CurrentTeamInfoRepositoryImpl(
    this.curreentTeamInfoRemoteDatasource,
    this.networkInfo,
  );
  @override
  Future<List<CurrentTeamInfoEntity>> getCurrentTeamInfo() async {
    try {
      return curreentTeamInfoRemoteDatasource.getCurrentTeamInfoData();
    } catch (e) {
      if (!await networkInfo.isConnected) {
        throw NoInternetException();
      }
      rethrow;
    }
  }

  @override
  Future<ApiResponse> addCurrentTeamInfo(
    CurrentTeamInfoEntity teamInfos,
  ) async {
    try {
      final finalteamInfo = CurrentTeamInfoModel(
        teamInfoID: teamInfos.teamInfoID,
        userID: teamInfos.userID,
        role: teamInfos.role,
        statusName: teamInfos.statusName,
        updateKey: teamInfos.updateKey,
        recordStatus: teamInfos.recordStatus,
        id: teamInfos.id,
        teamName: teamInfos.teamName,
        teamCode: teamInfos.teamCode,
        teamImage: teamInfos.teamImage,
      );
      return curreentTeamInfoRemoteDatasource.addCurrentTeamInfoData(
        finalteamInfo,
      );
    } catch (e) {
      if (!await networkInfo.isConnected) {
        throw NoInternetException();
      }
      rethrow;
    }
  }

  @override
  Future<ApiResponse> deleteCurrentTeamInfo(int userGroupID) async {
    try {
      return await curreentTeamInfoRemoteDatasource.deleteCurrentTeamInfo(
        userGroupID,
      );
    } catch (e) {
      if (!await networkInfo.isConnected) {
        throw NoInternetException();
      }
      rethrow;
    }
  }

  @override
  Future<ApiResponse> editCurrentTeamInfo(
    CurrentTeamInfoEntity teamInfos,
  ) async {
    final finalTeamInfo = CurrentTeamInfoModel(
      teamInfoID: teamInfos.id,
      userID: teamInfos.userID,
      role: teamInfos.role,
      statusName: teamInfos.statusName,
      updateKey: teamInfos.updateKey,
      recordStatus: teamInfos.recordStatus,
      id: teamInfos.id,
      teamName: teamInfos.teamName,
      teamCode: teamInfos.teamCode,
      teamImage: teamInfos.teamImage,
    );
    try {
      return await curreentTeamInfoRemoteDatasource.updateCurrentTeamInfo(
        finalTeamInfo,
      );
    } catch (e) {
      if (!await networkInfo.isConnected) {
        throw NoInternetException();
      }
      rethrow;
    }
  }
}
