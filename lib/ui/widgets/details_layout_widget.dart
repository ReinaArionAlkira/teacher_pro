import 'package:flutter/material.dart';

class DetailsLayoutWidget extends StatefulWidget {
  const DetailsLayoutWidget(
      {super.key,
      required this.body,
      this.onEdit,
      this.text,
      this.editButtonActive = true});

  final Widget body;
  final void Function()? onEdit;
  final String? text;
  final bool editButtonActive;

  @override
  State<DetailsLayoutWidget> createState() => _DetailsLayoutWidgetState();
}

class _DetailsLayoutWidgetState extends State<DetailsLayoutWidget> {
  Widget? get body => widget.body;
  void Function()? get onEdit => widget.onEdit;
  String? get text => widget.text;
  bool get editButtonActive => widget.editButtonActive;

  @override
  Widget build(BuildContext context) {
    List<Widget> actions = [
      IconButton(
          icon: const Icon(Icons.edit),
          onPressed: editButtonActive ? onEdit : null),
    ];

    return Scaffold(
        appBar: AppBar(
          title: Text(text ?? 'Details'),
          actions: actions,
        ),
        body: body);
  }
}
