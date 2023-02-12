import 'package:flutter/material.dart';
import 'package:teacher_pro/services/isar_service.dart';
import 'package:teacher_pro/ui/widgets/add_widget.dart';
import 'package:teacher_pro/ui/widgets/list_of_grades_widget.dart';
import 'package:teacher_pro/ui/widgets/text_field_widget.dart';

//It will be in main.dart
class HomePagex extends StatelessWidget {
  const HomePagex({required this.title, super.key});

  final String title;

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
  static final isarService = IsarService();
  static List<TextFieldWidget> formFieldsGrade = [
    TextFieldWidget(
        isarService: isarService,
        text: 'Grade',
        type: const TextInputType.numberWithOptions()),
    //TODO: dropdown list
    //https://api.flutter.dev/flutter/material/DropdownButton-class.html
    TextFieldWidget(isarService: isarService, text: 'Lesson'),
    //TODO: dropdown list of students from lesson
    TextFieldWidget(isarService: isarService, text: 'Name'),
    TextFieldWidget(isarService: isarService, text: 'Surrname'),
    TextFieldWidget(
        isarService: isarService,
        text: 'Register Number',
        type: TextInputType.number),
  ];

  static List<TextFieldWidget> formFieldsStudent = [
    TextFieldWidget(isarService: isarService, text: 'Name'),
    TextFieldWidget(isarService: isarService, text: 'Surrname'),
    TextFieldWidget(
        isarService: isarService,
        text: 'Register Number',
        type: TextInputType.number),
  ];

  static List<TextFieldWidget> formFieldsLesson = [
    TextFieldWidget(isarService: isarService, text: 'Name'),
    //TODO: list to fast adding existing students
    //https://medium.flutterdevs.com/selecting-multiple-item-in-list-in-flutter-811a3049c56f
  ];

  // ignore: prefer_final_fields
  static List<Widget> _dialogOptions = <Widget>[
    AddWidget(isarService: isarService, formFields: formFieldsGrade),
    AddWidget(isarService: isarService, formFields: formFieldsStudent),
    AddWidget(isarService: isarService, formFields: formFieldsLesson),
  ];

  static final List<Widget> _widgetOptions = <Widget>[
    ListOfGradesWidget(isarService: isarService),
    AddWidget(isarService: isarService, formFields: formFieldsStudent),
    AddWidget(isarService: isarService, formFields: formFieldsLesson),
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
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 18.0, 0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.70,
                  height: 40,
                  child: const TextField(
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
