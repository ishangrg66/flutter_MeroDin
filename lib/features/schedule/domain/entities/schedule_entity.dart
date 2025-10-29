import '../../data/models/schedule_model.dart';

class ScheduleEntity {
  final int id;
  final String title;
  final String endTime;
  final String scheduleDate;
  final String scheduleTime;
  final String guest;
  final int priority;
  final int visibility;
  final String description;

  ScheduleEntity({
    required this.id,
    required this.title,
    required this.endTime,
    required this.scheduleDate,
    required this.scheduleTime,
    required this.guest,
    required this.priority,
    required this.visibility,
    required this.description,
  });

  factory ScheduleEntity.fromModel(ScheduleModel model) {
    return ScheduleEntity(
      id: model.id,
      title: model.title,
      endTime: model.endTime,
      scheduleDate: model.scheduleDate,
      scheduleTime: model.scheduleTime,
      guest: model.guest,
      priority: model.priority,
      visibility: model.visibility,
      description: model.description,
    );
  }
}
