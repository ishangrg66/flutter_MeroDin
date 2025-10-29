import '../../../../core/errors/no_internet_exception.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/enitities/current_user_entity.dart';
import '../../domain/repositories/user_respository.dart';
import '../datasources/user_remote_datasource.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl(this.remoteDataSource, this.networkInfo);
  @override
  Future<CurrentUserEntity> fetchCurrentUser() async {
    try {
      return await remoteDataSource.fetchCurentUser();
    } catch (e) {
      if (!await networkInfo.isConnected) {
        throw NoInternetException();
      }
      rethrow;
    }
  }
}
