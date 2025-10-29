abstract class ApproveTeamEvent {}

class ApproveTeamAction extends ApproveTeamEvent {
  final int teamId;
  final int action; // 1 = Approve, 0 = Delete, -1 = Reject

  ApproveTeamAction({required this.teamId, required this.action});
}
