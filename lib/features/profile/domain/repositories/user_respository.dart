import '../enitities/current_user_entity.dart';

abstract class UserRepository {
  Future<CurrentUserEntity> fetchCurrentUser();
}
