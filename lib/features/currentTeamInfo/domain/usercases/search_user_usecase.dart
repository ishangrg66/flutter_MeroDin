import 'package:mero_din_app/features/currentTeamInfo/domain/entities/search_user_entity.dart';
import 'package:mero_din_app/features/currentTeamInfo/domain/repositories/search_user_repository.dart';

class SearchUsersUseCase {
  final SearchUserRepository repository;

  SearchUsersUseCase(this.repository);

  Future<List<SearchUserEntity>> call(String email) async {
    return repository.searchUsers(email);
  }
}
