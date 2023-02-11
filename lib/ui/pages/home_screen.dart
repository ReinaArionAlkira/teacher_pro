import 'package:flutter/material.dart';
import 'package:teacher_pro/ui/widgets/add_student_widget.dart';
import 'package:teacher_pro/ui/widgets/text_field_widget.dart';

//It will be in main.dart
class HomePagex extends StatelessWidget {
  const HomePagex({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //         appBar: AppBar(
        //   title: Text(widget.title),
        // ),
        appBar: AppBar(
          elevation: 0.0,
          title: Text(title),
        ),
        body: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  //final String title;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static List<TextFieldWidget> formFieldsGrade = [
    TextFieldWidget(text: 'Grade', type: TextInputType.numberWithOptions()),
    //TODO: dropdown list
    //https://api.flutter.dev/flutter/material/DropdownButton-class.html
    TextFieldWidget(text: 'Lesson'),
    //TODO: dropdown list of students from lesson
    TextFieldWidget(text: 'Name'),
    TextFieldWidget(text: 'Surrname'),
    TextFieldWidget(text: 'Register Number', type: TextInputType.number),
  ];

  static List<TextFieldWidget> formFieldsStudent = [
    TextFieldWidget(text: 'Name'),
    TextFieldWidget(text: 'Surrname'),
    TextFieldWidget(text: 'Register Number', type: TextInputType.number),
  ];

  static List<TextFieldWidget> formFieldsLesson = [
    TextFieldWidget(text: 'Name'),
    //TODO: list to fast adding existing students
    //https://medium.flutterdevs.com/selecting-multiple-item-in-list-in-flutter-811a3049c56f
  ];

  // ignore: prefer_final_fields
  static List<Widget> _widgetOptions = <Widget>[
    AddStudentWidget(formFields: formFieldsGrade),
    AddStudentWidget(formFields: formFieldsStudent),
    AddStudentWidget(formFields: formFieldsLesson),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
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
      //     body: Column(children: [
      //   ElevatedButton(
      //     onPressed: () {
      //       Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //               builder: (context) => const AddStudentScreen()));
      //     },
      //     child: const Text('Add Student'),
      //   ),
      //   ElevatedButton(
      //     onPressed: () {
      //       //route to add
      //     },
      //     child: const Text('Add Grade'),
      //   ),
      //   ElevatedButton(
      //     onPressed: () {
      //       //route to add
      //     },
      //     child: const Text('Add Lesson'),
      //   ),
      // ]));
    );
  }
}
