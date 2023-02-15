import 'dart:async';

import 'package:flutter/material.dart';
import 'package:teacher_pro/services/entities/grade.dart';
import 'package:teacher_pro/services/student_service.dart';

import '../../../services/entities/lesson.dart';
import '../../../services/entities/student.dart';
import '../../../services/grade_service.dart';
import '../../../services/lesson_service.dart';
import '../add_widget.dart';
import '../drop_down_menu_Widget.dart';

class AddGradeWidget extends StatefulWidget {
  const AddGradeWidget({super.key});

  @override
  State<AddGradeWidget> createState() => _AddGradeWidgetState();
}

class _AddGradeWidgetState extends State<AddGradeWidget> {
  final GradeService gradeService = GradeService();
  final LessonService lessonService = LessonService();
  final StudentService studentService = StudentService();

  List<Lesson> lessons = [];
  List<Student> students = [];

  double grade = 2.5;

  final List<double> gradez = [2.5, 3.0, 3.5, 4.0, 4.5, 5.0];

  Student? student;
  StreamSubscription? sub;

  Lesson? lesson;

  @override
  initState() {
    super.initState();
    lessonService
        .getAllLessons()
        .first
        .then((value) => setState(() => lessons = value));
  }

  @override
  Widget build(BuildContext context) {
    return AddWidget(
        onSubmit: () async {
          await gradeService.createGrade(Grade()
            ..grade = grade
            ..lesson.value = lesson
            ..student.value = student);
        },
        formFields: [
          DropDownMenuWidget(
            val: grade,
            list: gradez,
            text: "Grade",
            onChanged: (value) => setState(() => grade = value ?? 2.5),
          ),
          DropDownMenuWidget(
            val: lesson,
            text: "Lesson",
            list: lessons,
            onChanged: (value) => studentService
                .getAllStudentsFromLesson(value!)
                .first
                .then((students) => setState(() {
                      lesson = value;
                      this.students = students;
                      student = null;
                    })),
          ),
          DropDownMenuWidget(
            disabledHint: const Text("Choose lesson"),
            val: student,
            text: "Student",
            list: students,
            onChanged: (value) => setState(() => student = value!),
          ),
        ]);
  }
}
