import 'package:flutter/material.dart';
import 'package:teacher_pro/services/isar_service.dart';

enum Mode { view, edit }

class EditWidget extends StatelessWidget {
  EditWidget(
      {required this.formFields,
      this.mode,
      this.onSubmit,
      this.onCancel,
      super.key});

  final Mode? mode;
  final IsarService isarService = IsarService();
  final List<Widget> formFields;
  static final _formKey = GlobalKey<FormState>();
  final Function? onSubmit;
  final Function? onCancel;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            for (var i = 0; i < formFields.length; i++)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: formFields[i],
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: mode == Mode.view
                  ? []
                  : [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (onCancel != null) onCancel!();
                            _formKey.currentState?.reset();
                          },
                          child: const Text('Cancel'),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   const SnackBar(content: Text('Processing Data')),
                            // );
                            if (onSubmit != null) {
                              onSubmit!();
                            }
                          }
                        },
                        child: const Text('Save'),
                      ),
                    ],
            ),
          ],
        ),
      ),
    );
  }
}
