import 'package:dio/dio.dart';
import 'package:mero_din_app/features/profile/data/models/current_user_model.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/services/auth_service.dart';

abstract class UserRemoteDataSource {
  Future<CurrentUserModel> fetchCurentUser();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio dio;
  final AuthService authService;

  UserRemoteDataSourceImpl(this.dio, this.authService);
  @override
  Future<CurrentUserModel> fetchCurentUser() async {
    try {
      final token = authService.token ?? '';
      final response = await dio.get(
        '${ApiConstants.baseUrl}/Users/GetUserInfo',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 200) {
        final apiResponse = ApiResponse.fromJson(
          response.data,
          (json) => CurrentUserModel.fromJson(json),
        );
        if (apiResponse.success && apiResponse.data != null) {
          if (authService.userId == null || authService.userId!.isEmpty) {
            await authService.saveUserId(apiResponse.data!.userId.toString());
          }
          return apiResponse.data!;
        } else {
          throw Exception(apiResponse.message);
        }
      } else {
        throw Exception('Failed to load Logged in User');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    }
  }
}
