import 'package:mero_din_app/features/auth/domain/models/auth_payload.dart';
import 'package:mero_din_app/features/auth/domain/repositories/auth_repository.dart';

import '../entities/user.dart';

class LoginUsecase {
  final AuthRepository repository;

  LoginUsecase(this.repository);
  Future<User> call(AuthPayload payload) {
    return repository.login(payload);
  }
}
