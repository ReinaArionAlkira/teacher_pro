import 'package:flutter/material.dart';

class DropDownMenuWidget<T> extends StatelessWidget {
  const DropDownMenuWidget(
      {this.val,
      required this.text,
      required this.list,
      this.onChanged,
      this.disabledHint,
      super.key});

  final Widget? disabledHint;
  final T? val;
  final String text;
  final List<T> list;
  final void Function(T?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      disabledHint: disabledHint,
      value: val,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      isExpanded: true,
      hint: Text(text),
      items: list
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e.toString()),
              ))
          .toList(),
      onChanged: onChanged,
      validator: (value) {
        if (value == null) {
          return 'Please enter some data';
        }
        return null;
      },
    );
  }
}
