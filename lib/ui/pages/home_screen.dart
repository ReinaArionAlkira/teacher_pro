import 'package:flutter/material.dart';
import 'package:teacher_pro/services/isar_service.dart';
import 'package:teacher_pro/ui/widgets/list_of_grades_widget.dart';
import 'package:teacher_pro/ui/widgets/list_of_lessons_widget.dart';
import 'package:teacher_pro/ui/widgets/list_of_students_widget.dart';
import 'package:teacher_pro/ui/widgets/add_student_widget.dart';
import 'package:teacher_pro/ui/widgets/add_grade_widget.dart';
import 'package:teacher_pro/ui/widgets/add_lesson_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  //final String title;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static final isarService = IsarService();

  static final List<Widget> _dialogOptions = <Widget>[
    AddGradeWidget(isarService: isarService),
    AddStudentWidget(isarService: isarService),
    AddLessonWidget(isarService: isarService),
  ];

  static final List<Widget> _widgetOptions = <Widget>[
    ListOfGradesWidget(isarService: isarService),
    ListOfStudentsWidget(isarService: isarService),
    ListOfLessonsWidget(isarService: isarService),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future openDialog(Widget element) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Add'),
          content: element,
          // actions: [
          //   TextButton(
          //     child: const Text('Submit'),
          //     onPressed: () => submit(),
          //   )
          // ],
        ),
      );

  void submit() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Expanded(
                  child: TextField(
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.justify,
                      maxLines: 1,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        border: OutlineInputBorder(),
                        hintText: 'Search',
                      )),
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    openDialog(_dialogOptions.elementAt(_selectedIndex));
                  },
                ),
              ]),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 2,
          color: Theme.of(context).primaryColor,
        ),
        _widgetOptions.elementAt(_selectedIndex),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.grade_outlined),
            label: 'Grade',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Students',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_lesson),
            label: 'Lessons',
          ),
        ],
        backgroundColor: Theme.of(context).primaryColor,
        fixedColor: Theme.of(context).primaryColorLight,
        unselectedItemColor: Theme.of(context).primaryColorDark,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
