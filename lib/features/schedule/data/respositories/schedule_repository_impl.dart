import 'package:mero_din_app/features/schedule/data/datasources/schedule_remote_datasource.dart';

import '../../domain/entities/schedule_entity.dart';
import '../../domain/repositories/schedule_repository.dart';
import '../models/schedule_model.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleRemoteDataSource remoteDataSource;

  ScheduleRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ScheduleEntity>> getSchedules() async {
    final result = await remoteDataSource.getSchedules();
    return result.map((e) => ScheduleEntity.fromModel(e)).toList();
  }

  @override
  Future<void> addSchedule(ScheduleEntity schedule) async {
    final model = ScheduleModel(
      id: schedule.id,
      title: schedule.title,
      endTime: schedule.endTime,
      scheduleDate: schedule.scheduleDate,
      scheduleTime: schedule.scheduleTime,
      guest: schedule.guest,
      priority: schedule.priority,
      visibility: schedule.visibility,
      description: schedule.description,
    );
    await remoteDataSource.addSchedule(model);
  }
}
