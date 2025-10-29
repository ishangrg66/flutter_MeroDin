import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mero_din_app/features/currentTeamInfo/data/datasources/approve_team_remote_datasource.dart';
import 'approve_team_event.dart';
import 'approve_team_state.dart';

class ApproveTeamBloc extends Bloc<ApproveTeamEvent, ApproveTeamState> {
  final ApproveTeamRemoteDatasource datasource;

  ApproveTeamBloc(this.datasource) : super(ApproveTeamInitial()) {
    on<ApproveTeamAction>((event, emit) async {
      emit(ApproveTeamLoading());

      try {
        await datasource.approveTeam(event.teamId, event.action);
        emit(ApproveTeamSuccess("Status updated successfully"));
      } catch (e) {
        emit(ApproveTeamError(e.toString()));
      }
    });
  }
}
