import 'package:flutter/material.dart';
import 'package:teacher_pro/ui/pages/home_screen.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const _title = 'Teacher Helper';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        //         appBar: AppBar(
        //   title: Text(widget.title),
        // ),
        appBar: AppBar(
          elevation: 0.0,
          title: const Text(_title),
        ),
        body: const HomePage(),
      ),
    );
  }
}
