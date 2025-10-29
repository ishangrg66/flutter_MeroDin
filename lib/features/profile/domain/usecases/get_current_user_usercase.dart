import 'package:mero_din_app/features/profile/domain/enitities/current_user_entity.dart';
import 'package:mero_din_app/features/profile/domain/repositories/user_respository.dart';

class GetCurrentUserUsercase {
  final UserRepository repository;

  GetCurrentUserUsercase(this.repository);
  Future<CurrentUserEntity> call() => repository.fetchCurrentUser();
}
