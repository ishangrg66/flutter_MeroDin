class CurrentTeamInfoEntity {
  final int teamInfoID;
  final int userID;
  final int role;

  final String teamName;
  final String teamCode;
  final String teamImage;
  final String statusName;
  final String updateKey;
  final int recordStatus;
  final int id;

  CurrentTeamInfoEntity({
    required this.teamInfoID,
    required this.userID,
    required this.role,
    required this.teamName,
    required this.teamCode,
    required this.teamImage,
    required this.statusName,

    required this.updateKey,
    required this.recordStatus,
    required this.id,
  });
}
