import 'package:flutter/material.dart';
import 'package:teacher_pro/services/isar_service.dart';

class ConfirmationDialogWidget extends StatelessWidget {
  ConfirmationDialogWidget(
      {required this.title, required this.content, super.key});

  final String content;
  final String title;
  final IsarService isarService = IsarService();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        ElevatedButton(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: const Text("Confirm"),
          onPressed: () {
            isarService.cleanDataBase();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
