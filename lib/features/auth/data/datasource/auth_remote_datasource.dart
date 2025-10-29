import 'package:dio/dio.dart';
import 'package:mero_din_app/core/network/api_response.dart';
import 'package:mero_din_app/features/auth/domain/models/auth_payload.dart';
import 'package:mero_din_app/features/auth/domain/models/sign_up_payload.dart';

import '../../../../core/constants/api_constants.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(AuthPayload payload);
  Future<ApiResponse> signUp(SignUpPayload payload);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;
  AuthRemoteDataSourceImpl(this.dio);
  @override
  Future<UserModel> login(AuthPayload payload) async {
    try {
      final response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.generateToken}',
        data: {'username': payload.username, 'password': payload.password},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw Exception('Failed to login: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Login error: $e');
    }
  }

  @override
  Future<ApiResponse> signUp(SignUpPayload payload) async {
    try {
      final response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.signUp}',
        data: {
          "id": 0,
          "username": payload.username,
          "firstName": payload.firstName,
          "lastName": payload.lastName,
          "email": payload.email,
          "password": payload.password,
          "userGroupId": 1,
          "userGroupName": "",
          "userGroupCode": "",
        },
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        return ApiResponse.fromJson(response.data, (_) => null);
      } else {
        throw Exception('Failed to login: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Login error: $e');
    }
  }
}
