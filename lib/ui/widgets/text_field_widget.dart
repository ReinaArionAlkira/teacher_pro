import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teacher_pro/services/isar_service.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget({required this.text, this.type, this.onSaved, super.key});

  final IsarService isarService = IsarService();
  final TextInputType? type;

  final String text;
  final controller = TextEditingController();
  final Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    TextInputFormatter formater = FilteringTextInputFormatter.deny(r'\d');
    if (type == TextInputType.number) {
      formater = FilteringTextInputFormatter.digitsOnly;
    }
    return TextFormField(
      onSaved: onSaved,
      keyboardType: type,
      inputFormatters: [formater],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some data';
        }
        if (type != TextInputType.number) {
          RegExp regex = RegExp(r'^[A-ZŻŹĆĄŚĘŁÓŃ][a-zżźćńółęąś]+$');
          if (!regex.hasMatch(value)) {
            return 'Enter Correct Data';
          }
          return null;
        }
        if (text == 'Register Number' && value.length != 6) {
          return 'Enter Correct Data';
        }
        return null;
      },
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: text,
      ),
    );
  }
}
