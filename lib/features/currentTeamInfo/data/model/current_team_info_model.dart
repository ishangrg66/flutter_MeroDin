import 'package:mero_din_app/features/currentTeamInfo/domain/entities/current_team_info_entity.dart';

class CurrentTeamInfoModel extends CurrentTeamInfoEntity {
  CurrentTeamInfoModel({
    required super.teamInfoID,
    required super.userID,
    required super.role,
    required super.statusName,

    required super.updateKey,
    required super.recordStatus,
    required super.id,
    required super.teamName,
    required super.teamCode,
    required super.teamImage,
  });

  // From JSON
  factory CurrentTeamInfoModel.fromJson(Map<String, dynamic> json) {
    return CurrentTeamInfoModel(
      teamInfoID: json['teamInfoID'] != null ? json['teamInfoID'] as int : 0,
      userID: json['userID'] != null ? json['userID'] as int : 0,
      role: json['role'] != null ? json['role'] as int : 0,
      statusName: json['statusName'] != null
          ? json['statusName'] as String
          : '',

      updateKey: json['updateKey'] != null ? json['updateKey'] as String : '',
      recordStatus: json['recordStatus'] != null
          ? json['recordStatus'] as int
          : 0,
      id: json['id'] != null ? json['id'] as int : 0,
      teamName: json['teamName'] != null ? json['teamName'] as String : '',
      teamCode: json['teamCode'] != null ? json['teamCode'] as String : '',
      teamImage: json['teamImage'] != null ? json['teamImage'] as String : '',
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'teamInfoID': teamInfoID,
      'userID': userID,
      'role': role,
      'teamName': teamName,
      'teamCode': teamCode,
      'teamImage': teamImage,
      'statusName': statusName,

      'updateKey': updateKey,
      'recordStatus': recordStatus,
      'id': id,
    };
  }
}
