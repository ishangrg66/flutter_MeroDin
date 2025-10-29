import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/schedule_entity.dart';
import '../bloc/schedule_bloc.dart';
import '../bloc/schedule_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomScheduleForm extends StatefulWidget {
  final NepaliDateTime selectedDate;
  final int scheduleInfoId;
  const BottomScheduleForm({
    super.key,
    required this.selectedDate,
    this.scheduleInfoId = 0,
  });

  @override
  State<BottomScheduleForm> createState() => _BottomScheduleFormState();
}

class _BottomScheduleFormState extends State<BottomScheduleForm> {
  final titleController = TextEditingController();
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  int visibility = 1;

  Future<void> _pickTime(bool isStart) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }

  void _save() async {
    if (titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter title')));
      return;
    }
    if (_startTime == null || _endTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select start and end time')),
      );
      return;
    }

    // format values
    final englishDate = NepaliDateFormat(
      "yyyy-MM-dd",
      Language.english,
    ).format(widget.selectedDate);
    final startTimeFormatted =
        '${_startTime!.hour.toString().padLeft(2, '0')}:${_startTime!.minute.toString().padLeft(2, '0')}';
    final endTimeFormatted =
        '${_endTime!.hour.toString().padLeft(2, '0')}:${_endTime!.minute.toString().padLeft(2, '0')}';

    final newSchedule = ScheduleEntity(
      id: 0,

      title: titleController.text.trim(),
      scheduleDate: englishDate,
      scheduleTime: startTimeFormatted,
      guest: 'Default Guest',
      priority: 1,

      endTime: endTimeFormatted,
      description: 'Default Description',
      visibility: visibility,
    );

    context.read<ScheduleBloc>().add(AddNewSchedule(newSchedule));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Schedule saved successfully')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Add Schedule",
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Title Field
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              hintMaxLines: 4,
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),

          // Start Time
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => _pickTime(true),
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Start Time',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.access_time),
                    ),
                    child: Text(
                      _startTime == null
                          ? 'Select start time'
                          : _startTime!.format(context),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // End Time
              Expanded(
                child: InkWell(
                  onTap: () => _pickTime(false),
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'End Time',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.access_time),
                    ),
                    child: Text(
                      _endTime == null
                          ? 'Select end time'
                          : _endTime!.format(context),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Visibility
          DropdownButtonFormField<int>(
            initialValue: visibility,
            decoration: const InputDecoration(
              labelText: 'Visibility',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: 1, child: Text('Visible (All Users)')),
              DropdownMenuItem(value: 0, child: Text('Hidden (Admin Only)')),
            ],
            onChanged: (val) => setState(() => visibility = val!),
          ),
          const SizedBox(height: 20),

          // Save Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.save_rounded),
              label: const Text('Save Schedule'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _save,
            ),
          ),
        ],
      ),
    );
  }
}
