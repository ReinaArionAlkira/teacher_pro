import 'package:flutter/material.dart';
import 'package:teacher_pro/ui/widgets/text_field_widget.dart';
import 'package:teacher_pro/services/isar_service.dart';

import 'add_widget.dart';

class AddLessonWidget extends StatelessWidget {
  const AddLessonWidget({super.key, required this.isarService});

  final IsarService isarService;

  @override
  Widget build(BuildContext context) {
    return AddWidget(isarService: isarService, formFields: [
      TextFieldWidget(isarService: isarService, text: 'Name'),
      //TODO: list to fast adding existing students, rest of lessons options
      //https://medium.flutterdevs.com/selecting-multiple-item-in-list-in-flutter-811a3049c56f
    ]);
  }
}
