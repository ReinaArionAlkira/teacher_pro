import 'package:flutter/material.dart';
import 'package:teacher_pro/services/entities/lesson.dart';
import 'package:teacher_pro/ui/widgets/text_field_widget.dart';
import 'package:time_range_picker/time_range_picker.dart';
import '../../../services/lesson_service.dart';
import '../../../utils/time_range_convert.dart';
import '../add_widget.dart';

class AddLessonWidget extends StatefulWidget {
  const AddLessonWidget({super.key});

  @override
  State<AddLessonWidget> createState() => _AddLessonWidgetState();
}

class _AddLessonWidgetState extends State<AddLessonWidget> {
  final LessonService lessonService = LessonService();

  String? name;

  String? day;

  final List<String> dayZ = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  TimeRange? timeRange;

  @override
  Widget build(BuildContext context) {
    return AddWidget(
        onSubmit: () async {
          await lessonService.createLesson(
            Lesson()
              ..name = name
              ..day = day
              ..fromTime = timeOfDayToMinutes(timeRange!.startTime)
              ..toTime = timeOfDayToMinutes(timeRange!.endTime),
          );
        },
        formFields: [
          TextFieldWidget(
            onChange: (value) => setState(() => name = value),
            type: TextInputType.text,
            text: 'Name',
          ),
          DropdownButtonFormField(
            value: day,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            isExpanded: true,
            hint: const Text("Day"),
            items: dayZ
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ))
                .toList(),
            onChanged: (value) => setState(() => day = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some data';
              }
              return null;
            },
          ),
          TextFormField(
              onTap: () async {
                TimeRange result = await showTimeRangePicker(
                    context: context,
                    minDuration: const Duration(minutes: 45),
                    disabledTime: TimeRange(
                        startTime: const TimeOfDay(hour: 22, minute: 0),
                        endTime: const TimeOfDay(hour: 6, minute: 0)),
                    rotateLabels: false,
                    start: const TimeOfDay(hour: 6, minute: 0),
                    labelOffset: -25,
                    ticks: 24,
                    labels: [
                      "0:00",
                      "3:00",
                      "6:00",
                      "9:00",
                      "12:00",
                      "15:00",
                      "18:00",
                      "21:00"
                    ].asMap().entries.map((e) {
                      return ClockLabel.fromIndex(
                          idx: e.key, length: 8, text: e.value);
                    }).toList());
                setState(() {
                  timeRange = result;
                });
              },
              readOnly: true,
              validator: (value) {
                if (timeRange == null) {
                  return "Choose time range";
                }
                return null;
              },
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: timeRange == null
                      ? "Select time range"
                      : "${timeRange!.startTime.format(context)} - ${timeRange!.endTime.format(context)}"))
        ]);
  }
}
