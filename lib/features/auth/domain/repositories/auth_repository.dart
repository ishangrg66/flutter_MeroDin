import 'package:mero_din_app/features/auth/domain/models/sign_up_payload.dart';

import '../entities/user.dart';
import '../models/auth_payload.dart';

abstract class AuthRepository {
  Future<User> login(AuthPayload payload);
  Future<void> signUp(SignUpPayload payload);
}
