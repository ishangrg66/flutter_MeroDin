import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mero_din_app/features/teamInfo/domain/entities/team_info_entities.dart';
import 'package:mero_din_app/features/teamInfo/domain/usercases/add_team_info_use_case.dart';
import 'package:mero_din_app/features/teamInfo/domain/usercases/delete_team_info_use_case.dart';
import 'package:mero_din_app/features/teamInfo/domain/usercases/update_team_info_use_case.dart';
import 'package:mero_din_app/features/teamInfo/domain/usercases/team_info_use_case.dart';
// import 'package:resturant_system/core/network/api_response.dart';

import '../../../../core/errors/no_internet_exception.dart';
import 'team_info_event.dart';
import 'team_info_state.dart';

class TeamInfoBloc extends Bloc<TeamInfoEvent, TeamInfoState> {
  TeamInfoUseCase teamInfoUseCase;
  AddTeamInfoUseCase addTeamInfoUseCase;
  DeleteTeamInfoUseCase deleteTeamInfoUseCase;
  UpdatTeamInfoUseCase updateTeamInfoUseCase;
  TeamInfoBloc(
    this.teamInfoUseCase,
    this.addTeamInfoUseCase,
    this.deleteTeamInfoUseCase,
    this.updateTeamInfoUseCase,
  ) : super(TeamInfoInitial()) {
    on<LoadTeamInfo>((event, emit) async {
      emit(TeamInfoLoading());
      try {
        final List<TeamInfoEntity> userGroups = await teamInfoUseCase();
        emit(TeamInfoLoaded(userGroups));
      } on NoInternetException catch (_) {
        emit(TeamInfoNoInternet("No Internet Connection"));
      } catch (e) {
        emit(TeamInfoError(e.toString()));
      }
    });
    on<AddTeamInfo>((event, emit) async {
      emit(TeamInfoLoading());
      try {
        await addTeamInfoUseCase.execute(event.teamInfoData);
        emit(TeamInfoSuccess());
      } on NoInternetException catch (_) {
        emit(TeamInfoNoInternet("No Internet Connection"));
      } catch (e) {
        emit(TeamInfoError(e.toString()));
      }
    });
    on<DeleteTeamInfo>((event, emit) async {
      emit(TeamInfoLoading());
      try {
        await deleteTeamInfoUseCase.execute(event.teamInfoID);
        emit(TeamInfoSuccess());
      } on NoInternetException catch (_) {
        emit(TeamInfoNoInternet("No Internet Connection"));
      } catch (e) {
        emit(TeamInfoError(e.toString()));
      }
    });
    on<UpdateTeamInfo>((event, emit) async {
      emit(TeamInfoLoading());
      try {
        await updateTeamInfoUseCase.execute(event.teamInfoEntity);
        emit(TeamInfoSuccess());
      } on NoInternetException catch (_) {
        emit(TeamInfoNoInternet("No Internet Connection"));
      } catch (e) {
        emit(TeamInfoError(e.toString()));
      }
    });
  }
}
