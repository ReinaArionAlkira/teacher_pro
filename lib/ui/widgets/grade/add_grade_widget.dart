import 'package:flutter/material.dart';
import 'package:teacher_pro/ui/widgets/text_field_widget.dart';

import '../../../services/entities/lesson.dart';
import '../../../services/entities/student.dart';
import '../../../services/grade_service.dart';
import '../add_widget.dart';

//TODO: Edit it
class AddGradeWidget extends StatefulWidget {
  const AddGradeWidget({super.key});

  @override
  State<AddGradeWidget> createState() => _AddGradeWidgetState();
}

class _AddGradeWidgetState extends State<AddGradeWidget> {
  final GradeService gradeService = GradeService();

  double grade = 2.5;
  final List<double> gradez = [2.5, 3.0, 3.5, 4.0, 4.5, 5.0];

  late final Student student;

  late final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    return AddWidget(formFields: [
      DropdownButtonFormField(
        value: grade,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
        isExpanded: true,
        hint: const Text("Grade"),
        items: gradez
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e.toString()),
                ))
            .toList(),
        onChanged: (value) => setState(() => grade = value!),
        validator: (value) {
          if (value == null) {
            return 'Please enter some data';
          }
          return null;
        },
      ),

      //TODO: dropdown list of existing lessons
      TextFieldWidget(text: 'Lesson'),
      //TODO: dropdown list of students from chosen lesson
      TextFieldWidget(text: 'Name'),
    ]);
  }
}
