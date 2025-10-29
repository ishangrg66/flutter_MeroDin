import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mero_din_app/features/schedule/presentation/bloc/schedule_bloc.dart';
import 'package:mero_din_app/features/schedule/presentation/bloc/schedule_event.dart';
import 'package:mero_din_app/features/schedule/presentation/bloc/schedule_state.dart';
import 'package:mero_din_app/features/schedule/presentation/pages/add_schedule_form.dart';
import 'package:mero_din_app/features/schedule/presentation/widgets/drawer.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:nepali_utils/nepali_utils.dart';
import '../../domain/entities/schedule_entity.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  NepaliDateTime _focusedDay = NepaliDateTime.now();
  NepaliDateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    context.read<ScheduleBloc>().add(LoadSchedules());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<ScheduleBloc>().add(LoadSchedules());
        await Future.delayed(const Duration(seconds: 1));
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('मेरो तालिका (My Schedule)')),
        drawer: const AppDrawer(),

        body: BlocBuilder<ScheduleBloc, ScheduleState>(
          builder: (context, state) {
            if (state is ScheduleLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ScheduleLoaded) {
              return _buildNepaliCalendarWithList(state.schedules);
            } else if (state is ScheduleError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildNepaliCalendarWithList(List<ScheduleEntity> schedules) {
    // Filter schedules for selected Nepali date
    final selectedSchedules = _selectedDay == null
        ? []
        : schedules.where((s) {
            final scheduleDate = DateTime.parse(s.scheduleDate); // parse string
            final nepDate = NepaliDateTime.fromDateTime(scheduleDate);
            return nepDate.year == _selectedDay!.year &&
                nepDate.month == _selectedDay!.month &&
                nepDate.day == _selectedDay!.day;
          }).toList();

    return SingleChildScrollView(
      child: Column(
        children: [
          TableCalendar(
            firstDay: NepaliDateTime(2070, 1, 1).toDateTime(),
            lastDay: NepaliDateTime(2090, 12, 30).toDateTime(),
            focusedDay: _focusedDay.toDateTime(),
            selectedDayPredicate: (day) =>
                _selectedDay?.toDateTime().isAtSameMomentAs(day) ?? false,
            onDaySelected: (selected, focused) {
              setState(() {
                _selectedDay = NepaliDateTime.fromDateTime(selected);
                _focusedDay = NepaliDateTime.fromDateTime(focused);
              });
            },
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                final nepDay = NepaliDateTime.fromDateTime(day);
                return _dayCell(nepDay.day, day.day);
              },
              todayBuilder: (context, day, focusedDay) {
                final nepDay = NepaliDateTime.fromDateTime(day);
                return _dayCell(nepDay.day, day.day, isToday: true);
              },
              selectedBuilder: (context, day, focusedDay) {
                final nepDay = NepaliDateTime.fromDateTime(day);
                return _dayCell(nepDay.day, day.day, isSelected: true);
              },
              markerBuilder: (context, date, _) {
                final hasEvent = schedules.any((s) {
                  final scheduleDate = DateTime.parse(
                    s.scheduleDate,
                  ); // parse string
                  final nepDate = NepaliDateTime.fromDateTime(scheduleDate);
                  final d = NepaliDateTime.fromDateTime(date);
                  return nepDate.year == d.year &&
                      nepDate.month == d.month &&
                      nepDate.day == d.day;
                });
                if (hasEvent) {
                  return Positioned(
                    bottom: 2,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }
                return null;
              },
            ),
            headerStyle: const HeaderStyle(formatButtonVisible: false),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (_selectedDay != null) {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) => Material(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        child: BottomScheduleForm(selectedDate: _selectedDay!),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select a date first'),
                      ),
                    );
                  }
                },
                child: Text("नया थाप्नुहोस"),
              ),
              SizedBox(width: 10),
            ],
          ),

          const SizedBox(height: 16),
          if (_selectedDay != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'कार्यतालिका (${NepaliDateFormat("yyyy/MM/dd").format(_selectedDay!)})',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          const SizedBox(height: 8),
          if (selectedSchedules.isEmpty && _selectedDay != null)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'यो दिनको लागि कुनै तालिका छैन ।',
                style: TextStyle(color: Color.fromARGB(255, 145, 144, 144)),
              ),
            ),
          ...selectedSchedules.map(
            (s) => Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                leading: const Icon(Icons.event, color: Colors.green),
                title: Text(s.title),
                subtitle: Text(s.description),
                trailing: Text(
                  s.scheduleTime.isNotEmpty ? s.scheduleTime : 'No time',
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _dayCell(
    int nepaliDay,
    int engDay, {
    bool isToday = false,
    bool isSelected = false,
  }) {
    final bgColor = isSelected
        ? Colors.blue.shade100
        : (isToday ? Colors.green.shade50 : Colors.white);
    final borderColor = isSelected
        ? Colors.blue
        : (isToday ? Colors.green.shade200 : Colors.grey.shade300);

    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            NepaliNumberFormat().format(nepaliDay),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isToday ? Colors.green.shade800 : Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$engDay',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }
}
