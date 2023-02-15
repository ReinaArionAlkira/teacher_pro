import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teacher_pro/services/isar_service.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget(
      {required this.text,
      this.editable = true,
      this.type,
      this.onSaved,
      this.onChange,
      this.value,
      super.key});

  final bool editable;
  final Function(String?)? onChange;
  final TextInputType? type;
  final String? value;
  final String text;
  final Function(String?)? onSaved;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  final IsarService isarService = IsarService();

  String value = "";

  @override
  Widget build(BuildContext context) {
    if (widget.value != null) {
      value = widget.value!;
    }

    // TextEditingController _controllerText = TextEditingController(text: value);
    TextInputFormatter formater = FilteringTextInputFormatter.deny(r'\d');
    if (widget.type == TextInputType.number) {
      formater = FilteringTextInputFormatter.digitsOnly;
    }
    return TextFormField(
      readOnly: !widget.editable,
      onChanged: (val) {
        if (widget.value == null) {
          setState(() => value = val);
        }
        widget.onChange?.call(val);
      },
      onSaved: widget.onSaved,
      keyboardType: widget.type,
      inputFormatters: [formater],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some data';
        }
        if (widget.type != TextInputType.number &&
            widget.type != TextInputType.text) {
          RegExp regex = RegExp(r'^[A-ZŻŹĆĄŚĘŁÓŃ][a-zżźćńółęąś]+$');
          if (!regex.hasMatch(value)) {
            return 'Enter Correct Data';
          }
          return null;
        }
        if (widget.text == 'Register Number' && value.length != 6) {
          return 'Enter Correct Data';
        }
        return null;
      },
      controller: TextEditingController(text: value)
        ..selection = TextSelection.collapsed(offset: value.length),
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: widget.text,
      ),
    );
  }
}
