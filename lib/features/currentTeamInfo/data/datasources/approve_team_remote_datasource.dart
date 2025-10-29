import 'package:dio/dio.dart';
import 'package:mero_din_app/core/constants/api_constants.dart';
import 'package:mero_din_app/core/network/api_response.dart';
import 'package:mero_din_app/core/services/auth_service.dart';

abstract class ApproveTeamRemoteDatasource {
  Future<ApiResponse<void>> approveTeam(int teamId, int action);
}

class ApproveTeamRemotaDataSourceImpl implements ApproveTeamRemoteDatasource {
  final Dio dio;
  final AuthService authService;
  ApproveTeamRemotaDataSourceImpl(this.dio, this.authService);

  @override
  Future<ApiResponse<void>> approveTeam(int teamId, int action) async {
    try {
      final token = authService.token ?? '';
      final response = await dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.approveRequest}',
        queryParameters: {'teamId': teamId, 'action': action},
        options: Options(
          headers: {'accept': '*/*', 'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        return ApiResponse.fromJson(response.data, (_) {});
      } else {
        return ApiResponse(
          success: false,
          message: 'Failed request: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      return ApiResponse(success: false, message: 'Dio error: ${e.message}');
    } catch (e) {
      return ApiResponse(success: false, message: 'Unknown error: $e');
    }
  }
}
