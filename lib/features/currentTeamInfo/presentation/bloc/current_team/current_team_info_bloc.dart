import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mero_din_app/features/currentTeamInfo/domain/entities/current_team_info_entity.dart';
import 'package:mero_din_app/features/currentTeamInfo/domain/usercases/add_current_team_info_use_case.dart';
import 'package:mero_din_app/features/currentTeamInfo/domain/usercases/current_team_info_use_case.dart';
import 'package:mero_din_app/features/currentTeamInfo/domain/usercases/delete_current_team_info_use_case.dart';
import 'package:mero_din_app/features/currentTeamInfo/domain/usercases/update_current_team_info_use_case.dart';

// import 'package:resturant_system/core/network/api_response.dart';

import '../../../../../core/errors/no_internet_exception.dart';
import 'current_team_info_event.dart';
import 'current_team_info_state.dart';

class CurrentTeamInfoBloc
    extends Bloc<CurrentTeamInfoEvent, CurrentTeamInfoState> {
  CurrentTeamInfoUseCase teamInfoUseCase;
  AddCurrentTeamInfoUseCase addTeamInfoUseCase;
  DeleteCurrentTeamInfoUseCase deleteTeamInfoUseCase;
  UpdatCurrentTeamInfoUseCase updateTeamInfoUseCase;
  CurrentTeamInfoBloc(
    this.teamInfoUseCase,
    this.addTeamInfoUseCase,
    this.deleteTeamInfoUseCase,
    this.updateTeamInfoUseCase,
  ) : super(CurrentTeamInfoInitial()) {
    on<LoadCurrentTeamInfo>((event, emit) async {
      emit(CurrentTeamInfoLoading());
      try {
        final List<CurrentTeamInfoEntity> userGroups = await teamInfoUseCase();
        emit(CurrentTeamInfoLoaded(userGroups));
      } on NoInternetException catch (_) {
        emit(CurrentTeamInfoNoInternet("No Internet Connection"));
      } catch (e) {
        emit(CurrentTeamInfoError(e.toString()));
      }
    });
    on<AddCurrentTeamInfo>((event, emit) async {
      emit(CurrentTeamInfoLoading());
      try {
        await addTeamInfoUseCase.execute(event.teamInfoData);
        emit(CurrentTeamInfoSuccess());
      } on NoInternetException catch (_) {
        emit(CurrentTeamInfoNoInternet("No Internet Connection"));
      } catch (e) {
        emit(CurrentTeamInfoError(e.toString()));
      }
    });
    on<DeleteCurrentTeamInfo>((event, emit) async {
      emit(CurrentTeamInfoLoading());
      try {
        await deleteTeamInfoUseCase.execute(event.currentteamInfoID);
        emit(CurrentTeamInfoSuccess());
      } on NoInternetException catch (_) {
        emit(CurrentTeamInfoNoInternet("No Internet Connection"));
      } catch (e) {
        emit(CurrentTeamInfoError(e.toString()));
      }
    });
    on<UpdateCurrentTeamInfo>((event, emit) async {
      emit(CurrentTeamInfoLoading());
      try {
        await updateTeamInfoUseCase.execute(event.updateTeamInfo);
        emit(CurrentTeamInfoSuccess());
      } on NoInternetException catch (_) {
        emit(CurrentTeamInfoNoInternet("No Internet Connection"));
      } catch (e) {
        emit(CurrentTeamInfoError(e.toString()));
      }
    });
  }
}
