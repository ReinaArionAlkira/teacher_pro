import 'package:flutter/material.dart';
import 'package:teacher_pro/services/entities/student.dart';
import 'package:teacher_pro/services/student_service.dart';
import 'package:teacher_pro/ui/widgets/text_field_widget.dart';

import '../add_widget.dart';

//TODO: Edit it and add inherited data
class EditStudentWidget extends StatefulWidget {
  const EditStudentWidget({super.key});

  @override
  State<EditStudentWidget> createState() => _EditStudentWidgetState();
}

class _EditStudentWidgetState extends State<EditStudentWidget> {
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
