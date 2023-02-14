import 'package:flutter/material.dart';
import 'package:teacher_pro/ui/widgets/text_field_widget.dart';
import '../../../services/entities/grade.dart';
import '../add_widget.dart';

//TODO: Edit it and add inherited data
class EditGradeWidget extends StatelessWidget {
  const EditGradeWidget({required this.grade, super.key});

  final Grade grade;

  @override
  Widget build(BuildContext context) {
    return AddWidget(formFields: [
      TextFieldWidget(
          value: grade.grade.toString(),
          text: 'Grade',
          type: const TextInputType.numberWithOptions()),
      TextFieldWidget(value: grade.lesson.toString(), text: 'Lesson'),
      //TODO: dropdown list of students from lesson
      TextFieldWidget(value: grade.student.value!.name, text: 'Name'),
      TextFieldWidget(value: grade.student.value!.surrname, text: 'Surrname'),
      TextFieldWidget(
          value: grade.student.value!.registerNo.toString(),
          text: 'Register Number',
          type: TextInputType.number),
    ]);
  }
}
