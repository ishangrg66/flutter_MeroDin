import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mero_din_app/features/profile/domain/usecases/get_current_user_usercase.dart';

import '../../../../core/errors/no_internet_exception.dart';
import 'current_user_event.dart';
import 'current_user_state.dart';

class CurrentUserBloc extends Bloc<CurrentUserEvent, CurrentUserState> {
  final GetCurrentUserUsercase currentUserUsercase;
  CurrentUserBloc(this.currentUserUsercase) : super(CurrentUserInitial()) {
    on<CurrentUserEvent>((event, emit) async {
      emit(CurrentUserLoading());
      try {
        final currentUser = await currentUserUsercase();
        emit(CurrentUserLoaded(currentUser));
      } on NoInternetException catch (_) {
        emit(CurrentUserNoInternet("No Internet Connection"));
      } catch (e) {
        emit(CurrentUserError(e.toString()));
      }
    });
  }
}
