abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class SignUpSuccess extends AuthState {}

class LoginFailure extends AuthState {
  final String message;

  LoginFailure(this.message);
}

class SignUpFailure extends AuthState {
  final String message;

  SignUpFailure(this.message);
}

class Unauthenticated extends AuthState {}

class LoginNoInternet extends AuthState {
  final String message;

  LoginNoInternet(this.message);
}
