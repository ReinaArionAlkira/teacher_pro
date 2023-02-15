import 'package:flutter/material.dart';
import 'package:teacher_pro/services/entities/lesson.dart';
import 'package:teacher_pro/ui/widgets/details_layout_widget.dart';
import 'package:teacher_pro/ui/widgets/student/list_of_students_widget.dart';
import 'package:teacher_pro/ui/widgets/text_field_widget.dart';
import 'package:time_range_picker/time_range_picker.dart';
import '../../../services/entities/student.dart';
import '../../../services/grade_service.dart';
import '../../../services/lesson_service.dart';
import '../../../services/student_service.dart';
import '../../../utils/time_range_convert.dart';
import '../drop_down_menu_Widget.dart';
import '../edit_widget.dart';

class EditLessonWidget extends StatefulWidget {
  const EditLessonWidget({required this.lesson, super.key});

  final Lesson lesson;

  @override
  State<EditLessonWidget> createState() => _EditLessonWidgetState();
}

class _EditLessonWidgetState extends State<EditLessonWidget> {
  final GradeService gradeService = GradeService();
  final LessonService lessonService = LessonService();
  final StudentService studentService = StudentService();

  List<Lesson> lessons = [];
  List<Student> students = [];

  String name = '';
  int index = 0;

  @override
  initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    lesson = widget.lesson;
    final students = await studentService.getAllStudents().first;
    setState(() {
      this.students = students;
    });
  }

  late Lesson lesson = widget.lesson;

  Lesson lessonDraft = Lesson();

  Mode mode = Mode.view;
  bool get editable => mode == Mode.edit;

  Future<void> applyDraft() async {
    await lessonService.editLesson(widget.lesson.id, lessonDraft);
    setState(() {
      lesson.name = lessonDraft.name;
      lesson.day = lessonDraft.day;
      lesson.fromTime = lessonDraft.fromTime;
      lesson.toTime = lessonDraft.toTime;
    });
    //     ..fromTime = timeOfDayToMinutes(timeRange!.startTime)
    //     ..toTime = timeOfDayToMinutes(timeRange!.endTime),
  }

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
    return DefaultTabController(
      length: 2,
      child: DetailsLayoutWidget(
        editButtonActive: index == 0,
        bottom: TabBar(
          onTap: (value) => setState(() {
            index = value;
          }),
          tabs: const [
            Tab(text: 'Summary'),
            Tab(text: 'Students'),
          ],
        ),
        onEdit: () => setState(() {
          mode = Mode.edit;
        }),
        body: TabBarView(
          children: [
            EditWidget(
              mode: mode,
              onCancel: () {
                setState(() {
                  mode = Mode.view;
                });
              },
              onSubmit: () async {
                await applyDraft();
                setState(() {
                  mode = Mode.view;
                });
              },
              formFields: mode == Mode.view
                  ? [
                      TextFieldWidget(
                        editable: false,
                        value: lesson.name,
                        text: 'Name',
                        onSaved: (val) => name = val ?? "",
                      ),
                      TextFieldWidget(
                        editable: false,
                        value: lesson.day,
                        text: 'Day',
                        onSaved: (val) => day = val ?? "",
                      ),
                      TextFieldWidget(
                        editable: false,
                        value:
                            '${minutesToTimeOfDay(lesson.fromTime!).format(context)} - ${minutesToTimeOfDay(lesson.toTime!).format(context)}',
                        text: 'TimeRange',
                      ),
                      FutureBuilder(
                          future: studentService
                              .getCountStudentsForLesson(lesson.id),
                          builder: (BuildContext context,
                              AsyncSnapshot<int> snapshot) {
                            return TextFieldWidget(
                                editable: false,
                                value:
                                    'Number of students: ${snapshot.hasData ? snapshot.data : "0"}',
                                text: 'Number of students');
                          }),
                    ]
                  : [
                      TextFieldWidget(
                        onChange: (value) => setState(() => name = value!),
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
                                    startTime:
                                        const TimeOfDay(hour: 22, minute: 0),
                                    endTime:
                                        const TimeOfDay(hour: 6, minute: 0)),
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
                    ],
            ),
            Column(
              children: [
                DropDownMenuWidget(
                    text: "Students",
                    list: students,
                    onChanged: (value) => lessonService
                        .addStudentToLesson(lesson, value!)
                        .then((v) => setState(() {}))),
                ListOfStudentsWidget(
                    onDelete: (student) => lessonService
                        .deleteStudentFromLesson(lesson, student)
                        .then((v) => setState(() {})),
                    stream: () =>
                        studentService.getAllStudentsFromLesson(lesson)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
