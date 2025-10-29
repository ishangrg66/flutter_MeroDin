import 'package:flutter/material.dart';
import 'package:mero_din_app/features/auth/presentation/pages/login_screen.dart';
import 'package:mero_din_app/features/auth/presentation/pages/signup_screen.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:nepali_utils/nepali_utils.dart';

class NepaliCalendar extends StatefulWidget {
  const NepaliCalendar({super.key});

  @override
  State<NepaliCalendar> createState() => _NepaliCalendarState();
}

class _NepaliCalendarState extends State<NepaliCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final selectedNepaliDate = _selectedDay != null
        ? NepaliDateTime.fromDateTime(_selectedDay!)
        : null;

    return Scaffold(
      appBar: AppBar(title: const Text('Calendar')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 8),
            TableCalendar(
              firstDay: DateTime(2010, 1, 1),
              lastDay: DateTime(2035, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              headerVisible: false,
              calendarFormat: CalendarFormat.month,
              calendarStyle: const CalendarStyle(outsideDaysVisible: false),
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  final nepali = NepaliDateTime.fromDateTime(day);
                  return _dayCell(nepali.day, day.day, false);
                },
                todayBuilder: (context, day, focusedDay) {
                  final nepali = NepaliDateTime.fromDateTime(day);
                  return _dayCell(nepali.day, day.day, true);
                },
                selectedBuilder: (context, day, focusedDay) {
                  final nepali = NepaliDateTime.fromDateTime(day);
                  return _dayCell(nepali.day, day.day, false, true);
                },
              ),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
            ),
            const SizedBox(height: 16),

            if (selectedNepaliDate != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selected Date Details',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '📅 Nepali: ${NepaliDateFormat('yyyy MMMM d').format(selectedNepaliDate)}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      '🌍 English: ${_selectedDay!.toLocal().toString().split(' ')[0]}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 24),

            // Login / Create Account buttons
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade700,
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Login'),
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: BorderSide(color: Colors.green.shade700),
                  ),
                  child: const Text('Create Account'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final nepaliMonth = NepaliDateFormat(
      'MMMM yyyy',
    ).format(NepaliDateTime.fromDateTime(_focusedDay));
    final engMonth = "${_focusedDay.year} ${_monthName(_focusedDay.month)}";

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            setState(() {
              _focusedDay = DateTime(
                _focusedDay.year,
                _focusedDay.month - 1,
                1,
              );
            });
          },
        ),
        Column(
          children: [
            Text(
              nepaliMonth,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Text(engMonth, style: TextStyle(color: Colors.grey.shade700)),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: () {
            setState(() {
              _focusedDay = DateTime(
                _focusedDay.year,
                _focusedDay.month + 1,
                1,
              );
            });
          },
        ),
      ],
    );
  }

  Widget _dayCell(
    int nepaliDay,
    int engDay,
    bool isToday, [
    bool isSelected = false,
  ]) {
    final bg = isSelected
        ? Colors.blue.shade100
        : (isToday ? Colors.green.shade50 : Colors.white);
    final border = isSelected
        ? Border.all(color: Colors.blue)
        : Border.all(color: Colors.grey.shade300);

    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: border,
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

  String _monthName(int m) {
    const names = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return names[m];
  }
}
