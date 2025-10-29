import 'package:mero_din_app/features/auth/domain/models/auth_payload.dart';
import 'package:mero_din_app/features/auth/domain/models/sign_up_payload.dart';
import 'package:mero_din_app/features/auth/domain/repositories/auth_repository.dart';

// import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/no_internet_exception.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/services/auth_service.dart';
import '../../domain/entities/user.dart';
import '../datasource/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthService authService;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl(this.remoteDataSource, this.authService, this.networkInfo);
  @override
  Future<User> login(AuthPayload payload) async {
    try {
      final userModel = await remoteDataSource.login(payload);
      await authService.saveToken(userModel.token);
      await authService.saveUserGroup(userModel.userGroup);
      return userModel;
    } catch (e) {
      if (!await networkInfo.isConnected) {
        throw NoInternetException();
      }
      rethrow;
    }
  }

  @override
  Future<void> signUp(SignUpPayload payload) async {
    try {
      await remoteDataSource.signUp(payload);
    } catch (e) {
      if (!await networkInfo.isConnected) {
        throw NoInternetException();
      }
      rethrow;
    }
  }
}
