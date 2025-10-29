import 'package:mero_din_app/features/auth/domain/models/auth_payload.dart';
import 'package:mero_din_app/features/auth/domain/models/sign_up_payload.dart';

abstract class AuthEvent {}

class LoginSubmitted extends AuthEvent {
  final AuthPayload payload;

  LoginSubmitted(this.payload);
}

class SignUpSubmitted extends AuthEvent {
  final SignUpPayload payload;

  SignUpSubmitted(this.payload);
}

class LogoutEvent extends AuthEvent {}
