import 'dart:async';

import 'package:flutter/material.dart';
import 'package:teacher_pro/ui/widgets/details_layout_widget.dart';
import 'package:teacher_pro/ui/widgets/edit_widget.dart';
import 'package:teacher_pro/ui/widgets/text_field_widget.dart';
import 'package:teacher_pro/utils/time_range_convert.dart';
import '../../../services/entities/grade.dart';
import '../../../services/entities/lesson.dart';
import '../../../services/entities/student.dart';
import '../../../services/grade_service.dart';
import '../../../services/lesson_service.dart';
import '../../../services/student_service.dart';
import '../drop_down_menu_Widget.dart';

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

  @override
  initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    grade = widget.grade;
    final lessons = await lessonService.getAllLessons().first;
    final students = await studentService.getAllStudents().first;
    setState(() {
      this.lessons = lessons;
      this.students = students;
    });
    initDraftFromGrade();
  }

  Lesson findLessonForGrade(Grade grade) {
    return lessons
        .where((element) => element.id == grade.lesson.value?.id)
        .first;
  }

  Student findStudentForGrade(Grade grade) {
    return students
        .where(
            (element) => element.registerNo == grade.student.value?.registerNo)
        .first;
  }

  void initDraftFromGrade() {
    gradeDraft.id = grade.id;
    gradeDraft.grade = grade.grade;
    gradeDraft.lesson.value = findLessonForGrade(grade);
    gradeDraft.student.value = findStudentForGrade(grade);
  }

  Future<void> applyDraft() async {
    await gradeService.editGrade(widget.grade.id, gradeDraft);
    setState(() {
      grade.grade = gradeDraft.grade;
      grade.lesson.value = gradeDraft.lesson.value;
      grade.student.value = gradeDraft.student.value;
    });
  }

  late Grade grade;
  Grade gradeDraft = Grade();

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
          mode: mode,
          onCancel: () {
            initDraftFromGrade();
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
                      value: 'Grade: ${grade.grade.toString()}',
                      text: 'Grade',
                      type: const TextInputType.numberWithOptions()),
                  TextFieldWidget(
                      editable: false,
                      value: 'Lesson: ${grade.lesson.value!.name}',
                      text: 'Lesson'),
                  TextFieldWidget(
                      editable: false,
                      value: 'Day: ${grade.lesson.value!.day}',
                      text: 'Day of lesson: '),
                  TextFieldWidget(
                      editable: false,
                      value:
                          'Hours of lesson: ${minutesToTimeOfDay(grade.lesson.value!.fromTime!).format(context)} - ${minutesToTimeOfDay(grade.lesson.value!.toTime!).format(context)}',
                      text: 'Day: '),
                  TextFieldWidget(
                      editable: false,
                      value: 'Students name: ${grade.student.value!.name}',
                      text: 'Name'),
                  TextFieldWidget(
                      editable: false,
                      value:
                          'Students surrname: ${grade.student.value!.surrname}',
                      text: 'Surrname'),
                  TextFieldWidget(
                      editable: false,
                      value:
                          'Students Register number: ${grade.student.value!.registerNo.toString()}',
                      text: 'Register Number',
                      type: TextInputType.number),
                ]
              : [
                  DropDownMenuWidget(
                    val: gradeDraft.grade,
                    list: gradez,
                    text: "Grade",
                    onChanged: (value) =>
                        setState(() => gradeDraft.grade = value ?? 2.5),
                  ),
                  DropDownMenuWidget(
                    val: gradeDraft.lesson.value,
                    text: "Lesson",
                    list: lessons,
                    onChanged: (value) =>
                        setState(() => gradeDraft.lesson.value = value!),
                  ),
                  DropDownMenuWidget(
                    val: gradeDraft.student.value,
                    text: "Student",
                    list: students,
                    onChanged: (value) =>
                        setState(() => gradeDraft.student.value = value!),
                  ),
                ],
        ));
  }
}
