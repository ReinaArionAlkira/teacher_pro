import 'package:flutter/material.dart';
import 'package:teacher_pro/ui/widgets/text_field_widget.dart';
import 'add_widget.dart';

class AddLessonWidget extends StatefulWidget {
  const AddLessonWidget({super.key});

  @override
  State<AddLessonWidget> createState() => _AddLessonWidgetState();
}

class _AddLessonWidgetState extends State<AddLessonWidget> {
  String? name;

  String? day;

  final List<String> dayZ = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  String? hours;

  @override
  Widget build(BuildContext context) {
    return AddWidget(formFields: [
      TextFieldWidget(text: 'Name'),
      DropdownButtonFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
        isExpanded: true,
        hint: const Text("Day"),
        items: dayZ
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ))
            .toList(),
        onChanged: (value) => day = value,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some data';
          }
          return null;
        },
      ),

      //TODO: list to fast adding existing students, rest of lessons options
      //https://medium.flutterdevs.com/selecting-multiple-item-in-list-in-flutter-811a3049c56f
    ]);
  }
}
