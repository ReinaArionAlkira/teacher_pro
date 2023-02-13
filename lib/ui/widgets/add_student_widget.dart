import 'package:flutter/material.dart';
import 'package:teacher_pro/ui/widgets/text_field_widget.dart';
import 'package:teacher_pro/services/isar_service.dart';

import 'add_widget.dart';

class AddStudentWidget extends StatelessWidget {
  const AddStudentWidget({super.key, required this.isarService});

  final IsarService isarService;

  @override
  Widget build(BuildContext context) {
    return AddWidget(
      isarService: isarService,
      formFields: [
        TextFieldWidget(isarService: isarService, text: 'Name'),
        TextFieldWidget(isarService: isarService, text: 'Surrname'),
        TextFieldWidget(
            isarService: isarService,
            text: 'Register Number',
            type: TextInputType.number),
      ],
    );
  }
}
