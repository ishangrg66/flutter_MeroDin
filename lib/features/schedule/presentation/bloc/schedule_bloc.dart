import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mero_din_app/features/schedule/domain/usecases/add_schedule_usecase.dart';
import 'package:mero_din_app/features/schedule/domain/usecases/get_schedule_usecase.dart';
import 'package:mero_din_app/features/schedule/presentation/bloc/schedule_event.dart';
import 'package:mero_din_app/features/schedule/presentation/bloc/schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final GetSchedulesUseCase getSchedules;
  final AddScheduleUseCase addSchedule;

  ScheduleBloc(this.getSchedules, this.addSchedule) : super(ScheduleInitial()) {
    on<LoadSchedules>((event, emit) async {
      emit(ScheduleLoading());
      try {
        final schedules = await getSchedules();
        emit(ScheduleLoaded(schedules));
      } catch (e) {
        emit(ScheduleError(e.toString()));
      }
    });

    on<AddNewSchedule>((event, emit) async {
      try {
        await addSchedule(event.schedule);
        add(LoadSchedules()); // refresh after adding
      } catch (e) {
        emit(ScheduleError(e.toString()));
      }
    });
  }
}
