class TeamInfoEntity {
  final int teamInfoId;
  final String teamInfoName;
  final String teamInfoCode;
  final String? teamInfoimage;
  final String updateKey;

  final int recordStatus;
  TeamInfoEntity({
    required this.teamInfoId,
    required this.teamInfoName,
    required this.teamInfoCode,
    required this.teamInfoimage,
    required this.updateKey,
    required this.recordStatus,
  });
}
