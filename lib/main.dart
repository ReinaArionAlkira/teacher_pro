import 'package:flutter/material.dart';
import 'package:teacher_pro/services/isar_service.dart';
import 'package:teacher_pro/ui/pages/home_screen.dart';
import 'package:teacher_pro/ui/widgets/confirmation_dialog_widget.dart';

Future<void> main() async {
  await IsarService().init();
  runApp(MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const _title = 'Teacher Helper';
  static final IsarService isarService = IsarService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0.0,
          title: const Text(_title),
          actions: <Widget>[
            IconButton(
              padding: const EdgeInsets.only(right: 16.0),
              icon: const Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ConfirmationDialogWidget(
                        title: "Reset Database!",
                        content: "Are you sure, you want to delete all data?");
                  },
                );
              },
            )
          ],
        ),
        body: const HomePage(),
      ),
    );
  }
}
