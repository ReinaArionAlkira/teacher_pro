import 'package:flutter/material.dart';
import 'package:teacher_pro/ui/widgets/text_field_widget.dart';

import 'add_widget.dart';

class AddGradeWidget extends StatelessWidget {
  const AddGradeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AddWidget(formFields: [
      TextFieldWidget(
          text: 'Grade', type: const TextInputType.numberWithOptions()),
      //TODO: dropdown list
      //https://api.flutter.dev/flutter/material/DropdownButton-class.html
      TextFieldWidget(text: 'Lesson'),
      //TODO: dropdown list of students from lesson
      TextFieldWidget(text: 'Name'),
      TextFieldWidget(text: 'Surrname'),
      TextFieldWidget(text: 'Register Number', type: TextInputType.number),
    ]);
  }
}
