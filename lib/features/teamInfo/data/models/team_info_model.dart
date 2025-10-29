import 'package:mero_din_app/features/teamInfo/domain/entities/team_info_entities.dart';

class TeamInfoModel extends TeamInfoEntity {
  TeamInfoModel({
    required super.teamInfoId,
    required super.teamInfoName,
    required super.teamInfoCode,
    required super.teamInfoimage,
    required super.updateKey,
    required super.recordStatus,
  });
  factory TeamInfoModel.fromJson(Map<String, dynamic> json) {
    return TeamInfoModel(
      teamInfoId: json['id'] as int,
      teamInfoName: json['teamName'] as String,
      teamInfoCode: json['teamCode'] as String,
      teamInfoimage: json['image'] as String,
      updateKey: json['updateKey'] as String,
      recordStatus: json['recordStatus'] as int,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': teamInfoId,
      'teamName': teamInfoName,
      'teamCode': teamInfoCode,
      'image': teamInfoimage,
      'updateKey': updateKey,
      'recordStatus': recordStatus,
    };
  }
}
