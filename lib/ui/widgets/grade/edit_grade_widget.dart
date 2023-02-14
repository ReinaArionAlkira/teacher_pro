import 'dart:async';

import 'package:flutter/material.dart';
import 'package:teacher_pro/ui/widgets/details_layout_widget.dart';
import 'package:teacher_pro/ui/widgets/edit_widget.dart';
import 'package:teacher_pro/ui/widgets/text_field_widget.dart';
import '../../../services/entities/grade.dart';
import '../../../services/entities/lesson.dart';
import '../../../services/entities/student.dart';
import '../../../services/grade_service.dart';
import '../../../services/lesson_service.dart';
import '../../../services/student_service.dart';
import '../drop_down_menu_Widget.dart';

enum Mode { view, edit }

class EditGradeWidget extends StatefulWidget {
  const EditGradeWidget({required this.grade, super.key});

  final Grade grade;

  @override
  State<EditGradeWidget> createState() => _EditGradeWidgetState();
}

class _EditGradeWidgetState extends State<EditGradeWidget> {
  final GradeService gradeService = GradeService();
  final LessonService lessonService = LessonService();
  final StudentService studentService = StudentService();

  List<Lesson> lessons = [];
  List<Student> students = [];

  final List<double> gradez = [2.5, 3.0, 3.5, 4.0, 4.5, 5.0];

  Student? student;
  StreamSubscription? sub;

  Lesson? lesson;

  @override
  initState() {
    super.initState();
    lessonService.getAllLessons().first.then((value) => setState(() {
          lessons = value;
          lesson = lessons
              .where((element) => element.id == grade.lesson.value?.id)
              .first;
        }));
    studentService
        .getAllStudents()
        // .getAllStudentsFromLesson(lesson!)
        .first
        .then((value) => setState(() => students = value));
  }

  Grade get grade => widget.grade;

  Mode mode = Mode.view;
  bool get editable => mode == Mode.edit;

  @override
  Widget build(BuildContext context) {
    return DetailsLayoutWidget(
        editButtonActive: mode == Mode.view,
        onEdit: () => setState(() {
              mode = Mode.edit;
            }),
        body: EditWidget(
          onCancel: () => setState(() => mode = Mode.view),
          mode: mode,
          // onSubmit: () async {
          //   await gradeService.editGrade(
          //       grade.id,
          //       Grade()
          //         ..grade = grade.grade
          //         ..lesson.value = lesson
          //         ..student.value = student);
          // },
          formFields: mode == Mode.view
              ? [
                  TextFieldWidget(
                      editable: false,
                      value: grade.grade.toString(),
                      text: 'Grade',
                      type: const TextInputType.numberWithOptions()),
                  ListTile(
                    title: TextFieldWidget(
                        editable: false,
                        value: grade.lesson.toString(),
                        text: 'Lesson'),
                    subtitle: TextFieldWidget(
                        editable: false,
                        value: grade.lesson.value!.day,
                        text: 'Day: '),
                  ),

                  //TODO: dropdown list of students from lesson
                  TextFieldWidget(
                      editable: false,
                      value: grade.student.value!.name,
                      text: 'Name'),
                  TextFieldWidget(
                      editable: false,
                      value: grade.student.value!.surrname,
                      text: 'Surrname'),
                  TextFieldWidget(
                      editable: false,
                      value: grade.student.value!.registerNo.toString(),
                      text: 'Register Number',
                      type: TextInputType.number),
                ]
              : [
                  DropDownMenuWidget(
                    val: grade.grade,
                    list: gradez,
                    text: "Grade",
                    onChanged: (value) =>
                        setState(() => grade.grade = value ?? 2.5),
                  ),
                  DropDownMenuWidget(
                    val: lesson,
                    text: "Lesson",
                    list: lessons,
                    onChanged: (value) => setState(() => lesson = value!),
                  ),
                  //TODO: students from chosen lesson
                  // DropDownMenuWidget(
                  //   val: grade.student.value,
                  //   text: "Student",
                  //   list: students,
                  //   onChanged: (value) => setState(() => student = value!),
                  // ),
                ],
        ));
  }
}
