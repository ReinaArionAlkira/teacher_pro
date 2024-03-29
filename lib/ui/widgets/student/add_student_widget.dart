import 'package:flutter/material.dart';
import 'package:teacher_pro/services/entities/student.dart';
import 'package:teacher_pro/services/student_service.dart';
import 'package:teacher_pro/ui/widgets/text_field_widget.dart';

import '../add_widget.dart';

class AddStudentWidget extends StatefulWidget {
  const AddStudentWidget({super.key});

  @override
  State<AddStudentWidget> createState() => _AddStudentWidgetState();
}

class _AddStudentWidgetState extends State<AddStudentWidget> {
  final StudentService studentService = StudentService();

  String name = '';
  String surrname = '';
  int registerNo = 0;

  @override
  Widget build(BuildContext context) {
    return AddWidget(
      onSubmit: () async {
        await studentService.createStudent(
          Student()
            ..name = name
            ..surrname = surrname
            ..registerNo = registerNo,
        );
      },
      formFields: [
        TextFieldWidget(
          text: 'Name',
          onSaved: (val) => name = val ?? "",
        ),
        TextFieldWidget(
          text: 'Surrname',
          onSaved: (val) => surrname = val ?? "",
        ),
        TextFieldWidget(
            text: 'Register Number',
            onSaved: (val) => registerNo = int.parse(val ?? "0"),
            type: TextInputType.number),
      ],
    );
  }
}
