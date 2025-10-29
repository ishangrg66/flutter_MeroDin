import '../repositories/schedule_repository.dart';
import '../entities/schedule_entity.dart';

class AddScheduleUseCase {
  final ScheduleRepository repository;

  AddScheduleUseCase(this.repository);

  Future<void> call(ScheduleEntity schedule) async {
    await repository.addSchedule(schedule);
  }
}
