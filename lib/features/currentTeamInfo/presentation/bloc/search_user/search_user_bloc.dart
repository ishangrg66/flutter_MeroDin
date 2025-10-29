import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mero_din_app/features/currentTeamInfo/domain/usercases/search_user_usecase.dart';
import 'package:mero_din_app/features/currentTeamInfo/presentation/bloc/search_user/search_user_event.dart';
import 'package:mero_din_app/features/currentTeamInfo/presentation/bloc/search_user/search_user_state.dart';

class UserSearchBloc extends Bloc<UserSearchEvent, UserSearchState> {
  final SearchUsersUseCase searchUsersUseCase;

  UserSearchBloc(this.searchUsersUseCase) : super(UserSearchInitial()) {
    on<FetchUserSuggestions>((event, emit) async {
      emit(UserSearchLoading());
      try {
        final users = await searchUsersUseCase.call(event.query);
        emit(UserSearchSuccess(users));
      } catch (e) {
        emit(UserSearchError(e.toString()));
      }
    });
  }
}
