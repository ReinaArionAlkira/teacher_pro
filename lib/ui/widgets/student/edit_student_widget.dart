import 'package:flutter/material.dart';
import 'package:teacher_pro/services/entities/student.dart';
import 'package:teacher_pro/services/student_service.dart';
import 'package:teacher_pro/ui/widgets/text_field_widget.dart';

import '../../../services/entities/grade.dart';
import '../../../services/entities/lesson.dart';
import '../../../services/grade_service.dart';
import '../../../services/lesson_service.dart';
import '../details_layout_widget.dart';
import '../edit_widget.dart';
import '../grade/list_of_grades_widget.dart';
import '../lesson/list_of_lessons_widget.dart';

//TODO: Edit it and add inherited data
class EditStudentWidget extends StatefulWidget {
  const EditStudentWidget({required this.student, super.key});

  final Student student;

  @override
  State<EditStudentWidget> createState() => _EditStudentWidgetState();
}

class _EditStudentWidgetState extends State<EditStudentWidget> {
  final GradeService gradeService = GradeService();
  final LessonService lessonService = LessonService();
  final StudentService studentService = StudentService();

  List<Lesson> lessons = [];
  List<Grade> grades = [];

  String name = '';
  String surrname = '';
  int registerNo = 0;
  int index = 0;

  late Student student = widget.student;

  Student studentDraft = Student();

  Mode mode = Mode.view;
  bool get editable => mode == Mode.edit;

  Future<void> applyDraft() async {
    await studentService.editStudent(widget.student.registerNo!, studentDraft);
    setState(() {
      student.name = studentDraft.name;
      student.surrname = studentDraft.surrname;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: DetailsLayoutWidget(
        editButtonActive: index == 0,
        bottom: TabBar(
          onTap: (value) => setState(() {
            index = value;
          }),
          tabs: const [
            Tab(text: 'Summary'),
            Tab(text: 'Grades'),
            Tab(text: 'Lessons'),
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
                // initDraftFromGrade();
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
                        value: student.name,
                        text: 'Name',
                        onSaved: (val) => name = val ?? "",
                      ),
                      TextFieldWidget(
                        editable: false,
                        value: student.surrname,
                        text: 'Surrname',
                        onSaved: (val) => surrname = val ?? "",
                      ),
                      TextFieldWidget(
                          editable: false,
                          value: student.registerNo.toString(),
                          text: 'Register Number',
                          onSaved: (val) => registerNo = int.parse(val ?? "0"),
                          type: TextInputType.number),
                      FutureBuilder(
                          future: gradeService
                              .getCountGradesForStudent(student.registerNo!),
                          builder: (BuildContext context,
                              AsyncSnapshot<int> snapshot) {
                            return TextFieldWidget(
                                editable: false,
                                value:
                                    'Number of grades: ${snapshot.hasData ? snapshot.data : "0"}',
                                text: 'Number of grades',
                                onSaved: (val) =>
                                    registerNo = int.parse(val ?? "0"),
                                type: TextInputType.number);
                          }),
                      FutureBuilder(
                          future: lessonService
                              .getCountLessonsForStudent(student.registerNo!),
                          builder: (BuildContext context,
                              AsyncSnapshot<int> snapshot) {
                            return TextFieldWidget(
                                editable: false,
                                value:
                                    'Number of lessons: ${snapshot.hasData ? snapshot.data : "0"}',
                                text: 'Number of lessons',
                                onSaved: (val) =>
                                    registerNo = int.parse(val ?? "0"),
                                type: TextInputType.number);
                          }),
                    ]
                  : [
                      TextFieldWidget(
                        value: student.name,
                        text: 'Name',
                        onSaved: (val) =>
                            setState(() => studentDraft.name = val),
                      ),
                      TextFieldWidget(
                        value: student.surrname,
                        text: 'Surrname',
                        onSaved: (val) =>
                            setState(() => studentDraft.surrname = val),
                      ),
                    ],
            ),
            ListOfGradesWidget(
                stream: () => gradeService.getAllGradesFromStudent(student)),
            ListOfLessonsWidget(
                stream: () => lessonService
                    .getAllLessonsFromStudent(student.registerNo!)),
          ],
        ),
        // onSubmit: () async {
        //   await studentService.editStudent(
        //     registerNo,
        //     Student()
        //       ..name = name
        //       ..surrname = surrname
        //       ..registerNo = registerNo,
        //   );
        // },
      ),
    );
  }
}
