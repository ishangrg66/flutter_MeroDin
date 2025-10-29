import 'package:mero_din_app/features/auth/domain/models/sign_up_payload.dart';
import 'package:mero_din_app/features/auth/domain/repositories/auth_repository.dart';

class SignupUsecase {
  final AuthRepository repository;

  SignupUsecase(this.repository);
  Future<void> call(SignUpPayload payload) {
    return repository.signUp(payload);
  }
}
