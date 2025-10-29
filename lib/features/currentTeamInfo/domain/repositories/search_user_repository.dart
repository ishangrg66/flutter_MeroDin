import 'package:mero_din_app/features/currentTeamInfo/domain/entities/search_user_entity.dart';

abstract class SearchUserRepository {
  Future<List<SearchUserEntity>> searchUsers(String email);
}
