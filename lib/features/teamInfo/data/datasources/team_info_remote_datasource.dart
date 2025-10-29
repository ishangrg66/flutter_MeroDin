import 'package:dio/dio.dart';
import 'package:mero_din_app/features/teamInfo/data/models/team_info_model.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/services/auth_service.dart';

abstract class TeamInfoRemoteDataSource {
  Future<List<TeamInfoModel>> getTeamInfoData();
  Future<ApiResponse> addTeamInfoData(TeamInfoModel teamInfo);
  Future<ApiResponse> deleteTeamInfo(int teamInfoID);
  Future<ApiResponse> updateTeamInfo(TeamInfoModel teamInfo);
}

class TeamInfoRemoteDatasourceImpl implements TeamInfoRemoteDataSource {
  final Dio dio;
  final AuthService authService;

  TeamInfoRemoteDatasourceImpl(this.dio, this.authService);
  @override
  Future<List<TeamInfoModel>> getTeamInfoData() async {
    try {
      final token = authService.token ?? '';
      final response = await dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.getTeamInfo}',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 200) {
        final data = response.data as List;
        return data.map((e) => TeamInfoModel.fromJson(e)).toList();
      } else {
        throw Exception(
          'Failed to load TeamInfo, status code: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    }
  }

  @override
  Future<ApiResponse> addTeamInfoData(TeamInfoModel teamInfo) async {
    try {
      final payload = {
        "teamName": teamInfo.teamInfoName,
        "teamCode": teamInfo.teamInfoCode,
        "image": teamInfo.teamInfoimage,
      };
      final token = authService.token ?? '';
      final response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.teamInfo}',
        data: payload,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // final success = response.data['success'];
        // final message = response.data['message'];
        // return ApiResponse<void>(success: success, message: message);
        return ApiResponse<void>(
          success: true,
          message: 'Successfully Updated',
        );
      } else {
        return ApiResponse<void>(
          success: false,
          message: 'Failed with status ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    }
  }

  @override
  Future<ApiResponse> deleteTeamInfo(int teamInfo) async {
    try {
      final token = authService.token ?? '';

      final response = await dio.delete(
        '${ApiConstants.baseUrl}${ApiConstants.teamInfo}/$teamInfo',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final success = response.data['success'] as bool? ?? true;
        final message =
            response.data['message'] as String? ?? 'Deleted successfully';
        return ApiResponse<void>(success: success, message: message);
      } else if (response.statusCode == 204) {
        return ApiResponse<void>(
          success: true,
          message: 'Deleted successfully',
        );
      } else {
        return ApiResponse<void>(
          success: false,
          message: 'Failed with status ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    }
  }

  @override
  Future<ApiResponse> updateTeamInfo(TeamInfoModel teamInfo) async {
    try {
      final token = authService.token ?? '';
      // if (teamInfo.updateKey == null) {
      //   throw Exception('UpdateKey is required to update teamInfo');
      // }

      final payload = {
        "id": teamInfo.teamInfoId,
        "teamName": teamInfo.teamInfoName,
        "teamCode": teamInfo.teamInfoCode,
        "image": teamInfo.teamInfoimage,
      };

      final response = await dio.put(
        '${ApiConstants.baseUrl}${ApiConstants.teamInfo}/${teamInfo.teamInfoId}',
        data: payload,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // final success = response.data['success'];
        // final message = response.data['message'];
        // return ApiResponse<void>(success: success, message: message);
        return ApiResponse<void>(
          success: true,
          message: 'Successfully Updated',
        );
      } else {
        return ApiResponse<void>(
          success: false,
          message: 'Failed with status ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    }
  }
}
