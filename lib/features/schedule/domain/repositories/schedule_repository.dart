import '../entities/schedule_entity.dart';

abstract class ScheduleRepository {
  Future<List<ScheduleEntity>> getSchedules();
  Future<void> addSchedule(ScheduleEntity schedule);
}
