import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:teacher_pro/models/grade.dart';
import 'package:teacher_pro/models/lesson.dart';
import 'package:teacher_pro/models/student.dart';

import 'widgets/home_screen.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const HomeScreen(),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controllerName = TextEditingController();
  final controllerSurrname = TextEditingController();
  final controllerRegisterNo = TextEditingController();
  Future<void> createAndShow(student) async {
    final isar = await Isar.open([GradeSchema, StudentSchema, LessonSchema]);
    await isar.writeTxn(() async {
      await isar.students.put(student);
    });

    print(student);
  }

  // Future<void> showAll() async {
  //   final isar = await Isar.open([GradeSchema, StudentSchema, LessonSchema]);
  // }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          // ignore: prefer_const_constructors
          TextField(
            controller: controllerName,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Name',
            ),
          ),
          const SizedBox(height: 24),
          // ignore: prefer_const_constructors
          TextField(
            controller: controllerSurrname,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Surrname',
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: controllerRegisterNo,
            // ignore: unnecessary_const
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Register Number',
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
              onPressed: () {
                final student = Student()
                  ..name = controllerName as String
                  ..surrname = controllerSurrname as String
                  ..registerNo = controllerRegisterNo as Id;
                createAndShow(student);
              },
              child: const Text('Add')),
        ],
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
