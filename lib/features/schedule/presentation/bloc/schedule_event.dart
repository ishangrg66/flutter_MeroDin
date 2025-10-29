import 'package:mero_din_app/features/schedule/domain/entities/schedule_entity.dart';

abstract class ScheduleEvent {}

class LoadSchedules extends ScheduleEvent {}

class AddNewSchedule extends ScheduleEvent {
  final ScheduleEntity schedule;
  AddNewSchedule(this.schedule);
}
