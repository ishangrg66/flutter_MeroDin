import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mero_din_app/core/errors/no_internet_exception.dart';
import 'package:mero_din_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:mero_din_app/features/auth/domain/usecases/signup_usecase.dart';
import 'package:mero_din_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:mero_din_app/features/auth/presentation/bloc/auth_state.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUseCase;
  final SignupUsecase signupUsecase;

  AuthBloc(this.loginUseCase, this.signupUsecase) : super(AuthInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(AuthLoading());
      try {
        await loginUseCase(event.payload);
        emit(LoginSuccess());
      } on NoInternetException catch (_) {
        emit(LoginNoInternet("No Internet Connection"));
      } catch (e) {
        emit(LoginFailure(e.toString()));
      }
    });
    on<SignUpSubmitted>((event, emit) async {
      emit(AuthLoading());
      try {
        await signupUsecase(event.payload);
        emit(SignUpSuccess());
      } on NoInternetException catch (_) {
        emit(LoginNoInternet("No Internet Connection"));
      } catch (e) {
        emit(SignUpFailure(e.toString()));
      }
    });
    on<LogoutEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.remove('user_group');
      await prefs.remove('user_id');
      emit(Unauthenticated());
    });
  }
}
