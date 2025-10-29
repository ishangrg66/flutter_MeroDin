import 'package:dio/dio.dart';
import 'package:mero_din_app/features/currentTeamInfo/data/model/current_team_info_model.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/services/auth_service.dart';

abstract class CurrentTeamInfoRemoteDatasource {
  Future<List<CurrentTeamInfoModel>> getCurrentTeamInfoData();
  Future<ApiResponse> addCurrentTeamInfoData(CurrentTeamInfoModel teamInfo);
  Future<ApiResponse> deleteCurrentTeamInfo(int teamInfoID);
  Future<ApiResponse> updateCurrentTeamInfo(CurrentTeamInfoModel teamInfo);
}

class CurrentTeamInfoRemoteDatasourceImpl
    implements CurrentTeamInfoRemoteDatasource {
  final Dio dio;
  final AuthService authService;

  CurrentTeamInfoRemoteDatasourceImpl(this.dio, this.authService);
  @override
  Future<List<CurrentTeamInfoModel>> getCurrentTeamInfoData() async {
    try {
      final token = authService.token ?? '';
      final response = await dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.getCurrentTeamInfo}',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        try {
          final data = response.data;

          if (data is List) {
            return data
                .map(
                  (e) =>
                      CurrentTeamInfoModel.fromJson(e as Map<String, dynamic>),
                )
                .toList();
          } else if (data is Map<String, dynamic>) {
            final apiResponse =
                ApiResponse<List<CurrentTeamInfoModel>>.fromJson(data, (data) {
                  final list = data as List<dynamic>? ?? [];
                  return list
                      .map(
                        (e) => CurrentTeamInfoModel.fromJson(
                          e as Map<String, dynamic>,
                        ),
                      )
                      .toList();
                });
            return apiResponse.data ?? [];
          } else {
            throw Exception('Unexpected response type: ${data.runtimeType}');
          }
        } catch (e) {
          // JSON parsing error
          throw Exception('Failed to parse TeamInfo data: $e');
        }
      } else {
        throw Exception(
          'Failed to load TeamInfo, status code: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      // Other errors
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<ApiResponse> addCurrentTeamInfoData(
    CurrentTeamInfoModel teamInfo,
  ) async {
    try {
      final payload = {
        "teamInfoID": teamInfo.teamInfoID,
        "userID": teamInfo.userID,
        "role": teamInfo.role,
      };
      final token = authService.token ?? '';
      final response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.getTeamMapInfo}',
        data: payload,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
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
  Future<ApiResponse> deleteCurrentTeamInfo(int teamInfo) async {
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
  Future<ApiResponse> updateCurrentTeamInfo(
    CurrentTeamInfoModel teamInfo,
  ) async {
    try {
      final token = authService.token ?? '';
      // if (teamInfo.updateKey == null) {
      //   throw Exception('UpdateKey is required to update teamInfo');
      // }

      final payload = {
        {
          "id": teamInfo.id,
          "updateKey": teamInfo.updateKey,
          "teamInfoID": teamInfo.teamInfoID,
          "userID": teamInfo.userID,
          "role": teamInfo.role,
        },
      };

      final response = await dio.put(
        '${ApiConstants.baseUrl}${ApiConstants.teamInfo}/${teamInfo.id}',
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
