import '../repositories/schedule_repository.dart';
import '../entities/schedule_entity.dart';

class GetSchedulesUseCase {
  final ScheduleRepository repository;

  GetSchedulesUseCase(this.repository);

  Future<List<ScheduleEntity>> call() async {
    return await repository.getSchedules();
  }
}
