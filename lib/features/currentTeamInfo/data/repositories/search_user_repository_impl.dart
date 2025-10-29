import 'package:mero_din_app/core/errors/no_internet_exception.dart';
import 'package:mero_din_app/core/network/network_info.dart';
import 'package:mero_din_app/features/currentTeamInfo/data/datasources/search_user_datasource.dart';
import 'package:mero_din_app/features/currentTeamInfo/domain/entities/search_user_entity.dart';
import 'package:mero_din_app/features/currentTeamInfo/domain/repositories/search_user_repository.dart';

class SearchUserRepositoryImpl implements SearchUserRepository {
  final SearchUserDatasource searchUserDatasource;
  final NetworkInfo networkInfo;

  SearchUserRepositoryImpl(this.networkInfo, this.searchUserDatasource);

  @override
  Future<List<SearchUserEntity>> searchUsers(String email) async {
    try {
      final models = await searchUserDatasource.getSearchUser(email);

      final entities = models.map((model) => model.toEntity()).toList();

      return entities;
    } catch (e) {
      if (!await networkInfo.isConnected) {
        throw NoInternetException();
      }
      rethrow;
    }
  }
}
