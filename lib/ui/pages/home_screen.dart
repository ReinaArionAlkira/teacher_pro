import 'package:flutter/material.dart';
import 'package:teacher_pro/services/grade_service.dart';
import 'package:teacher_pro/ui/widgets/lesson/add_lesson_widget.dart';
import 'package:teacher_pro/ui/widgets/text_field_widget.dart';

import '../../services/lesson_service.dart';
import '../../services/student_service.dart';
import '../widgets/grade/add_grade_widget.dart';
import '../widgets/grade/list_of_grades_widget.dart';
import '../widgets/lesson/list_of_lessons_widget.dart';
import '../widgets/student/add_student_widget.dart';
import '../widgets/student/list_of_students_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  //final String title;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _dialogOptions = <Widget>[
    const AddGradeWidget(),
    const AddStudentWidget(),
    const AddLessonWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future openDialog(Widget element) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: const Text('Add'), content: element),
      );

  void submit() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      ListOfGradesWidget(stream: GradeService().getAllGrades),
      ListOfStudentsWidget(stream: StudentService().getAllStudents),
      ListOfLessonsWidget(stream: LessonService().getAllLessons),
    ];

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
                // Expanded(
                //     child: TextFormField(
                //         textAlign: TextAlign.center,
                //         style: const TextStyle(fontWeight: FontWeight.bold),
                //         decoration: const InputDecoration(
                //           border: InputBorder.none,
                //         ),
                //         readOnly: true,
                //         controller: TextEditingController(
                //             text:
                //                 "A d d   s o m e   r e c o r d s   t o   l i s t"))),
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
        //TODO:
        DropdownButton(items: items, onChanged: onChanged),
        widgetOptions.elementAt(_selectedIndex),
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
