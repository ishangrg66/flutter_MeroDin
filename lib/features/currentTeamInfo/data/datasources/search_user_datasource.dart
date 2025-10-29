import 'package:dio/dio.dart';
import 'package:mero_din_app/core/constants/api_constants.dart';
import 'package:mero_din_app/core/services/auth_service.dart';
import 'package:mero_din_app/features/currentTeamInfo/data/model/search_user_model.dart';

abstract class SearchUserDatasource {
  Future<List<SearchUserModel>> getSearchUser(String email);
}

class SearchUserDatasourceImpl implements SearchUserDatasource {
  final Dio dio;
  final AuthService authService;
  SearchUserDatasourceImpl(this.dio, this.authService);
  @override
  Future<List<SearchUserModel>> getSearchUser(String email) async {
    try {
      final token = authService.token ?? '';
      final response = await dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.getUserEmail}',
        queryParameters: {'email': email},
        options: Options(
          headers: {'accept': '*/*', 'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data;

        return jsonList.map((json) => SearchUserModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to login: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Login error: $e');
    }
  }
}
