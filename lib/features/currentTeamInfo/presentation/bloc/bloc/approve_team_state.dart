abstract class ApproveTeamState {}

class ApproveTeamInitial extends ApproveTeamState {}

class ApproveTeamLoading extends ApproveTeamState {}

class ApproveTeamSuccess extends ApproveTeamState {
  final String message;

  ApproveTeamSuccess(this.message);
}

class ApproveTeamError extends ApproveTeamState {
  final String message;

  ApproveTeamError(this.message);
}
